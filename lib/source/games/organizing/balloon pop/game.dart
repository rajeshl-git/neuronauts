import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/parallax.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/configuration/app_config.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/models/balloon_model.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/pause_game.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/routes/game_over.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/routes/gamepage.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/routes/homepage.dart';

class MainRouterGame extends FlameGame {
  // ignore: non_constant_identifier_names
  late double MaxVerticalVelocity;
  late final RouterComponent router;

  final List<BalloonModel> balloons = [
    BalloonModel(image: "bubble1.png",),
    BalloonModel(image: "bubble2.png",),
    BalloonModel(image: "bubble3.png",),
    BalloonModel(image: "bubble4.png",),
    BalloonModel(image: "bomb.png",isBomb: true),
  ];
  @override
  void onLoad() async {
    await super.onLoad();
      for(final balloon in balloons){
        await images.load(balloon.image);
      }
    addAll([
      ParallaxComponent(
        parallax: Parallax([await ParallaxLayer.load(ParallaxImageData("bomma2.jpg"))])
      ),
      router = RouterComponent(initialRoute: "home",routes: {
        "home": Route(HomePage2.new),
        "game-page": Route(GamePage2.new),
        "pause": PauseRoute(),
        "game-over": GameOverRoute()
      })
    ]);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    getMaxVerticalVelocity(size);
  }

  void getMaxVerticalVelocity(Vector2 size){
    MaxVerticalVelocity = sqrt(2 * 
    (AppConfig.gravity.abs() + AppConfig.acceleration.abs())
    * (size.y - AppConfig.objSize * 2));

  }
} 
