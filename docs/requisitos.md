# Requisitos e Funcionalidades — QueimadaZero

## 1. Introdução

O QueimadaZero é uma aplicação voltada ao monitoramento de queimadas, emissão de alertas e apoio à prevenção dos impactos causados pelo fogo e pela fumaça.

A proposta do aplicativo é transformar informações sobre queimadas em informações simples e úteis para a população, permitindo identificar focos próximos, receber alertas de risco e comunicar situações de fumaça observadas pelo próprio usuário.

A definição das funcionalidades e requisitos foi baseada no estudo de caso, na pesquisa realizada, no benchmark e nas personas desenvolvidas nas atividades anteriores.

A persona prioritária é Ana Maria, que representa uma usuária que precisa receber informações rápidas sobre queimadas próximas, compreender o risco da fumaça e saber quais medidas de proteção pode tomar. Joaquim Ferreira representa o uso do aplicativo por um brigadista voluntário, principalmente em situações de campo e em regiões com conexão instável.

---

## 2. Funcionalidades

### F01 — Mapa de focos de queimada

**Descrição:**  
O aplicativo deverá permitir que o usuário acesse um mapa contendo os focos de queimadas identificados e visualize a localização aproximada das ocorrências.

**Necessidade do usuário atendida:**  
Permitir que moradores, brigadistas, bombeiros e agentes ambientais identifiquem rapidamente onde existem focos de queimadas.

**Justificativa:**  
O mapa transforma dados de localização em uma informação visual e facilita a identificação das ocorrências.

**Prioridade:** Essencial.

---

### F02 — Mapa de calor e indicação visual de risco

**Descrição:**  
O aplicativo deverá apresentar uma representação visual das regiões de maior concentração ou atenção relacionada às queimadas por meio de um mapa de calor.

**Necessidade do usuário atendida:**  
Permitir que o usuário compreenda rapidamente quais regiões apresentam maior concentração ou atenção relacionada às queimadas.

**Justificativa:**  
A representação visual facilita a interpretação das informações apresentadas pelo aplicativo.

**Prioridade:** Essencial.

---

### F03 — Registro de ocorrência de fumaça

**Descrição:**  
O aplicativo deverá permitir que o usuário registre uma situação de fumaça ou possível queimada observada em sua região.

**Necessidade do usuário atendida:**  
Permitir que moradores e brigadistas contribuam com informações sobre ocorrências observadas.

**Justificativa:**  
O registro realizado pelos usuários complementa os dados públicos e permite a comunicação de situações observadas diretamente pela população.

**Prioridade:** Essencial.

---

### F04 — Consulta de relatos realizados

**Descrição:**  
O aplicativo deverá permitir que o usuário consulte os registros de ocorrências de fumaça realizados anteriormente por ele.

**Necessidade do usuário atendida:**  
Permitir que o usuário acompanhe os relatos realizados.

**Justificativa:**  
A consulta dos registros permite que o usuário tenha acesso ao histórico de suas contribuições no aplicativo.

**Prioridade:** Importante.

---

### F05 — Alertas de proximidade

**Descrição:**  
O aplicativo deverá enviar alertas quando uma ocorrência de queimada estiver próxima da localização do usuário, considerando as permissões e configurações disponíveis.

**Necessidade do usuário atendida:**  
Avisar o usuário sobre uma situação de risco próxima sem que ele precise procurar manualmente essa informação no aplicativo.

**Justificativa:**  
O alerta permite que o usuário tenha acesso rápido a informações sobre possíveis situações de risco em sua região.

**Prioridade:** Essencial.

---

### F06 — Informações sobre qualidade do ar

**Descrição:**  
O aplicativo deverá apresentar informações relacionadas à qualidade do ar e à exposição à fumaça.

**Necessidade do usuário atendida:**  
Permitir que o usuário compreenda melhor as condições do ar durante situações relacionadas às queimadas.

**Justificativa:**  
As informações sobre qualidade do ar complementam os dados sobre a localização das queimadas e ajudam o usuário a compreender os possíveis impactos da fumaça.

**Prioridade:** Importante.

---

### F07 — Dicas e orientações de proteção

**Descrição:**  
O aplicativo deverá disponibilizar orientações sobre medidas de proteção que podem ser adotadas durante situações de fumaça ou risco de queimada.

**Necessidade do usuário atendida:**  
Orientar o usuário sobre cuidados que podem ser adotados diante de situações de fumaça ou queimadas.

**Justificativa:**  
Além de informar sobre a existência de uma ocorrência, o aplicativo deve disponibilizar orientações que ajudem o usuário a agir diante da situação.

