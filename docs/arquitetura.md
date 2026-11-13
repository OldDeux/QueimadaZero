# Arquitetura do aplicativo

O QueimadaZero segue a **Clean Architecture**, organizada por feature. O código fica em `app/lib/`.

## Estrutura de pastas

```
app/lib/
├── main.dart              # inicia o app
├── app.dart               # MaterialApp, tema e tela inicial
├── injection.dart         # liga as camadas (composition root)
├── core/                  # código compartilhado entre as features
│   ├── error/
│   │   ├── exceptions.dart   # erros técnicos da camada data
│   │   └── failures.dart     # falhas entendidas pelo domínio e pela interface
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
| `presentation/` | `pages/` e `widgets/` | `domain/` e `core/` |

A regra principal: **as dependências apontam para dentro**. A interface conhece os casos de uso, os casos de uso conhecem os contratos, e a implementação dos contratos fica na camada `data/`. Assim dá para trocar a API do INPE, o banco local ou o Firebase sem mexer no domínio nem nas telas.

## Fluxo de uma chamada

```
DicasPage ──▶ ListarDicas ──▶ DicasRepository (contrato)
                                   ▲
                                   │ implementa
                         DicasRepositoryImpl ──▶ DicasLocalDataSource
```

1. A tela chama o caso de uso.
2. O caso de uso chama o contrato do repositório.
3. A implementação do repositório busca os dados na fonte (API, cache, Firebase).
4. Se a fonte lançar uma `AppException` (rede, servidor, cache), o repositório a converte numa `Failure` e devolve `Failed`. Em caso de sucesso, devolve `Success`.
5. A tela usa `result.fold(...)` para mostrar os dados ou um estado de erro amigável. Assim o app não quebra se a API do INPE cair.

## Injeção de dependências

As classes recebem as dependências pelo construtor, e `injection.dart` é o único lugar que monta tudo. Nos testes, basta passar versões falsas, como em `test/features/dicas/`.

A injeção é manual por enquanto. A escolha entre Riverpod e Bloc é da issue #7, que deve substituir o `AppDependencies` pelos providers ou blocs escolhidos.

## Como criar uma nova funcionalidade

Exemplo: listar os focos do INPE na feature `focos`.

1. **Domínio:** crie a entidade `Foco`, o contrato `FocosRepository` e o caso de uso `ListarFocos`.
2. **Dados:** crie o `FocoModel` com `fromJson`, a fonte `FocosRemoteDataSource`, que lança `ServerException` ou `NetworkException`, e o `FocosRepositoryImpl`, que converte as exceções em falhas.
3. **Interface:** crie a página, que recebe o caso de uso.
4. **Ligação:** registre a cadeia em `injection.dart`.
5. **Testes:** teste o caso de uso e o repositório com fontes falsas, em `test/features/focos/`.

Use a feature `dicas` como modelo.
