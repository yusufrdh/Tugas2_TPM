import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // WAJIB DITAMBAHKAN untuk FilteringTextInputFormatter
import '../controller/piramid_controller.dart';

class PiramidPage extends StatelessWidget {
  const PiramidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Piramid Segi Empat")),
      body: Column(
        children: [
          /// HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF312E81), Color(0xFF4F46E5)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.change_history_rounded,
                  size: 64,
                  color: Colors.white,
                ),
                SizedBox(height: 12),
                Text(
                  "Kalkulator Piramid",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Pilih jenis perhitungan",
                  style: TextStyle(color: Color(0xFFC7D2FE)),
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          /// MENU LUAS
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _menuCard(
              context,
              title: "Hitung Luas Permukaan",
              subtitle: "L = s² + 4 × ½ × s × tₘ",
              icon: Icons.layers_rounded,
              page: const LuasPiramidPage(),
            ),
          ),

          const SizedBox(height: 16),

          /// MENU VOLUME
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: _menuCard(
              context,
              title: "Hitung Volume",
              subtitle: "V = ⅓ × s² × t",
              icon: Icons.view_in_ar_rounded,
              page: const VolumePiramidPage(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Widget page,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => page));
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 15,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color(0xFFEEF2FF),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: const Color(0xFF4F46E5)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: Colors.grey)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// HALAMAN LUAS PERMUKAAN
////////////////////////////////////////////////////////////

class LuasPiramidPage extends StatefulWidget {
  const LuasPiramidPage({super.key});

  @override
  State<LuasPiramidPage> createState() => _LuasPiramidPageState();
}

class _LuasPiramidPageState extends State<LuasPiramidPage> {
  final TextEditingController sisiController = TextEditingController();
  final TextEditingController tinggiController = TextEditingController();

  final PiramidController controller = PiramidController();

  String hasil = "0";

  void hitung() {
    if (sisiController.text.isEmpty || tinggiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Masukan angka tidak boleh kosong!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    var result = controller.calculate(
      sisiController: sisiController,
      tinggiController: tinggiController,
    );

    setState(() {
      hasil = result.$1;
    });
  }

  void reset() {
    sisiController.clear();
    tinggiController.clear();
    setState(() => hasil = "0");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Luas Permukaan Piramid")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: sisiController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              decoration: const InputDecoration(
                labelText: "Sisi Alas (s)",
                prefixIcon: Icon(Icons.square_foot),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: tinggiController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              decoration: const InputDecoration(
                labelText: "Tinggi Piramid (t)",
                prefixIcon: Icon(Icons.height),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: reset,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                    ),
                    child: const Text("Reset",
                        style: TextStyle(color: Colors.black87)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: hitung,
                    child: const Text("Hitung Luas"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            _hasilCard("Luas Permukaan", hasil, "satuan²"),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// HALAMAN VOLUME
////////////////////////////////////////////////////////////

class VolumePiramidPage extends StatefulWidget {
  const VolumePiramidPage({super.key});

  @override
  State<VolumePiramidPage> createState() => _VolumePiramidPageState();
}

class _VolumePiramidPageState extends State<VolumePiramidPage> {
  final TextEditingController sisiController = TextEditingController();
  final TextEditingController tinggiController = TextEditingController();

  final PiramidController controller = PiramidController();

  String hasil = "0";

  void hitung() {
    if (sisiController.text.isEmpty || tinggiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Masukan angka tidak boleh kosong!"),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    var result = controller.calculate(
      sisiController: sisiController,
      tinggiController: tinggiController,
    );

    setState(() {
      hasil = result.$2;
    });
  }

  void reset() {
    sisiController.clear();
    tinggiController.clear();
    setState(() => hasil = "0");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Volume Piramid")),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: sisiController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              decoration: const InputDecoration(
                labelText: "Sisi Alas (s)",
                prefixIcon: Icon(Icons.square_foot),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: tinggiController,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
              decoration: const InputDecoration(
                labelText: "Tinggi Piramid (t)",
                prefixIcon: Icon(Icons.height),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: reset,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                    ),
                    child: const Text("Reset",
                        style: TextStyle(color: Colors.black87)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: hitung,
                    child: const Text("Hitung Volume"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            _hasilCard("Volume", hasil, "satuan³"),
          ],
        ),
      ),
    );
  }
}

////////////////////////////////////////////////////////////
/// CARD HASIL 
////////////////////////////////////////////////////////////

Widget _hasilCard(String title, String value, String unit) {
  return Card(
    elevation: 6,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 16, color: Colors.grey)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flexible(
                child: Text(
                  value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F46E5),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  unit,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
