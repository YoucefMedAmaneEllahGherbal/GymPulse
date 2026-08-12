import 'package:flutter/material.dart';
import 'package:gympulse_app/screens/change_password_screen.dart';
import 'package:gympulse_app/screens/home/analytics_page.dart';
import 'package:gympulse_app/screens/home/home_content.dart';
import 'package:gympulse_app/screens/home/home_screen.dart';
import 'package:gympulse_app/screens/landing_screen.dart';
import 'package:gympulse_app/screens/login_screen.dart';
import 'package:gympulse_app/screens/registration_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Poppins'),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return LandingScreen();
          }
        },
      ),

      routes: {
        LandingScreen.id: (context) => LandingScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        HomeScreen.id: (context) => HomeScreen(),
        HomeContent.id: (context) => HomeContent(),
        AnalyticsPage.id: (context) => AnalyticsPage(),
        ChangePasswordScreen.id :(context) => ChangePasswordScreen(),
      },
    );
  }
}