

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget conTainer({
  required String text,
  VoidCallback? onClicked,
  required ImageProvider<Object> image,
  required Color color,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: color,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onClicked,
          child: Image(
            image: image,
            height: 100,
            width: 150,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 7),
        Row(
          children: [
            Image.asset("assets/star.png"),
            const SizedBox(width: 6),
            FutureBuilder<String?>(
  future: dataforcontainer(),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      // Return a loading indicator or an empty string while waiting
      return const Text("0");
    } else if (snapshot.hasError) {
      // Handle any errors that occurred
      return Text("Error fetching progress: ${snapshot.error}");
    } else {
      // Data fetched successfully, use it in the conTainer
      return Text("${snapshot.data} / 100" ?? "0",style: const TextStyle(color: Colors.white,fontSize: 15),);
    }
  },
),
          ],
        )
      ],
    ),
  );
}

Widget conTainerr({
  required String text,
  VoidCallback? onClicked,
  required ImageProvider<Object> image,
  required Color color,
  required ImageProvider<Object> image2,
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: color,
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: onClicked,
          child: Image(
            image: image,
            height: 100,
            width: 150,
          ),
        ),
        const SizedBox(height: 7),
        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 7),
        Image(
          image: image2,
          height: 30,
          width: 30,
          )
      ],
    ),
  );
}

Future<String?> dataforcontainer() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection("MAZE_TIME")
            .where('email', isEqualTo: user.email)
            .get();

        if (snapshot.docs.isNotEmpty) {
          var data = snapshot.docs.first.data();
           return data['per'];

        }
      // ignore: empty_catches
      } catch (e) {
      }
    }
    return "0";
  }