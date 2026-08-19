import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gympulse_app/constants.dart';
import 'admin_members_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

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
            Icon(
              Icons.admin_panel_settings,
              size: 32,
              color: kLightAccentColor,
            ),
            SizedBox(width: 6),
            Text(
              'GymPulse Admin',
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
      body: Column(
        children: [
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              final docs = snapshot.data!.docs;

              return Padding(padding: const EdgeInsets.all(16));
            },
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdminMembersScreen(),
                  ),
                );
              },
              child: const Text('Members'),
            ),
          ),
        ],
      ),
    );
  }
}
