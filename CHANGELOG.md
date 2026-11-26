# Changelog

Registro das alterações realizadas no projeto **QueimadaZero**.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/).

## [0.12.0] - 2026-11-26

Geolocalização em tempo real com opção de desativar (#20).

### Adicionado

* Feature `localizacao`, nas camadas `domain`, `data` e `presentation`, com os pacotes `geolocator` (GPS) e `shared_preferences` (escolha salva no celular).
* Tela que explica para que o app usa a localização antes de o celular pedir a permissão, como no protótipo. Se a permissão for negada ou o GPS estiver desligado, a tela diz o que fazer.
* Tela de configurações com a chave "Usar minha localização". Ligada, mostra a precisão do GPS e a hora da última posição.
* `VerificarRastreamento`, que os alertas em segundo plano (#21 e #22) devem chamar antes de usar a posição.
* Falha `LocalizacaoFailure` e exceção `LocalizacaoException` em `core/error/`.
* 10 testes de localização, com GPS de mentira: ligar, desligar, "Agora não", permissão bloqueada, GPS desligado no meio do uso e erro ao ler a escolha salva.
* `docs/localizacao.md` com o funcionamento e as regras de privacidade.

### Observações

* A localização começa desligada, e o GPS só é acionado com ela ligada. Ao desligar, o GPS para na hora.
* As permissões do Android entram junto com a pasta `android/`, na issue #35.

---

## [Unreleased]

Primeira etapa da tela de notificações e alertas (#14).

### Adicionado

* Tela de alertas com mensagem de histórico vazio e informação sobre a integração futura das notificações.
* Tela de meus relatos com estado vazio e explicação dos status `Enviado` e `Na fila`.
* Testes de interface e adaptação em telas pequenas.

### Pendente

* Integração com alertas e denúncias reais e armazenamento offline.


### Alterado

Atualização da documentação da Unidade II (#31).

* `docs/requisitos.md`: situação das funcionalidades em relação às issues e aos PRs atuais.
* `docs/personas.md`: relação de Ana Maria e Joaquim com as telas implementadas e planejadas.
* `docs/pesquisa.md`: revisão do portal de dados do INPE e do papel do Prevfogo/IBAMA.
* `docs/justificativas.md`: decisões de interface, estado e integrações técnicas da Unidade II.
* `README.md`: contribuições registradas e instruções para executar o Flutter Web pelo Docker.

---

## [0.11.0] - 2026-11-25

Tela de dicas respiratórias (#13).

### Alterado

* A tela de orientações agora separa os cuidados do dia a dia das dicas para pessoas com asma ou DPOC, em cards com destaques visuais.
* Conteúdo e navegação seguem o tema de alto contraste do aplicativo.

### Adicionado

* Aviso de que as dicas ficam disponíveis sem internet, usando a fonte local já existente.
* Testes para a exibição das dicas e o destaque dos grupos de risco.

---

## [0.10.0] - 2026-11-24

Navegação entre as telas e tema de alto contraste (#15).

### Adicionado

* Navegação com o pacote `go_router`: menu inferior com 4 abas (Mapa, Meus relatos, Qualidade do ar e Orientações) e as telas de relato, alertas e configurações abrindo por cima do menu.
* Sino (alertas) e ajustes (configurações) no topo das abas, com descrição para o leitor de tela.
* Telas provisórias de mapa, relato, meus relatos, qualidade do ar, alertas e configurações, indicando a issue que implementa cada uma.
* Tema claro de alto contraste em `core/theme/`, com a paleta de `docs/justificativas.md`, botões de 56px de altura e o gradiente laranja → vermelho do mapa de calor.
* Fonte Manrope do protótipo em `app/assets/fonts/` (pesos 400 a 800), incluída no app para funcionar offline, com a licença OFL.
* Testes de contraste (WCAG), de fonte, de navegação entre as telas e de rótulos do menu em uma linha num celular de 375px.
* `docs/navegacao.md` com o diagrama do fluxo e a tabela de rotas.

### Alterado

* O app abre no Mapa, e não mais nas dicas.
* O teste de abertura do app foi substituído pelos testes de navegação.

---

## [0.9.0] - 2026-11-19

Gerência de estado com Riverpod (#7).

### Adicionado

* Pacote `flutter_riverpod` 3.5.0 para gerência de estado e injeção de dependências.
* `AsyncValueView` em `core/presentation/`, que mostra os estados padrão de toda tela: carregando, sucesso, erro e offline, com o botão "Tentar novamente".
* Providers da feature `dicas` em `presentation/providers/dicas_providers.dart`.
* 2 testes da tela de dicas: estado offline e recarga pelo botão "Tentar novamente" (8 testes no total).
* Justificativa da escolha do Riverpod em `docs/justificativas.md`.

### Alterado

* A tela de dicas passa a ser um `ConsumerWidget` que observa o `dicasProvider`.
* `Failure` passa a implementar `Exception`, e o `Result` ganha o `getOrThrow()`, para a falha virar o estado de erro do provider.
* A nova tentativa automática do Riverpod foi desligada no `main.dart`, para uma API fora do ar não ser chamada de novo sem o usuário saber.
* `docs/arquitetura.md` e a seção "Organização do código" de `docs/justificativas.md` atualizadas para a Clean Architecture com Riverpod.

### Removido

* `injection.dart` e a classe `AppDependencies`, substituídos pelos providers.

---

## [0.8.0] - 2026-11-19

CI no GitHub Actions (#36).

### Adicionado

* Workflow `.github/workflows/ci.yml` que roda em todo PR e push para a `main`: verifica a formatação, roda o `flutter analyze` e o `flutter test`.
* A versão do Flutter do CI é lida do `Dockerfile`, para ficar igual à do ambiente local.
* Selo do CI e instruções de formatação no `README.md`.

---

## [0.7.0] - 2026-11-13

Estrutura do app com Clean Architecture (#6).

### Adicionado

* Estrutura de pastas por feature (`alertas`, `denuncia`, `dicas`, `focos`, `qualidade_ar`), cada uma com as camadas `domain`, `data` e `presentation`.
* `core/` com as falhas (`Failure`), as exceções da camada de dados (`AppException`), o tipo `Result` e o contrato `UseCase`.
* Feature `dicas` completa como exemplo de ponta a ponta: entidade, contrato, caso de uso, fonte local, modelo, repositório e tela.
* `injection.dart` como ponto único de ligação das camadas, com injeção manual até a decisão da issue #7.
* 6 testes automatizados: caso de uso, repositório (incluindo a conversão de erro em falha), modelo e abertura do app.
* `docs/arquitetura.md` com as regras das camadas e o passo a passo para criar uma funcionalidade.

### Alterado

* Nome do pacote de `app` para `queimada_zero`.
* Remoção do app de exemplo (contador) gerado pelo Flutter. A tela inicial provisória passa a ser a de dicas.

---

## [0.6.0] - 2026-11-13

Ambiente de desenvolvimento com Docker (#34).

### Adicionado

* `Dockerfile` com o Flutter 3.47.9 (Dart 3.13.7), a mesma versão usada para criar o projeto em `app/`, com download conferido por checksum.
* `docker-compose.yml` com o serviço `flutter`, que compartilha a pasta `app/` com o container e guarda os pacotes no volume `pub-cache`.
* Seção **Ambiente de desenvolvimento** no `README.md`, com os comandos de `pub get`, `analyze` e `test` pelo container.

### Observações

* A imagem `cirruslabs/flutter` foi descartada porque ainda não publica o Flutter 3.47, exigido pelo `pubspec.yaml` do projeto.
* O container não roda emulador; o APK e a versão web ficam para a issue #35.

---

## [0.5.0] - 2026-11-13

Início da **Unidade II — Planejamento do desenvolvimento do aplicativo**.

### Adicionado

* Criação de 26 issues (#6 a #31) a partir dos requisitos da Unidade II, cada uma com checklist do que deve ser entregue.
* Criação do milestone **Unidade II** para agrupar as issues da entrega.
* Criação das labels por área: `área: arquitetura`, `área: telas`, `área: apis`, `área: firebase`, `área: alertas`, `área: denúncia`, `área: offline` e `testes`.
* Criação do Project público [QueimadaZero - Unidade II](https://github.com/users/marcos-grocha/projects/4), com todos os integrantes como colaboradores.
* Quadro Kanban com as colunas **Backlog geral**, **Em desenvolvimento**, **Em review** e **Concluído**.

### Fluxo de trabalho

* Cada PR deve citar a issue com `Closes #N` na descrição. O template de PR (`.github/pull_request_template.md`) já traz esse campo.
* Regras automáticas do Project:
  * item adicionado ao Project vai para **Backlog geral**;
  * PR ligado a uma issue leva o card para **Em review**;
  * PR mergeado ou issue fechada vai para **Concluído**;
  * issue reaberta volta para **Em desenvolvimento**.
* Só a movimentação para **Em desenvolvimento**, ao começar uma tarefa, é manual.
* Dependências entre as issues foram registradas como "blocked by", indicando a ordem de desenvolvimento.
* O template de issue **Tarefa** (`.github/ISSUE_TEMPLATE/tarefa.yml`) adiciona a issue nova ao Project automaticamente.
* PRs e issues criadas sem o template não aparecem para seleção na lateral, pois o Project pertence à conta `marcos-grocha` e não pode ser vinculado ao repositório do `OldDeux`. Eles devem ser adicionados pelo próprio Project, em **+ Add item** colando o link, ou pela linha de comando: `gh project item-add 4 --owner marcos-grocha --url <link>`.
* Ao abrir um PR, adicioná-lo ao Project e movê-lo para **Em review**.

---

## [0.4.0] - 2026-09-30

Início da **Atividade 04 — Prototipação**.

### Adicionado

* Criação do protótipo de baixa fidelidade em `docs/prototipoBaixaFidelidade.pdf`.
* Criação do protótipo de alta fidelidade em `docs/prototipoAltaFidelidade.pdf`.
* Criação do arquivo `docs/justificativas.md` com as justificativas das decisões de UI/UX.
* Definição dos fluxos principais de navegação entre as telas.
* Representação das principais funcionalidades e requisitos do QueimadaZero nos protótipos.
* Aplicação da identidade visual, cores, tipografia, componentes e elementos visuais no protótipo de alta fidelidade.

### Alterado

* Atualização do `README.md` com as responsabilidades dos integrantes referentes à Atividade 04.

---

## [0.3.0] - 2026-09-15

Início da **Atividade 03 — Funcionalidades e Requisitos**.

### Adicionado

- Criação do arquivo `docs/requisitos.md` com a definição das funcionalidades, requisitos funcionais, requisitos não funcionais, CRUD e priorização.
- Definição de 9 funcionalidades do QueimadaZero, com descrição, necessidade do usuário atendida, justificativa e prioridade.
- Definição de 15 requisitos funcionais (RF01 a RF15).
- Definição de 10 requisitos não funcionais (RNF01 a RNF10).
- Identificação das operações de CRUD aplicáveis ao projeto, com exemplo detalhado da notificação de fumaça.
- Priorização das funcionalidades em essenciais, importantes e secundárias.
- Relação das funcionalidades com as personas Ana Maria e Joaquim Ferreira.
- Identificação da funcionalidade considerada mais importante do projeto (F05 — Alertas de proximidade) e sua justificativa.
- Preparação da apresentação da Atividade 03 em `docs/apresentacaoRequisitos.pdf`.

### Alterado

- Atualização do `README.md` com as responsabilidades de cada integrante referentes à Atividade 03 e complemento da lista de arquivos de documentação.

---

## [0.2.0] - 2026-09-10

Início da **Atividade 02 — Pesquisa, Benchmark e Personas**.

### Adicionado

- Criação do arquivo `docs/pesquisa.md` para reunir informações sobre o problema, necessidades dos usuários e dados relevantes para o desenvolvimento do aplicativo.
- Criação do arquivo `docs/benchmark.md` para análise de soluções semelhantes ao QueimadaZero.
- Análise do aplicativo **Watch Duty** como uma das referências do benchmark, considerando:
  - Principais funcionalidades;
  - Pontos positivos e negativos;
  - Interface e experiência de uso;
  - Ideias que podem ser aproveitadas ou melhoradas no QueimadaZero.
- Estrutura inicial para o arquivo `docs/personas.md`, que será utilizado para organizar as personas do projeto.

### Alterado

- Atualização do `README.md` para manter as responsabilidades dos integrantes de acordo com a nova atividade.
- Organização da documentação da Atividade 02 dentro da pasta `docs/`.

---

## [0.1.0] - 2026-09-10

Primeira versão da documentação do projeto, referente à **Atividade 01 — Análise do Estudo de Caso**.

### Adicionado

- Criação do repositório e da estrutura inicial de pastas (`docs/`).
- `README.md` com nome do projeto, integrantes, turma, descrição e responsabilidade de cada integrante na atividade.
- `CHANGELOG.md` para registro das alterações do projeto.
- `docs/estudo-de-caso.md` com a análise do estudo de caso, contemplando:
  - Problema, relevância e principal necessidade a ser atendida;
  - Público e usuários (moradores urbanos e rurais, brigadistas voluntários, bombeiros e agentes ambientais, pessoas com doenças respiratórias crônicas);
  - Contexto de uso (ambiente, conectividade, dispositivo, visibilidade, nível de atenção e alertas);
  - Objetivo e proposta de valor;
  - Personalidade, identidade e experiência;
  - Funcionalidades e características já definidas, com a necessidade atendida por cada uma;
  - Restrições e condições do projeto;
  - Pontos de atenção considerados mais importantes para o sucesso do aplicativo.

### Alterado

- Ajustes de organização e de estrutura dos tópicos do `docs/estudo-de-caso.md`.
- Correção do nome de integrante no `README.md`.
