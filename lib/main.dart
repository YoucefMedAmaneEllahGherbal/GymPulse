import 'package:flutter/material.dart';
import 'package:gympulse_app/screens/landing_screen.dart';
import 'package:gympulse_app/screens/login_screen.dart';
import 'package:gympulse_app/screens/registration_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingScreen(),

      routes: {
        LandingScreen.id: (context) => LandingScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
      },
    );
  }
}
