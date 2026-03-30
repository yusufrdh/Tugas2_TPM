import 'package:flutter/material.dart';
import 'package:decimal/decimal.dart';

class CalculatorController {

  String Calculate({
    required String num,
    required TextEditingController Controller1,
    required String operator
  }) {
    String hasil = "";
    
    final Decimal? num1 = Decimal.tryParse(num);
    final Decimal? num2 = Decimal.tryParse(Controller1.text);
    
    if (num1 == null || num2 == null) {
      hasil = "Error";
    } else {
      if (operator == '+') hasil = (num1 + num2).toString();
      if (operator == '-') hasil = (num1 - num2).toString();
      if (operator == '*') hasil = (num1 * num2).toString();
      if (operator == '/') {
        if (num2 == Decimal.zero) {
          hasil = "Error: Dibagi Nol";
        } else {
          hasil = (num1.toDouble() / num2.toDouble()).toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '');
        }
      }
    }
    return hasil;
  }
}