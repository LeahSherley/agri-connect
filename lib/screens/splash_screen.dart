import 'dart:async';

import 'package:agri_tech/screens/login_screen.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 10), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              heading("AgriConnect"),
              const SizedBox(
                height:15,
              ),
              Image.asset("assets/images/splash_screen-removebg-preview.png", height:150,),
              const SizedBox(
                height:15,
              ),
              heading("Empowering Smallholder Farmers Through Accessible Resources and Community Support"),
              /*const CircularProgressIndicator(
                color: Colors.green,
                strokeWidth: 2,
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}
