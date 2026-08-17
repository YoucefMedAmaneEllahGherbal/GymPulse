import 'package:flutter/material.dart';
import '../../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'admin_member_details_screen.dart';

class AdminMembersScreen extends StatelessWidget {
  const AdminMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: kLightAccentColor),
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.people_alt, color: kAccentColor, size: 32),
            SizedBox(width: 6),
            Text(
              'Members',
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
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('role', isEqualTo: "user")
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];

              return ListTile(
                title: Text(
                  user['username'],
                  style: TextStyle(color: kAccentColor, fontSize: 15),
                ),
                subtitle: Text(
                  user['email'],
                  style: TextStyle(color: kAccentColor, fontSize: 15),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AdminMemberDetailsScreen(user: user,),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
