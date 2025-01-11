import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/auth_screens/emailverify.dart';
import 'package:neuronauts_real/source/auth_screens/login_signup.dart';
import 'package:neuronauts_real/source/auth_screens/loginsignup1.dart';

class AuthPage1 extends StatelessWidget {
  const AuthPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context ,snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting){
            return const CircularProgressIndicator();
          }else{
            if(snapshot.hasError){
              return const Center(child: Text("Something Went Wrong.."),);
            }else if(snapshot.hasData) {
              return  const EmailVerify();
            }else{
              return const LogInAndSignUp1();
            }
          }
        },
        ),
    );
  }
}