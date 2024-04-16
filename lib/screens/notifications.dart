import 'package:agri_tech/models/notifications.dart';
import 'package:agri_tech/screens/notification_list.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';

class MyNotifications extends StatelessWidget {
  const MyNotifications({super.key, required this.notifications});
  final Notifications notifications;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: scaffoldtext("My Notifications"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const NotificationList()));
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.green[100]!,
                Colors.green[50]!,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 150,
                child: Image.asset(
                  "assets/images/splash_screen-removebg-preview.png",
                  
                ),
              ),
              const SizedBox(height: 5),
              Text(
                notifications.title,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.green[200],
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                notifications.body,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.green[200],
                ),
                textAlign: TextAlign.center,

              ),
              const SizedBox(height: 15),
              RichText(
                text: const TextSpan(
                  text: '© ',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                  children: [
                    TextSpan(
                      text: 'AgriConnect',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 10,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
