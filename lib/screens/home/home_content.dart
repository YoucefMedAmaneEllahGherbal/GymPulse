import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeContent extends StatefulWidget {
  static String id = 'HomeContent';

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String? userName;

  Future getUserNAme() async {
    final useruid = FirebaseAuth.instance.currentUser!.uid;
    final userdoc = FirebaseFirestore.instance.collection('users').doc(useruid);

    final userData = await userdoc.get();
    setState(() {
      userName = userData['username'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserNAme();
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
            FaIcon(FontAwesomeIcons.dumbbell, size: 32, color: kAccentColor),
            Text(
              'Welcome $userName',
              style: TextStyle(
                color: kLightAccentColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: kAccentColor, height: 1),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [SizedBox(height: 18)],
        ),
      ),
    );
  }
}
