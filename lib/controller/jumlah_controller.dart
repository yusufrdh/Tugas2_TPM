import 'package:flutter/material.dart';

class JumlahController extends ChangeNotifier {
  Map<String, int> hasilDetail = {};
  int totalKarakter = 0;
  int totalKata = 0;

  void hitungSemua(TextEditingController textController) {
    String input = textController.text;
    
    // 1. Hitung Detail Karakter (Spasi diabaikan)
    Map<String, int> counts = {};
    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      if (char == ' ') continue; 
      counts[char] = (counts[char] ?? 0) + 1;
    }

    // Urutkan hasilnya biar rapi
    var sortedKeys = counts.keys.toList()..sort();
    Map<String, int> sortedCounts = {};
    for (var key in sortedKeys) {
      sortedCounts[key] = counts[key]!;
    }
    hasilDetail = sortedCounts;

    // 2. Hitung Total Karakter (Kalo lu mau ngitung spasi juga, hapus replaceAll-nya)
    totalKarakter = input.replaceAll(' ', '').length;

    // 3. Hitung Total Kata
    String trimmedInput = input.trim();
    if (trimmedInput.isEmpty) {
      totalKata = 0;
    } else {
      // Split berdasarkan jarak spasi/enter biar presisi ngitung katanye
      totalKata = trimmedInput.split(RegExp(r'\s+')).length;
    }

    // Lapor ke UI kalo data udeh beres diitung
    notifyListeners();
  }

  void resetData() {
    hasilDetail.clear();
    totalKarakter = 0;
    totalKata = 0;
    notifyListeners();
  }
}