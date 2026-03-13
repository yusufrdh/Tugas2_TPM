import 'package:flutter/material.dart';

class CalculatorController {

  String Calculate({
    required TextEditingController Controller1,
    required TextEditingController Controller2,
    required String operator
  }) {
    String hasil = "";
    final double? num1 = double.tryParse(Controller1.text);
    final double? num2 = double.tryParse(Controller2.text);
    if (num1 == null || num2 == null) {
      hasil = "Error";
    } else {
      if (operator == '+') hasil = (num1 + num2).toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '');
      if (operator == '-') hasil = (num1 - num2).toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '');
    }
    return hasil;
  }

}