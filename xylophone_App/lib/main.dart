import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: XyloApp()));
}

final assetsAudioPlayer = AssetsAudioPlayer();

class XyloApp extends StatefulWidget {
  const XyloApp({Key? key}) : super(key: key);

  @override
  State<XyloApp> createState() => _XyloState();
}

class _XyloState extends State<XyloApp> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController =
  AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  int _numberOfButtons = 6;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _playSound(String soundPath) {
    assetsAudioPlayer.open(Audio(soundPath));
  }

  void _animateButton(int index) {
    _animationController.reset();
    _animationController.forward();
  }

  void _addButton() {
    setState(() {
      _numberOfButtons++;
    });
  }

  void _removeButton() {
    setState(() {
      if (_numberOfButtons > 0) {
        _numberOfButtons--;
      }
    });
  }

  List<Widget> _buildButtons() {
    List<Widget> buttons = [];

    for (int i = 0; i < _numberOfButtons; i++) {
      buttons.add(Expanded(
        child: GestureDetector(
          onTap: () {
            _playSound("assets/note${i + 1}.wav");
            _animateButton(i);
          },
          child: ScaleTransition(
            scale: Tween(begin: 1.0, end: 0.9).animate(_animationController),
            child: Container(
              color: Colors.primaries[i % Colors.primaries.length],
              child: Center(child: Text("Button ${i + 1}")),
            ),
          ),
        ),
      ));
    }

    return buttons;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Xylophone"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _addButton,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: _removeButton,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.remove),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildButtons(),
            ),
          ),
        ],
      ),
    );
  }
}
