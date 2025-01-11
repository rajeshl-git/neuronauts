import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/auth_screens/utils.dart';
import 'package:neuronauts_real/source/dashboard/dashboard.dart';
import 'package:neuronauts_real/source/doctor_screen/doc_dashboard.dart';

class EmailVerify1 extends StatefulWidget {
  const EmailVerify1({super.key});

  @override
  State<EmailVerify1> createState() => _EmailVerify1State();
}

class _EmailVerify1State extends State<EmailVerify1> {
  bool isEmailVerified = false;
Timer? timer;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    if(!isEmailVerified){
      sendVerificationEmail();
      timer = Timer.periodic(const Duration(seconds: 3),
       (_) => checkEmailVerified(),
       );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified=FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if(isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try{
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
    }catch(e){
      Utils.showSnackbar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
  ? const DoctorDashboard()
  :Scaffold(
    appBar: AppBar(
      title: const Text("Verify"),
    ),
    body: Center(
      child: Column(
        children: [
          const SizedBox(height: 240,),
          const Text("Verification Mail Has Been Sent To Your Email",style: TextStyle(fontWeight: FontWeight.bold),),
          const SizedBox(height: 200,),
          TextButton(onPressed: () async {
            await FirebaseAuth.instance.signOut();
            
          },
          child: const Text("Back",style: TextStyle(color: Color.fromRGBO(215, 181, 216, 1.0),),))
        ],
      ),
    ),
  );
}