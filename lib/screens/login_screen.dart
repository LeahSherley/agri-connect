// ignore_for_file: use_build_context_synchronously

import 'package:agri_tech/screens/home_screen.dart';
import 'package:agri_tech/screens/registration_screen.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  var _enteredemail = "";
  var _enteredpassword = "";
  bool isAuthenticating = false;

  void _login() async {
    final isValid = _formkey.currentState!.validate();

    if (!isValid) {
      return;
    }
    _formkey.currentState!.save();
    try {
      setState(() {
        isAuthenticating = true;
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _enteredemail,
        password: _enteredpassword,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        mySnackBar("Login Successful!"),
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
                child: heading("Welcome to AgriConnect!"),
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
                          textCapitalization: TextCapitalization.none,
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
                            if (value == null || value.trim().isEmpty) {
                              return "Enter Password";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _enteredpassword = value!;
                          }),
                      const SizedBox(height: 20),
                      isAuthenticating
                          ? const CircularProgressIndicator(
                              strokeWidth: 2.0,
                            )
                          : Container(
                              margin:
                                  const EdgeInsets.only(left: 20, right: 20),
                              height: 40,
                              width: double.infinity,
                              child: OutlinedButton.icon(
                                  onPressed: _login,
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
                                    "LogIn",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.green[900],
                                    ),
                                  )),
                            ),
                      const SizedBox(
                        height: 18,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const Registration(),
                              ),
                            );
                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.green[900],
                            ),
                          ))
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
