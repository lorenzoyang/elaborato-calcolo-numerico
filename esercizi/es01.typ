#import "../conf.typ": esercizio

#esercizio(
  "1",
  [Combinare linearmente $y(t + h), y(t), h y'(t), h y'(t - h), h y'(t - 2h)$, con coefficienti non nulli e indipendenti da $h$, in modo da ottenere un residuo che sia $O(h^4)$. Dettagliare il procedimento.],
)[
  Dobbiamo combinare linearmente i termini assegnati in modo che i termini di ordine inferiore dello sviluppo di Taylor si annullino, lasciando un residuo (errore di troncamento) di ordine $O(h^4)$.

  === Sviluppo di Taylor dei termini
  Espandiamo le funzioni e le loro derivate arrestandoci al terzo ordine (poiché moltiplicando per $h$ arriveremo al termine $h^3$, e il resto sarà inglobato in $O(h^4)$):

  - $y(t + h) = y(t) + h y'(t) + h^2/2 y''(t) + h^3/6 y'''(t) + O(h^4)$
  - $y(t) = y(t)$
  - $h y'(t) = h y'(t)$
  - $h y'(t - h) = h (y'(t) - h y''(t) + h^2/2 y'''(t) + O(h^3)) = h y'(t) - h^2 y''(t) + h^3/2 y'''(t) + O(h^4)$
  - $h y'(t - 2h) = h (y'(t) - 2h y''(t) + (2h)^2/2 y'''(t) + O(h^3)) = h y'(t) - 2h^2 y''(t) + 2h^3 y'''(t) + O(h^4)$

  === Definizione della combinazione lineare
  Vogliamo determinare i coefficienti $a, b, c, d, e$ tali per cui:
  $ a y(t+h) + b y(t) + c h y'(t) + d h y'(t-h) + e h y'(t-2h) = O(h^4) $

  Sostituendo gli sviluppi appena ottenuti e raccogliendo a fattor comune rispetto alle derivate di $y(t)$, imponiamo che i coefficienti dei termini di ordine inferiore a $h^4$ siano nulli:
  - Termini in $y(t)$: $a + b = 0$
  - Termini in $h y'(t)$: $a + c + d + e = 0$
  - Termini in $h^2 y''(t)$: $a/2 - d - 2e = 0$
  - Termini in $h^3 y'''(t)$: $a/6 + d/2 + 2e = 0$

  === Risoluzione del sistema
  Abbiamo un sistema lineare omogeneo di 4 equazioni in 5 incognite. Possiamo fissare un parametro libero. Per evitare frazioni e ottenere coefficienti interi, poniamo $a = 12$ (il minimo comune multiplo tra 2 e 6):

  Dalla prima equazione:
  $ 12 + b = 0 => b = -12 $

  Sostituendo $a = 12$ nella terza e quarta equazione, otteniamo un sottosistema in $d$ ed $e$:
  $ 12/2 - d - 2e = 0 => d + 2e = 6 $
  $ 12/6 + d/2 + 2e = 0 => d/2 + 2e = -2 $

  Sottraendo la seconda equazione dalla prima:
  $ (d + 2e) - (d/2 + 2e) = 6 - (-2) => d/2 = 8 => d = 16 $

  Sostituendo $d = 16$ in $d + 2e = 6$:
  $ 16 + 2e = 6 => 2e = -10 => e = -5 $

  Infine, sostituiamo $a, d, e$ nella seconda equazione per trovare $c$:
  $ 12 + c + 16 - 5 = 0 => c + 23 = 0 => c = -23 $

  === Risultato finale
  I coefficienti richiesti sono $a = 12$, $b = -12$, $c = -23$, $d = 16$, $e = -5$.
  La combinazione lineare finale è:
  $ 12 y(t + h) - 12 y(t) - 23 h y'(t) + 16 h y'(t - h) - 5 h y'(t - 2h) = O(h^4) $
]
