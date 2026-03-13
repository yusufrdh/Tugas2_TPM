import 'package:flutter/material.dart';
import 'pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF4338CA);
    const bgColor = Color(0xFFF8FAFC);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mobile Programming Task",

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Roboto",

        scaffoldBackgroundColor: bgColor,

        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),

        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),

      home: const LoginPage(),
    );
  }
}
