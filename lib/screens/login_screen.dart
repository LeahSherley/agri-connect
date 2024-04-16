import 'package:agri_tech/screens/home_screen.dart';
import 'package:agri_tech/screens/registration_screen.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty ||
                              !value.contains('@')) {
                            return "Enter a valid Email Address";
                          }
                          return null;
                        },
                      ),
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
                      ),
                      const SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.only(left: 20, right: 20),
                        height: 40,
                        width: double.infinity,
                        child: OutlinedButton.icon(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()),
                              );
                            },
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
