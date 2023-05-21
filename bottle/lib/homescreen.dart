import 'package:flutter/material.dart';
import 'gameScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int playerCount = 1;
  late AnimationController _animationController;
  late Animation<double> _animation;
  String selectedDirection = '';

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController);
  }

  void startGame() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameScreen(playerCount, selectedDirection),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _updateSelectedDirection(String direction) {
    setState(() {
      selectedDirection = direction;
      _animationController.reset();
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spin Bottle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select Direction',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _updateSelectedDirection('Forward'),
                  child: const Text('Forward'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _updateSelectedDirection('Reverse'),
                  child: const Text('Reverse'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Opacity(
                  opacity: _animation.value,
                  child: Text(
                    selectedDirection,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 50),
            const Text(
              'Number of Players',
              style: TextStyle(fontSize: 20),
            ),
            Slider(
              value: playerCount.toDouble(),
              min: 1,
              max: 10,
              divisions: 9,
              onChanged: (value) {
                setState(() {
                  playerCount = value.toInt();
                });
              },
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: startGame,
              child: const Text('Generate'),
            ),
          ],
        ),
      ),
    );
  }
}
