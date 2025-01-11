import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/dashboard/dashboard.dart';
import 'package:neuronauts_real/source/games/problem_solving/maze/maze.dart';
import 'package:neuronauts_real/source/games/problem_solving/maze/mazecraze.dart';
import 'package:neuronauts_real/source/games/problem_solving/maze/mazehard.dart';
import 'package:neuronauts_real/source/games/problem_solving/maze/mazemedium.dart';
import 'package:neuronauts_real/source/widgets/container.dart';
import 'package:neuronauts_real/source/widgets/navpop.dart';

class MazeLevel extends StatefulWidget {
  const MazeLevel({super.key});

  @override
  State<MazeLevel> createState() => _MazeLevelState();
}

class _MazeLevelState extends State<MazeLevel> {
  @override
   void initState() {
  super.initState(); 
  fetchGameProgress();
}


   int b1 = 0;
   int b2 = 0;
   int b3 = 0;
   int b4 = 0;

   Future<void> fetchGameProgress() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection("MAZE_TIME")
            .where('email', isEqualTo: user.email)
            .get();

        if (snapshot.docs.isNotEmpty) {
          var data = snapshot.docs.first.data();

          // Extract level values from the document
          b1 = data['bronze'] ?? 0;
          b2 = data['silver'] ?? 0;
          b3 = data['gold'] ?? 0;
          b4 = data['platinum'] ?? 0;


          // Do something with the extracted values
          // For now, we'll just print them
          if(mounted){setState(() {});} // Update the widget to reflect the changes
        }
      // ignore: empty_catches
      } catch (e) {
      }
    }
  }

  tickSelector(int level){
    switch(level){
      case 1:{
        if(b1 > 0){
          return const AssetImage("assets/tick.png");
        }
        else{
          return const AssetImage("assets/wrong.png");
        }
      }
      case 2:{
        if(b2 > 0){
          return const AssetImage("assets/tick.png");
        }
        else{
          return  const AssetImage("assets/wrong.png");
        }
      }
      case 3:{
        if(b3 > 0){
          return  const AssetImage("assets/tick.png");
        }
        else{
          return  const AssetImage("assets/wrong.png");
        }
      }
      case 4:{
        if(b4 > 0){
          return  const AssetImage("assets/tick.png");
        }
        else{
          return  const AssetImage("assets/wrong.png");
        }
      }
      
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Maze Levels"),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(127, 3, 131, 1),
        leading: IconButton(
          onPressed: (){
            navPop(context);
            navPop(context);
            Navigator.push(context, MaterialPageRoute(builder: (builder)=> const DashBoard()));
            },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),

      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20,right: 10),
                  child: Row(
                    children: [
                      conTainerr(
                        text: "Level 1",
                        image: const AssetImage("assets/maze.png"),
                        color: Colors.black,
                        image2: tickSelector(1),
                        onClicked: (){
                          if(b1 == 1){
                            showDialog(
      
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Already Completed",style: TextStyle(color: Colors.white),),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                      },
                      child: const Text('Back'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=> const MazeDashBoard()));
                      },
                      child: const Text('Replay'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
                          }else{
                            showDialog(
      
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Let's Start...",style: TextStyle(color: Colors.white),),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=> const MazeDashBoard()));
                      },
                      child: const Text('Play'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
                          }
                        }
                        ),
                        const SizedBox(width: 7,),
                        conTainerr(
                        text: "Level 2",
                        image: const AssetImage("assets/maze.png"),
                        color: Colors.black,
                        image2: tickSelector(2),
                        onClicked: (){
                          if(b1 == 1){
                            if(b2 == 1){
                            showDialog(
      
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Already Completed",style: TextStyle(color: Colors.white),),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                      },
                      child: const Text('Back'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=> const MazeMedium()));
                      },
                      child: const Text('Replay'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
                          }else{
                            showDialog(
      
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Let's Start...",style: TextStyle(color: Colors.white),),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=> const MazeMedium()));
                      },
                      child: const Text('Play'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
                          }
                          }else{
                            showDialog(
      
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Complete Level 1",style: TextStyle(color: Colors.white),),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
                          }
                        }
                        ),
                        const SizedBox(width: 7,),
                        conTainerr(
                        text: "Level 3",
                        image: const AssetImage("assets/maze.png"),
                        color: Colors.black,
                        image2: tickSelector(3),
                        onClicked: (){
                          if(b2 == 1){
                            if(b3 == 1){
                            showDialog(
      
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Already Completed",style: TextStyle(color: Colors.white),),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                      },
                      child: const Text('Back'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=> const MazeHard()));
                      },
                      child: const Text('Replay'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
                          }else{
                            showDialog(
      
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Let's Start...",style: TextStyle(color: Colors.white),),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=> const MazeHard()));
                      },
                      child: const Text('Play'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
                          }
                          }else{
                            showDialog(
      
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Complete Level 2",style: TextStyle(color: Colors.white),),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
                          }
                        }
                        ),
                        const SizedBox(width: 7,),
                        conTainerr(
                        text: "Level 4",
                        image: const AssetImage("assets/maze.png"),
                        color: Colors.black,
                        image2: tickSelector(4),
                        onClicked: (){
                          if(b3 == 1){
                            if(b4 == 1){
                            showDialog(
      
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Already Completed",style: TextStyle(color: Colors.white),),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                      },
                      child: const Text('Back'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=> const MazeCraze()));
                      },
                      child: const Text('Replay'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
                          }else{
                            showDialog(
      
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Let's Start...",style: TextStyle(color: Colors.white),),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=> const MazeCraze()));
                      },
                      child: const Text('Play'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
                          }
                          }else{
                            showDialog(
      
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Complete Level 3",style: TextStyle(color: Colors.white),),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
                          }
                        }
                        ),
                        const SizedBox(width: 7,),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}