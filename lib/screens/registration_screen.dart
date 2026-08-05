import 'package:flutter/material.dart';
import 'package:gympulse_app/constants.dart';
import 'package:gympulse_app/screens/login_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widgets/text_field_widget.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  static const String id = "RegistrationScreen";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: 'logo',
                    child: Image(
                      image: AssetImage("assets/images/GymPulse_icon.png"),
                      width: 100,
                      height: 100,
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
                    TextFieldWidget("Enter Your E-mail"),
                    TextFieldWidget("Enter Your Username"),
                    TextFieldWidget("Enter Your Phone Number"),
                    TextFieldWidget("Enter Your Password"),
                    TextFieldWidget("Enter Your Password"),
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
                    onPressed: () {},
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
    );
  }
}
