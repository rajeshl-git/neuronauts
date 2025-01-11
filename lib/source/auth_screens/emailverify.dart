import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/auth_screens/docorchi.dart';
import 'package:neuronauts_real/source/auth_screens/utils.dart';
import 'package:neuronauts_real/source/dashboard/dashboard.dart';

class EmailVerify extends StatefulWidget {
  const EmailVerify({super.key});

  @override
  State<EmailVerify> createState() => _EmailVerifyState();
}

class _EmailVerifyState extends State<EmailVerify> {
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
  ? const DocorChi()
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