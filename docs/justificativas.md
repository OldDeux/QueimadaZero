# Justificativas — QueimadaZero

Aqui explicamos as principais decisões que tomamos nos protótipos da Atividade 04. A ideia é mostrar o motivo de cada escolha, ligando com o que já tínhamos definido no estudo de caso, na pesquisa, nas personas e nos requisitos.

Protótipos:

- Baixa fidelidade: `docs/prototipoBaixaFidelidade.pdf`
- Alta fidelidade: `docs/prototipoAltaFidelidade.pdf`
- Figma: https://www.figma.com/design/1kL4d8dQ6QXWHTPWTpt4ln

---

## 1. Cores

A paleta já tinha sido definida no estudo de caso: **laranja, vermelho e preto**. São cores que passam a ideia de alerta, e isso combina com o assunto do app.

| Cor | Código | Onde usamos |
|---|---|---|
| Laranja | `#F05A28` | Logo, ícones e destaques |
| Laranja escuro | `#C2410C` | Botões principais, como "Estou vendo fumaça" |
| Vermelho | `#D92D20` | Risco crítico, alertas e o botão de excluir |
| Preto | `#141414` | Textos e botões secundários |
| Cinza | `#5C5C5C` | Textos de apoio (horário, fonte, legenda) |
| Verde | `#2F7D59` | Só para "deu certo" e para ar de boa qualidade |

Alguns cuidados que tivemos:

- **Laranja mais escuro nos botões.** O laranja normal com texto branco fica com pouco contraste. Por isso usamos um tom mais escuro nos botões, para o texto ficar fácil de ler.
- **Verde só em casos específicos.** Ele aparece só quando precisa passar a ideia de "tudo certo". Em qualquer outro lugar, fugiria da paleta e poderia confundir com a escala de risco.
- **Mapa de calor em laranja → vermelho.** Quanto mais vermelho, maior a concentração de focos.

No protótipo que o grupo tinha feito antes, a cor principal era um azul petrolado. Voltamos para a paleta do estudo de caso para manter a coerência com o que já estava definido.

## 2. Tipografia

Usamos a fonte **Manrope** em todo o app. Ela é sem serifa, tem letras bem abertas e continua legível em tamanhos pequenos, o que ajuda quem está usando o celular no sol.

| Uso | Tamanho | Peso |
|---|---|---|
| Títulos | 24px | ExtraBold |
| Subtítulos | 18px | Bold |
| Texto normal | 15px | Regular |
| Legendas | 12px | Medium |

A hierarquia é simples: primeiro vem o que importa (o nível de risco, a distância), em letra grande e forte. Depois vêm os detalhes, menores e em cinza. Evitamos textos muito pequenos: o mínimo é 12px, e só algumas etiquetas bem curtas, como "RECOMENDADO", ficaram com 11px.

## 3. Organização das informações

A persona prioritária, a Ana Maria, precisa de três respostas: **tem risco perto de mim, onde ele está e o que eu faço agora**. Organizamos as telas seguindo essa ordem.

- **Mapa (tela inicial):** logo no topo aparece o card "Risco na sua região", com o nível e a distância do foco mais perto. O mapa vem logo abaixo, e as orientações ficam a um toque de distância.
- **Alerta:** a informação principal fica num card vermelho grande (distância, risco e horário). Logo embaixo vem uma dica rápida ("feche portas e janelas") e os botões "Ver no mapa" e "Como me proteger".
- **Distância em km, e não coordenada.** Na pesquisa vimos que "foco a 3,2 km" é muito mais fácil de entender do que uma coordenada.
- **Sempre mostramos a hora da atualização e a fonte** ("INPE + relatos"), para a pessoa saber se a informação é recente.

## 4. Navegação

