import 'package:flutter/material.dart';
import 'dart:math';

class PiramidController {

  (String, String) Calculate({
    required TextEditingController Controller1,
    required TextEditingController Controller2
  }) {
    String Luas = "";
    String Volume = "";
    final double? s = double.tryParse(Controller1.text);
    final double? t = double.tryParse(Controller2.text);
    if (s == null || t == null) {
      Luas = "Error";
      Volume = "Error";
    }
    double volume = (1 / 3) * (s! * s) * t!;
    double tinggiSegitiga = sqrt(pow((s / 2), 2) + pow(t, 2));
    double luasPermukaan = (s * s) + (4 * 0.5 * s * tinggiSegitiga);
    Volume = volume.toStringAsFixed(2);
    Luas = luasPermukaan.toStringAsFixed(2);
    return (Volume, Luas);
  }
  
}