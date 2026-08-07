import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountPage extends StatelessWidget {
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
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
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