**Prioridade:** Importante.

---

### F08 — Consulta de informações previamente armazenadas

**Descrição:**  
O aplicativo deverá permitir a consulta de informações previamente armazenadas no dispositivo quando não houver conexão com a internet.

**Necessidade do usuário atendida:**  
Permitir que usuários em áreas rurais ou com conexão instável continuem consultando informações que já tenham sido carregadas anteriormente.

**Justificativa:**  
O estudo de caso considera situações de conectividade limitada. A consulta de informações previamente armazenadas permite que parte do conteúdo continue acessível mesmo durante uma indisponibilidade temporária da conexão.

**Prioridade:** Importante.

---

### F09 — Utilização de dados públicos de queimadas

**Descrição:**  
O aplicativo deverá utilizar dados públicos de focos de queimadas para complementar as informações apresentadas no mapa.

**Necessidade do usuário atendida:**  
Permitir o acesso a informações sobre ocorrências mesmo em regiões com poucos relatos realizados pelos usuários.

**Justificativa:**  
A utilização de dados públicos complementa os relatos da comunidade e amplia a quantidade de informações disponíveis no aplicativo.

**Prioridade:** Essencial.

---

## 3. Requisitos Funcionais

Os requisitos funcionais representam as ações e comportamentos que o sistema deverá oferecer ao usuário ou executar para disponibilizar as funcionalidades definidas para o QueimadaZero.

### RF01 — Acessar o mapa

O sistema deve permitir que o usuário acesse a tela do mapa de queimadas.

### RF02 — Visualizar focos de queimadas

O sistema deve apresentar os focos de queimadas disponíveis no mapa, indicando sua localização aproximada.

### RF03 — Consultar informações de um foco

O sistema deve permitir que o usuário selecione um foco apresentado no mapa e consulte as informações disponíveis sobre a ocorrência.

### RF04 — Visualizar mapa de calor

O sistema deve permitir que o usuário visualize o mapa de calor com a indicação visual das regiões de maior concentração ou atenção relacionada às queimadas.

### RF05 — Visualizar localização do usuário

O sistema deve permitir que o usuário visualize sua localização no mapa, mediante autorização para utilização da localização do dispositivo.

### RF06 — Registrar ocorrência de fumaça

O sistema deve permitir que o usuário registre uma ocorrência de fumaça ou possível queimada.

### RF07 — Informar localização da ocorrência

O sistema deve permitir que o usuário informe a localização da ocorrência ou utilize a localização do dispositivo para associá-la ao registro, mediante autorização.

### RF08 — Adicionar imagem à ocorrência

O sistema deve permitir que o usuário adicione uma imagem ao registro da ocorrência, quando disponível.

### RF09 — Consultar relatos realizados

O sistema deve permitir que o usuário consulte os registros de ocorrências realizados anteriormente por ele.

### RF10 — Receber alerta de proximidade

O sistema deve enviar uma notificação ao usuário quando uma ocorrência relevante estiver próxima de sua localização, considerando as permissões e configurações disponíveis.

### RF11 — Consultar informações sobre qualidade do ar

O sistema deve permitir que o usuário consulte informações disponíveis relacionadas à qualidade do ar e à exposição à fumaça.

### RF12 — Consultar orientações de proteção

O sistema deve permitir que o usuário acesse orientações de proteção relacionadas a situações de fumaça e queimadas.

### RF13 — Utilizar dados públicos

O sistema deve utilizar dados públicos de focos de queimadas para complementar as informações apresentadas pelo aplicativo.

### RF14 — Consultar informações armazenadas

O sistema deve permitir que o usuário consulte informações previamente armazenadas no dispositivo quando não houver conexão disponível.

### RF15 — Atualizar informações

O sistema deve atualizar as informações de focos e ocorrências quando houver conexão disponível.

---

## 4. Requisitos Não Funcionais

### RNF01 — Usabilidade

O aplicativo deve permitir que as principais funcionalidades, especialmente a consulta do mapa e o registro de uma ocorrência, sejam acessadas em poucos passos.

### RNF02 — Acessibilidade

O aplicativo deve utilizar textos legíveis, áreas de toque adequadas e elementos compatíveis com os recursos de acessibilidade disponíveis no sistema operacional.

### RNF03 — Contraste visual

A interface deve apresentar contraste suficiente para facilitar a leitura das informações apresentadas pelo aplicativo, inclusive em ambientes externos.

### RNF04 — Segurança e privacidade (LGPD)

