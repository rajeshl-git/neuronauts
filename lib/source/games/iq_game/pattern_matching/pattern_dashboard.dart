import 'package:flutter/material.dart';

class PatternGame extends StatefulWidget {
  const PatternGame({super.key});

  @override
  State<PatternGame> createState() => _PatternGameState();
}

class _PatternGameState extends State<PatternGame> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          color: Color.fromRGBO(215, 181, 216, 1.0),
          height: 100,
          width: 100,
        ),
      ),
      );
  }
}