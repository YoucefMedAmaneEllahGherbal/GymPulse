import 'package:flutter/material.dart';
import 'package:gympulse_app/constants.dart';

class SubscriptionCard extends StatelessWidget {
  const SubscriptionCard(
    this.subscriptionActive,
    this.subscriptionStartDate,
    this.subscriptionExpiryDate,
    this.remainingDays,
  );

  final bool subscriptionActive;
  final DateTime? subscriptionStartDate;
  final DateTime? subscriptionExpiryDate;
  final int? remainingDays;

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
              Icon(Icons.switch_account_sharp, color: kLightAccentColor),
              SizedBox(width: 8),
              Text(
                "Status : ${subscriptionActive ? "Active " : "Not Active"}",
                textAlign: TextAlign.center,
                style: TextStyle(color: kAccentColor, fontSize: 16),
              ),
            ],
          ),
          if (subscriptionActive)
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
                      "Started : $subscriptionStartDate",
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
                      "Expires : $subscriptionExpiryDate",
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
        ],
      ),
    );
  }
}
