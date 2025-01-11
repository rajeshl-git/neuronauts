import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maze/maze.dart';
import 'package:neuronauts_real/source/dashboard/dashboard.dart';
import 'package:neuronauts_real/source/widgets/navpop.dart';

class MazeCraze extends StatefulWidget {
  const MazeCraze({super.key});

  @override
  State<MazeCraze> createState() => _MazeCrazeState();
}

class _MazeCrazeState extends State<MazeCraze> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
 // Variable to store the elapsed time

   @override
  void initState() {
    super.initState();
    startTimer();
  }
  int  counter = 0; // Variable to store the start time of the maze game
   Timer? time;

  // Function to start the timer
  void startTimer() {
    counter = 0;
    time = Timer.periodic(const Duration(seconds: 1), (timer) {
      if(counter < 60){
        if(mounted){
        setState(() {
          counter++;
        });
        }else{
          time?.cancel();
        }
      }else{
        time?.cancel();
        showDialog(
      
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Time Over",style: TextStyle(color: Colors.white),),
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                        navPop(context);
                      },
                      child: const Text('Quit'),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        navPop(context);
                        navPop(context);
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=> const MazeCraze()));
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      );
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            showDialog(
          
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text("Are You Sure?",style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 10,),
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
                          onPressed: (){
                            time?.cancel();
                            navPop(context);
                            navPop(context);
                          },
                          child: const Text('Quit'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
          },
          icon: const Icon(Icons.arrow_back_ios)
          ),
        title: const Text("MAZE TRAINING MODE", style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromRGBO(127, 3, 131, 1),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          actions: <Widget>[
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text("TIMER: $counter".toString(),style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
              )
          ],
        ),
        body: SafeArea(
  child: 
      Maze(
        player: MazeItem(
          'assets/man.png',
          ImageType.asset,
        ),
        columns: 11,
        rows: 14,
        wallThickness: 4,
        wallColor: Colors.black,
        finish: MazeItem(
          'assets/man2.png',
          ImageType.asset,
        ),
        onFinish: () {
          time?.cancel(); // Convert elapsed time to seconds
        saveTimeData(counter, "level4","100");
        navPop(context);
          showDialog(
          
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.black,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Image(image: AssetImage("assets/congrats.png")),
                    const SizedBox(height: 10,),
                    const Text("You Completed The Game",style: TextStyle(color: Colors.white),),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            navPop(context);
                            navPop(context);
                            navPop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (builder)=> const DashBoard()));
                            },
                          child: const Text('Done'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
  
  )
        );
  }
  Future<void> saveTimeData(int elapsedTime, String level, String per) async {
  try {
    User? user = _auth.currentUser;
    if (user != null) {
      // Query the "MAZE_TIME" collection based on the current user's email
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('MAZE_TIME')
          .where('email', isEqualTo: user.email)
          .get();

      // Check if a document exists for the user
      if (querySnapshot.docs.isNotEmpty) {
        // Update the respective level based on the provided level parameter
        await FirebaseFirestore.instance
            .collection('MAZE_TIME')
            .doc(querySnapshot.docs.first.id)
            .update({
              level: elapsedTime,
              "per": per,
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