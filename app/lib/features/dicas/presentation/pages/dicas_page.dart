import 'package:flutter/material.dart';

import '../../../../core/usecase/usecase.dart';
import '../../domain/entities/dica.dart';
import '../../domain/usecases/listar_dicas.dart';

/// Lista simples das dicas respiratórias.
///
/// Serve de exemplo de ponta a ponta da arquitetura. O visual final é da
/// issue #13, e a gerência de estado (Riverpod ou Bloc) é da issue #7.
class DicasPage extends StatefulWidget {
  const DicasPage({super.key, required this.listarDicas});

  final ListarDicas listarDicas;

  @override
  State<DicasPage> createState() => _DicasPageState();
}

class _DicasPageState extends State<DicasPage> {
  late final Future<_Estado> _estado = _carregar();

  Future<_Estado> _carregar() async {
    final resultado = await widget.listarDicas(const NoParams());
    return resultado.fold(
      (failure) => _Estado.erro(failure.message),
      _Estado.dicas,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dicas respiratórias')),
      body: FutureBuilder<_Estado>(
        future: _estado,
        builder: (context, snapshot) {
          final estado = snapshot.data;
          if (estado == null) {
            return const Center(child: CircularProgressIndicator());
          }
          if (estado.erro != null) {
            return Center(child: Text(estado.erro!));
          }
          return ListView(
            children: [for (final dica in estado.dicas) _DicaTile(dica: dica)],
          );
        },
      ),
    );
  }
}

class _Estado {
  const _Estado.dicas(this.dicas) : erro = null;
  const _Estado.erro(this.erro) : dicas = const [];

  final List<Dica> dicas;
  final String? erro;
}

class _DicaTile extends StatelessWidget {
  const _DicaTile({required this.dica});

  final Dica dica;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(dica.grupoDeRisco ? Icons.medical_services : Icons.air),
      title: Text(dica.titulo),
      subtitle: Text(dica.descricao),
    );
  }
}
