import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'landing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Black Cab Burger',
      debugShowCheckedModeBanner: false,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF8F5F0), // Cream paper
        colorScheme: const ColorScheme.light(
          primary: Color(0xFFAD0F0F),    // Crimson Red
          secondary: Color(0xFFAD0F0F),  // Red Accent
          surface: Color(0xFFFFFFFF),    // White surface
        ),
        textTheme: GoogleFonts.outfitTextTheme(
          ThemeData.light().textTheme.copyWith(
            bodyLarge: const TextStyle(color: Color(0xFF1A1A1A)),
            bodyMedium: const TextStyle(color: Color(0xFF555555)),
          ),
        ),
        useMaterial3: true,
      ),
      home: const LandingPage(),
    );
  }
}
