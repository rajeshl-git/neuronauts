
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/widgets/navpop.dart';

class GameProgress extends StatefulWidget {
  const GameProgress({super.key});

  @override
  State<GameProgress> createState() => _GameProgressState();
}

class _GameProgressState extends State<GameProgress> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
void initState() {
  super.initState(); 
  _fetchProgressAndBatch();
}

Future<void> _fetchProgressAndBatch() async {
  await fetchGameProgress();
  batchCall();
  if (mounted) {
    setState(() {}); 
  }
}

  int l1 = 0; 
  int l2 = 0; 
  int l3 = 0;
  int l4 = 0;

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
          l1 = data['level1'] ?? 0;
          l2 = data['level2'] ?? 0;
          l3 = data['level3'] ?? 0;
          l4 = data['level4'] ?? 0;


          // Do something with the extracted values
          // For now, we'll just print them
          if(mounted){setState(() {});} // Update the widget to reflect the changes
        }
      // ignore: empty_catches
      } catch (e) {
      }
    }
  }
  platinumCall(){
    if(l4 > 0){
      return const Image(image: AssetImage("assets/medal4.png"),height: 100,width: 100,);
    }else{
      return Container();
    }
  }
  platinumCall2(){
    if(l4 > 0){
      return const Text("Completed!",style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),);
    }else{
      return Container();
    }
  }
  batchCall1(int i){
    switch(i){
      case 0: {
        if(l1 > 0){
          return const Image(image: AssetImage("assets/medal.png"),height: 40,width: 40,);
        }else{
          return Container();
        }
      }
      case 1: {
        if(l2 > 0){
          return const Image(image: AssetImage("assets/medal2.png"),height: 40,width: 40,);
        }else{
          return Container();
        }
      }
      case 2: {
        if(l3 > 0){
          return const Image(image: AssetImage("assets/medal3.png"),width: 40,height: 40,);
        }else{
          return Container();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... rest of your build function
    return Scaffold(
      appBar: AppBar(
        title: const Text("Performance"),
        leading: IconButton(
          onPressed: (){navPop(context);},
          icon: const Icon(Icons.arrow_back_ios),
          ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("MAZE PROGRESS",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.bold),),
            ],
          ),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Row(
              children: [
              Container(
              width: 200,
              height: 240,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(30),bottomLeft: Radius.circular(30)),
                color: Colors.black,
              ),
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
              
                    Image(image: AssetImage("assets/maze.png"),),
                    SizedBox(height: 7,),
                    Text("MAZE",style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
            Container(
              width: 190,
              height: 240,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),bottomRight: Radius.circular(30)),
                color: Colors.black,
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    platinumCall(),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          batchCall1(0),
                          const SizedBox(width: 6,),
                          batchCall1(1),
                          const SizedBox(width: 6,),
                          batchCall1(2),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10,),
                    platinumCall2(),
                  ],
                ),
              ),

              ],
            ),
          )
        ],
      )
      );
  }

void batchCall(){
  if(l1 > 0){
     saveTimeData1("bronze");
  }
  if(l2 > 0){
     saveTimeData1("silver");
  }
  if(l3 > 0){
     saveTimeData1("gold");
  }
  if(l4 > 0){
     saveTimeData1("platinum");
  }
}
Future<void> saveTimeData1(String batch) async {
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
              batch: 1,
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
