#import "../conf.typ": esercizio

#esercizio(
  "2",
  [Scrivere una function Matlab che, sapendo solamente che l'aritmetica finita implementata utilizza la base binaria con arrotondamento, calcoli: la precisione di macchina; il più grande numero di macchina; il più piccolo numero di macchina normalizzato; il più piccolo numero di macchina denormalizzato. Argomentare la sua stesura, che deve prevedere solo l'utilizzo di operazioni algebriche elementari (validare i risultati con le function `realmax` e `realmin` di Matlab).],
)[
  === Argomentazione Teorica

  - *Precisione di macchina ($u$)*: È il più piccolo numero positivo tale per cui il calcolatore percepisce $1 + u > 1$. Partendo da $u = 1.0$, lo si divide iterativamente per $2.0$ finché la somma arrotondata non coincide con $1.0$. L'ultimo valore valido riscontrato è la precisione cercata.
  - *Più grande numero di macchina*: La massima mantissa rappresentabile in base $2$ è pari a $2.0 - u$. Moltiplicando iterativamente per $2.0$ questo valore di base, si arriverà inevitabilmente all'overflow (infinito in macchina). Per testare l'avvenuto overflow senza usare funzioni predefinite come `isinf`, si sfrutta la proprietà algebrica per cui il reciproco dell'infinito informatico è esattamente zero: $1.0 / (x dot 2.0) == 0.0$.
  - *Più piccolo numero normalizzato*: Si ottiene partendo da $1.0$ e dividendo iterativamente per $2.0$. Entrando nella zona dei numeri denormalizzati, i bit significativi cominciano a scivolare fuori dalla mantissa. Un numero $x$ è da considerarsi ancora normalizzato se la moltiplicazione per $(1.0 + u)$ produce un risultato strettamente maggiore di $x$ (ovvero, non si è ancora perso l'ultimo bit di precisione disponibile).
  - *Più piccolo numero denormalizzato*: Partendo dal più piccolo numero normalizzato appena trovato, si continua a dividere iterativamente per $2.0$ finché il numero non diventa matematicamente $0.0$ a causa della perdita totale dei bit (Underflow). L'ultimo valore strettamente positivo registrato è il nostro minimo denormalizzato.

  === Codice Matlab: La Function
  ```matlab
  function [u_mac, max_mac, min_norm, min_denorm] = calcola_costanti_macchina()
  % Function [u_mac, max_mac, min_norm, min_denorm] = calcola_costanti_macchina()
  %
  % Calcola le costanti fondamentali della macchina assumendo che l'aritmetica
  % finita implementata utilizzi la base binaria con arrotondamento.
  % Il calcolo utilizza esclusivamente operazioni algebriche elementari.
  % La function provvede inoltre a stampare a video la validazione dei
  % risultati confrontandoli con le costanti native di Matlab.
  %
  % Input:
  %   Nessuno
  %
  % Output:
  %   u_mac      - precisione di macchina
  %   max_mac    - piu' grande numero di macchina
  %   min_norm   - piu' piccolo numero di macchina normalizzato
  %   min_denorm - piu' piccolo numero di macchina denormalizzato
  %
  % Rel. 05-03-2026.

  % 1. calcolo della precisione di macchina
  u_mac = 1.0;
  while (1.0 + u_mac / 2.0) > 1.0
      u_mac = u_mac / 2.0;
  end

  % 2. calcolo del piu' grande numero di macchina
  max_mac = 2.0 - u_mac;
  while (1.0 / (max_mac * 2.0)) > 0.0
      max_mac = max_mac * 2.0;
  end

  % 3. calcolo del piu' piccolo numero di macchina normalizzato
  min_norm = 1.0;
  while ((min_norm / 2.0) * (1.0 + u_mac)) > (min_norm / 2.0)
      min_norm = min_norm / 2.0;
  end

  % 4. Calcolo del piu' piccolo numero di macchina denormalizzato
  min_denorm = min_norm;
  while (min_denorm / 2.0) > 0.0
      min_denorm = min_denorm / 2.0;
  end

  % stampa e validazione dei risultati
  fprintf('VALIDAZIONE COSTANTI DI MACCHINA\n');
  fprintf('Precisione(u): calcolato=%e | Matlab(eps)=%e\n', u_mac, eps);
  fprintf('Realmax: calcolato=%e | Matlab(realmax)=%e\n', max_mac, realmax);
  fprintf('Realmin Norm: calcolato=%e | Matlab(realmin)=%e\n', min_norm, realmin);
  % il valore esatto corrisponde a realmin * eps
  fprintf('Min Denorm: calcolato=%e | Atteso=%e\n', min_denorm, realmin * eps);

  end

  ```
]
