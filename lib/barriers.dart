import 'package:flutter/material.dart';

class MyBarrier extends StatelessWidget {
  final size;

  const MyBarrier({super.key, this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: size,
      decoration: BoxDecoration(
          color: Colors.brown,
          border: Border.all(width: 10, color: Colors.brown),
          borderRadius: BorderRadius.circular(15)),
    );
  }
}
