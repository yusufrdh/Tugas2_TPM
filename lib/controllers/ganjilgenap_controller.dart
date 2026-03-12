import 'dart:math';
import 'package:flutter/material.dart';

class GanjilgenapController {
  bool isPrime(int N){
    int i = 2;
    double temp = sqrt(N);
    int k = temp.ceil();
    while(i <= k){
      if (N % i == 0) {
        return false;
      }
      i += 1;
    }
    return true;
  }

  (String, String) cekBilangan ({
    required TextEditingController num
  }){
    int? angka = int.tryParse(num.text);
    String? genap;
    String? prima;
    if (angka == null) {
      genap = "Input Invalid";
      prima = "";
    } else {
      genap = (angka % 2 == 0) ? "Bilangan Genap" : "Bilangan Ganjil";
      prima = isPrime(angka) ? "Bilangan Prima" : "Bukan Prima";
    }

    return (genap, prima);
  }
}