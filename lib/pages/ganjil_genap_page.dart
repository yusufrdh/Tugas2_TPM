import 'package:flutter/material.dart';
import 'dart:math';

class GanjilGenapPage extends StatefulWidget {
  const GanjilGenapPage({super.key});
  @override
  State<GanjilGenapPage> createState() => _GanjilGenapPageState();
}

class _GanjilGenapPageState extends State<GanjilGenapPage> {
  final TextEditingController _controller = TextEditingController();
  String _hasilGanjilGenap = "";
  String _hasilPrima = "";

  bool isPrime(int number) {
    if (number <= 1) return false;
    for (int i = 2; i <= sqrt(number); i++) {
      if (number % i == 0) return false;
    }
    return true;
  }

  void cekBilangan() {
    setState(() {
      int? angka = int.tryParse(_controller.text);
      if (angka == null) {
        _hasilGanjilGenap = "Input Invalid";
        _hasilPrima = "";
      } else {
        _hasilGanjilGenap = (angka % 2 == 0) ? "Even Number (Genap)" : "Odd Number (Ganjil)";
        _hasilPrima = isPrime(angka) ? "Prime Number" : "Not Prime";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Number Check")),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            TextField(controller: _controller, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Enter a number", prefixIcon: Icon(Icons.tag_rounded))),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: cekBilangan, child: const Text("CHECK STATUS"))),
            const SizedBox(height: 40),
            if (_hasilGanjilGenap.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: const Color(0xFFE2E8F0))),
                child: Column(
                  children: [
                    Text(_hasilGanjilGenap, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
                    const Padding(padding: EdgeInsets.symmetric(vertical: 16), child: Divider(color: Color(0xFFE2E8F0))),
                    Text(_hasilPrima, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: Color(0xFF4338CA))),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}