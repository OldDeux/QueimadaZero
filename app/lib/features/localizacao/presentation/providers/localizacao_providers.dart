import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/result.dart';
import '../../../../core/usecase/usecase.dart';
import '../../data/datasources/gps_datasource.dart';
import '../../data/datasources/preferencias_localizacao_datasource.dart';
import '../../data/repositories/localizacao_repository_impl.dart';
import '../../domain/entities/permissao_localizacao.dart';
import '../../domain/entities/posicao.dart';
import '../../domain/repositories/localizacao_repository.dart';
import '../../domain/usecases/acompanhar_posicao.dart';
import '../../domain/usecases/ativar_rastreamento.dart';
import '../../domain/usecases/desativar_rastreamento.dart';
import '../../domain/usecases/verificar_rastreamento.dart';

// Injeção de dependências. Nos testes, troque as fontes de dados com
// `overrideWithValue`.

final gpsDataSourceProvider = Provider<GpsDataSource>(
  (ref) => const GeolocatorDataSource(),
);

final preferenciasLocalizacaoDataSourceProvider =
    Provider<PreferenciasLocalizacaoDataSource>(
      (ref) => const SharedPreferencesLocalizacaoDataSource(),
    );

final localizacaoRepositoryProvider = Provider<LocalizacaoRepository>(
  (ref) => LocalizacaoRepositoryImpl(
    ref.watch(gpsDataSourceProvider),
    ref.watch(preferenciasLocalizacaoDataSourceProvider),
  ),
);

final ativarRastreamentoProvider = Provider(
  (ref) => AtivarRastreamento(ref.watch(localizacaoRepositoryProvider)),
);

final desativarRastreamentoProvider = Provider(
  (ref) => DesativarRastreamento(ref.watch(localizacaoRepositoryProvider)),
);

final verificarRastreamentoProvider = Provider(
  (ref) => VerificarRastreamento(ref.watch(localizacaoRepositoryProvider)),
);

final acompanharPosicaoProvider = Provider(
  (ref) => AcompanharPosicao(ref.watch(localizacaoRepositoryProvider)),
);

// Estado das telas.

/// Se a pessoa deixou a localização ligada.
final rastreamentoProvider = AsyncNotifierProvider<RastreamentoNotifier, bool>(
  RastreamentoNotifier.new,
);

class RastreamentoNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final resultado = await ref.read(verificarRastreamentoProvider)(
      const NoParams(),
    );
    return resultado.getOrThrow();
  }

  /// Pede a permissão e liga a localização se o celular permitir.
  ///
  /// Devolve a resposta, para a tela explicar o que fazer quando negar.
  Future<Result<PermissaoLocalizacao>> ativar() async {
    final resultado = await ref.read(ativarRastreamentoProvider)(
      const NoParams(),
    );
    if (resultado case Success(value: PermissaoLocalizacao.concedida)) {
      state = const AsyncData(true);
    }
    return resultado;
  }

  /// Desliga a localização. O GPS para na hora.
  Future<Result<void>> desativar() async {
    final anterior = state;
    state = const AsyncData(false);
    final resultado = await ref.read(desativarRastreamentoProvider)(
      const NoParams(),
    );
    // Se não conseguiu salvar, volta o botão para a posição real.
    if (resultado is Failed) state = anterior;
    return resultado;
  }

  Future<bool> abrirAjustes(PermissaoLocalizacao motivo) =>
      ref.read(localizacaoRepositoryProvider).abrirAjustes(motivo);
}

/// Posição atual, só enquanto a localização estiver ligada.
///
/// Fica `null` com a localização desligada. Ao desligar, o provider é
/// refeito e o fluxo do GPS é cancelado.
final posicaoProvider = StreamProvider<Posicao?>((ref) {
  final ativado = ref.watch(rastreamentoProvider).value ?? false;
  if (!ativado) return Stream.value(null);
  return ref
      .watch(acompanharPosicaoProvider)()
      .map((resultado) => resultado.getOrThrow());
});
