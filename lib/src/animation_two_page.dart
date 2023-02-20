import 'dart:math';

import 'package:flutter/material.dart';

class AnimationTwoPage extends StatefulWidget {
  const AnimationTwoPage({super.key});

  @override
  State<AnimationTwoPage> createState() => _AnimationTwoPageState();
}

enum CircleSide { left, right }

extension on VoidCallback {
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();

    late Offset offset;
    late bool clockwise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockwise = false;
        break;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockwise = true;
        break;
    }

    path.arcToPoint(offset, clockwise: clockwise, radius: Radius.elliptical(size.width / 2, size.height / 2));
    path.close();

    return path;
  }
}

class _AnimationTwoPageState extends State<AnimationTwoPage> with TickerProviderStateMixin {
  late AnimationController _rotationAnimationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _rotationAnimationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _rotationAnimation =
        Tween<double>(begin: 0, end: -(pi / 2)).animate(CurvedAnimation(parent: _rotationAnimationController, curve: Curves.bounceOut));
  }

  @override
  void dispose() {
    _rotationAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _rotationAnimationController
      ..reset()
      ..forward.delayed(const Duration(milliseconds: 1000));

    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
            animation: _rotationAnimation,
            builder: (context, _) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()..rotateZ(_rotationAnimation.value),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipPath(
                      clipper: HalfCircleClipper(side: CircleSide.left),
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.indigo,
                      ),
                    ),
                    ClipPath(
                      clipper: HalfCircleClipper(side: CircleSide.right),
                      child: Container(
                        height: 200,
                        width: 200,
                        color: Colors.yellow,
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  HalfCircleClipper({required this.side});
  final CircleSide side;

  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
