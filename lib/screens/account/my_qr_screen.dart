import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gympulse_app/constants.dart';
import 'package:qr_flutter/qr_flutter.dart';

class MyQrScreen extends StatelessWidget {
  const MyQrScreen({super.key});
  static String id = "MyQrScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        iconTheme: IconThemeData(color: kLightAccentColor),
        title: Text(
          "My Qr Code",
          style: TextStyle(
            color: kLightAccentColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: kAccentColor, height: 1),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Show This Qr code to GYM Staff to check in",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: kLightAccentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 25),
            Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: QrImageView(data: FirebaseAuth.instance.currentUser!.uid),
            ),
          ],
        ),
      ),
    );
  }
}
