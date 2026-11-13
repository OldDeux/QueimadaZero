# Changelog

Registro das alterações realizadas no projeto **QueimadaZero**.

O formato é baseado em [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/).

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
