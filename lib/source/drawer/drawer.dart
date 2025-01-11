import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/drawer/content_drawer/activities.dart';
import 'package:neuronauts_real/source/performance/progress.dart';

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({super.key});

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(35),
          bottomRight: Radius.circular(35)
          )
          ),
      child: Material(
        color: const Color.fromRGBO(157, 118, 193, 1.0),
        child: ListView(
          padding: padding,
          children: <Widget>[
            buildHeader(),
            const SizedBox(height: 10,),
            const Divider(color: Colors.black,thickness: 0.8,),
            const SizedBox(height: 25,),
            buildMenuItem(
              text: 'Activities',
              icon: Icons.gamepad,
              onClicked: () => selectedItem(context, 0),
            ),
            buildMenuItem(
              text: 'Progress',
              icon: Icons.circle,
              onClicked: () => selectedItem(context, 1),
            ),
            const SizedBox(height: 300,),
            const Divider(color: Colors.black,thickness: 0.8,),
            const SizedBox(height: 5,),
            buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
              onClicked: () => confirmLogout(context),
            ),
          ],
        ),
      ),
    );
  }
}

void confirmLogout(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(dialogContext).pop(); 
            },
          ),
          TextButton(
            child: const Text('Yes'),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              // ignore: use_build_context_synchronously
              Navigator.of(dialogContext).pop(); 
            },
          ),
        ],
      );
    },
  );
}

Widget buildMenuItem({
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  const color = Colors.black;
  const hoverColor = Colors.black;
  return ListTile(
    leading: Icon(icon, color: color, size: 27,),
    title: Text(text, style: const TextStyle(color: color, fontSize: 16),),
    hoverColor: hoverColor,
    onTap: onClicked,
  );
}

Future<void> selectedItem(BuildContext context, int index) async {
  Navigator.of(context).pop();
  switch(index) {
    case 0:{
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const Activities()));
    break;
    }
    case 1: {
      Navigator.push(context, MaterialPageRoute(builder: (context)=> const GameProgress()));
    break;
    }
  }
  }

Widget buildHeader(){
  final user = FirebaseAuth.instance.currentUser!;
  return StreamBuilder(
            stream: FirebaseFirestore.instance.collection("HERE").where('email', isEqualTo: user.email).snapshots(),
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
                        Text(data['fullname'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.white)),
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
          );

}