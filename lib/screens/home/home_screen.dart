import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gympulse_app/constants.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gympulse_app/screens/account/account_page.dart';
import 'package:gympulse_app/screens/home/analytics_page.dart';
import 'package:gympulse_app/screens/home/bottom_navbar.dart';
import 'home_content.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static final String id = 'HomesCreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  User? loggedInUser;
  String? email;
  int _selectedIndex = 0;

  final List<Widget> _pages = [HomeContent(), AnalyticsPage(), AccountPage()];

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        setState(() {
          loggedInUser = user;
          email = loggedInUser!.email;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Pages for each tab — keep simple placeholders so navigation is visible

    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,

        body: _pages[_selectedIndex],

        bottomNavigationBar: BottomNavbar(
          updateIndex: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}
