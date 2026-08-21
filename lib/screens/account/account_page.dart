import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gympulse_app/widgets/security_card.dart';
import 'package:gympulse_app/widgets/subscription_card.dart';

import '../../constants.dart';
import '../../widgets/account_info_card.dart';

class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    getUserData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      checkEmail();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  String? email = '';
  String? userName = '';
  String? phoneNumber = '';

  bool isEmailVerified = false;

  final FocusNode emailFocusNode = FocusNode();
  final FocusNode userNameFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();

  bool subscriptionActive = false;
  DateTime? subscriptionStartDate;
  DateTime? subscriptionExpiryDate;
  int? remainingDays;

  bool isSubscriptionExpired = false;

  void getUserData() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userDoc = FirebaseFirestore.instance.collection('users').doc(userId);

    final emailStatus = FirebaseAuth.instance.currentUser!.emailVerified;

    final userData = await userDoc.get();

    setState(() {
      email = userData['email'];
      userName = userData['username'];
      phoneNumber = userData['phoneNumber'];
      isEmailVerified = emailStatus;
      subscriptionActive = userData['subscriptionActive'];
      subscriptionStartDate = userData['subscriptionStartDate']?.toDate();
      subscriptionExpiryDate = userData['subscriptionExpiryDate']?.toDate();
      isSubscriptionExpired =
          subscriptionExpiryDate != null &&
          subscriptionExpiryDate!.isBefore(DateTime.now());
      remainingDays = subscriptionExpiryDate == null
          ? null
          : subscriptionExpiryDate!.difference(DateTime.now()).inDays;
    });
  }

  Future updateData(String dataToChange, String newData) async {
    final useruid = FirebaseAuth.instance.currentUser!.uid;

    final userdoc = FirebaseFirestore.instance.collection('users').doc(useruid);

    await userdoc.update({dataToChange: newData});
  }

  Future updateEmail(String newEmail) async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.verifyBeforeUpdateEmail(newEmail);
  }

  Future<void> checkEmail() async {
    final user = FirebaseAuth.instance.currentUser!;

    await user.reload();

    final updatedUser = FirebaseAuth.instance.currentUser!;
    setState(() {
      isEmailVerified = updatedUser.emailVerified;
    });

    print("checking the is verified variable : $isEmailVerified");
  }

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    final attendanceStream = FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('attendance')
        .orderBy('checkInTime', descending: true)
        .snapshots();
    return Scaffold(
      backgroundColor: kBackgroundColor,

      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.userCircle, size: 32, color: kAccentColor),
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
          child: Container(color: kAccentColor, height: 1),
        ),
      ),

      body: SingleChildScrollView(
        child: Column(
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

            SubscriptionCard(
              subscriptionActive,
              subscriptionStartDate,
              subscriptionExpiryDate,
              remainingDays,
              isSubscriptionExpired,
            ),
            const SizedBox(height: 18),

            StreamBuilder(
              stream: attendanceStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }

                if (snapshot.hasError) {
                  return const Text("Something went wrong");
                }

                final attendanceRecords = snapshot.data!.docs;

                return Column(
                  children: [
                    const Text(
                      "Attendance",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: kAccentColor,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      "Total visits: ${attendanceRecords.length}",
                      style: const TextStyle(
                        fontSize: 18,
                        color: kLightAccentColor,
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 18),
            SecurityCard(isEmailVerified!, () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Password changed succesfully")),
              );
            }),

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
