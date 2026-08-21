import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gympulse_app/screens/account/my_qr_screen.dart';
import 'package:gympulse_app/widgets/day_container.dart';
import '../../constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomeContent extends StatefulWidget {
  static String id = 'HomeContent';

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  String? userName;
  DateTime today = DateTime.now();
  List<bool> weekAttendance = List.filled(7, false);

  Future getUserName() async {
    final useruid = FirebaseAuth.instance.currentUser!.uid;
    final userdoc = FirebaseFirestore.instance.collection('users').doc(useruid);

    final userData = await userdoc.get();
    setState(() {
      userName = userData['username'];
    });
  }

  String getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  List<DateTime> getCurrentWeek() {
    DateTime saturday = today.subtract(Duration(days: (today.weekday + 1) % 7));

    return List.generate(7, (index) => saturday.add(Duration(days: index)));
  }

  Future getWeekAttendance() async {
    final useruid = FirebaseAuth.instance.currentUser!.uid;

    final attendanceCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(useruid)
        .collection('attendance');

    final week = getCurrentWeek();
    for (int i = 0; i < week.length; i++) {
      final date = week[i];

      final dateId =
          '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

      final attendanceDoc = await attendanceCollection.doc(dateId).get();

      if (attendanceDoc.exists) {
        weekAttendance[i] = attendanceDoc['attended'];
      }
    }
    setState(() {});
  }

  int getTodayIndex() {
    return (today.weekday + 1) % 7;
  }

  @override
  void initState() {
    super.initState();
    getUserName();
    getWeekAttendance();
  }

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
            FaIcon(FontAwesomeIcons.dumbbell, size: 32, color: kAccentColor),
            Text(
              'Welcome $userName',
              style: TextStyle(
                color: kLightAccentColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, MyQrScreen.id);
            },
            icon: Icon(Icons.qr_code_2_outlined, color: Colors.white, size: 32),
          ),
        ],

        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(color: kAccentColor, height: 1),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kSecondaryColor,
              border: Border.all(color: kAccentColor, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,

              children: getCurrentWeek().asMap().entries.map((entry) {
                final index = entry.key;
                final date = entry.value;
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: DayContainer(
                      getDayName(date.weekday),
                      date.day.toString(),
                      date.day == today.day &&
                          date.month == today.month &&
                          date.year == today.year,
                      weekAttendance[index],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),

          // ElevatedButton.icon(
          //   onPressed: weekAttendance[getTodayIndex()]
          //       ? null
          //       : () async {
          //           final useruid = FirebaseAuth.instance.currentUser!.uid;
          //           final attendanceDoc = FirebaseFirestore.instance
          //               .collection('users')
          //               .doc(useruid)
          //               .collection('attendance')
          //               .doc(
          //                 '${today.year}-${today.month.toString().padLeft(2, '0')}-${today.day.toString().padLeft(2, '0')}',
          //               );

          //           await attendanceDoc.set({'attended': true});
          //           setState(() {
          //             weekAttendance[getTodayIndex()] = true;
          //           });
          //         },
          //   icon: Icon(Icons.check),
          //   label: Text(
          //     weekAttendance[getTodayIndex()]
          //         ? 'Checked in '
          //         : 'Check in Today',
          //   ),
          // ),
        ],
      ),
    );
  }
}
