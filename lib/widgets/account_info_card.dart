import 'package:flutter/material.dart';
import '../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gympulse_app/widgets/text_field_widget.dart';

class AccountInfoCard extends StatelessWidget {
  const AccountInfoCard({
    super.key,
    required this.email,
    required this.userName,
    required this.phoneNumber,
    required this.emailFocusNode,
    required this.onEmailChanged,
    required this.onEmailEdit,
    required this.userNameFocusNode,
    required this.onUserNameChanged,
    required this.onUserNameEdit,
    required this.phoneNumberFocusNode,
    required this.onPhoneNumberChanged,
    required this.onPhoneNumberEdit,
  });

  final String? email;
  final String? userName;
  final String? phoneNumber;
  final FocusNode emailFocusNode;
  final Future<void> Function(String) onEmailChanged;
  final VoidCallback onEmailEdit;
  final FocusNode userNameFocusNode;
  final Future<void> Function(String) onUserNameChanged;
  final VoidCallback onUserNameEdit;
  final FocusNode phoneNumberFocusNode;
  final Future<void> Function(String) onPhoneNumberChanged;
  final VoidCallback onPhoneNumberEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: 12),
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
                  onEmailChanged,
                ),
              ),
              IconButton(
                onPressed: onEmailEdit,
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
                  null,
                  userNameFocusNode,
                  onUserNameChanged,
                ),
              ),
              IconButton(
                onPressed: onUserNameEdit,
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
                  TextInputType.phone,
                  false,
                  (value) {},
                  null,
                  phoneNumberFocusNode,
                  onPhoneNumberChanged,
                ),
              ),
              IconButton(
                onPressed: onPhoneNumberEdit,
                icon: Icon(Icons.edit_rounded),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
