import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/auth_screens/utils.dart';
import 'package:neuronauts_real/source/widgets/navpop.dart';
import 'package:neuronauts_real/source/widgets/textForm.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController emailController =  TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 240.0),
            const Text(
              'Enter your email to reset your password',
              style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20.0),
            textForm(
              emailController,
              "Email Is Empty",
              "Email",
              Icons.email,
              ),
            const SizedBox(height: 30.0),
            SizedBox(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              resetPassword();
                            },
                            child:const Text("Reset Password"),
                          ),
    ),
    const SizedBox(height: 20,),
    TextButton(
      onPressed: (){navPop(context);},
      child: const Text("Back"),
      )
          ],
        ),
      ),
    );
  }
  Future resetPassword() async {
    try{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text.trim());
    Utils.showSnackbar("Reset Email Was Sent");
    }on FirebaseAuthException catch (e){
      Utils.showSnackbar(e.message);
    }
  }
}
