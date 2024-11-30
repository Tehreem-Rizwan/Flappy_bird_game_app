import 'dart:async';
import 'package:flappy_bird_game/barriers.dart';
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

  // Barrier positions
  static double barrierXone = 1;
  double barrierXtwo = barrierXone + 1.5;

  // Scoring
  int score = 0;
  int highscore = 0;

  void _jump() {
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gamehasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      time += 0.04;
      height = -4.9 * time * time + 2.8 * time;

      setState(() {
        birdYaxis = initialHeight - height;
      });

      // Move barriers
      setState(() {
        if (barrierXone < -2) {
          barrierXone += 3.5;
          score++; // Increment score when a barrier passes
        } else {
          barrierXone -= 0.05;
        }

        if (barrierXtwo < -2) {
          barrierXtwo += 3.5;
          score++;
        } else {
          barrierXtwo -= 0.05;
        }
      });

      // Check for collisions or falling out of bounds
      if (birdYaxis > 1 || _checkCollision()) {
        timer.cancel();
        gamehasStarted = false;
        _showdialogue();
      }
    });
  }

  bool _checkCollision() {
    const birdHeight = 0.1;
    const barrierWidth = 0.2; // Approximate barrier width

    // Check for collisions with barrier one
    bool collisionOne = (barrierXone.abs() < barrierWidth) &&
        (birdYaxis < -0.8 || birdYaxis > 0.8);

    // Check for collisions with barrier two
    bool collisionTwo = (barrierXtwo.abs() < barrierWidth) &&
        (birdYaxis < -0.7 || birdYaxis > 0.7);

    return collisionOne || collisionTwo;
  }

  void _showdialogue() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          title: const Text(
            "GAME OVER",
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            "Score: $score",
            style: const TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              child: const Text(
                "PLAY AGAIN",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (score > highscore) {
                  highscore = score;
                }
                _restartGame();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _restartGame() {
    setState(() {
      birdYaxis = 0;
      time = 0;
      height = 0;
      initialHeight = birdYaxis;
      barrierXone = 1;
      barrierXtwo = barrierXone + 1.5;
      score = 0;
      gamehasStarted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gamehasStarted) {
          _jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, birdYaxis),
                    duration: const Duration(milliseconds: 0),
                    color: Colors.green,
                    child: Center(child: BirdPage()),
                  ),
                  Container(
                    alignment: const Alignment(0, -0.3),
                    child: gamehasStarted
                        ? const Text("")
                        : const Text(
                            "T A P  T O  P L A Y",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: MyBarrier(size: 200.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXone, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: MyBarrier(size: 200.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, 1.1),
                    duration: const Duration(milliseconds: 0),
                    child: MyBarrier(size: 150.0),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(barrierXtwo, -1.1),
                    duration: const Duration(milliseconds: 0),
                    child: MyBarrier(size: 250.0),
                  ),
                ],
              ),
            ),
            Container(
              height: 15,
              color: Colors.brown,
            ),
            Expanded(
              child: Container(
                color: Colors.blue,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "SCORE",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "$score",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 35),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "BEST",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "$highscore",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 35),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
