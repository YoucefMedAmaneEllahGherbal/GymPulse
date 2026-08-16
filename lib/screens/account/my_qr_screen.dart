import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:qr_flutter/qr_flutter.dart';



class MyQrScreen extends StatelessWidget {
  const MyQrScreen({super.key});
  static String id = "MyQrScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Qr Code"),
      ),
      body: Center(
        child: QrImageView(data: FirebaseAuth.instance.currentUser!.uid)
      ),
    );
  }
}