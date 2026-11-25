import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../data/datasources/qualidade_ar_remote_datasource.dart';
import '../../data/repositories/qualidade_ar_repository_impl.dart';
import '../../domain/entities/localizacao.dart';
import '../../domain/entities/qualidade_ar.dart';
import '../../domain/repositories/qualidade_ar_repository.dart';
import '../../domain/usecases/buscar_qualidade_ar.dart';

// Injeção de dependências: fonte de dados -> repositório -> caso de uso.
// Nos testes, troque qualquer elo com `overrideWithValue`.

final qualidadeArHttpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
});

final qualidadeArRemoteDataSourceProvider =
    Provider<QualidadeArRemoteDataSource>(
      (ref) =>
          QualidadeArRemoteDataSourceImpl(ref.watch(qualidadeArHttpClientProvider)),
    );

final qualidadeArRepositoryProvider = Provider<QualidadeArRepository>(
  (ref) => QualidadeArRepositoryImpl(
    ref.watch(qualidadeArRemoteDataSourceProvider),
  ),
);

final buscarQualidadeArProvider = Provider<BuscarQualidadeAr>(
  (ref) => BuscarQualidadeAr(ref.watch(qualidadeArRepositoryProvider)),
);

/// Local consultado. Por enquanto é fixo em Aracaju; a geolocalização em
/// tempo real (issue #20) vai trocar este provider.
final localizacaoProvider = Provider<Localizacao>(
  (ref) => const Localizacao(
    cidade: 'Aracaju',
    latitude: -10.9472,
    longitude: -37.0731,
  ),
);

// Estado da tela.

/// Qualidade do ar atual da cidade.
///
/// Ao recarregar com `ref.invalidate`, o Riverpod mantém o último valor
/// recebido. Se a nova busca falhar, a Home mostra esse dado salvo com o
/// horário da última atualização, em vez de esconder o card.
final qualidadeArAtualProvider = FutureProvider<QualidadeAr>((ref) async {
  final buscar = ref.watch(buscarQualidadeArProvider);
  final resultado = await buscar(ref.watch(localizacaoProvider));
  return resultado.getOrThrow();
});
