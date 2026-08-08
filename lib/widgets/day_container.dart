import 'package:flutter/material.dart';
import 'package:gympulse_app/constants.dart';

class DayContainer extends StatelessWidget {
  const DayContainer(this.day, this.date, this.isToday);
  final String day;
  final String date;
  final bool isToday;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isToday ? kAccentColor : kBackgroundColor,
        border: Border.all(
          color: isToday ? kAccentColor : Colors.white24,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            date,
            style: TextStyle(
              color: isToday ? kBackgroundColor : kLightAccentColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            day,
            style: TextStyle(
              color: isToday ? kBackgroundColor : kLightAccentColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
