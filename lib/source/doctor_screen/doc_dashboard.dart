import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({super.key});

  @override
  State<DoctorDashboard> createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Childrens data"),
      ),
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Text("Children List",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              StreamBuilder(
              stream: FirebaseFirestore.instance.collection("HERE").where('email', isEqualTo: "tejaswi.r.2021.cce@ritchennai.edu.in").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs. first;
                  return ListView(
                    scrollDirection: Axis.vertical,
                     shrinkWrap: true,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20,),
                          const Image(image: AssetImage("assets/user1.png")),
                          const SizedBox(height: 4,),
                          Text(data['fullname'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 6),
                          Text(data['rollno'].toString(),style: const TextStyle(color: Colors.black,fontSize: 15),),
                          const SizedBox(height: 4),
                          Text(data['email'],style: const TextStyle(color: Colors.black),),
                          const SizedBox(height: 10,),
                        ],
                      ),
                     ],
                   );
                } else {
                  return const CircularProgressIndicator(strokeWidth: 1.0,);
                }
              },
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("MAZE_TIME").where('email', isEqualTo: "tejaswi.r.2021.cce@ritchennai.edu.in").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs. first;
                  return ListView(
                    scrollDirection: Axis.vertical,
                     shrinkWrap: true,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5,),
                          Text("PERFOMANCE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Text("ATTENTION : ${data['level1']}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 6),
                          Text("PROBLEM SOLVING: ${data['level2']}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 4),
                          Text("REASONING: ${data['level3']}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 4),
                          Text("VERBAL: ${data['level4']}", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 10,),
                        ],
                      ),
                     ],
                   );
                } else {
                  return const CircularProgressIndicator(strokeWidth: 1.0,);
                }
              },
            ),
            SizedBox(height: 10,),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("HERE").where('email', isEqualTo: "leoinfant.p.2021.cce@ritchennai.edu.in").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs. first;
                  return ListView(
                    scrollDirection: Axis.vertical,
                     shrinkWrap: true,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20,),
                          const Image(image: AssetImage("assets/user1.png")),
                          const SizedBox(height: 4,),
                          Text(data['fullname'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 6),
                          Text(data['rollno'].toString(),style: const TextStyle(color: Colors.black,fontSize: 15),),
                          const SizedBox(height: 4),
                          Text(data['email'],style: const TextStyle(color: Colors.black),),
                        ],
                      ),
                     ],
                   );
                } else {
                  return const CircularProgressIndicator(strokeWidth: 1.0,);
                }
              },
            ),StreamBuilder(
              stream: FirebaseFirestore.instance.collection("MAZE_TIME").where('email', isEqualTo: "rajesh.l.2021.cce@ritchennai.edu.in").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs. first;
                  return ListView(
                    scrollDirection: Axis.vertical,
                     shrinkWrap: true,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5,),
                          Text("PERFOMANCE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Text(" ATTENTION : 0", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 6),
                          Text("PROBLEM SOLVING: 0", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 4),
                          Text("REASONING: 0", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 4),
                          Text("VERBAL: 0", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 10,),
                        ],
                      ),
                     ],
                   );
                } else {
                  return const CircularProgressIndicator(strokeWidth: 1.0,);
                }
              },
            ),
            SizedBox(height: 10,),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("HERE").where('email', isEqualTo: "rajesh.l.2021.cce@ritchennai.edu.in").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs. first;
                  return ListView(
                    scrollDirection: Axis.vertical,
                     shrinkWrap: true,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20,),
                          const Image(image: AssetImage("assets/user1.png")),
                          const SizedBox(height: 4,),
                          Text(data['fullname'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 6),
                          Text(data['rollno'].toString(),style: const TextStyle(color: Colors.black,fontSize: 15),),
                          const SizedBox(height: 4),
                          Text(data['email'],style: const TextStyle(color: Colors.black),),
                        ],
                      ),
                     ],
                   );
                } else {
                  return const CircularProgressIndicator(strokeWidth: 1.0,);
                }
              },
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection("MAZE_TIME").where('email', isEqualTo: "rajesh.l.2021.cce@ritchennai.edu.in").snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  var data = snapshot.data!.docs. first;
                  return ListView(
                    scrollDirection: Axis.vertical,
                     shrinkWrap: true,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5,),
                          Text("PERFOMANCE",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Text("ATTENTION : 0", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 6),
                          Text("PROBLEM SOLVING: 0", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 4),
                          Text("REASONING: 0", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 4),
                          Text("VERBAL: 0", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black)),
                          const SizedBox(height: 10,),
                        ],
                      ),
                     ],
                   );
                } else {
                  return const CircularProgressIndicator(strokeWidth: 1.0,);
                }
              },
            ),
            ],
          ),
        ),
      ),
    );
  }
}