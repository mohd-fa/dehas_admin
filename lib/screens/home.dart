import 'package:dehas_admin/screens/locationpage.dart';
import 'package:dehas_admin/screens/settingspage.dart';
import 'package:flutter/material.dart';
import 'package:sliding_clipped_nav_bar/sliding_clipped_nav_bar.dart';
import 'package:dehas_admin/screens/homepage.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int navindex = 0;
  final List<Widget> pages = [
     HomePage(),
    const LocationPage(),
    const SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[navindex],
      appBar: AppBar(
        title: const Text(
          'DEHAS admin',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      bottomNavigationBar: SlidingClippedNavBar(
        backgroundColor: Colors.red,
        activeColor: Colors.white,
        selectedIndex: navindex,
        onButtonPressed: (index) => setState(() {
          navindex = index;
        }),
        barItems: [
          BarItem(title: 'Home', icon: Icons.home_rounded),
          BarItem(title: 'Drone Locations', icon: Icons.location_on),
          BarItem(title: 'Settings', icon: Icons.settings),
        ],
      ),
    );
  }
}
