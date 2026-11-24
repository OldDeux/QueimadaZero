import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/alertas/presentation/pages/alertas_page.dart';
import '../../features/configuracoes/presentation/pages/configuracoes_page.dart';
import '../../features/denuncia/presentation/pages/meus_relatos_page.dart';
import '../../features/denuncia/presentation/pages/relatar_page.dart';
import '../../features/dicas/presentation/pages/dicas_page.dart';
import '../../features/focos/presentation/pages/mapa_page.dart';
import '../../features/qualidade_ar/presentation/pages/qualidade_ar_page.dart';
import '../presentation/app_shell.dart';
import 'rotas.dart';

/// Navegação do app. O mapa do fluxo está em `docs/navegacao.md`.
final routerProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: Rotas.mapa,
    routes: [
      // Menu inferior com 4 abas. Cada aba guarda a própria pilha de telas.
      StatefulShellRoute.indexedStack(
        builder: (context, state, shell) => AppShell(shell: shell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Rotas.mapa,
                builder: (context, state) => const MapaPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Rotas.relatos,
                builder: (context, state) => const MeusRelatosPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Rotas.qualidadeAr,
                builder: (context, state) => const QualidadeArPage(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: Rotas.dicas,
                builder: (context, state) => const DicasPage(),
              ),
            ],
          ),
        ],
      ),
      // Telas por cima do menu.
      GoRoute(
        path: Rotas.relatar,
        builder: (context, state) => const RelatarPage(),
      ),
      GoRoute(
        path: Rotas.alertas,
        builder: (context, state) => const AlertasPage(),
      ),
      GoRoute(
        path: Rotas.configuracoes,
        builder: (context, state) => const ConfiguracoesPage(),
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
