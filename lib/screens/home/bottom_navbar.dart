import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gympulse_app/screens/home/analytics_page.dart';
import 'package:gympulse_app/screens/home/home_screen.dart';
import '../../constants.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                },
                icon: IconData(
                  FontAwesomeIcons.house.codePoint,
                  fontFamily: FontAwesomeIcons.house.fontFamily,
                  fontPackage: FontAwesomeIcons.house.fontPackage,
                ),
                text: 'Home',
              ),
              GButton(
                onPressed: () {
                  Navigator.pushNamed(context, AnalyticsPage.id);
                },
                icon: IconData(
                  FontAwesomeIcons.chartBar.codePoint,
                  fontFamily: FontAwesomeIcons.chartBar.fontFamily,
                  fontPackage: FontAwesomeIcons.chartBar.fontPackage,
                ),
                text: 'Analytics',
              ),
              GButton(
                onPressed: () {
                  Navigator.pushNamed(context, HomeScreen.id);
                },
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
    );
  }
}
