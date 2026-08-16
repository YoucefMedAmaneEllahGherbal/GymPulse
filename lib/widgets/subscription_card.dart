import 'package:flutter/material.dart';
import 'package:gympulse_app/constants.dart';
import 'package:intl/intl.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard(
    this.subscriptionActive,
    this.subscriptionStartDate,
    this.subscriptionExpiryDate,
    this.remainingDays,
    this.isSubscriptionExpired,
  );

  final bool subscriptionActive;
  final DateTime? subscriptionStartDate;
  final DateTime? subscriptionExpiryDate;
  final int? remainingDays;
  final bool isSubscriptionExpired;

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
              Icon(
                Icons.workspace_premium_outlined,
                size: 25,
                color: kAccentColor,
              ),
              SizedBox(width: 8),
              Text(
                "Subscription : ",
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
              SizedBox(width: 12),
              if (subscriptionActive && !isSubscriptionExpired)
                Icon(Icons.check_circle_outline, color: Colors.green),
              if (subscriptionActive && isSubscriptionExpired)
                Icon(Icons.error_outline, color: Colors.red),
              if (!subscriptionActive)
                Icon(Icons.remove_circle_outline, color: kLightAccentColor),

              SizedBox(width: 8),
              Text(
                "Status : ${subscriptionActive
                    ? isSubscriptionExpired
                          ? 'Expired'
                          : 'Active'
                    : "Not Active"}",
                textAlign: TextAlign.center,
                style: TextStyle(color: kAccentColor, fontSize: 16),
              ),
            ],
          ),
          if (subscriptionActive && !isSubscriptionExpired)
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 12),
                    Icon(
                      Icons.event_available_outlined,
                      color: kLightAccentColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Started : ${DateFormat.yMMMEd().format(subscriptionStartDate!)}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: kAccentColor, fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 12),
                    Icon(Icons.event_busy, color: kLightAccentColor),
                    SizedBox(width: 8),
                    Text(
                      "Expires : ${DateFormat.yMMMEd().format(subscriptionExpiryDate!)}",
                      style: TextStyle(color: kAccentColor, fontSize: 16),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 12),
                    Icon(
                      Icons.hourglass_bottom_outlined,
                      color: kLightAccentColor,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Remaining : $remainingDays Days",
                      style: TextStyle(color: kAccentColor, fontSize: 16),
                    ),
                  ],
                ),
              ],
            ),
          if (subscriptionActive && isSubscriptionExpired)
            Row(
              children: [
                SizedBox(width: 12),
                Icon(Icons.event_busy, color: kLightAccentColor),
                SizedBox(width: 8),
                Text(
                  "Expiry Date : ${DateFormat.yMMMEd().format(subscriptionExpiryDate!)}",
                  style: TextStyle(color: kAccentColor, fontSize: 16),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
