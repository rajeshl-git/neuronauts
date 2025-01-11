import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/auth_screens/forgetpassword.dart';
import 'package:neuronauts_real/source/auth_screens/utils.dart';
import 'package:neuronauts_real/source/widgets/textForm.dart';

class LogInPage extends StatefulWidget {
  final void Function()? onPressed;
  const LogInPage({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();

  Future signInWithEmailAndPassword() async {

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text,
        password: _password.text,
      );
    } on FirebaseAuthException catch (e) {
      Utils.showSnackbar(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(215, 181, 216, 1.0),
               Color.fromRGBO(215, 181, 216, 1.0),
              ],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/brain_realone.png',height: 250,width: 250,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textForm(
                          _email,
                          "Email Is Empty",
                          "Email",
                          Icons.email,
                          ),
                        const SizedBox(
                          height: 10,
                        ),
                        textForm(
                          _password,
                          "Password Is Empty",
                          "Password",
                          Icons.password,
                          ),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> const ForgotPasswordPage()));
                              },
                              child: const Text("Forget Password",style: TextStyle(color: Colors.black),)
                              )
                          ],
                        ),
                       
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                signInWithEmailAndPassword();
                              }
                            },
                            child:const Text("Login"),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          "or",
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        dontHave(
                          "Don't Have An Account?",
                        "SignUp",
                        ),
                      ],
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ));
  }
  Widget dontHave(String txt, String button){
    return TextButton(
                          onPressed: widget.onPressed,
                          child: RichText(
                            text: const TextSpan(
                              text: "Don't have an account? ",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              children: <TextSpan>[
                                TextSpan(
                                  text: "SignUp",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 21, 0, 255),
                                      fontSize: 16),
                                ),
                              ],
                            ),
                          ),
                        );
  }
}
