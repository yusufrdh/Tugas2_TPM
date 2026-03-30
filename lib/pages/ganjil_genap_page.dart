import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/controller/ganjilgenap_controller.dart';

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
    if (_controller.text.isEmpty) {
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
      var (ganjilGenap, prima) =
          _ganjilgenapController.cekBilangan(num: _controller);
      _hasilGanjilGenap = ganjilGenap;
      _hasilPrima = prima;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cek Angka")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              maxLines:
                  1, // Memaksa teks jadi 1 baris dan otomatis scroll ke samping
              inputFormatters: [
                FilteringTextInputFormatter
                    .digitsOnly, // Anti spasi, minus, dan huruf
              ],
              decoration: const InputDecoration(
                hintText: "Masukkan Angka",
                prefixIcon: Icon(Icons.tag_rounded),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: cekBilangan,
                child: const Text("CEK STATUS BILANGAN"),
              ),
            ),
            const SizedBox(height: 40),
            if (_hasilGanjilGenap.isNotEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                ),
                child: Column(
                  children: [
                    Text(
                      _hasilGanjilGenap,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Divider(color: Color(0xFFE2E8F0)),
                    ),
                    Text(
                      _hasilPrima,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4338CA),
                      ),
                    ),
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
