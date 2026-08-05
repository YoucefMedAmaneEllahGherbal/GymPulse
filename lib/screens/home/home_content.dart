import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeContent extends StatelessWidget {
  final String? email;
  const HomeContent({Key? key, this.email}) : super(key: key);

  static String id = 'HomeContent';

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.dumbbell, size: 64, color: kAccentColor),
          SizedBox(height: 18),
          Text(
            'Welcome${email != null ? ', ${email!.split('@').first}' : ''}',
            style: TextStyle(
              color: kLightAccentColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
