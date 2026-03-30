import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/penanggalan_controller.dart';

class DateCalculatorPage extends StatefulWidget {
  const DateCalculatorPage({super.key});

  @override
  State<DateCalculatorPage> createState() => _DateCalculatorPageState();
}

class _DateCalculatorPageState extends State<DateCalculatorPage> {
  DateTime? _selectedDate;
  final PenanggalanController _controller = PenanggalanController();

  String _tanggalMasehiTampil = "-";
  String _weton = "-";
  String _umur = "-";
  String _hijriah = "-";

  Future<void> _pickDateTime() async {
    // 1. Menampilkan Kalender
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1938),
      lastDate:
          DateTime.now(), // Membatasi max hari ini agar tidak milih masa depan
      helpText: "PILIH TANGGAL LAHIR",
    );

    if (date != null) {
      // 2. Menampilkan Jam
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        helpText: "PILIH JAM LAHIR",
      );

      if (time != null) {
        setState(() {
          // Gabungkan Tanggal dan Jam
          _selectedDate =
              DateTime(date.year, date.month, date.day, time.hour, time.minute);

          // Memformat tampilan angka 1 digit menjadi 2 digit (contoh jam 8:5 menjadi 08:05)
          String menit = time.minute.toString().padLeft(2, '0');
          String jam = time.hour.toString().padLeft(2, '0');
          _tanggalMasehiTampil =
              "${date.day}/${date.month}/${date.year}  pukul  $jam:$menit";

          // Panggil fungsi dari controller
          _weton = _controller.hitungWeton(_selectedDate!);
          _umur = _controller.hitungUmur(_selectedDate!);
          _hijriah = _controller.konversiHijriah(_selectedDate!);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
          0xFFF8FAFC), 
      appBar: AppBar(title: const Text("Penanggalan Sakti")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0F172A),
                    Color(0xFF334155)
                  ], // Warna dark slate
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Column(
                children: [
                  const Icon(Icons.auto_awesome, size: 64, color: Colors.white),
                  const SizedBox(height: 12),
                  const Text(
                    "Kalkulator Tanggal & Umur",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.calendar_month,
                        color: Color(0xFF0F172A)),
                    label: const Text("PILIH TANGGAL & JAM",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A))),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                    ),
                    onPressed: _pickDateTime,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// HASIL DATA
            if (_selectedDate != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _buildResultCard(
                        "Tanggal Masehi", _tanggalMasehiTampil, Icons.event),
                    _buildResultCard(
                        "Hari & Weton Jawa", _weton, Icons.history_edu),
                    _buildResultCard("Umur Presisi", _umur, Icons.timer),
                    _buildResultCard(
                        "Tanggal Hijriah", _hijriah, Icons.brightness_auto),
                  ],
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(40),
                child: Text(
                  "Silakan pilih tanggal lahir terlebih dahulu",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              )
          ],
        ),
      ),
    );
  }

  /// WIDGET CARD UNTUK HASIL (Lebih Modern)
  Widget _buildResultCard(String title, String value, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment
            .start, // Agar icon tetap di atas walau textnya 2 baris
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: const Color(0xFF334155), size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey),
                ),
                const SizedBox(height: 6),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
