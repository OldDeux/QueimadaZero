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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      // Tela inicial provisória até a navegação (#15) e a Home (#10).
      home: const DicasPage(),
    );
  }
}
