// ignore_for_file: use_build_context_synchronously

import 'package:agri_tech/screens/home_screen.dart';

import 'package:agri_tech/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final _formkey = GlobalKey<FormState>();
  var _enteredemail = "";
  var _enteredpassword = "";
  var _enteredusername = "";
  bool isAuthenticating = false;

  void _registration() async {
    final isValid = _formkey.currentState!.validate();

    if (!isValid) {
      return;
    }
    _formkey.currentState!.save();
    try {
      setState(() {
        isAuthenticating = true;
      });
      final userCredentials =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _enteredemail,
        password: _enteredpassword,
      );

      FirebaseFirestore.instance
          .collection('users')
          .doc(userCredentials.user!.uid)
          .set({
        'username': _enteredusername,
        'email': _enteredemail,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        mySnackBar("Authentication Successful!"),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == "email-already-in-use") {}
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        mySnackBar(error.message ?? "Authentication Failed!"),
      );
      setState(() {
        isAuthenticating = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/splash_screen-removebg-preview.png",
                height: 150,
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.only(right: 20, left: 20),
                width: double.infinity,
                child: heading("Sign Up to AgriConnect!"),
              ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade200,
                      Colors.green.shade500,
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                ),
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email Address:',
                          labelStyle: TextStyle(
                            fontSize: 11,
                            color: Colors.green[900],
                          ),
                        ),
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return "Enter a valid Email Address";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _enteredemail = value!;
                        },
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Username:',
                            labelStyle: TextStyle(
                              fontSize: 11,
                              color: Colors.green[900],
                            ),
                          ),
                          autocorrect: false,
                          validator: (value) {
                            if (value == null ||
                                value.trim().isEmpty ||
                                value.trim().length < 6) {
                              return "Username should have atleast 6 characters!";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredusername = value!;
                          }),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Password:',
                            labelStyle: TextStyle(
                              fontSize: 11,
                              color: Colors.green[900],
                            ),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.trim().length < 6) {
                              return "Password should be atleast 6 characters";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredpassword = value!;
                          }),
                      const SizedBox(height: 30),
                      isAuthenticating
                          ? const CircularProgressIndicator(
                              strokeWidth: 2,
                            )
                          : Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              height: 40,
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                  onPressed: _registration,
                                  icon: Icon(
                                    Icons.east_rounded,
                                    size: 15,
                                    color: Colors.green[900],
                                  ),
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ))),
                                  label: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green[900],
                                    ),
                                  )),
                            ),
                      const SizedBox(
                        height: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
