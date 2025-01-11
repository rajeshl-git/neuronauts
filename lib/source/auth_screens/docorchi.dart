import 'package:audioplayers/audioplayers.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:neuronauts_real/source/auth_screens/authpage.dart';
import 'package:neuronauts_real/source/auth_screens/authpage1.dart';
import 'package:neuronauts_real/source/dashboard/dashboard.dart';
import 'package:neuronauts_real/source/doctor_screen/doc_dashboard.dart';
import 'package:neuronauts_real/source/games/organizing/balloon%20pop/game.dart';

class DocorChi extends StatefulWidget {
  const DocorChi({super.key});

  @override
  State<DocorChi> createState() => _DocorChiState();
}

class _DocorChiState extends State<DocorChi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (builder)=> DoctorDashboard()));}, child: Text("Doctor")),
            SizedBox(height: 20,),
            ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (builder)=> DashBoard()));
              }, child: Text("Child"))
          ],
        ),
      ),
    );
  }
}
