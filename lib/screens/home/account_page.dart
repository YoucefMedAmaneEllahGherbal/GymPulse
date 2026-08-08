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

  final TextEditingController usernameController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();

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

  Future updateData(String dataToChange, String newData) async {
    final useruid = FirebaseAuth.instance.currentUser!.uid;

    final userdoc = FirebaseFirestore.instance.collection('users').doc(useruid);
    await userdoc.update({dataToChange: newData});
    setState(() {
      dataToChange = newData;
    });
  }

  // final phoneNbr = FirebaseFirestore.instance
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: kBackgroundColor,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  FontAwesomeIcons.userCircle,
                  size: 32,
                  color: kAccentColor,
                ),
                SizedBox(height: 12),
                Text(
                  'Account',
                  style: TextStyle(color: kLightAccentColor, fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 18),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
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
                      FaIcon(
                        FontAwesomeIcons.userCircle,
                        size: 25,
                        color: kAccentColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Account :",
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
                        child: TextFieldWidget(
                          email == null ? "you find here your email " : email!,
                          TextInputType.emailAddress,
                          false,
                          (value) {},
                          null,
                          emailFocusNode,
                          (value) async {
                            await updateData('email', value);
                            setState(() {
                              email = value;
                            });
                            emailFocusNode.unfocus();
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          emailFocusNode.requestFocus();
                        },
                        icon: Icon(Icons.edit_rounded),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                          userName == null
                              ? "you find here your username here "
                              : userName!,
                          TextInputType.text,
                          false,
                          (value) {},
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit_rounded),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFieldWidget(
                          phoneNumber == null
                              ? "you find here your phone number here "
                              : phoneNumber!,
                          TextInputType.text,
                          false,
                          (value) {},
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.edit_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 18),
            TextFieldWidget('New Username', TextInputType.text, false, (value) {
              newUserName = value;
            }, usernameController),
            ElevatedButton(
              onPressed: () async {
                usernameController.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: kAccentColor,
                foregroundColor: kBackgroundColor,
              ),
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
      ),
    );
  }
}
