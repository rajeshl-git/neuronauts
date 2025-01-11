import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/components/simple_button.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/game.dart';

class BackButton1 extends SimpleButton with HasGameReference<MainRouterGame> {
  BackButton1({
    VoidCallback? onPressed,
  }) : super(
          Path()
            ..moveTo(22, 8)
            ..lineTo(10, 20)
            ..lineTo(22, 32)
            ..moveTo(12, 20)
            ..lineTo(34, 20),
          position: Vector2.all(10),
        ) {
    super.action = onPressed ?? () {
      game.router.pop();
    };
  }

  @override
  void render(Canvas canvas) {
    // Set the color you want for the button (black in this case)
    canvas.drawRect(size.toRect(), Paint()..color = Color.fromARGB(255, 136, 136, 255));

    super.render(canvas);
  }
}