O aplicativo deve solicitar autorização para utilização da localização e utilizar essa informação somente para as finalidades necessárias ao funcionamento das funcionalidades relacionadas à localização, respeitando os princípios da Lei Geral de Proteção de Dados (LGPD).

### RNF05 — Desempenho

O aplicativo deve apresentar as principais informações em tempo adequado e evitar recursos excessivamente pesados que possam prejudicar seu funcionamento em smartphones com menor capacidade de processamento.

### RNF06 — Compatibilidade

O aplicativo deve ser desenvolvido prioritariamente para smartphones Android e considerar dispositivos com diferentes capacidades de processamento.

### RNF07 — Conectividade

O aplicativo deve considerar situações de conexão instável ou inexistente, especialmente em regiões onde o acesso à internet possa ser limitado.

### RNF08 — Funcionamento offline

O aplicativo deve permitir a consulta de informações previamente armazenadas quando não houver conexão disponível.

### RNF09 — Sincronização

Quando a conexão estiver disponível novamente, o aplicativo deve atualizar as informações armazenadas localmente.

### RNF10 — Legibilidade

O aplicativo deve apresentar textos e informações de forma legível, inclusive quando o usuário utilizar tamanhos de fonte maiores disponibilizados pelo sistema operacional.

---

## 6. Priorização das Funcionalidades

### Essenciais

- **F01 — Mapa de focos de queimada**
- **F02 — Mapa de calor e indicação visual de risco**
- **F03 — Registro de ocorrência de fumaça**
- **F05 — Alertas de proximidade**
- **F09 — Utilização de dados públicos de queimadas**

Essas funcionalidades estão diretamente relacionadas à proposta principal do QueimadaZero: apresentar informações sobre queimadas, identificar situações de risco, alertar usuários e permitir a contribuição da população.

### Importantes

- **F04 — Consulta de relatos realizados**
- **F06 — Informações sobre qualidade do ar**
- **F07 — Dicas e orientações de proteção**
- **F08 — Consulta de informações previamente armazenadas**

Essas funcionalidades complementam as funções principais e aumentam a utilidade do aplicativo para os usuários.

### Secundárias

No escopo atual, não foram definidas funcionalidades secundárias específicas. Novas funcionalidades poderão ser identificadas nas próximas etapas do projeto.

---

## 8. Funcionalidade Mais Importante

A funcionalidade considerada mais importante é a **F05 — Alertas de proximidade**.

O principal motivo é que o alerta permite que o usuário seja informado sobre uma ocorrência de risco próxima sem precisar procurar manualmente essa informação no aplicativo.

Dessa forma, o QueimadaZero não apenas apresenta informações sobre queimadas, mas também pode comunicar uma situação relevante ao usuário de forma mais direta, permitindo que ele tenha conhecimento do risco e possa tomar medidas preventivas.

---

## 9. Relação com o Problema e a Pesquisa

As funcionalidades e requisitos definidos estão relacionados ao problema identificado no estudo de caso: a dificuldade de obter rapidamente informações sobre focos de queimadas, fumaça e possíveis riscos para a população.

A pesquisa realizada anteriormente mostrou a necessidade de transformar informações sobre queimadas em conteúdos mais compreensíveis para os usuários, além de disponibilizar informações atualizadas e orientações relacionadas à proteção.

O benchmark demonstrou a utilização de mapas e informações sobre ocorrências em soluções relacionadas ao monitoramento de queimadas. O QueimadaZero busca combinar dados públicos com relatos realizados pelos próprios usuários e informações relacionadas à proteção contra a fumaça.

Dessa forma, as funcionalidades propostas procuram atender às necessidades identificadas nas pesquisas e nas personas, mantendo o foco em identificar ocorrências, informar sobre riscos, permitir a participação dos usuários e fornecer orientações.

---

## 10. Considerações Finais

A definição das funcionalidades e requisitos estabelece uma base para o desenvolvimento do QueimadaZero.

O conjunto priorizado concentra-se principalmente em quatro necessidades: visualizar onde existem queimadas, identificar situações de maior atenção, receber informações sobre riscos próximos e permitir que a população registre ocorrências observadas.

Os requisitos funcionais descrevem as ações que o sistema deverá disponibilizar para atender a essas necessidades, enquanto os requisitos não funcionais definem características relacionadas à usabilidade, acessibilidade, segurança, desempenho, compatibilidade e conectividade.

A partir desses requisitos, as próximas etapas do projeto poderão utilizar as funcionalidades essenciais como base para o desenvolvimento das telas, fluxos de navegação e implementação técnica do aplicativo.
