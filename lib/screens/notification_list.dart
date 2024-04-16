import 'package:agri_tech/models/notifications.dart';
import 'package:agri_tech/screens/home_screen.dart';
import 'package:agri_tech/screens/notifications.dart';
import 'package:agri_tech/widgets/widgets.dart';
import 'package:flutter/material.dart';

class NotificationList extends StatefulWidget {
  const NotificationList({super.key});

  @override
  State<NotificationList> createState() => _NotificationListState();
}

class _NotificationListState extends State<NotificationList> {
  List<Notifications> notifications = [
    Notifications(
        title: "Welcome to AgriConnect!",
        body:
            "An intuitive agricultural management app fostering seamless communication and collaboration among farmers, suppliers, and experts, enhancing productivity and sustainability in the agricultural sector."),
    Notifications(
        title: "This is a sample title!",
        body: "This is still about everything I prayed for and more!"),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.green[50],
        centerTitle: true,
        title: scaffoldtext("My Notifications"),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.green[800],
            size: 28,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement<void, void>(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomePage(),
              ),
            );
          },
        ),
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text(
                "No notifications",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.deepPurple,
                ),
              ),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 20,
                  ),
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.green,
                      style: BorderStyle.none,
                    ),
                  ),
                  child: ListTile(
                    leading: Image.asset(
                      "assets/images/splash_screen-removebg-preview.png",
                    ),
                    isThreeLine: true,
                    title: Text(
                      notification.title,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      notification.body,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                    trailing: Icon(
                      Icons.notifications_active,
                      color: Colors.red[200],
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MyNotifications(notifications: notification),
                      ));
                    },
                  ),
                );
              },
            ),
    );
  }
}
