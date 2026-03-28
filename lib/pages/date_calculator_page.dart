import 'package:flutter/material.dart';
import 'package:hijri/hijri_calendar.dart';

class DateCalculatorPage extends StatefulWidget {
  const DateCalculatorPage({super.key});

  @override
  State<DateCalculatorPage> createState() => _DateCalculatorPageState();
}

class _DateCalculatorPageState extends State<DateCalculatorPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  String _weton = "-";
  String _umur = "-";
  String _hijriah = "-";

  String hitungWeton(DateTime date) {
    int diff = date.difference(DateTime(1970, 1, 1)).inDays;
    List<String> pasaran = ['Wage', 'Kliwon', 'Legi', 'Pahing', 'Pon'];
    List<String> hari = ['Kamis', 'Jumat', 'Sabtu', 'Minggu', 'Senin', 'Selasa', 'Rabu'];
    
    int indexPasaran = (diff % 5 + 5) % 5;
    int indexHari = (diff % 7 + 7) % 7;
    return '${hari[indexHari]} ${pasaran[indexPasaran]}';
  }

  // Logic Umur Detail
  String hitungUmur(DateTime birthDate) {
    DateTime now = DateTime.now();
    int years = now.year - birthDate.year;
    int months = now.month - birthDate.month;
    int days = now.day - birthDate.day;
    int hours = now.hour - birthDate.hour;
    int minutes = now.minute - birthDate.minute;

    if (minutes < 0) { minutes += 60; hours--; }
    if (hours < 0) { hours += 24; days--; }
    if (days < 0) {
      months--;
      days += DateTime(now.year, now.month, 0).day;
    }
    if (months < 0) { months += 12; years--; }

    return '$years Thn, $months Bln, $days Hr, $hours Jam, $minutes Mnt';
  }

  Future<void> _pickDateTime() async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if (time != null) {
        setState(() {
          _selectedDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
          _weton = hitungWeton(_selectedDate!);
          _umur = hitungUmur(_selectedDate!);
          _hijriah = HijriCalendar.fromDate(_selectedDate!).toFormat("dd MMMM yyyy");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Penanggalan Sakti")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.calendar_month),
              label: const Text("Pilih Tanggal & Waktu Lahir"),
              onPressed: _pickDateTime,
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
            ),
            const SizedBox(height: 30),
            if (_selectedDate != null) ...[
              _buildResultCard("Weton (Jawa)", _weton, Icons.history_edu),
              _buildResultCard("Umur Presisi", _umur, Icons.timer),
              _buildResultCard("Tanggal Hijriah", _hijriah, Icons.brightness_auto),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(String title, String value, IconData icon) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 15),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue, size: 30),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value, style: const TextStyle(fontSize: 16, color: Colors.black87)),
      ),
    );
  }
}