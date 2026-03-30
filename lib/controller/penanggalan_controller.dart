import 'package:hijri/hijri_calendar.dart';

class PenanggalanController {
  /// 1. LOGIKA WETON JAWA
  String hitungWeton(DateTime date) {
    DateTime dateUtc = DateTime.utc(date.year, date.month, date.day);
    DateTime epoch = DateTime.utc(1970, 1, 1);

    int diff = dateUtc.difference(epoch).inDays;

    List<String> pasaran = ['Wage', 'Kliwon', 'Legi', 'Pahing', 'Pon'];
    List<String> hari = [
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
      'Senin',
      'Selasa',
      'Rabu'
    ];

    int indexPasaran = (diff % 5 + 5) % 5;
    int indexHari = (diff % 7 + 7) % 7;

    return '${hari[indexHari]} ${pasaran[indexPasaran]}';
  }

  /// 2. LOGIKA UMUR PRESISI
  String hitungUmur(DateTime birthDate) {
    DateTime now = DateTime.now();

    if (birthDate.isAfter(now)) {
      return "Belum Lahir (Dari Masa Depan)";
    }

    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;
    int hours = now.hour - birthDate.hour;
    int minutes = now.minute - birthDate.minute;

    if (minutes < 0) {
      minutes += 60;
      hours--;
    }
    if (hours < 0) {
      hours += 24;
      days--;
    }
    if (days < 0) {
      months--;
      days += DateTime(now.year, now.month, 0).day;
    }
    if (months < 0) {
      months += 12;
      years--;
    }

    return '$years Tahun, $months Bulan, $days Hari\n$hours Jam, $minutes Menit';
  }

  /// 3. LOGIKA HIJRIAH
  String konversiHijriah(DateTime date) {
    try {
      var hijri = HijriCalendar.fromDate(date);
      return hijri.toFormat("dd MMMM yyyy");
    } catch (e) {
      return "Gagal mengkonversi tanggal";
    }
  }
}
