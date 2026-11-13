# QueimadaZero

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

### Observações

* A pasta `app/` é compartilhada com o container: o código é editado normalmente na sua máquina, no editor de sua preferência.
* Os pacotes baixados ficam no volume `pub-cache`, então o `pub get` só baixa o que mudou.
* No Git Bash do Windows, se algum caminho for convertido de forma errada, rode antes `export MSYS_NO_PATHCONV=1`.
* O container não abre o app em emulador nem no celular. A geração do APK e a versão web ficam na issue #35.

## Repositório

[OldDeux/QueimadaZero](https://github.com/OldDeux/QueimadaZero)
