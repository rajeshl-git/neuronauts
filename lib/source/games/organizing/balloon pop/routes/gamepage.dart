import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/components/back_button.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/components/balloon_component.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/components/pause_button.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/configuration/app_config.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/game.dart';

class GamePage2 extends Component  with DragCallbacks, HasGameReference<MainRouterGame>{
  final Random random = Random();
  late List<double> balloonTime;
  late double time,countDown;
  TextComponent? _countdownTextComponent,_mistakeTextComponent,_scoreTextComponent;
  bool _countdownFinished = false;
  late int mistakeCount;
  late int score;
   final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onMount() {
    countDown =3;
    mistakeCount=0;
    score=0;
    time = 0;
    _countdownFinished = false;
    balloonTime =  [];

    double initTime = 0;
    for(int i =0; i< 100; i++){
      if(i != 0){
        initTime = balloonTime.last;
      }
      final millisecondTime = random.nextInt(100)/30;
      final componentTime = random.nextInt(1)+ millisecondTime + initTime;
      balloonTime.add(componentTime);
    }




    addAll([
      BackButton1 (
        onPressed: () async{
          await saveData(score.toString());
          removeAll(children);
          game.router.pop();  
        }
      ),
      PauseButton(),
      _countdownTextComponent = TextComponent(
        text: "${countDown.toInt() + 1}",
        size: Vector2.all(50),
        position: game.size/2,
        anchor: Anchor.center,  
      ),
      _mistakeTextComponent = TextComponent(
        text: "Mistake: $mistakeCount",
        
        position: Vector2(game.size.x-10, 10),
        anchor: Anchor.topRight,  
      ),
      _scoreTextComponent = TextComponent(
        text: "Score: $score",
        
        position: Vector2(game.size.x-10, _mistakeTextComponent!.position.y+40),
        anchor: Anchor.topRight,  
      ),

    ]);
    super.onMount();
  }
  @override
  void update(double dt) {
    super.update(dt);
    if(!_countdownFinished){
      countDown -= dt;
    _countdownTextComponent?.text = (countDown.toInt() +1).toString();  
    if(countDown<0){
      _countdownFinished=true;
    } 
    }else{
      _countdownTextComponent?.removeFromParent();
      time+=dt;

      balloonTime.where((element) => element<time).toList().forEach((element) {
        final gameSize = game.size;
        double posX = random.nextInt(gameSize.x.toInt()).toDouble();

        Vector2 balloonPosition = Vector2(posX, gameSize.y);
        Vector2 velocity = Vector2(0, game.MaxVerticalVelocity);

        final randballoon = game.balloons.random();
        add(
          BalloonComponent(
           this,
           balloonPosition,
           balloon: randballoon,
           size: Vector2.all(70),
           acceleration: AppConfig.acceleration,
           image: game.images.fromCache(randballoon.image),
           pageSize: gameSize,
           velocity: velocity
            )
        );        balloonTime.remove(element); 
      });
    }
  }
  @override
  bool containsLocalPoint(Vector2 point) => true;

  @override
  void onDragUpdate(DragUpdateEvent event) {
    super.onDragUpdate(event);

    // ignore: deprecated_member_use
    componentsAtPoint(event.canvasPosition).forEach((element) {
      if(element is BalloonComponent){
        // ignore: deprecated_member_use
        element.touchAtpoint(event.canvasPosition);
      }
    });
  }

  void gameOver(){
    saveData(score.toString());
    game.router.pushNamed("game-over");
  }

  void addScore(){
    score++;
    _scoreTextComponent?.text= "Score: $score";
  }

  void addMistake(){
    mistakeCount++;
    _mistakeTextComponent?.text = "Mistake: $mistakeCount";
    if(mistakeCount >= 3){
      saveData(score.toString());
      gameOver();
    }
  }
  Future<void> saveData(String per) async {
  try {
    User? user = _auth.currentUser;
    if (user != null) {
      // Query the "MAZE_TIME" collection based on the current user's email
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('BUBBLE')
          .where('email', isEqualTo: user.email)
          .get();

      // Check if a document exists for the user
      if (querySnapshot.docs.isNotEmpty) {
        // Update the respective level based on the provided level parameter
        await FirebaseFirestore.instance
            .collection('BUBBLE')
            .doc(querySnapshot.docs.first.id)
            .update({
              "score": per,
        });
      } else {
      }
    } else {
    }
  // ignore: empty_catches
  } catch (e) {
  }
}
}