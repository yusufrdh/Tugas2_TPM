import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/jumlah_controller.dart';

class JumlahPage extends StatefulWidget {
  const JumlahPage({super.key});
  @override
  State<JumlahPage> createState() => _JumlahPageState();
}

class _JumlahPageState extends State<JumlahPage> {
  final TextEditingController _controller = TextEditingController();
  final JumlahController _jumlahController = JumlahController();
  
  Map<String, int> _hasilCount = {};
  bool _sudahDihitung = false;

  void hitungJumlah() {
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Teks tidak boleh kosong!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _hasilCount = _jumlahController.hitungAngka(textController: _controller);
      _sudahDihitung = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Penghitung Angka")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, 
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.multiline,
              minLines: 3, 
              maxLines: 7,
              decoration: const InputDecoration(
                hintText: "Paste paragraf teks acak di sini...", 
                border: OutlineInputBorder(), 
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity, 
              child: ElevatedButton(
                onPressed: hitungJumlah, 
                child: const Text("HITUNG KEMUNCULAN ANGKA")
              )
            ),
            const SizedBox(height: 40),
            
            if (_sudahDihitung) ...[
              const Text(
                "Total angka:", 
                style: TextStyle(
                  fontSize: 16, 
                  fontWeight: FontWeight.bold, 
                  color: Color(0xFF1E293B)
                )
              ),
              const SizedBox(height: 12),
              
              if (_hasilCount.isEmpty)
                const Text(
                  "Tidak ada angka yang ditemukan.",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                )
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _hasilCount.entries.map((entry) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0), 
                      child: Text(
                        "- Angka ${entry.key} = ${entry.value} karakter",
                        style: const TextStyle(
                          fontSize: 16, 
                          color: Color(0xFF334155)
                        ),
                      ),
                    );
                  }).toList(),
                ),
            ]
          ],
        ),
      ),
    );
  }
}