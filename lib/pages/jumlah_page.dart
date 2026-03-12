import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/jumlah_controller.dart';

class JumlahPage extends StatefulWidget {
  const JumlahPage({super.key});
  @override
  State<JumlahPage> createState() => _JumlahPageState();
}

class _JumlahPageState extends State<JumlahPage> {
  final TextEditingController _controller = TextEditingController();
  final JumlahController _jumlahController = JumlahController();
  String hasil = "0";

  void hitungJumlah() {
    setState(() {
      hasil = _jumlahController.Penjumlahan(penjumlahan: _controller);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Jumlah Total")),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            TextField(controller: _controller, keyboardType: TextInputType.text, decoration: const InputDecoration(hintText: "Contoh: 10, 20, 30", prefixIcon: Icon(Icons.add_circle_outline_rounded))),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: hitungJumlah, child: const Text("HITUNG TOTAL"))),
            const SizedBox(height: 48),
            const Text("Hasil Total Penjumlahan", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
            const SizedBox(height: 8),
            Text(hasil, style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w800, color: Color(0xFF4338CA))),
          ],
        ),
      ),
    );
  }
}