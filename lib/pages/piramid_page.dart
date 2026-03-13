import 'package:flutter/material.dart';

// ==========================================
// 1. HALAMAN MENU PILIHAN (MENU UTAMA PIRAMID)
// ==========================================
class PiramidPage extends StatelessWidget {
  const PiramidPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Piramid Segi Empat")),
      body: Column(
        children: [
          // HEADER KEREN ANTI-COPAS
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF312E81), Color(0xFF4F46E5)]),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40)),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
                  child: const Icon(Icons.change_history_rounded, size: 64, color: Colors.white),
                ),
                const SizedBox(height: 16),
                const Text("Pilih Mode Perhitungan", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white)),
                const SizedBox(height: 8),
                const Text("Kalkulator Limas Segi Empat Beraturan", style: TextStyle(color: Color(0xFFC7D2FE))),
              ],
            ),
          ),
          
          const SizedBox(height: 32),

          // KARTU PILIHAN 1: LUAS PERMUKAAN
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: _buildMenuOption(
              context,
              title: "Hitung Luas Permukaan",
              subtitle: "L = a² + 2 × a × t.miring",
              icon: Icons.layers_rounded,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const _LuasPiramidPage())),
            ),
          ),

          // KARTU PILIHAN 2: VOLUME
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
            child: _buildMenuOption(
              context,
              title: "Hitung Volume",
              subtitle: "V = ⅓ × a² × t",
              icon: Icons.view_in_ar_rounded,
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const _VolumePiramidPage())),
            ),
          ),
        ],
      ),
    );
  }

  // Desain Kartu Menu Pilihan (Biar rapi dan elegan)
  Widget _buildMenuOption(BuildContext context, {required String title, required String subtitle, required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: const Color(0xFF4F46E5).withOpacity(0.08), blurRadius: 20, offset: const Offset(0, 10))],
          border: Border.all(color: const Color(0xFFF1F5F9), width: 2),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Color(0xFFEEF2FF), shape: BoxShape.circle),
              child: Icon(icon, color: Color(0xFF4F46E5), size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Color(0xFF94A3B8))),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFFCBD5E1), size: 20),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. HALAMAN KALKULATOR LUAS PERMUKAAN
// ==========================================
class _LuasPiramidPage extends StatefulWidget {
  const _LuasPiramidPage();
  @override
  State<_LuasPiramidPage> createState() => _LuasPiramidPageState();
}

class _LuasPiramidPageState extends State<_LuasPiramidPage> {
  final TextEditingController _aCtrl = TextEditingController();
  final TextEditingController _tMiringCtrl = TextEditingController();
  String _hasil = "0";

  void _hitung() {
    double? a = double.tryParse(_aCtrl.text);
    double? tMiring = double.tryParse(_tMiringCtrl.text);
    if (a == null || tMiring == null) {
      setState(() => _hasil = "Error");
      return;
    }
    setState(() => _hasil = ((a * a) + (2 * a * tMiring)).toStringAsFixed(2));
  }

  void _reset() {
    _aCtrl.clear();
    _tMiringCtrl.clear();
    setState(() => _hasil = "0");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Luas Permukaan")),
      body: Stack(
        children: [
          Positioned(top: 50, right: -50, child: Icon(Icons.layers_rounded, size: 300, color: const Color(0xFF4F46E5).withOpacity(0.05))),
          SingleChildScrollView(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(controller: _aCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Sisi Alas (a)", prefixIcon: Icon(Icons.straighten_rounded))),
                const SizedBox(height: 16),
                TextField(controller: _tMiringCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Tinggi Sisi Miring (t.miring)", prefixIcon: Icon(Icons.height_rounded))),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(flex: 1, child: ElevatedButton(onPressed: _reset, style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF64748B), elevation: 0, side: const BorderSide(color: Color(0xFFE2E8F0))), child: const Text("Reset"))),
                    const SizedBox(width: 16),
                    Expanded(flex: 2, child: ElevatedButton(onPressed: _hitung, child: const Text("Hitung Luas"))),
                  ],
                ),
                const SizedBox(height: 48),
                const Text("Hasil Luas Permukaan", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8))),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(_hasil, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Color(0xFF4F46E5), height: 1)),
                    const SizedBox(width: 8),
                    const Padding(padding: EdgeInsets.only(bottom: 8.0), child: Text("satuan²", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF64748B)))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 3. HALAMAN KALKULATOR VOLUME
// ==========================================
class _VolumePiramidPage extends StatefulWidget {
  const _VolumePiramidPage();
  @override
  State<_VolumePiramidPage> createState() => _VolumePiramidPageState();
}

class _VolumePiramidPageState extends State<_VolumePiramidPage> {
  final TextEditingController _aCtrl = TextEditingController();
  final TextEditingController _tCtrl = TextEditingController();
  String _hasil = "0";

  void _hitung() {
    double? a = double.tryParse(_aCtrl.text);
    double? t = double.tryParse(_tCtrl.text);
    if (a == null || t == null) {
      setState(() => _hasil = "Error");
      return;
    }
    setState(() => _hasil = ((1 / 3) * a * a * t).toStringAsFixed(2));
  }

  void _reset() {
    _aCtrl.clear();
    _tCtrl.clear();
    setState(() => _hasil = "0");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Volume Piramid")),
      body: Stack(
        children: [
          Positioned(top: 50, left: -50, child: Icon(Icons.view_in_ar_rounded, size: 300, color: const Color(0xFF4F46E5).withOpacity(0.05))),
          SingleChildScrollView(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(controller: _aCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Sisi Alas (a)", prefixIcon: Icon(Icons.straighten_rounded))),
                const SizedBox(height: 16),
                TextField(controller: _tCtrl, keyboardType: TextInputType.number, decoration: const InputDecoration(hintText: "Tinggi Piramid (t)", prefixIcon: Icon(Icons.height_rounded))),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(flex: 1, child: ElevatedButton(onPressed: _reset, style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF64748B), elevation: 0, side: const BorderSide(color: Color(0xFFE2E8F0))), child: const Text("Reset"))),
                    const SizedBox(width: 16),
                    Expanded(flex: 2, child: ElevatedButton(onPressed: _hitung, child: const Text("Hitung Volume"))),
                  ],
                ),
                const SizedBox(height: 48),
                const Text("Hasil Volume", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF94A3B8))),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(_hasil, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: Color(0xFF4F46E5), height: 1)),
                    const SizedBox(width: 8),
                    const Padding(padding: EdgeInsets.only(bottom: 8.0), child: Text("satuan³", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF64748B)))),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}