import 'package:flutter/material.dart';

class GanjilgenapController {
  (String, String) cekBilangan({required TextEditingController num}) {
    String input = num.text.trim();
    if (input.isEmpty) return ("Input Kosong", "Input Kosong");

    /// 1. LOGIKA GANJIL/GENAP (Anti-Error)
    /// Berapapun panjang angkanya (mau 1000 digit sekalipun), kita cuma perlu
    /// melihat 1 angka paling ujung belakangnya saja.
    int digitTerakhir = int.parse(input.substring(input.length - 1));
    String statusGanjilGenap =
        (digitTerakhir % 2 == 0) ? "Bilangan Genap" : "Bilangan Ganjil";

    /// 2. LOGIKA PRIMA (Menggunakan BigInt)
    String statusPrima = "Bukan Bilangan Prima";

    try {
      BigInt angka = BigInt.parse(input);

      if (angka <= BigInt.one) {
        statusPrima = "Bukan Bilangan Prima";
      } else if (angka == BigInt.two) {
        statusPrima = "Bilangan Prima";
      } else if (angka.isEven) {
        // TRIK CEPAT: Kalau angkanya genap (seperti di screenshot kamu yang ujungnya angka 2),
        // program tidak perlu mikir lama, otomatis BUKAN prima.
        statusPrima = "Bukan Bilangan Prima";
      } else {
        // Proteksi agar emulator tidak freeze jika mengetik angka ganjil terlalu panjang
        if (angka > BigInt.parse("999999999999999")) {
          statusPrima = "Terlalu besar untuk dicek primanya";
        } else {
          // Logika penghitungan bilangan prima normal
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
    } catch (e) {
      return (statusGanjilGenap, "Input Invalid");
    }

    return (statusGanjilGenap, statusPrima);
  }
}
