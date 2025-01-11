import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/auth_screens/login1.dart';
import 'package:neuronauts_real/source/auth_screens/loginpage.dart';
import 'package:neuronauts_real/source/auth_screens/signupage.dart';
class LogInAndSignUp1 extends StatefulWidget {
  const LogInAndSignUp1({Key? key});

  @override
  State<LogInAndSignUp1> createState() => _LogInAndSignUpState();
}

class _LogInAndSignUpState extends State<LogInAndSignUp1> {
  bool isLogin = true;

  void togglePage() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LogInPage1(onPressed: togglePage);
    } else {
      return SignUp(onPressed: togglePage);
    }
  }
}