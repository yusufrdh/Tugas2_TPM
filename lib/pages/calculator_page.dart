import 'package:flutter/material.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String _hasil = "0";

  void _calculate(String operator) {
    final double? num1 = double.tryParse(_controller1.text);
    final double? num2 = double.tryParse(_controller2.text);
    if (num1 == null || num2 == null) {
      setState(() => _hasil = "Error");
      return;
    }
    setState(() {
      if (operator == '+') _hasil = (num1 + num2).toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '');
      if (operator == '-') _hasil = (num1 - num2).toStringAsFixed(2).replaceAll(RegExp(r'\.00$'), '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Aritmatik")),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            TextField(controller: _controller1, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Angka Pertama", prefixIcon: Icon(Icons.looks_one_rounded))),
            const SizedBox(height: 16),
            TextField(controller: _controller2, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Angka Kedua", prefixIcon: Icon(Icons.looks_two_rounded))),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(child: ElevatedButton(onPressed: () => _calculate('+'), child: const Text("+", style: TextStyle(fontSize: 24)))),
                const SizedBox(width: 16),
                Expanded(child: ElevatedButton(onPressed: () => _calculate('-'), child: const Text("-", style: TextStyle(fontSize: 28)))),
              ],
            ),
            const SizedBox(height: 48),
            const Text("Hasil Penjumlahan / Pengurangan", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
            const SizedBox(height: 8),
            Text(_hasil, style: const TextStyle(fontSize: 56, fontWeight: FontWeight.w800, color: Color(0xFF4338CA))),
          ],
        ),
      ),
    );
  }
}