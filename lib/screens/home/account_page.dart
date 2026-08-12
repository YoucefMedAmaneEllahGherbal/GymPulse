import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';
import '../../widgets/account_info_card.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  void initState() {
    super.initState();
    getUserData();
  }

  String? email = '';
  String? userName = '';
  String? phoneNumber = '';

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();

  void getUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc =
        FirebaseFirestore.instance.collection('users').doc(userId);

    final userData = await userDoc.get();

    setState(() {
      email = userData['email'];
      userName = userData['username'];
      phoneNumber = userData['phoneNumber'];
    });
  }

  Future updateData(String dataToChange, String newData) async {
    final useruid = FirebaseAuth.instance.currentUser!.uid;

    final userdoc =
        FirebaseFirestore.instance.collection('users').doc(useruid);

    await userdoc.update({
      dataToChange: newData,
    });
  }

  Future updateEmail(String newEmail) async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.verifyBeforeUpdateEmail(newEmail);
  }

  void checkEmail() async {
    final user = FirebaseAuth.instance.currentUser!;

    await user.reload();

    print(user.email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              FontAwesomeIcons.userCircle,
              size: 32,
              color: kAccentColor,
            ),
            SizedBox(width: 6),
            Text(
              'Account',
              style: TextStyle(
                color: kLightAccentColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            color: kAccentColor,
            height: 1,
          ),
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 18),

          AccountInfoCard(
            email: email,
            userName: userName,
            phoneNumber: phoneNumber,

            emailFocusNode: emailFocusNode,

            onEmailChanged: (value) async {
              await updateEmail(value);

              setState(() {
                email = value;
              });

              emailFocusNode.unfocus();
            },

            onEmailEdit: () {
              emailFocusNode.requestFocus();
              checkEmail();
            },

            userNameFocusNode: userNameFocusNode,

            onUserNameChanged: (value) async {
              await updateData('username', value);

              setState(() {
                userName = value;
              });

              userNameFocusNode.unfocus();
            },

            onUserNameEdit: () {
              userNameFocusNode.requestFocus();
            },

            phoneNumberFocusNode: phoneNumberFocusNode,

            onPhoneNumberChanged: (value) async {
              await updateData('phoneNumber', value);

              setState(() {
                phoneNumber = value;
              });

              phoneNumberFocusNode.unfocus();
            },

            onPhoneNumberEdit: () {
              phoneNumberFocusNode.requestFocus();
            },
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