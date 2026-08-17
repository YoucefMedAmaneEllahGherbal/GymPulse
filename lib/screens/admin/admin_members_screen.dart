import 'package:flutter/material.dart';

class AdminMembersScreen extends StatelessWidget {
  const AdminMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Members'),
      ),
      body: const Center(
        child: Text(
          'Gym Members',
          style: TextStyle(fontSize: 25),
        ),
      ),
    );
  }
}