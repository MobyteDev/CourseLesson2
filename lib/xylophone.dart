import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

final intToColor = {
  0: Colors.red,
  1: Colors.orange,
  2: Colors.yellow,
  3: Colors.green,
  4: Colors.lightBlueAccent,
  5: Colors.blue,
  6: Colors.deepPurple,
};

class Xylophone extends StatefulWidget {
  @override
  _XylophoneState createState() => _XylophoneState();
}

class _XylophoneState extends State<Xylophone> {
  void swipeLeft(int number) {
    var _player = AudioCache();
    _player.play(
      'standart_sounds/note${number + 1}.wav',
    );
  }

  void swipeRight(int number) {
    var _player = AudioCache();
    _player.play(
      'alt_pack/note${number + 1}.wav',
    );
  }

  Widget makeRainbow(
    int n,
  ) {
    return GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity > 0)
            swipeRight(n);
          else if (details.primaryVelocity < 0) swipeLeft(n);
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 7,
          color: intToColor[n],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => swipeRight(3),
        ),
        body: ListView.builder(
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              int currentIndex = index % 7;
              return makeRainbow(
                currentIndex,
              );
            }));
  }
}

class PieceOfRainbow extends StatelessWidget {
  final int number;
  final void Function() onSwipeLeft;
  final void Function() onSwipeRight;

  PieceOfRainbow(this.number,
      {@required this.onSwipeLeft, @required this.onSwipeRight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity > 0)
            onSwipeRight();
          else if (details.primaryVelocity < 0) onSwipeLeft();
        },
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 7,
          color: intToColor[number],
        ));
  }
}
