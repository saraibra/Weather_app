import 'package:flutter/material.dart';

DateTime convertTimeToDate(int time) {
  return DateTime.fromMillisecondsSinceEpoch(time * 1000);
}

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

   
