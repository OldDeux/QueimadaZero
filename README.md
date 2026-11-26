# QueimadaZero

[![CI](https://github.com/OldDeux/QueimadaZero/actions/workflows/ci.yml/badge.svg)](https://github.com/OldDeux/QueimadaZero/actions/workflows/ci.yml)

Projeto de aplicação voltado para alertas de queimadas, monitoramento de focos e apoio à prevenção dos impactos causados pela fumaça.

O aplicativo tem como proposta reunir informações sobre queimadas, permitir notificações de fumaça e ajudar diferentes usuários, como moradores, brigadistas, bombeiros e agentes ambientais, a acompanhar situações de risco.

## Integrantes

* **Laura de Jesus Lima Brito**
* **Marcos Araújo Goulart**
* **Victor Felipe Santos Melo**
* **Vitória Maíra Evangelista Ribeiro**
* **Thaíssa da Silva Araujo**

## Turma

**PROGRAMAÇÃO PARA DISPOSITIVOS MÓVEIS - GP0161NOT05A**

## Responsabilidades

> As atualizações do `README.md` e do `CHANGELOG.md` são de responsabilidade conjunta do grupo: cada integrante atualiza sua própria seção de responsabilidades a cada nova atividade, e o fechamento final do `CHANGELOG.md` fica a cargo de quem estiver responsável pela documentação da atividade.

### Laura de Jesus Lima Brito

Responsável pelos tópicos:

* Objetivo e proposta de valor;
* Personalidade, identidade e experiência;
* Criação das personas;
* Definição dos requisitos não funcionais;
* Elaboração das `justificativas.md`.

### Marcos Araújo Goulart

Responsável pelos tópicos:

* Funcionalidades e características já definidas;
* Restrições e condições;
* Pontos de atenção;
* Criação da pesquisa;
* Definição do CRUD e da relação com as personas;
* Elaboração das `justificativas.md`.

### Victor Felipe Santos Melo

Responsável por:

* Liderança do grupo;
* Criação e organização inicial do repositório;
* Criação de benchmark;
* Criação do `docs/requisitos.md` e definição das funcionalidades e priorização;
* Criação e organização do protótipo de alta fidelidade.

### Vitória Maíra Evangelista Ribeiro

Responsável por:

* Criação do `README.md`;
* Problema;
* Público e usuários;
* Contexto de uso;
* Criação de benchmark;
* Definição dos requisitos funcionais;
* Organização dos fluxos e da navegação dos protótipos.

### Thaíssa da Silva Araujo

Responsável por:

* Elaboração do slide;
* Definição da funcionalidade mais importante, relação com o problema/pesquisa e considerações finais;
* Criação e organização do protótipo de baixa fidelidade.

## Contribuições da Unidade II

A evolução do aplicativo é acompanhada nas [issues](https://github.com/OldDeux/QueimadaZero/issues), nos pull requests e no [Project da Unidade II](https://github.com/users/marcos-grocha/projects/4).

- `lauralimab`: tela de dicas respiratórias (#13, PR #43 incorporado à `main`).
- `lauralimab`: primeira etapa visual de Alertas e Meus relatos (#14, PR #44 em revisão; integração real pendente).
- `lauralimab`: atualização da documentação da Unidade II (#31, nesta branch).

Esses registros complementam as responsabilidades das atividades anteriores, apresentadas acima.

## Organização do projeto

A documentação das atividades está sendo organizada dentro do repositório para manter as contribuições do grupo registradas e facilitar o acompanhamento das alterações realizadas durante o desenvolvimento.

Os principais arquivos de documentação são:

* `README.md` — informações gerais do projeto e integrantes;
* `docs/estudo-de-caso.md` — análise do estudo de caso;
* `docs/pesquisa.md` — pesquisa sobre o problema e necessidades dos usuários;
* `docs/benchmark.md` — análise de soluções semelhantes ao QueimadaZero;
* `docs/personas.md` — personas do projeto;
* `docs/requisitos.md` — funcionalidades, requisitos funcionais, requisitos não funcionais, CRUD e priorização;
* `docs/apresentacaoRequisitos.pdf` — apresentação dos principais requisitos e funcionalidades;
* `docs/prototipoBaixaFidelidade.pdf` — protótipo de baixa fidelidade;
* `docs/prototipoAltaFidelidade.pdf` — protótipo de alta fidelidade;
* `docs/justificativas.md` — justificativas das decisões de UI/UX;
* `docs/arquitetura.md` — Clean Architecture do app e como criar uma funcionalidade;
* `docs/navegacao.md` — fluxo de navegação, rotas e tema do app;
* `docs/localizacao.md` — como o app usa o GPS e respeita a escolha de desligar a localização;
* `CHANGELOG.md` — registro das alterações feitas no projeto.

O código do aplicativo fica em `app/`, e o ambiente para rodá-lo está em `Dockerfile` e `docker-compose.yml` (veja [Ambiente de desenvolvimento](#ambiente-de-desenvolvimento)).

## Ambiente de desenvolvimento

O app fica na pasta `app/` e é desenvolvido em Flutter **3.47.9** (Dart 3.13.7). Para todo o grupo usar a mesma versão sem instalar o SDK, o Flutter roda dentro do Docker.

### Pré-requisitos

* [Docker Desktop](https://www.docker.com/products/docker-desktop/) no Windows e no macOS, ou Docker Engine com o plugin Compose no Linux.

### Primeira vez

Na raiz do repositório, gere a imagem (só precisa fazer de novo quando o `Dockerfile` mudar):

```bash
docker compose build
```

### Comandos do dia a dia

Tudo o que vem depois de `flutter` no comando normal vai depois de `docker compose run --rm flutter`:

```bash
docker compose run --rm flutter pub get
docker compose run --rm flutter analyze
docker compose run --rm flutter test
```

Para adicionar um pacote: `docker compose run --rm flutter pub add <pacote>`.

Antes de abrir um PR, formate o código, senão o CI falha:

```bash
docker compose run --rm --entrypoint dart flutter format lib test
```

### CI

Todo PR para a `main` roda o workflow [CI](.github/workflows/ci.yml) no GitHub Actions, que verifica a formatação, roda o `flutter analyze` e o `flutter test`. A versão do Flutter é lida do `Dockerfile`, então o CI usa sempre a mesma do ambiente local. Se o CI falhar, o resultado aparece no próprio PR.

### Observações

* A pasta `app/` é compartilhada com o container: o código é editado normalmente na sua máquina, no editor de sua preferência.
* Os pacotes baixados ficam no volume `pub-cache`, então o `pub get` só baixa o que mudou.
* No Git Bash do Windows, se algum caminho for convertido de forma errada, rode antes `export MSYS_NO_PATHCONV=1`.
* O container não abre o app em emulador Android nem instala um APK no celular. A geração do APK e o build web de distribuição ficam para a issue #35.

### Visualizar o aplicativo no navegador

Com o Docker Desktop em execução, na raiz do repositório:

```bash
docker compose run --rm -p 8080:8080 flutter run -d web-server --web-hostname=0.0.0.0 --web-port=8080
```

Abra `http://127.0.0.1:8080` no navegador do mesmo computador e mantenha o terminal em execução. Esse comando serve o app em modo de desenvolvimento; não gera um pacote de produção.

## Repositório

[OldDeux/QueimadaZero](https://github.com/OldDeux/QueimadaZero)
