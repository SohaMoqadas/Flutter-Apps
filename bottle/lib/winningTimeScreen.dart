import 'package:flutter/material.dart';

class WinningTimeScreen extends StatelessWidget {
  final List<String> winningTimes;

  const WinningTimeScreen({Key? key, required this.winningTimes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Winning Times'),
      ),
      body: ListView.builder(
        itemCount: winningTimes.length,
        itemBuilder: (BuildContext context, int index) {
          final winningTime = winningTimes[index];
          return ListTile(
            title: Text('Player ${index + 1} - $winningTime'),
          );
        },
      ),
    );
  }
}
