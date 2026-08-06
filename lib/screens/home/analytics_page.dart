import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gympulse_app/screens/home/bottom_navbar.dart';
import '../../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({Key? key}) : super(key: key);

  static String id = 'AnalyticPage';

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
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
            ElevatedButton(
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              },
              child: Text("Logout"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavbar(),
    );
  }
}
