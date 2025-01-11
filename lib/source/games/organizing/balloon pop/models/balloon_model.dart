
import 'package:flutter/material.dart';

class BalloonModel{
  String image;
  bool isBomb;
  Color color;
  

  BalloonModel({
    this.color = Colors.transparent,
    required this.image,
    this.isBomb = false,
  });
}