import 'package:flutter/material.dart';
// Jangan lupa cocokin path import-nye sama punya lu ye bos!
import 'package:flutter_application_1/controller/jumlah_controller.dart';

class JumlahPage extends StatefulWidget {
  const JumlahPage({super.key});

  @override
  State<JumlahPage> createState() => _JumlahPageState();
}

class _JumlahPageState extends State<JumlahPage> {
  final TextEditingController _inputController = TextEditingController();
  final JumlahController _jumlahController = JumlahController();

  @override
  void dispose() {
    _inputController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hitung Jumlah Teks"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: const Color(0xFFF8FAFC),
      body: ListenableBuilder(
        listenable: _jumlahController,
        builder: (context, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // KOTAK INPUTAN
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _inputController,
                        maxLines: 4,
                        decoration: const InputDecoration(
                          hintText: "Ketik teks atau kalimat di sini...",
                          border: InputBorder.none,
                        ),
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              _inputController.clear();
                              _jumlahController.resetData();
                            },
                            child: const Text("Reset", style: TextStyle(color: Colors.grey)),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                              backgroundColor: const Color(0xFF4338CA),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))
                            ),
                            onPressed: () {
                              // Lempar controller inputan ke mesin hitung
                              _jumlahController.hitungSemua(_inputController);
                            },
                            child: const Text("Hitung Total"),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),

                // HASIL: TOTAL KATA & KARAKTER
                if (_jumlahController.totalKarakter > 0) ...[
                  Row(
                    children: [
                      Expanded(child: _buildStatCard("Total Kata", _jumlahController.totalKata.toString(), Icons.menu_book_rounded)),
                      const SizedBox(width: 16),
                      Expanded(child: _buildStatCard("Total Karakter", _jumlahController.totalKarakter.toString(), Icons.text_snippet_rounded)),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  const Text("Detail Kemunculan:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  const SizedBox(height: 12),

                  // HASIL: DETAIL PER KARAKTER
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
                    ),
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _jumlahController.hasilDetail.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        String key = _jumlahController.hasilDetail.keys.elementAt(index);
                        int count = _jumlahController.hasilDetail[key]!;
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFEEF2FF),
                            child: Text(key, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF4338CA))),
                          ),
                          title: Text("Karakter '$key'"),
                          trailing: Text("$count kali", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF64748B))),
                        );
                      },
                    ),
                  )
                ]
              ],
            ),
          );
        }
      ),
    );
  }

  // WIDGET BANTUAN BUAT KOTAK HASIL
  Widget _buildStatCard(String title, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF4338CA), Color(0xFF312E81)], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: const Color(0xFF4338CA).withOpacity(0.3), blurRadius: 15, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white70, size: 28),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
          Text(title, style: const TextStyle(color: Color(0xFFC7D2FE), fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}