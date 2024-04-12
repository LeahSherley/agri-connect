import 'package:agri_tech/screens/community.dart';
import 'package:agri_tech/screens/home.dart';
import 'package:agri_tech/screens/market_place.dart';
import 'package:agri_tech/screens/services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex = 0;
  final bar = [
    const Home(),
    const MarketPlace(),
    const Community(),
    const Services(),
  ];

  List<BottomNavigationBarItem> barItem = [
    const BottomNavigationBarItem(
      label: "Home",
      icon: Icon(
        Icons.home_rounded,
      ),
    ),
    const BottomNavigationBarItem(
      label: "Marketplace",
      icon: Icon(
        Icons.storefront_outlined,
      ),
    ),
    const BottomNavigationBarItem(
      label: "Community",
      icon: Icon(
        Icons.group,
      ),
    ),
    const BottomNavigationBarItem(
      label:"My Products",
      icon: Icon(
        Icons.agriculture_rounded,
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: bar[currentIndex],
    bottomNavigationBar: BottomNavigationBar(
      elevation: 10.0,
        enableFeedback: true,
        currentIndex: currentIndex,
        items: barItem,
        unselectedItemColor: Colors.grey[700],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green[100],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}