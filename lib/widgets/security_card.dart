import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gympulse_app/screens/change_password_screen.dart';
import '../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SecurityCard extends StatelessWidget {
  const SecurityCard(this.isEmailVerified, this.onPasswordChanged);

  final bool isEmailVerified;
  final VoidCallback onPasswordChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 12),
      alignment: Alignment.topLeft,
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              FaIcon(FontAwesomeIcons.lock, size: 25, color: kAccentColor),
              SizedBox(width: 8),
              Text(
                "Security :",
                style: TextStyle(
                  color: kAccentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Change Password",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kAccentColor),
                ),
              ),
              IconButton(
                onPressed: () async {
                  final result = await Navigator.pushNamed(
                    context,
                    ChangePasswordScreen.id,
                  );
                  if (result == true) {
                    onPasswordChanged();
                  }
                },
                icon: Icon(Icons.arrow_right_alt_outlined, size: 32),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  "Email Status : ${isEmailVerified ? "Email verified" : "not verified"}",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: kAccentColor),
                ),
              ),
              if (isEmailVerified)
                Icon(Icons.check_outlined, size: 32, color: Colors.green)
              else
                Icon(Icons.close_outlined, size: 32, color: Colors.red),
              if (!isEmailVerified)
                TextButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.currentUser!
                        .sendEmailVerification();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Email verification sent succesfully"),
                      ),
                    );
                  },
                  child: Text(
                    "Verify Now",
                    style: TextStyle(color: kLightAccentColor),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
