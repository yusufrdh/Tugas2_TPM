import 'package:flutter/material.dart';
import 'login_page.dart';
import 'calculator_page.dart';
import 'ganjil_genap_page.dart';
import 'jumlah_page.dart';
import 'stopwatch_page.dart';
import 'piramid_page.dart';

class HomePage extends StatefulWidget {
  final String userName;
  const HomePage({super.key, required this.userName});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 2) {
      _logout();
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          "Log Out",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: const Text("Keluar dari aplikasi?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal", style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Text(
              "Keluar",
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      body: SafeArea(
        child: _selectedIndex == 0 ? _buildHomeView() : _buildTeamView(),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex == 2 ? 0 : _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: const Color(0xFF4338CA),
          unselectedItemColor: const Color(0xFF94A3B8),
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.groups_rounded),
              label: "Team",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout_rounded),
              label: "Logout",
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================
  // TAMPILAN HALAMAN 1: HOME (Dashboard Menu)
  // ==========================================
  Widget _buildHomeView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 40.0,
            bottom: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Selamat Datang,",
                style: TextStyle(fontSize: 16, color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 4),
              Text(
                widget.userName.toUpperCase(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1E293B),
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(left: 24.0, top: 12, bottom: 16),
          child: Text(
            "Menu Utama",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E293B),
            ),
          ),
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
                _buildMenuCard(
                  context,
                  "Stopwatch",
                  Icons.timer_rounded,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StopwatchPage(),
                    ),
                  ),
                ),
                _buildMenuCard(
                  context,
                  "Piramid",
                  Icons.change_history_rounded,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PiramidPage(),
                    ),
                  ),
                ),
                _buildMenuCard(
                  context,
                  "Aritmatik",
                  Icons.calculate_rounded,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CalculatorPage(),
                    ),
                  ),
                ),
                _buildMenuCard(
                  context,
                  "Cek Angka",
                  Icons.tag_rounded,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const GanjilGenapPage(),
                    ),
                  ),
                ),
                _buildMenuCard(
                  context,
                  "Jumlah Total",
                  Icons.functions_rounded,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const JumlahPage()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ==========================================
  // TAMPILAN HALAMAN 2: TEAM MEMBERS
  // ==========================================
  Widget _buildTeamView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 24.0,
            right: 24.0,
            top: 40.0,
            bottom: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Informasi Kelompok",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF1E293B),
                  letterSpacing: -0.5,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Daftar anggota Kelompok.",
                style: TextStyle(fontSize: 15, color: Color(0xFF64748B)),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF312E81), Color(0xFF4338CA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4338CA).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(
                      Icons.groups_rounded,
                      color: Color(0xFF818CF8),
                      size: 24,
                    ),
                    SizedBox(width: 12),
                    Text(
                      "ANGGOTA KELOMPOK",
                      style: TextStyle(
                        fontSize: 13,
                        color: Color(0xFF818CF8),
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                _buildTeamMember("Yusuf Nur Ramadhan", "123230188"),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Color(0xFF4F46E5), height: 1),
                ),
                _buildTeamMember("Kevin Dwi Cahyadi", "123230110"),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Color(0xFF4F46E5), height: 1),
                ),
                _buildTeamMember("M. Bintang Al-Kautsar", "123230137"),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  child: Divider(color: Color(0xFF4F46E5), height: 1),
                ),
                _buildTeamMember("M. Irham Hadi Putra", "123230042"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // --- Widget Bantuan ---
  Widget _buildTeamMember(String name, String nim) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        Text(
          nim,
          style: const TextStyle(
            color: Color(0xFFC7D2FE),
            fontSize: 14,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }

  Widget _buildMenuCard(
    BuildContext context,
    String title,
    IconData icon, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF1E293B).withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Color(0xFFEEF2FF),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 28, color: Color(0xFF4338CA)),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
