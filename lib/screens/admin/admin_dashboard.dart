import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GymPulse Admin'),
      ),
      body: const Center(
        child: Text(
          'Welcome Admin',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}