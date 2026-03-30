import 'package:flutter/material.dart';

class JumlahController {
  
  // Mengembalikan Map berisi angka apa saja yang muncul dan berapa jumlahnya
  Map<String, int> hitungAngka({required TextEditingController textController}) {
    String input = textController.text;
    Map<String, int> counts = {};

    // Cek karakter satu per satu dari seluruh teks
    for (int i = 0; i < input.length; i++) {
      String char = input[i];
      
      // Jika karakter tersebut adalah angka (0 sampai 9)
      if (RegExp(r'[0-9]').hasMatch(char)) {
        // Tambahkan hitungannya (+1)
        counts[char] = (counts[char] ?? 0) + 1;
      }
    }

    // (Opsional tapi rapi) Urutkan hasilnya dari angka 0 sampai 9
    var sortedKeys = counts.keys.toList()..sort();
    Map<String, int> sortedCounts = {};
    for (var key in sortedKeys) {
      sortedCounts[key] = counts[key]!;
    }

    return sortedCounts;
  }
}