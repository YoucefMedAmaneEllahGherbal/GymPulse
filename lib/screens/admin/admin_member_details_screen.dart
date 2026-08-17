import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminMemberDetailsScreen extends StatefulWidget {
  const AdminMemberDetailsScreen({super.key, required this.user});

  final dynamic user;

  @override
  State<AdminMemberDetailsScreen> createState() =>
      _AdminMemberDetailsScreenState();
}

class _AdminMemberDetailsScreenState extends State<AdminMemberDetailsScreen> {
  int selectedDuration = 30;

  @override
  Widget build(BuildContext context) {
    final userStream = FirebaseFirestore.instance
        .collection('users')
        .doc(widget.user.id)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        iconTheme: IconThemeData(color: kLightAccentColor),
        backgroundColor: kBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 32, color: kAccentColor),
            SizedBox(width: 6),
            Text(
              'Member Details',
              style: TextStyle(
                color: kAccentColor,
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

      body: StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final user = snapshot.data!;
          final subscriptionActive = user['subscriptionActive'] ?? false;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Username: ${user['username']}'),
                Text('Email: ${user['email']}'),
                Text('Phone: ${user['phoneNumber']}'),
                Text('Subscription Active: $subscriptionActive'),

                const SizedBox(height: 20),

                const Text(
                  'Subscription',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                if (subscriptionActive == true) ...[
                  Text('Status: Active'),
                  Text(
                    'Start: ${DateFormat.MMMEd().format(user['subscriptionStartDate'].toDate()).toString()}',
                  ),
                  Text(
                    'Expiry: ${DateFormat.MMMEd().format(user['subscriptionExpiryDate'].toDate()).toString()}',
                  ),
                ] else ...[
                  const Text('Status: No active subscription'),

                  const SizedBox(height: 8),

                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              final startDate = DateTime.now();

                              final expiryDate = startDate.add(
                                Duration(days: selectedDuration),
                              );

                              return AlertDialog(
                                title: const Text("Activate Subscription"),

                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Row(
                                      children: [
                                        Icon(
                                          Icons.hourglass_bottom,
                                          color: kLightAccentColor,
                                        ),
                                        SizedBox(width: 8),
                                        Text("Duration"),
                                      ],
                                    ),

                                    const SizedBox(height: 15),

                                    DropdownButton<int>(
                                      value: selectedDuration,
                                      isExpanded: true,
                                      items: const [
                                        DropdownMenuItem(
                                          value: 30,
                                          child: Text("30 days"),
                                        ),
                                        DropdownMenuItem(
                                          value: 90,
                                          child: Text("90 days"),
                                        ),
                                        DropdownMenuItem(
                                          value: 180,
                                          child: Text("180 days"),
                                        ),
                                        DropdownMenuItem(
                                          value: 365,
                                          child: Text("365 days"),
                                        ),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedDuration = value!;
                                        });
                                      },
                                    ),

                                    const SizedBox(height: 15),

                                    Text(
                                      'Start: ${startDate.day}/${startDate.month}/${startDate.year}',
                                    ),

                                    Text(
                                      'Expiry: ${expiryDate.day}/${expiryDate.month}/${expiryDate.year}',
                                    ),
                                  ],
                                ),

                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("Cancel"),
                                  ),

                                  ElevatedButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(widget.user.id)
                                          .update({
                                            'subscriptionActive': true,
                                            'subscriptionStartDate': startDate,
                                            'subscriptionExpiryDate':
                                                expiryDate,
                                          });

                                      Navigator.pop(context);
                                    },
                                    child: const Text("Activate"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    child: const Text("Activate subscription"),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
