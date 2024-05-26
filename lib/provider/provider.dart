import 'package:flutter/material.dart';
import 'package:project_1/screens/dashboard_screen.dart';
import 'package:project_1/screens/profile.dart';
import 'package:provider/provider.dart';
import 'package:project_1/provider/bottomNavigationBarProvider.dart';

class ButtomNavigationProviderScreen extends StatefulWidget {
  @override
  _ButtomNavigationProviderScreenState createState() =>
      _ButtomNavigationProviderScreenState();
}

class _ButtomNavigationProviderScreenState extends State<ButtomNavigationProviderScreen> {
  var currentTab = [
    DashboardScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ButtonNavigationBarProvider>(context);
    return Scaffold(
      body: currentTab[provider.screenIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: provider.screenIndex,
        onTap: (index) {
          provider.currentIndex = index;
        },
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
