
// ignore_for_file: use_build_context_synchronously, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:neuronauts_real/source/widgets/textForm.dart';

class SignUp extends StatefulWidget {
  final void Function()? onPressed;
  const SignUp({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}


class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _fullnamecontroller = TextEditingController();
  final TextEditingController _rollnocontroller = TextEditingController();

  void createUserWithEmailAndPassword() async {
    try {
      if (mounted) {
        setState(() {
          isLoading = true;
        });
      }
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      await gameUser(_email.text);
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
      if (e.code == 'weak-password') {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("The password provided is too weak.")),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("The account already exists for that email.")),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
    userDetails(
      _fullnamecontroller.text.trim(),
      int.parse(_rollnocontroller.text.trim()),
      _email.text.trim());
  }
  
  Future userDetails(String fullname,int rollno,String email) async{
    await FirebaseFirestore.instance.collection('HERE').add({
      'fullname': fullname,
      'rollno': rollno,
      'email': email,
    });
  }
  Future gameUser(String email, ) async{
    await FirebaseFirestore.instance.collection('MAZE_TIME').add({
      'email': email,
      'level1': 0,
      'level2': 0,
      'level3': 0,
      'level4': 0,
      'bronze': 0,
      'silver': 0,
      'gold': 0,
      'platinum':0,
      'per': 0,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(
        //centerTitle: true,
        //title: const Text("SignUp"),
      //),
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/brain_realone.png',height: 230,width: 230,
              
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textForm(
                          _fullnamecontroller,
                        "Name Is Empty",
                        "FullName",
                        Icons.person,
                        ),
                        
                        const SizedBox(height: 10,),
                        textForm(
                          _rollnocontroller, 
                        "Phoneno Is Empty", 
                        "PhoneNo", 
                        Icons.phone,
                        ),
                 
                        const SizedBox(height: 10,),
                        textForm(
                          _email,
                          "Email Is Empty",
                          "Email",
                          Icons.email,
                          ),
                          const SizedBox(height: 10,),
                          textForm(
                            _password,
                          "Password Is Empty",
                           "Password",
                          Icons.password,
                          ),
                        const SizedBox(height: 20,),
                        SizedBox(
                          width: double.infinity,
                          height: 45,
                          child: ElevatedButton(
                            style:  ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(127, 3, 131, 1),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              if (_formkey.currentState!.validate()) {
                                createUserWithEmailAndPassword();
                              }
                            },
                            child: isLoading
                                ? const Center(child: CircularProgressIndicator(color: Colors.white))
                                : const Text("Signup"),
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text("or",style: TextStyle(fontSize: 16),),
                        const SizedBox(height: 6),
                        TextButton(
                        onPressed: widget.onPressed,
                        child: RichText(
                          text: const TextSpan(
                            text: "Already have an account? ",
                            style: TextStyle(color: Colors.black,fontSize: 16),
                            children: <TextSpan>[
                              TextSpan(
                                text: "LogIn",
                                style: TextStyle(color: Color.fromARGB(255, 21, 0, 255),fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        ),
                    
                      ],
                    ),
                  ),
                ),
                        ),
              ),
            ]
          ),
        ),
        ),
      )
    );
  }
}

