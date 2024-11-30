import 'dart:async';

import 'package:flappy_bird_game/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double birdYaxis = 0;
  double time = 0;
  double height = 0;
  double initialHeight = birdYaxis;
  bool gamehasStarted = false;
  void _jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gamehasStarted = true;
    Timer.periodic(Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;
      setState(() {
        birdYaxis = initialHeight - height;
      });
      if (birdYaxis > 1) {
        timer.cancel();
        gamehasStarted = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  if (gamehasStarted) {
                    _jump();
                  } else {
                    startGame();
                  }
                },
                child: AnimatedContainer(
                  alignment: Alignment(0, birdYaxis),
                  duration: Duration(milliseconds: 0),
                  color: Colors.green,
                  child: Center(child: BirdPage()),
                ),
              )),
          Expanded(
              child: Container(
            color: Colors.blue,
          )),
        ],
      ),
    );
  }
}
