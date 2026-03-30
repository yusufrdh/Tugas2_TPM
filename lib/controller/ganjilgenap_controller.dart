import 'package:flutter/material.dart';

class GanjilgenapController {
  (String, String) cekBilangan({required TextEditingController num}) {
    String input = num.text.trim();
    if (input.isEmpty || input == "-") return ("Input Invalid", "Input Invalid");

    /// 1. LOGIKA GANJIL/GENAP (Pake BigInt biar aman angka gaban & minus)
    /// Daripada parsing string yang rawan salah kalo ada minus, 
    /// mending parsing full angka ke BigInt, terus cek isEven-nya.
    BigInt angka;
    try {
      angka = BigInt.parse(input);
    } catch (e) {
      return ("Angka Terlalu Ekstrem / Invalid", "Input Invalid");
    }

    String statusGanjilGenap = angka.isEven ? "Bilangan Genap" : "Bilangan Ganjil";
    // Kalo minus, kita tambahin teks biar jelas
    if (angka < BigInt.zero) {
      statusGanjilGenap = "$statusGanjilGenap (Negatif)";
    }

    /// 2. LOGIKA PRIMA
    String statusPrima = "Bukan Bilangan Prima";

    // Bilangan negatif secara matematis BUKAN bilangan prima
    if (angka <= BigInt.one) {
      statusPrima = "Bukan Bilangan Prima";
    } else if (angka == BigInt.two) {
      statusPrima = "Bilangan Prima";
    } else if (angka.isEven) {
      statusPrima = "Bukan Bilangan Prima";
    } else {
      // Proteksi angka gaban ganjil
      if (angka > BigInt.parse("999999999999999")) {
        statusPrima = "Terlalu besar untuk dicek primanya";
      } else {
        bool isPrima = true;
        for (BigInt i = BigInt.from(3); i * i <= angka; i += BigInt.two) {
          if (angka % i == BigInt.zero) {
            isPrima = false;
            break;
          }
        }
        statusPrima = isPrima ? "Bilangan Prima" : "Bukan Bilangan Prima";
      }
    }

    return (statusGanjilGenap, statusPrima);
  }
}