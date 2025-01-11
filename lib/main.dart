
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/auth_screens/utils.dart';
import 'package:neuronauts_real/source/splash_screen/splash.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: Utils.messengerKey, 
      theme: ThemeData(
      ),
      home: const CSplash(),
    );
  }
}


 