- **Menu fixo embaixo com 4 abas:** Mapa, Meus relatos, Qualidade do ar e Orientações. São as funções principais. O menu embaixo fica ao alcance do polegar, o que ajuda quem está usando com uma mão só.
- **Botão "Estou vendo fumaça" grande, na tela inicial.** O relato precisa ser feito em poucos passos, então o botão ocupa a largura toda para ser fácil de achar e de tocar.
- **Sino e configurações no topo.** O sino leva aos alertas, e o ícone de ajustes leva às configurações de localização e alertas.
- **Sem tela de login.** No estudo de caso vimos que, se o relato exigir cadastro, a pessoa desiste, e nenhum requisito pede conta de usuário. Os relatos ficam salvos no próprio celular. O lado ruim é que, se a pessoa trocar de aparelho, perde o histórico. Uma conta opcional poderia entrar numa versão futura. Canais oficiais, como o app Guardiões da Amazônia e a Linha Verde do IBAMA, também aceitam denúncia de queimada sem identificação.

O fluxo principal ficou assim:

**Mapa → Estou vendo fumaça → foto, localização e descrição → Relato enviado → Meus relatos → Detalhe do relato**

## 5. Componentes

| Componente | Para que serve |
|---|---|
| Card de risco | Mostra o nível de risco e a distância logo na primeira tela |
| Marcador de foco com etiqueta | Mostra o foco no mapa com o nível escrito embaixo (Moderado, Alto, Crítico) |
| Botões grandes | Fáceis de tocar com pressa ou com uma mão só |
| Painel do foco (abre de baixo para cima) | Mostra o detalhe do foco sem sair do mapa |
| Etiquetas de status | Enviado, Confirmado e Não confirmado, cada um com ícone e texto |
| Chaves liga/desliga | Nas configurações de localização, alertas, som e vibração |
| Faixa "sem internet" | Avisa que os dados são os salvos no celular e de que horas eles são |
| Janela de confirmação | Pergunta antes de excluir um relato, porque não dá para desfazer |

**Sobre os status do relato:** os documentos não diziam quem confirma um relato, e não queríamos inventar uma equipe que analisa cada um. Por isso, o relato fica **Enviado**, vira **Confirmado** quando coincide com um foco do INPE ou com outros relatos perto do mesmo lugar, e fica **Não confirmado** quando não aparece nada parecido.

## 6. Acessibilidade

- **A cor nunca é a única informação.** Os focos têm o nível escrito na etiqueta, a legenda do mapa de calor tem texto (Baixo, Moderado, Alto, Crítico) e os status têm ícone e nome. Isso ajuda quem tem daltonismo.
- **Bom contraste.** Os textos principais são pretos em fundo claro, e o cinza dos textos de apoio é escuro o bastante para ler no sol.
- **Áreas de toque grandes.** Os botões principais são altos e largos, pensando em quem está com pressa ou tem dificuldade motora.
- **Alerta por mais de um canal.** O alerta aparece na tela, toca som e vibra. Assim chega a quem não está olhando o celular ou não ouve o som.
- **Textos curtos e diretos**, pensando em quem está com pressa ou não tem costume com tecnologia.

Para quando o app for desenvolvido, ficam dois pontos: respeitar o tamanho de fonte que a pessoa escolhe no celular e colocar descrição nos ícones para o leitor de tela.

## 7. Contexto de uso

O app vai ser usado em situações bem diferentes. A Ana usa em casa ou no trabalho. O Joaquim, brigadista, usa em campo, no sol, com fumaça e sinal fraco. Por isso:

- **Sol forte:** alto contraste e letras em negrito nas informações principais.
- **Pressa e uma mão só:** botões grandes, menu embaixo e o relato com só a localização obrigatória. A foto é recomendada, e a descrição é opcional.
- **Sinal fraco ou sem internet:** o mapa mostra os dados salvos, com a hora da última atualização. Um relato feito sem internet é enviado quando a conexão volta.
- **App fechado:** a notificação chega mesmo com o celular bloqueado, porque o alerta de proximidade é a funcionalidade mais importante do projeto.
- **Celular simples:** evitamos animações pesadas e mapas 3D.
- **Privacidade:** o app explica para que usa a localização antes de pedir, deixa desligar nas configurações e não mostra o nome de quem enviou o relato.

## 8. Arquitetura do sistema

O app vai ser feito em **Flutter**, com a linguagem **Dart**, e vai usar o **Firebase** como back-end.

