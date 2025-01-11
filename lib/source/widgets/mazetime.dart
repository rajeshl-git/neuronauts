import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget timeShow() {
  final user = FirebaseAuth.instance.currentUser!;
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection("MAZE_TIME").where('email', isEqualTo: user.email).snapshots(),
    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
      if (snapshot.hasData) {
        var data = snapshot.data!.docs.first;

        return Container(
          child: Column(
            children: [
              Text(
                'Level 1 Time: ${data['level1'].toString()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Level 2 Time: ${data['level2'].toString()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                'Level 3 Time: ${data['level3'].toString()}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      } else {
        return const Text("No Name");
      }
    },
  );
}