import 'package:flappy_bird_game/constants/app_images.dart';
import 'package:flutter/material.dart';

class BirdPage extends StatelessWidget {
  const BirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 60, width: 60, child: Image.asset(Assets.imagesFlappybird));
  }
}