Escolhemos o Flutter porque, com um código só, dá para fazer o app para Android, que é a nossa prioridade, e também para iOS, se um dia precisar. O Firebase foi escolhido porque já tem pronto quase tudo que o QueimadaZero precisa (banco de dados, armazenamento de fotos e notificações), funciona bem com o Flutter e tem um plano gratuito. Assim a gente não precisa criar um servidor do zero.

### Visão geral

A arquitetura tem três partes:

1. **O app no celular (Flutter):** as telas e tudo que a pessoa usa.
2. **O Firebase (na nuvem):** guarda os relatos, os focos e as fotos, e manda as notificações.
3. **Os dados do INPE:** a fonte oficial dos focos de queimada.

```
 Celular (app Flutter)  <------>  Firebase  <------  Dados abertos do INPE
  - telas                          - banco de dados (relatos e focos)
  - GPS                            - fotos dos relatos
  - dados salvos no celular        - notificações
```

### Componentes e função de cada um

| Componente | Função no projeto |
|---|---|
| **App em Flutter** | As telas: mapa, relato, meus relatos, qualidade do ar, orientações e configurações |
| **Mapa (flutter_map, com OpenStreetMap)** | Mostra os focos, o mapa de calor e a localização da pessoa. É gratuito e dá para guardar a região no celular, para usar sem internet |
| **GPS do celular (geolocator)** | Calcula a distância até os focos e marca o local do relato, sempre com permissão |
| **Câmera (image_picker)** | Tira ou escolhe a foto do relato |
| **Firebase Authentication (modo anônimo)** | Cria uma identificação para o celular sem a pessoa precisar fazer cadastro. É assim que o "Meus relatos" sabe quais relatos são dela, mesmo sem login |
| **Cloud Firestore (banco de dados)** | Guarda os relatos e os focos. Ele também guarda uma cópia no celular: se a pessoa estiver sem internet, o relato fica salvo e é enviado sozinho quando a conexão volta |
| **Firebase Storage** | Guarda as fotos dos relatos |
| **Cloud Functions** | Rodam no Firebase de tempos em tempos para: buscar os focos novos do INPE, confirmar os relatos que coincidem com esses focos ou com outros relatos perto, e decidir quem deve receber alerta |
| **Firebase Cloud Messaging** | Manda a notificação de alerta, mesmo com o app fechado |

### Como funciona na prática

1. Uma Cloud Function busca os focos novos do INPE e salva no banco de dados.
2. Quando alguém envia um relato, ele vai para o banco, e a foto vai para o Storage.
3. A Cloud Function compara o relato com os focos do INPE e com outros relatos perto. Se coincidir, o relato vira **Confirmado**.
4. Se aparecer um foco perto de quem está com a localização ligada, o Firebase manda a notificação.
5. Sem internet, o app mostra o que já estava salvo no celular e envia os relatos pendentes quando a conexão volta.

### Organização do código

Para o código não virar uma bagunça, vamos separar o app em três partes:

- **Telas:** o que aparece para a pessoa (mapa, relato, alertas...).
- **Serviços:** o que conversa com fora do app (Firebase, GPS, câmera, notificações).
- **Modelos:** como os dados são organizados, por exemplo um `Relato` (foto, local, descrição, status e data) e um `Foco` (local, nível de risco, fonte e horário).

A fonte dos dados de qualidade do ar ainda vamos pesquisar. Precisamos de uma que use o índice brasileiro (IQAr), que é o que aparece no protótipo.

## 9. Do baixa para o alta fidelidade

Algumas coisas mudaram entre as duas versões depois que conferimos o protótipo com os requisitos:

- **O relato era em 3 telas** (foto, local e envio, como estava no estudo de caso) **e virou uma tela só**, com os 3 passos numerados. Ficou mais rápido e a pessoa vê tudo antes de enviar.
- **Entraram telas que faltavam:** permissão de localização, notificação com o celular bloqueado, mapa sem internet, configurações e confirmação antes de excluir um relato.
- **Os focos ganharam etiqueta com o nível escrito**, para não depender só da cor.
