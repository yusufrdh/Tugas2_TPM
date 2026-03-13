import 'package:flutter/material.dart';
import 'dart:math';

class PiramidController {
  (String luas, String volume) calculate({
    required TextEditingController sisiController,
    required TextEditingController tinggiController,
  }) {
    double? s = double.tryParse(sisiController.text);
    double? t = double.tryParse(tinggiController.text);

    if (s == null || t == null) {
      return ("Error", "Error");
    }

    /// tinggi segitiga sisi
    double tMiring = sqrt(pow((s / 2), 2) + pow(t, 2));

    /// luas permukaan
    double luasPermukaan = (s * s) + (4 * 0.5 * s * tMiring);

    /// volume
    double volume = (1 / 3) * (s * s) * t;

    return (luasPermukaan.toStringAsFixed(2), volume.toStringAsFixed(2));
  }
}
