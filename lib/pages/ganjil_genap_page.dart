import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/ganjilgenap_controller.dart';

class GanjilGenapPage extends StatefulWidget {
  const GanjilGenapPage({super.key});
  @override
  State<GanjilGenapPage> createState() => _GanjilGenapPageState();
}

class _GanjilGenapPageState extends State<GanjilGenapPage> {
  final TextEditingController _controller = TextEditingController();
  final GanjilgenapController _ganjilgenapController = GanjilgenapController();
  String _hasilGanjilGenap = "";
  String _hasilPrima = "";

  void cekBilangan() {
    setState(() {
      var (ganjilGenap, prima) = _ganjilgenapController.cekBilangan(num: _controller);
      _hasilGanjilGenap = ganjilGenap;
      _hasilPrima = prima;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cek Angka")),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            TextField(controller: _controller, keyboardType: TextInputType.number, maxLength: 10, decoration: const InputDecoration(hintText: "Masukkan 1 Angka", prefixIcon: Icon(Icons.tag_rounded))),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, child: ElevatedButton(onPressed: cekBilangan, child: const Text("CEK STATUS BILANGAN"))),
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