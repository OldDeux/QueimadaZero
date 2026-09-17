# Requisitos e Funcionalidades — QueimadaZero

## 1. Introdução

O QueimadaZero é uma aplicação voltada ao monitoramento de queimadas, emissão de alertas e apoio à prevenção dos impactos causados pelo fogo e pela fumaça.

A proposta do aplicativo é transformar informações sobre queimadas em informações simples e úteis para a população, permitindo identificar focos próximos, receber alertas de risco e comunicar situações de fumaça observadas pelo próprio usuário.

A definição das funcionalidades e requisitos foi baseada no estudo de caso, na pesquisa realizada, no benchmark e nas personas desenvolvidas nas atividades anteriores.

A persona prioritária é Ana Maria, que representa uma usuária que precisa receber informações rápidas sobre queimadas próximas, compreender o risco da fumaça e saber quais medidas de proteção pode tomar. Joaquim Ferreira representa o uso do aplicativo por um brigadista voluntário, principalmente em situações de campo e em regiões com conexão instável.

## 2. Funcionalidades

### F01 — Mapa de focos de queimada
**Descrição:** O aplicativo deverá apresentar um mapa com os focos de queimadas identificados, permitindo que o usuário visualize a localização aproximada das ocorrências.
**Necessidade do usuário atendida:** Permitir que moradores, brigadistas, bombeiros e agentes ambientais identifiquem rapidamente onde existem focos de queimadas.
**Justificativa:** O mapa é uma das principais formas de transformar dados técnicos de localização em uma informação visual e fácil de compreender.
**Prioridade:** Essencial.

### F02 — Mapa de calor e indicação visual de risco
**Descrição:** O aplicativo deverá apresentar uma representação visual das regiões de maior atenção utilizando um mapa de calor, com gradiente entre laranja e vermelho.
**Necessidade do usuário atendida:** Permitir que o usuário compreenda rapidamente quais regiões apresentam maior concentração ou atenção relacionada às queimadas.
**Justificativa:** Facilita a compreensão da situação em ambientes externos, sob sol forte, sem depender de textos ou números.
**Prioridade:** Essencial.

### F03 — Notificação de fumaça pelo usuário
**Descrição:** O aplicativo deverá permitir que o usuário informe uma situação de fumaça ou possível queimada observada em sua região.
**Necessidade do usuário atendida:** Permitir que moradores e brigadistas contribuam com informações sobre ocorrências ainda não identificadas.
**Justificativa:** É um dos principais diferenciais do QueimadaZero em relação a plataformas que apenas apresentam dados públicos.
**Prioridade:** Essencial.

### F04 — Acompanhamento do relato enviado
**Descrição:** O aplicativo deverá permitir que o usuário acompanhe o registro de uma notificação de fumaça enviada anteriormente.
**Necessidade do usuário atendida:** Permitir que o usuário saiba se sua informação foi registrada e considerada pelo sistema.
**Justificativa:** Dar retorno ao usuário aumenta a confiança no sistema e incentiva novas contribuições.
**Prioridade:** Importante.

### F05 — Alertas de proximidade
**Descrição:** O aplicativo deverá enviar alertas quando uma ocorrência de queimada estiver próxima da localização do usuário.
**Necessidade do usuário atendida:** Avisar o usuário sobre uma situação de risco mesmo quando ele não estiver com o aplicativo aberto.
**Justificativa:** Permite que o usuário seja informado antes ou durante a chegada da fumaça à sua região, dando tempo para medidas preventivas.
**Prioridade:** Essencial.

### F06 — Informações sobre qualidade do ar
**Descrição:** O aplicativo deverá apresentar informações relacionadas à qualidade do ar e à possível exposição à fumaça.
**Necessidade do usuário atendida:** Permitir que o usuário compreenda melhor o impacto da fumaça, não apenas a localização do foco.
**Justificativa:** A fumaça pode afetar pessoas mesmo distantes do foco, especialmente as mais vulneráveis.
**Prioridade:** Importante.

### F07 — Dicas e orientações de proteção
**Descrição:** O aplicativo deverá disponibilizar orientações sobre medidas que podem ser tomadas durante situações de fumaça ou risco de queimada.
**Necessidade do usuário atendida:** Orientar o usuário sobre como reduzir sua exposição à fumaça.
**Justificativa:** O alerta sozinho informa o risco, mas não explica o que fazer; as orientações transformam a informação em ação preventiva.
**Prioridade:** Importante.

### F08 — Modo offline do mapa
**Descrição:** O aplicativo deverá permitir a consulta de informações previamente armazenadas no mapa mesmo sem conexão com a internet.
**Necessidade do usuário atendida:** Permitir que usuários em áreas rurais ou com internet instável continuem consultando informações disponíveis.
**Justificativa:** O estudo de caso estabelece que o aplicativo deve funcionar em situações de conectividade limitada.
**Prioridade:** Importante.

### F09 — Utilização de dados públicos de queimadas
**Descrição:** O aplicativo deverá utilizar dados públicos de focos de queimadas para alimentar as informações apresentadas no mapa.
**Necessidade do usuário atendida:** Garantir que o aplicativo tenha informações mesmo em regiões com poucos usuários relatando.
**Justificativa:** O uso de dados públicos (ex: INPE) evita dependência exclusiva das notificações da comunidade.
**Prioridade:** Essencial.

## 6. Priorização das funcionalidades

### Essenciais
- F01 — Mapa de focos de queimada
- F02 — Mapa de calor e indicação visual de risco
- F03 — Notificação de fumaça pelo usuário
- F05 — Alertas de proximidade
- F09 — Utilização de dados públicos de queimadas

Indispensáveis porque representam a proposta principal: mostrar onde existem queimadas, alertar quem pode ser afetado e permitir que a população contribua com informações.

### Importantes
- F04 — Acompanhamento do relato enviado
- F06 — Informações sobre qualidade do ar
- F07 — Dicas e orientações de proteção
- F08 — Modo offline do mapa

Agregam valor, mas podem vir após o núcleo principal.

### Secundárias
No escopo atual, não foram definidas funcionalidades secundárias específicas. Novas funcionalidades poderão ser identificadas nas próximas etapas.
