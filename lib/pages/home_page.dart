import 'package:flutter/material.dart';
import 'login_page.dart';
import 'calculator_page.dart';
import 'ganjil_genap_page.dart';
import 'jumlah_page.dart';
import 'stopwatch_page.dart';
import 'piramid_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text("Log Out", style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel", style: TextStyle(color: Colors.grey))),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text("Log Out", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard"),
        actions: [
          IconButton(icon: const Icon(Icons.logout), onPressed: () => _logout(context)),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // KARTU TIM - GRADASI PREMIUM
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF312E81), Color(0xFF4338CA)], // Dark Indigo to Tech Indigo
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [BoxShadow(color: const Color(0xFF4338CA).withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 10))],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.stars_rounded, color: Color(0xFF818CF8), size: 20),
                        SizedBox(width: 8),
                        Text("TEAM MEMBERS", style: TextStyle(fontSize: 12, color: Color(0xFF818CF8), letterSpacing: 1.5, fontWeight: FontWeight.w700)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildTeamMember("Yusuf Nur Ramadhan", "123230188"),
                    const SizedBox(height: 10),
                    _buildTeamMember("Kevin Dwi Cahyadi", "123230115"),
                    const SizedBox(height: 10),
                    _buildTeamMember("M. Bintang Al-Kautsar", "123230137"),
                    const SizedBox(height: 10),
                    _buildTeamMember("Irham Hadi Putra", "123230042"),
                  ],
                ),
              ),
            ),
            
            const Padding(
              padding: EdgeInsets.only(left: 28.0, top: 28, bottom: 16),
              child: Text("Applications", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: Color(0xFF1E293B))),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildMenuCard(context, "Calculator", Icons.calculate_rounded, const CalculatorPage()),
                    _buildMenuCard(context, "Number Check", Icons.tag_rounded, const GanjilGenapPage()),
                    _buildMenuCard(context, "Sum Total", Icons.functions_rounded, const JumlahPage()),
                    _buildMenuCard(context, "Stopwatch", Icons.timer_rounded, const StopwatchPage()),
                    _buildMenuCard(context, "Pyramid", Icons.change_history_rounded, const PiramidPage()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMember(String name, String nim) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14)),
        Text(nim, style: const TextStyle(color: Color(0xFFC7D2FE), fontSize: 13, fontFeatures: [FontFeature.tabularFigures()])),
      ],
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, IconData icon, Widget page) {
    return InkWell(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [BoxShadow(color: const Color(0xFF1E293B).withOpacity(0.04), blurRadius: 20, offset: const Offset(0, 10))],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: Color(0xFFEEF2FF), shape: BoxShape.circle), // Background ikon soft indigo
              child: Icon(icon, size: 28, color: const Color(0xFF4338CA)), // Ikon warna tech indigo
            ),
            const SizedBox(height: 16),
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
          ],
        ),
      ),
    );
  }
}