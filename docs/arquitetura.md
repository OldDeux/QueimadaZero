# Arquitetura do aplicativo

O QueimadaZero segue a **Clean Architecture**, organizada por feature. O código fica em `app/lib/`.

## Estrutura de pastas

```
app/lib/
├── main.dart              # inicia o app dentro do ProviderScope
├── app.dart               # MaterialApp, tema e tela inicial
├── core/                  # código compartilhado entre as features
│   ├── error/
│   │   ├── exceptions.dart   # erros técnicos da camada data
│   │   └── failures.dart     # falhas entendidas pelo domínio e pela interface
│   ├── presentation/
│   │   └── async_value_view.dart  # estados carregando, sucesso, erro e offline
│   ├── result.dart           # Result<T>: Success ou Failed
│   └── usecase/usecase.dart  # contrato UseCase<T, Params>
└── features/
    ├── alertas/           # geolocalização e alertas de proximidade
    ├── denuncia/          # fluxo "Estou vendo fumaça"
    ├── dicas/             # dicas respiratórias (exemplo completo)
    ├── focos/             # focos de queimada e mapa
    └── qualidade_ar/      # AQI e dados de clima
```

Cada feature tem três camadas:

| Camada | O que fica nela | Pode depender de |
|---|---|---|
| `domain/` | `entities/` (objetos do negócio), `repositories/` (contratos) e `usecases/` (uma ação cada) | Só do `core/`. Não importa Flutter, HTTP nem Firebase. |
| `data/` | `datasources/` (API, banco local, Firebase), `models/` (conversão de JSON) e `repositories/` (implementação dos contratos) | `domain/` e `core/` |
| `presentation/` | `pages/`, `widgets/` e `providers/` (estado e ligação das camadas com Riverpod) | `domain/` e `core/`. Os providers também importam `data/`, por serem o ponto de ligação. |

A regra principal: **as dependências apontam para dentro**. A interface conhece os casos de uso, os casos de uso conhecem os contratos, e a implementação dos contratos fica na camada `data/`. Assim dá para trocar a API do INPE, o banco local ou o Firebase sem mexer no domínio nem nas telas.

## Fluxo de uma chamada

```
DicasPage ──▶ dicasProvider ──▶ ListarDicas ──▶ DicasRepository (contrato)
                                                     ▲
                                                     │ implementa
                                           DicasRepositoryImpl ──▶ DicasLocalDataSource
```

1. A tela observa um provider, que chama o caso de uso.
2. O caso de uso chama o contrato do repositório.
3. A implementação do repositório busca os dados na fonte (API, cache, Firebase).
4. Se a fonte lançar uma `AppException` (rede, servidor, cache), o repositório a converte numa `Failure` e devolve `Failed`. Em caso de sucesso, devolve `Success`.
5. O provider chama `result.getOrThrow()`: a falha vira `AsyncError`, e a tela usa o `AsyncValueView` para mostrar os dados, o carregamento, o erro ou o aviso de offline, com o botão "Tentar novamente". Assim o app não quebra se a API do INPE cair.

## Gerência de estado e injeção de dependências

O app usa o **Riverpod** (`flutter_riverpod`). A justificativa da escolha está em [`justificativas.md`](justificativas.md#gerência-de-estado-riverpod).

Cada feature tem um arquivo `presentation/providers/<feature>_providers.dart` com dois tipos de provider:

* **Ligação das camadas:** `Provider` para a fonte de dados, o repositório e o caso de uso. As classes continuam recebendo as dependências pelo construtor; o provider só as monta.
* **Estado da tela:** `FutureProvider` (dados carregados uma vez), `StreamProvider` (dados que mudam, como a posição do GPS) ou `NotifierProvider` (estado com ações, como o formulário de relato).

As telas são `ConsumerWidget` e usam `ref.watch(provider)` para ler o estado e `ref.invalidate(provider)` para recarregar.

### Estados padrão

Todo dado assíncrono é mostrado com o `AsyncValueView` (`core/presentation/async_value_view.dart`):

| Estado | Quando | O que aparece |
|---|---|---|
| Carregando | O provider ainda está buscando | Indicador de progresso |
| Sucesso | `AsyncData` | O conteúdo da tela |
| Offline | `AsyncError` com `NetworkFailure` | Aviso "Você está offline" e botão "Tentar novamente" |
| Erro | `AsyncError` com outra falha | Mensagem da falha e botão "Tentar novamente" |

A nova tentativa automática do Riverpod está desligada no `main.dart`: quem decide tentar de novo é a pessoa, pelo botão, ou o próprio provider, quando ele tiver atualização periódica.

### Testes

Nos testes, troque qualquer elo com `overrideWithValue`, como em `test/features/dicas/presentation/dicas_page_test.dart`:

```dart
ProviderScope(
  retry: semNovaTentativa,
  overrides: [dicasRepositoryProvider.overrideWithValue(RepositorioFalso())],
  child: const MaterialApp(home: DicasPage()),
)
```

## Como criar uma nova funcionalidade

Exemplo: listar os focos do INPE na feature `focos`.

1. **Domínio:** crie a entidade `Foco`, o contrato `FocosRepository` e o caso de uso `ListarFocos`.
2. **Dados:** crie o `FocoModel` com `fromJson`, a fonte `FocosRemoteDataSource`, que lança `ServerException` ou `NetworkException`, e o `FocosRepositoryImpl`, que converte as exceções em falhas.
3. **Providers:** em `presentation/providers/focos_providers.dart`, crie os providers da fonte, do repositório e do caso de uso, e um `FutureProvider` com a lista de focos.
4. **Interface:** crie a página como `ConsumerWidget`, mostrando o provider com o `AsyncValueView`.
5. **Testes:** teste o caso de uso e o repositório com fontes falsas, e a página com `overrideWithValue`, em `test/features/focos/`.

Use a feature `dicas` como modelo.
