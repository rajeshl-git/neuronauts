import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/game.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/roundbutton.dart';

class HomePage2 extends Component with HasGameReference<MainRouterGame>{
  late final RoundedButton _button1;


  @override
  void onLoad() {
    
  super.onLoad();

  add(_button1 = RoundedButton(text: "Start",
  onPressed: (){
    game.router.pushNamed("game-page");
  },
  color: Colors.blue,
  borderColor: Colors.blue)
  );
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _button1.position = size/2;
  }
}

