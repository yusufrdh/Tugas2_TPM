import 'package:flutter/material.dart';
import 'dart:math';

class PiramidPage extends StatefulWidget {
  const PiramidPage({super.key});
  @override
  State<PiramidPage> createState() => _PiramidPageState();
}

class _PiramidPageState extends State<PiramidPage> {
  final TextEditingController _sisiController = TextEditingController();
  final TextEditingController _tinggiController = TextEditingController();
  String _hasilLuas = "0";
  String _hasilVolume = "0";

  void _hitungPiramid() {
    final double? s = double.tryParse(_sisiController.text);
    final double? t = double.tryParse(_tinggiController.text);
    if (s == null || t == null) {
      setState(() { _hasilLuas = "Error"; _hasilVolume = "Error"; });
      return;
    }
    double volume = (1 / 3) * (s * s) * t;
    double tinggiSegitiga = sqrt(pow((s / 2), 2) + pow(t, 2));
    double luasPermukaan = (s * s) + (4 * 0.5 * s * tinggiSegitiga);

    setState(() {
      _hasilVolume = volume.toStringAsFixed(2);
      _hasilLuas = luasPermukaan.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pyramid")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            TextField(controller: _sisiController, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Base Length (s)", prefixIcon: Icon(Icons.square_foot_rounded))),
            const SizedBox(height: 16),
            TextField(controller: _tinggiController, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Pyramid Height (t)", prefixIcon: Icon(Icons.height_rounded))),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _hitungPiramid, child: const Text("CALCULATE"))),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildResultCard("Volume", _hasilVolume)),
                const SizedBox(width: 16),
                Expanded(child: _buildResultCard("Surface Area", _hasilLuas)),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildResultCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600, fontSize: 13)),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF4338CA))),
        ],
      ),
    );
  }
}