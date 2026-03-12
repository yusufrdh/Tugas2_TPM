import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/auth_controller.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _nimController = TextEditingController();
  final AuthController _AuthController = AuthController();
  String errorMessage = "";

  void _login() {
    String userName = _AuthController.AuthLogin(NIM : _nimController);
    if (userName != "") {
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(builder: (context) => HomePage(userName: userName))
      );
    } else {
      setState(() => errorMessage = "NIM tidak ditemukan. Silakan coba lagi.");
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4338CA); 

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center, 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEF2FF),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: primaryColor.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))],
                    ),
                    child: const Icon(Icons.code_rounded, size: 48, color: primaryColor),
                  ),
                  const SizedBox(height: 32),
                  
                  const Text(
                    "Selamat Datang Di\nTugas 2 Teknologi\n Pemrograman Mobile.", 
                    textAlign: TextAlign.center, 
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF1E293B), height: 1.2, letterSpacing: -0.5)
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    "Silakan masukkan NIM Anda.", 
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: Color(0xFF64748B), height: 1.5)
                  ),
                  // ----------------------------------------
                  
                  const SizedBox(height: 48),
                  
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [BoxShadow(color: const Color(0xFF1E293B).withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 5))],
                    ),
                    child: TextField(
                      controller: _nimController,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                        hintText: "NIM...",
                        hintStyle: const TextStyle(color: Color(0xFF94A3B8), fontWeight: FontWeight.normal),
                        prefixIcon: const Icon(Icons.numbers_rounded, color: primaryColor),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  if (errorMessage.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      children: [
                        const Icon(Icons.error_outline_rounded, color: Colors.redAccent, size: 20),
                        const SizedBox(width: 8),
                        Text(errorMessage, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600, fontSize: 14)),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                  
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _login,
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Access Dashboard", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward_rounded, size: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}