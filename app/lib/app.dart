import 'package:flutter/material.dart';
import 'presentation/pages/homePage.dart';

class QueimadaZeroApp extends StatelessWidget {
  const QueimadaZeroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QueimadaZero',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF7F7F7),
      ),
      home: const HomePage(),
    );
  }
}
