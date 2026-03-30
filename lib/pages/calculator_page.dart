import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:flutter_application_1/controller/calculator_controller.dart';

class CalculatorPage extends StatefulWidget {
  const CalculatorPage({super.key});
  @override
  State<CalculatorPage> createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final CalculatorController _calculatorController = CalculatorController();
  String _hasil = "0";

  void _calculate(String operator) {
    if (_controller1.text.isEmpty || _controller2.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Angka tidak boleh kosong!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    setState(() {
      _hasil = _calculatorController.Calculate(
          Controller1: _controller1,
          Controller2: _controller2,
          operator: operator);
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
            TextField(
              controller: _controller1,
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true, signed: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.\-]')),
              ],
              decoration: const InputDecoration(
                hintText: "Angka Pertama",
                prefixIcon: Icon(Icons.looks_one_rounded),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _controller2,
              keyboardType: const TextInputType.numberWithOptions(
                  decimal: true, signed: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.\-]')),
              ],
              decoration: const InputDecoration(
                hintText: "Angka Kedua",
                prefixIcon: Icon(Icons.looks_two_rounded),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _calculate('+'),
                    child: const Text("+", style: TextStyle(fontSize: 24)),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _calculate('-'),
                    child: const Text("-", style: TextStyle(fontSize: 28)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            const Text(
              "Hasil Penjumlahan / Pengurangan",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF94A3B8),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: Text(
                    _hasil,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF4338CA),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
