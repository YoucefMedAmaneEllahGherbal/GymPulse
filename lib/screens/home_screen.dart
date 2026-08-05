import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gympulse_app/constants.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
    final pages = [
      HomeContent(email: email),
      AnalyticsPage(),
      AccountPage(onSignOut: () async => await _auth.signOut()),
    ];

    return Scaffold(
      backgroundColor: kBackgroundColor,
      // preserve state of each tab with IndexedStack
      body: IndexedStack(index: _selectedIndex, children: pages),
      // floating, rounded navigation bar with subtle shadow
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: Container(
            decoration: BoxDecoration(
              color: kSecondaryColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: GNav(
              selectedIndex: _selectedIndex,
              onTabChange: (index) => setState(() => _selectedIndex = index),
              rippleColor: kAccentColor.withOpacity(0.12),
              hoverColor: Colors.white12,
              haptic: true,
              gap: 6,
              iconSize: 22,
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: kAccentColor.withOpacity(0.18),
              color: Colors.grey[400],
              activeColor: kBackgroundColor,
              curve: Curves.easeOut,
              tabs: [
                GButton(
                  icon: IconData(
                    FontAwesomeIcons.house.codePoint,
                    fontFamily: FontAwesomeIcons.house.fontFamily,
                    fontPackage: FontAwesomeIcons.house.fontPackage,
                  ),
                  text: 'Home',
                ),
                GButton(
                  icon: IconData(
                    FontAwesomeIcons.chartBar.codePoint,
                    fontFamily: FontAwesomeIcons.chartBar.fontFamily,
                    fontPackage: FontAwesomeIcons.chartBar.fontPackage,
                  ),
                  text: 'Analytics',
                ),
                GButton(
                  icon: IconData(
                    FontAwesomeIcons.user.codePoint,
                    fontFamily: FontAwesomeIcons.user.fontFamily,
                    fontPackage: FontAwesomeIcons.user.fontPackage,
                  ),
                  text: 'Account',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Simple placeholder pages — replace or expand with real screens as needed
class HomeContent extends StatelessWidget {
  final String? email;
  const HomeContent({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.dumbbell, size: 64, color: kAccentColor),
          SizedBox(height: 18),
          Text(
            'Welcome${email != null ? ', ${email!.split('@').first}' : ''}',
            style: TextStyle(
              color: kLightAccentColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.chartLine, size: 64, color: kAccentColor),
          SizedBox(height: 12),
          Text(
            'Analytics',
            style: TextStyle(color: kLightAccentColor, fontSize: 18),
          ),
        ],
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  final VoidCallback onSignOut;
  const AccountPage({Key? key, required this.onSignOut}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.userCircle, size: 64, color: kAccentColor),
          SizedBox(height: 12),
          Text(
            'Account',
            style: TextStyle(color: kLightAccentColor, fontSize: 18),
          ),
          SizedBox(height: 18),
          ElevatedButton(
            onPressed: onSignOut,
            style: ElevatedButton.styleFrom(
              backgroundColor: kAccentColor,
              foregroundColor: kBackgroundColor,
            ),
            child: Text('Sign out'),
          ),
        ],
      ),
    );
  }
}
