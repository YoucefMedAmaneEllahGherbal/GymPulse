import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gympulse_app/widgets/text_field_widget.dart';
import '../../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  String? email = '';
  String? userName = '';
  String? phoneNumber = '';
  String? newUserName;

  void getUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    final userData = await userDoc.get();

    setState(() {
      email = userData['email'];
      userName = userData['username'];
      phoneNumber = userData['phoneNumber'];
    });
  }

  // final phoneNbr = FirebaseFirestore.instance
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
            'Welcome $userName',
            style: TextStyle(color: kLightAccentColor, fontSize: 18),
          ),
          SizedBox(height: 18),
          Text(
            'Your Email : $email',
            style: TextStyle(color: kLightAccentColor, fontSize: 18),
          ),
          SizedBox(height: 18),
          Text(
            'Phone Number : $phoneNumber',
            style: TextStyle(color: kLightAccentColor, fontSize: 18),
          ),
          SizedBox(height: 18),
          TextFieldWidget('New Username', TextInputType.text, true, (value) {
            newUserName = value;
          }),
          ElevatedButton(
            onPressed: () async {
              final useruid = FirebaseAuth.instance.currentUser!.uid;

              final userdoc = FirebaseFirestore.instance
                  .collection('users')
                  .doc(useruid);
              await userdoc.update({'username': newUserName});
            },
            child: Text('Update Username'),
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
