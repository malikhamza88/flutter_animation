import 'dart:math' show pi;

import 'package:flutter/material.dart';

class AnimationOnePage extends StatefulWidget {
  const AnimationOnePage({super.key});

  @override
  State<AnimationOnePage> createState() => _AnimationOnePageState();
}

class _AnimationOnePageState extends State<AnimationOnePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animation = Tween<double>(begin: 0, end: 2 * pi).animate(_controller);

    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, _) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateY(_animation.value),
                child: Container(
                  height: 100,
                  width: 100,
                  color: Colors.amber,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
