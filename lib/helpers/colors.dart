import 'package:flutter/material.dart';

class AppColors {
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color greyColor = Colors.grey;

  static var buttonGradientColor = const LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.blueAccent,
        Colors.lightBlueAccent,
      ]);
  static var appGradientColor = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.lightBlueAccent.shade100.withOpacity(0.4),
        Colors.lightBlueAccent.shade100.withOpacity(0.1),
      ]);
  static var applightGradientColor = LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Colors.lightBlueAccent.shade100.withOpacity(0.2),
        Colors.lightBlueAccent.shade100.withOpacity(0.1),
      ]);
}
