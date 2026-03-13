import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/piramid_controller.dart';

class PiramidPage extends StatefulWidget {
  const PiramidPage({super.key});
  @override
  State<PiramidPage> createState() => _PiramidPageState();
}

class _PiramidPageState extends State<PiramidPage> {
  final TextEditingController _sisiController = TextEditingController();
  final TextEditingController _tinggiController = TextEditingController();
  final PiramidController _piramidController = PiramidController();
  String _hasilLuas = "0";
  String _hasilVolume = "0";

  void _hitungPiramid() {
    var (volume, luas) = _piramidController.Calculate(Controller1: _sisiController, Controller2: _tinggiController);
    setState(() {
      _hasilVolume = volume;
      _hasilLuas = luas;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Piramid")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            TextField(controller: _sisiController, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Panjang Sisi Alas (s)", prefixIcon: Icon(Icons.square_foot_rounded))),
            const SizedBox(height: 16),
            TextField(controller: _tinggiController, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Tinggi Piramid (t)", prefixIcon: Icon(Icons.height_rounded))),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _hitungPiramid, child: const Text("HITUNG LUAS & VOLUME"))),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: _buildResultCard("Volume", _hasilVolume)),
                const SizedBox(width: 16),
                Expanded(child: _buildResultCard("Luas Permukaan", _hasilLuas)),
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
    ),
  );
}
