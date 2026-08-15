import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gympulse_app/constants.dart';
import '../../widgets/text_field_widget.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();

  static String id = 'ChangePasswordSreen';
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String? newPassword;
  String? confirmedPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Change Your Password",
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
      body: Container(
        color: kSecondaryColor,
        child: Column(
          children: [
            TextFieldWidget("New Password", TextInputType.text, true, (value) {
              newPassword = value;
            }),
            TextFieldWidget("Confirm Your Password", TextInputType.text, true, (
              value,
            ) {
              confirmedPassword = value;
            }),
            ElevatedButton(
              onPressed: () async {
                if (newPassword == "") {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Passwords cannot be empty",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else if (newPassword != confirmedPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        "Passwords doesnt match",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                } else {
                  try {
                    await FirebaseAuth.instance.currentUser!.updatePassword(
                      newPassword!,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Password Changed Succesfully")),
                    );
                   Navigator.pop(context , true);
                  } on FirebaseAuthException catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.code, textAlign: TextAlign.center),
                      ),
                    );
                  }
                }
              },
              child: Text("Update Password"),
            ),
          ],
        ),
      ),
    );
  }
}
