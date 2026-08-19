import 'package:flutter/material.dart';
import 'package:gympulse_app/constants.dart';
import 'package:gympulse_app/screens/home/home_screen.dart';
import 'package:gympulse_app/screens/auth/login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../../widgets/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  static const String id = "RegistrationScreen";

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;

  String? email;

  String? userName;

  String? password;

  String? confirmationPassword;

  String? phoneNumber;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: kBackgroundColor,
          body: SingleChildScrollView(
            child: Column(
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
                  "Join Thousands Of BodyBuilders",
                  style: TextStyle(
                    color: kLightAccentColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
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
                    children: [
                      TextFieldWidget(
                        "Enter Your E-mail",
                        TextInputType.emailAddress,
                        false,
                        (value) {
                          email = value;
                        },
                        null,
                      ),
                      TextFieldWidget(
                        "Enter Your Username",
                        TextInputType.text,
                        false,
                        (value) {
                          userName = value;
                        },
                        null,
                      ),
                      TextFieldWidget(
                        "Enter Your Phone Number",
                        TextInputType.phone,
                        false,
                        (value) {
                          phoneNumber = value;
                        },
                        null,
                      ),
                      TextFieldWidget(
                        "Enter Your Password",
                        TextInputType.text,
                        true,
                        (value) {
                          password = value;
                        },
                        null,
                      ),
                      TextFieldWidget(
                        "Enter Your Password",
                        TextInputType.text,
                        true,
                        (value) {
                          confirmationPassword = value;
                        },
                        null,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(kAccentColor),
                      ),
                      onPressed: () async {
                        try {
                          if (password == confirmationPassword) {
                            setState(() {
                              showSpinner = true;
                            });
                            final newUser = await _auth
                                .createUserWithEmailAndPassword(
                                  email: email!,
                                  password: password!,
                                );

                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(newUser.user!.uid)
                                .set({
                                  'email': email,
                                  'phoneNumber': phoneNumber,
                                  'username': userName,
                                  'role': "user",
                                  'subscriptionActive': false,
                                  'subscriptionStartDate': null,
                                  'subscriptionExpiryDate': null,
                                });
                            setState(() {
                              showSpinner = false;
                            });
                            Navigator.pop(context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Password doesnt match")),
                            );
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        } on FirebaseAuthException catch (e) {
                          setState(() {
                            showSpinner = false;
                          });
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(getError(e))));
                          return;
                        }
                      },
                      child: Text(
                        "Register",
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
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: Text(
                    "Already have an Account? Login",
                    style: TextStyle(
                      color: kLightAccentColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  "Or register with : ",
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
      ),
    );
  }
}
