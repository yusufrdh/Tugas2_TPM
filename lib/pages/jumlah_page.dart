import 'package:flutter/material.dart';

class JumlahPage extends StatefulWidget {
  const JumlahPage({super.key});
  @override
  State<JumlahPage> createState() => _JumlahPageState();
}

class _JumlahPageState extends State<JumlahPage> {
  final TextEditingController _controller = TextEditingController();
  String hasil = "0";

  void hitungJumlah() {
    setState(() {
      try {
        List<String> parts = _controller.text.split(RegExp(r'[,\s]+'));
        List<int> angka = parts.where((e) => e.isNotEmpty).map((e) => int.parse(e.trim())).toList();
        int total = angka.fold(0, (sum, item) => sum + item);
        hasil = total.toString();
      } catch (e) {
        hasil = "Error";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Sum Total")),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            TextField(controller: _controller, keyboardType: TextInputType.text, decoration: const InputDecoration(hintText: "E.g. 10, 20, 30", prefixIcon: Icon(Icons.add_circle_outline_rounded))),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: hitungJumlah, child: const Text("CALCULATE SUM"))),
            const SizedBox(height: 48),
            const Text("Total Result", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
            const SizedBox(height: 8),
            Text(hasil, style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w800, color: Color(0xFF4338CA))),
          ],
        ),
      ),
    );
  }
}