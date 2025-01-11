import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/auth_screens/loginpage.dart';
import 'package:neuronauts_real/source/auth_screens/signupage.dart';
class LogInAndSignUp extends StatefulWidget {
  const LogInAndSignUp({Key? key});

  @override
  State<LogInAndSignUp> createState() => _LogInAndSignUpState();
}

class _LogInAndSignUpState extends State<LogInAndSignUp> {
  bool isLogin = true;

  void togglePage() {
    setState(() {
      isLogin = !isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLogin) {
      return LogInPage(onPressed: togglePage);
    } else {
      return SignUp(onPressed: togglePage);
    }
  }
}
