import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(const DiceApp());

class DiceApp extends StatefulWidget {
  const DiceApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DiceAppState createState() => _DiceAppState();
}

class _DiceAppState extends State<DiceApp> {
  int _diceValue = 1;

  void _rollDice() {
    setState(() {
      _diceValue = Random().nextInt(6) + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Dice App'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$_diceValue',
                style: const TextStyle(fontSize: 60),
              ),
              const SizedBox(height: 20),
              RaisedButton(
                child: const Text('Roll Dice'),
                onPressed: _rollDice,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
RaisedButton({required Text child, required void Function() onPressed}) {
}
