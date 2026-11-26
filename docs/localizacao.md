# Localização

O app usa o GPS para os alertas de proximidade e para marcar o local do relato. O código fica em `app/lib/features/localizacao/`.

## Regras

* **Começa desligada.** Até a pessoa ligar, o app não aciona o GPS.
* **Explica antes de pedir.** Ao ligar a chave nas configurações, o app mostra para que usa a localização. Só depois o celular pede a permissão. A decisão está em [`justificativas.md`](justificativas.md) (seção "Privacidade").
* **Desliga na hora.** Ao desligar a chave, o GPS para e a escolha fica salva no celular.
* **Vale com o app fechado.** Os alertas em segundo plano também respeitam a escolha.

Quando a permissão é negada, a tela diz o que fazer:

| Resposta do celular | O que a tela mostra |
|---|---|
| Negada | Que a localização continua desligada e o botão "Tentar de novo" |
| Negada de vez | Como liberar nos ajustes do celular, com o botão "Abrir ajustes do celular" |
| GPS desligado | Que é preciso ligar o GPS, com o botão que abre os ajustes do GPS |

Na versão web, o botão de ajustes não aparece, porque o navegador não deixa o site abrir os ajustes.

## Como usar em outra funcionalidade

* **Na tela:** observe o `posicaoProvider`. Ele traz a posição atual, ou `null` com a localização desligada.
* **Fora da tela (alertas em segundo plano, #21 e #22):** chame o `VerificarRastreamento` antes de usar a posição. Se ele devolver `false`, não use o GPS.
* **Para pedir a permissão:** abra a rota `Rotas.permissaoLocalizacao` com `context.push<bool>(...)`. Ela fecha com `true` se a localização foi ligada.

Nunca chame o `geolocator` direto de uma tela. Assim a escolha da pessoa é sempre respeitada.

## Android

As permissões `ACCESS_FINE_LOCATION` e `ACCESS_COARSE_LOCATION` vão no `AndroidManifest.xml` quando a pasta `android/` for criada na `main` (issue #35).
