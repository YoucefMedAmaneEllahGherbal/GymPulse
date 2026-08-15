import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:gympulse_app/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gympulse_app/screens/home/home_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';

const String id = "LoginScreen";

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  static const String id = "LoginScreen";

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

String getError(FirebaseAuthException e) {
  if (e.code == "invalid-credential") {
    return "invalid-credential";
  }
  if (e.code == "network-request-failed") {
    return "Network error";
  }
  return "";
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Hero(
                      tag: 'logo',
                      child: Image(
                        image: AssetImage("assets/images/GymPulse_icon.png"),
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                  Text(
                    "GymPulse",
                    style: TextStyle(
                      color: kLightAccentColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
              Text(
                "Welcome Back",
                style: TextStyle(
                  color: kLightAccentColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kSecondaryColor,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                width: double.infinity,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFieldWidget(
                      "Enter Your E-mail",
                      TextInputType.emailAddress,
                      false,
                      (value) {
                        email = value;
                      },
                      
                    ),
                    TextFieldWidget(
                      "Enter Your Password",
                      TextInputType.text,
                      true,
                      (value) {
                        password = value;
                      },
                      
                    ),
                    SizedBox(height: 15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                              kAccentColor,
                            ),
                          ),
                          onPressed: () async {
                            try {
                              if (email == null ||
                                  email!.isEmpty ||
                                  password == null ||
                                  password!.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Email and passwsord are required to login",
                                    ),
                                  ),
                                );
                                return;
                              }
                              setState(() {
                                showSpinner = true;
                              });
                              final user = await _auth
                                  .signInWithEmailAndPassword(
                                    email: email!,
                                    password: password!,
                                  );
                              if (user != null) {
                                setState(() {
                                  showSpinner = false;
                                });
                                Navigator.pop(context);
                              }
                            } on FirebaseAuthException catch (e) {
                              setState(() {
                                showSpinner = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(getError(e))),
                              );
                            }
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        print("forgot password button pressed ");
                      },
                      child: Text(
                        "Forgot your password?",
                        style: TextStyle(
                          color: kLightAccentColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                "Or login with : ",
                style: TextStyle(
                  color: kLightAccentColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: kSecondaryColor,
                ),
                width: 170,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.googlePlus,
                        color: Colors.white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.facebook,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
