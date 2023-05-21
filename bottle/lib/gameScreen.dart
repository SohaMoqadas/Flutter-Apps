import 'package:flutter/material.dart';
import 'dart:math';

class GameScreen extends StatefulWidget {
  final int playerCount;
  final String selectedDirection;

  const GameScreen(this.playerCount, this.selectedDirection, {Key? key})
      : super(key: key);

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isAnimating = false;
  Map<int, int> winningCounts = {};

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _startSpinningAnimation() {
    if (!_isAnimating) {
      _isAnimating = true;
      _animationController.reset();

      // Bottle spinning animation
      _animationController.repeat();

      // Delay before starting the rotation animation
      Future.delayed(const Duration(seconds: 2), () {
        double begin = 0.0;
        double end = 1.0;

        if (widget.selectedDirection.toLowerCase() == 'reverse') {
          begin = -1.0;
          end = 0.0;
        }

        _animationController.value = begin;
        _animationController.animateTo(end).whenComplete(() {
          _isAnimating = false;
          _animationController.stop();
          _showWinnerDialog();
        });
      });
    }
  }

  void _showWinnerDialog() {
    final int winnerIndex = Random().nextInt(widget.playerCount) + 1;
    final String winnerMessage = 'Player $winnerIndex wins!';

    // Update winningCounts map
    winningCounts.update(winnerIndex, (value) => value + 1, ifAbsent: () => 1);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Winner'),
          content: Text(winnerMessage),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WinningTimeScreen(
                      winningCounts: winningCounts,
                    ),
                  ),
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spin Bottle'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Rotate the Bottle',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  GestureDetector(
                    onTap: _startSpinningAnimation,
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (BuildContext context, Widget? child) {
                        double rotationAngle =
                            _animationController.value * 2 * pi;

                        if (widget.selectedDirection.toLowerCase() ==
                            'reverse') {
                          rotationAngle = -rotationAngle;
                        }

                        return Transform.rotate(
                          angle: rotationAngle,
                          child: child,
                        );
                      },
                      child: Image.asset(
                        "images/bottle.png",
                        height: 80,
                        width: 90,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: 200,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        for (int i = 0; i < widget.playerCount; i++)
                          Positioned(
                            top: 100 -
                                70 *
                                    sin(2 * pi * i / widget.playerCount +
                                        _animationController.value * 2 * pi),
                            left: 100 +
                                70 *
                                    cos(2 * pi * i / widget.playerCount +
                                        _animationController.value * 2 * pi),
                            child: Container(
                              width: 50,
                              height: 50,
                              alignment: Alignment.centerLeft,
                              child: Text('P ${i + 1}'),
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _startSpinningAnimation,
                child: Text('Spin Bottle ${widget.selectedDirection.capitalize()}'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WinningTimeScreen extends StatelessWidget {
  final Map<int, int> winningCounts;

  const WinningTimeScreen({Key? key, required this.winningCounts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Winning Score'),
      ),
      body: ListView.builder(
        itemCount: winningCounts.length,
        itemBuilder: (BuildContext context, int index) {
          final playerIndex = winningCounts.keys.elementAt(index);
          final winningCount = winningCounts[playerIndex];
          return ListTile(
            title: Text('Player $playerIndex - Wins: $winningCount'),
          );
        },
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + this.substring(1);
  }
}
