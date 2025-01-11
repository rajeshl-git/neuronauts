import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/auth_screens/emailverify.dart';
import 'package:neuronauts_real/source/auth_screens/login_signup.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

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
              return const LogInAndSignUp();
            }
          }
        },
        ),
    );
  }
}