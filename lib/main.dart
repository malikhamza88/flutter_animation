import 'package:flutter/material.dart';
import 'package:flutter_animations/src/animation_two_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      home: const AnimationTwoPage(),
    );
  }
}
