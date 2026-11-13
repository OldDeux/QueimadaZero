import 'package:flutter/material.dart';

import 'features/dicas/presentation/pages/dicas_page.dart';
import 'injection.dart';

class QueimadaZeroApp extends StatelessWidget {
  const QueimadaZeroApp({super.key, required this.dependencies});

  final AppDependencies dependencies;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QueimadaZero',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      // Tela inicial provisória até a navegação (#15) e a Home (#10).
      home: DicasPage(listarDicas: dependencies.listarDicas),
    );
  }
}
