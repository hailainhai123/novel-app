import 'package:flutter/material.dart';

class Styles {
  static TextStyle titleTextStyles = const TextStyle(
      color: Color(0xff19191b), fontSize: 18, fontWeight: FontWeight.w600);

  static BoxDecoration shadowDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          spreadRadius: 5,
          blurRadius: 7,
        ), // change
      ]);
}
