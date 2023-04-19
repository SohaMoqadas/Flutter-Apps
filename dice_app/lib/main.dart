import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() => runApp(const DiceApp());

class DiceApp extends StatelessWidget {
  const DiceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dice App',
      theme: ThemeData(
        fontFamily: 'Montserrat',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(background: Colors.grey[200]),
      ),
      home: const DicePage(),
    );
  }
}

class DicePage extends StatefulWidget {
  const DicePage({super.key});

  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage>
    with SingleTickerProviderStateMixin {
  List<int> _diceValues = [1, 1]; // initialize with two dice
  int _score = 2;

  late AnimationController _animationController;
  late CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _curvedAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  void _rollDice() {
    setState(() {
      _diceValues = List.generate(
          _diceValues.length, (index) => math.Random().nextInt(6) + 1);
      _score = _diceValues.reduce((a, b) => a + b);
    });

    _animationController.reset();
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> diceList = [];
    for (int i = 0; i < _diceValues.length; i++) {
      diceList.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: RotationTransition(
              turns: _curvedAnimation,
              child: Image.asset('images/dice${_diceValues[i]}.jpg'),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dice App'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: diceList,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _rollDice,
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.casino),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _diceValues.add(math.Random().nextInt(6) + 1);
                  _score += _diceValues.last;
                });
              },
              child: const Text("Add Dice"),
            ),
            ElevatedButton(
              onPressed: () {
                if (_diceValues.length > 1) {
                  setState(() {
                    _score -= _diceValues.last;
                    _diceValues.removeLast();
                  });
                }
              },
              child: const Text("Remove Dice"),
            ),
          ],
        ),
      ),
    );
  }
}
