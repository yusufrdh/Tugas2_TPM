import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String errorMessage = "";
  bool _isObscure = true;

  void _login() {
    if (_usernameController.text == "admin" && _passwordController.text == "1234") {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage()));
    } else {
      setState(() => errorMessage = "Username atau password salah!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ikon dengan Gradasi Premium
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: const Color(0xFF4338CA).withOpacity(0.15), blurRadius: 30, offset: const Offset(0, 10))],
                  ),
                  child: const Icon(Icons.fingerprint, size: 56, color: Color(0xFF4338CA)),
                ),
                const SizedBox(height: 32),
                const Text("Welcome Back", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF1E293B), letterSpacing: -0.5)),
                const SizedBox(height: 8),
                const Text("Please sign in to your account", style: TextStyle(fontSize: 15, color: Color(0xFF64748B))),
                const SizedBox(height: 48),
                
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(hintText: "Username", prefixIcon: Icon(Icons.person_outline)),
                ),
                const SizedBox(height: 16),
                
                TextField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(_isObscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: const Color(0xFF94A3B8)),
                      onPressed: () => setState(() => _isObscure = !_isObscure),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                
                if (errorMessage.isNotEmpty) ...[
                  Text(errorMessage, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 16),
                ],
                
                SizedBox(width: double.infinity, child: ElevatedButton(onPressed: _login, child: const Text("SIGN IN"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}