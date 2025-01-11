import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/configuration/app_config.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/configuration/utils.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/models/balloon_model.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/routes/gamepage.dart';
import 'package:flame/image_composition.dart' as composition;

class BalloonComponent extends SpriteComponent{
  Vector2 velocity;
    final Vector2 pageSize;
    final double acceleration;
    final BalloonModel balloon;
    final composition.Image image;
    late Vector2 _initPosition;
    bool _canDragonShape = false;
    GamePage2 parentComponent;
    bool divided;

  BalloonComponent(
    this.parentComponent,
    Vector2 p,
    {
      Vector2? size,
      required this.velocity,
      required this.pageSize,
      required this.acceleration,
      required this.balloon,
      required this.image,
      double? angle,
      Anchor? anchor,
      this.divided = false,
      }
    ): super(
      sprite: Sprite(image),
      position: p,
      size: size,
      anchor: anchor??Anchor.center,
        angle: angle,

    ){
      _initPosition = p;
      _canDragonShape = false;
    }

    final player = AudioPlayer();

    @override
      void update(double dt) {
    super.update(dt);
    if(_initPosition.distanceTo(position)> 60){
      _canDragonShape = true;
    }
    angle += 0.5 * dt;
    angle %= 2 * pi;
    position += Vector2(velocity.x, -(velocity.y * dt - .5 * AppConfig.gravity * dt *dt));
    velocity.y += (AppConfig.acceleration + AppConfig.gravity)*dt;
    if((position.y - AppConfig.objSize) > pageSize.y){
      removeFromParent();
      if(!divided && !balloon.isBomb){
        parentComponent.addMistake();
      }
    }
  }
   void touchAtpoint(Vector2 vector2){
    if(divided && !_canDragonShape){
      return;
    }
    if(balloon.isBomb){
      parentComponent.gameOver();
      return;
    }
    final a = Utils2.getAngleOfTouchPoint(
      center: center,
      initAngle: angle,
      touch: vector2,
      );

      if( a < 45 || (a > 135 && a < 225) || a > 315){
        final dividedImage1 = composition.ImageComposition()
        ..add(image, Vector2(0, 0)
        ,source: Rect.fromLTWH(0, 0, image.width.toDouble(), image.height/2)),
        dividedImage2 = composition.ImageComposition()
        ..add(image, Vector2(0, 0)
        ,source: Rect.fromLTWH(0, 0, image.width.toDouble(), image.height/2));
        parentComponent.addAll([
          BalloonComponent(
            parentComponent,
             center - Vector2(size.x/2 * cos(angle), size.x/2 * sin(angle)),
             balloon: balloon,
             image: dividedImage2.composeSync(),
             acceleration: acceleration,
             velocity: Vector2(velocity.x-2, velocity.y),
             pageSize: pageSize,
             divided: true,
            size: Vector2(size.x, size.y/2),
            angle: angle,
            anchor: Anchor.topLeft,
                     ),
                   BalloonComponent(
                    parentComponent,
                    center + Vector2(size.x/4 * cos(angle + 3 * pi/2), size.x/4 * sin(angle + 3 * pi/2)),
                        size: Vector2(size.x, size.y/2),
                        angle: angle,
                        anchor: Anchor.center,
                        balloon: balloon,
             image: dividedImage1.composeSync(),
             acceleration: acceleration,
             velocity: Vector2(velocity.x+2, velocity.y),
             pageSize: pageSize,
             divided: true,
                      )
        ]);
        removeFromParent();
      }
      else{
        final dividedImage1 = composition.ImageComposition()
        ..add(image, Vector2(0, 0)
        ,source: Rect.fromLTWH(0, 0, image.width.toDouble(), image.height/2)),
        dividedImage2 = composition.ImageComposition()
        ..add(image, Vector2(0, 0)
        ,source: Rect.fromLTWH(0, 0, image.width.toDouble(), image.height/2));
         parentComponent.addAll([
          BalloonComponent(
            parentComponent,
            center -   Vector2(size.x/4*cos(angle), size.x/4*sin(angle)),
            size: Vector2(size.x/2, size.y),
           angle: angle,
            anchor: Anchor.center,
            balloon: balloon,
             image: dividedImage1.composeSync(),
             acceleration: acceleration,
             velocity: Vector2(velocity.x-2, velocity.y),
             pageSize: pageSize,
             divided: true,
            
                      ),
                      BalloonComponent(
                        parentComponent,
                        center + Vector2(size.x/2 * cos(angle + 3 * pi/2), size.x/2 * sin(angle + 3 * pi/2)),
                        size: Vector2(size.x/2, size.y),
                       angle: angle,
                        anchor: Anchor.topLeft,
                        balloon: balloon,
             image: dividedImage2.composeSync(),
             acceleration: acceleration,
             velocity: Vector2(velocity.x+2, velocity.y),
             pageSize: pageSize,
             divided: true,
                      )
        ]);
      }
      parentComponent.addScore();
      removeFromParent();
}
}