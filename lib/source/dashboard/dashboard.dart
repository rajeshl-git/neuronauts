import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/game.dart' hide Game;
import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/drawer/drawer.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/game.dart';
import 'package:neuronauts_real/source/games/problem_solving/maze/mazelevel.dart';
import 'package:neuronauts_real/source/performance/progress.dart';
import 'package:neuronauts_real/source/widgets/container.dart';
import 'package:neuronauts_real/source/widgets/fetchgame.dart';

class DashBoard extends StatefulWidget {

  const DashBoard({Key? key}) : super(key: key);
  @override
  State<DashBoard> createState() => _DashBoardState();
}
class _DashBoardState extends State<DashBoard> {
  final user = FirebaseAuth.instance.currentUser!;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavigationDrawerWidget(),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(170),
        child: AppBar(
          actions: [IconButton(onPressed: ()=> confirmLogout(context), icon: Icon(Icons.logout))],
          flexibleSpace: Column(
            children: [
              const SizedBox(height: 110),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Welcome",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    buildHeaderr(),
                  ],
                ),
              ),
            ],
          ),
          title: const Text("DashBoard", style: TextStyle(color: Colors.white)),
          backgroundColor: const Color.fromRGBO(127, 3, 131, 1),
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(215, 181, 216, 0.1),
                Color.fromRGBO(215, 181, 216, 0.1),
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 25),
              const Text("PROGRESS",style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
              const SizedBox(height: 10),
              Center(
                child: Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                        decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const GameProgress()));
          },
          child: const Image(
            image: AssetImage("assets/progress.png"),
            height: 180,
            width: 220,
          ),
        ),
        const SizedBox(height: 7),
        const SizedBox(height: 7,),
        const Text("Check here...",style: TextStyle(color: Colors.white),),
      ],
    ),
  ),
                  ],
                ),
              ),
              const SizedBox(height: 20,),
              const Divider(thickness: 5,),
              const Text("ACTIVITY",style: TextStyle(color: Colors.black,fontSize: 24,fontWeight: FontWeight.bold),),
              const SizedBox(height: 20,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "PROBLEM SOLVING",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FutureBuilder<String?>(
  future: fetchGameProgress1(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // Return a loading indicator or an empty string while waiting
      return conTainer(
        text: "MAZE",
        image: const AssetImage("assets/maze.png"),
        color: const Color.fromARGB(255, 199, 34, 240),
        onClicked: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => const MazeLevel()),
          );
        },
      );
    } else if (snapshot.hasError) {
      // Handle any errors that occurred
      return Text("Error fetching progress: ${snapshot.error}");
    } else {
      // Data fetched successfully, use it in the conTainer
      return conTainer(// Default to "0" if data is null
        text: "MAZE",
        image: const AssetImage("assets/maze.png"),
        color: const Color.fromARGB(255, 199, 34, 240),
        onClicked: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (builder) => const MazeLevel()),
          );
        },
      );
    }
  },
),
                      const SizedBox(width: 25),
                      conTainer(
                        text: "",
                        image: const AssetImage("assets/comming.png"),
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "REASONING",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      conTainer(
                        text: "RING STACK TOWER",
                        image: const AssetImage("assets/ring.jpg"),
                        color: const Color.fromARGB(255, 199, 34, 240),
                        
                      ),
                      const SizedBox(width: 25),
                      conTainer(
                        text: "CONNECTOR",
                        image: const AssetImage("assets/comming.png"),
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "ATTENTION",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      conTainer(
                        text: "BUBBLE POP",
                        image: const AssetImage("assets/bubble.png"),
                        color: const Color.fromARGB(255, 199, 34, 240),
                        onClicked: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=> GameWidget(game: MainRouterGame())));
                        }
                      ),
                      const SizedBox(width: 25),
                      conTainer(
                        text: "CONNECTOR",
                        image: const AssetImage("assets/comming.png"),
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "ORGANIZING",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      conTainer(
                        text: "SHAPE MATCHING",
                        image: const AssetImage("assets/shape.jpg"),
                        color: const Color.fromARGB(255, 199, 34, 240),
                        
                      ),
                      const SizedBox(width: 25),
                      conTainer(
                        text: "CONNECTOR",
                        image: const AssetImage("assets/comming.png"),
                        color: Colors.black,
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
            ],
          ),
        ),
      ),
    );
  }
}



Widget buildHeaderr(){
  final user = FirebaseAuth.instance.currentUser!;
  return StreamBuilder(
            stream: FirebaseFirestore.instance.collection("HERE").where('email', isEqualTo: user.email).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data!.docs. first;
                return Text(data['fullname'],style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: Colors.white),);
              } else {
                return const Text("No Name");
              }
            },
          );

}




