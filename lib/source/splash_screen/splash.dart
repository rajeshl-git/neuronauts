import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/auth_screens/authpage.dart';
import 'package:neuronauts_real/source/auth_screens/docorchi.dart';

class CSplash extends StatefulWidget {
  const CSplash({super.key});

  @override
  State<CSplash> createState() => _CSplashState();
}

class _CSplashState extends State<CSplash> {
  bool animate = true;

  @override
  void initState() {
    super.initState();
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                //Colors.white,
               // Colors.white,
                Color.fromRGBO(215, 181, 216, 1.0),
               Color.fromRGBO(215, 181, 216, 1.0),
              ],
              ),
          ),
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(image: AssetImage("assets/brain_realone.png"),height: 300,width: 300,),
                SizedBox(height: 13,),
              ],
            ),
          ),
        ),
      ),
      
    );
  }

  Future startAnimation() async {
    await Future.delayed(const Duration(milliseconds: 3000));
    if (mounted) {
      setState(() => animate = true);
    }
    await Future.delayed(const Duration(milliseconds: 3000 ));
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const AuthPage() ),
    );
  }
}