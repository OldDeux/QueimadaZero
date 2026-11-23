import 'package:flutter/material.dart';

import 'features/dicas/presentation/pages/dicas_page.dart';

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
            // Tela provisória até a Home (#10) e a navegação (#15).
      home: const DicasPage(),
    );
  }
}
