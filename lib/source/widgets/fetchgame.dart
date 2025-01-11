import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<int> fetchGameProgress2(String batch,) async {
     int b = 0;
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        final snapshot = await FirebaseFirestore.instance
            .collection("MAZE_TIME")
            .where('email', isEqualTo: user.email)
            .get();

        if (snapshot.docs.isNotEmpty) {
          var data = snapshot.docs.first.data();
          b = data[batch] ?? 0;
        }
        return b;
      // ignore: empty_catches
      } catch (e) {
      }
    }
    return 0; // Return a default value if no progress is found
  }

   Future<String?> fetchGameProgress1() async {
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
