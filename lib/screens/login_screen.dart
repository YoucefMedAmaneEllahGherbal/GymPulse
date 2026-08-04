import 'package:flutter/material.dart';
import 'package:gympulse_app/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "GymPulse",
            style: TextStyle(
              color: kLightAccentColor,
              fontWeight: FontWeight.bold,
              fontSize: 35,
            ),
          ),
          Text(
            "Welcome Back",
            style: TextStyle(
              color: kLightAccentColor,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "Enter Your Email",
                filled: true,
                fillColor: kLightAccentColor,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                hintText: "Enter Your Password",
                filled: true,
                fillColor: kLightAccentColor,
              ),
            ),
          ),
          SizedBox(height: 25),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(kAccentColor),
              ),
              onPressed: () {},
              child: Text(
                "Login",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              print("forgot password button pressed ");
            },
            child: Text(
              "Forgot your password?",
              style: TextStyle(
                color: kLightAccentColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
