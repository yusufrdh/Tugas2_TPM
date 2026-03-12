import 'package:flutter/material.dart';

class JumlahController {
  String Penjumlahan ({
    required TextEditingController penjumlahan
  }){
    String hasil = "";
    try {
      List<String> parts = penjumlahan.text.split(RegExp(r'[,\s]+'));
      List<int> angka = parts.where((e) => e.isNotEmpty).map((e) => int.parse(e.trim())).toList();
      int total = angka.fold(0, (sum, item) => sum + item);
      hasil = total.toString();
    } catch (e) {
      hasil = "Error";
    }
    return hasil;
  }
}
