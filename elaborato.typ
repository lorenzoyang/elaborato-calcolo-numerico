#import "conf.typ": conf, esercizio

#set document(title: [Elaborato Calcolo Numerico 2025-2026])

#show: conf.with(
  autore: "Lorenzo Yang",
  matricola: "7136074",
  email: "lorenzo.yang@edu.unifi.it",
  anno_acc: "2025-2026",
  data: "Giugno 2026",
  logo: "img/unifi-logo.png",
)

#esercizio(
  "1",
  [Combinare linearmente $y(t + h), y(t), h y'(t), h y'(t - h), h y'(t - 2h)$, con coefficienti non nulli e indipendenti da $h$, in modo da ottenere un residuo che sia $O(h^4)$. Dettagliare il procedimento.],
)[
  Per risolvere l'esercizio, dobbiamo combinare linearmente i termini assegnati in modo che i termini di ordine inferiore dello sviluppo di Taylor si annullino, lasciando un residuo (errore di troncamento) di ordine $O(h^4)$. Il procedimento si basa sull'espansione in serie di ogni termine centrato nel punto $t$.

  *Sviluppo di Taylor dei termini* \
  Espandiamo le funzioni e le loro derivate arrestandoci al terzo ordine (poiché moltiplicando per $h$ arriveremo al termine $h^3$, e il resto sarà inglobato in $O(h^4)$):

  - $y(t + h) = y(t) + h y'(t) + h^2/2 y''(t) + h^3/6 y'''(t) + O(h^4)$
  - $y(t) = y(t)$
  - $h y'(t) = h y'(t)$
  - $h y'(t - h) = h (y'(t) - h y''(t) + h^2/2 y'''(t) + O(h^3)) = h y'(t) - h^2 y''(t) + h^3/2 y'''(t) + O(h^4)$
  - $h y'(t - 2h) = h (y'(t) - 2h y''(t) + (2h)^2/2 y'''(t) + O(h^3)) = h y'(t) - 2h^2 y''(t) + 2h^3 y'''(t) + O(h^4)$

  *Definizione della combinazione lineare* \
  Vogliamo determinare i coefficienti $a, b, c, d, e$ tali per cui:
  $ a y(t+h) + b y(t) + c h y'(t) + d h y'(t-h) + e h y'(t-2h) = O(h^4) $

  Sostituendo gli sviluppi appena ottenuti e raccogliendo a fattor comune rispetto alle derivate di $y(t)$, imponiamo che i coefficienti dei termini di ordine inferiore a $h^4$ siano nulli:
  - Termini in $y(t)$: $a + b = 0$
  - Termini in $h y'(t)$: $a + c + d + e = 0$
  - Termini in $h^2 y''(t)$: $a/2 - d - 2e = 0$
  - Termini in $h^3 y'''(t)$: $a/6 + d/2 + 2e = 0$

  *Risoluzione del sistema* \
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

  *Risultato finale* \
  I coefficienti richiesti sono $a = 12$, $b = -12$, $c = -23$, $d = 16$, $e = -5$.
  La combinazione lineare finale è:
  $ 12 y(t + h) - 12 y(t) - 23 h y'(t) + 16 h y'(t - h) - 5 h y'(t - 2h) = O(h^4) $
]

#esercizio(
  "2",
  [Scrivere una function Matlab che, sapendo solamente che l'aritmetica finita implementata utilizza la base binaria con arrotondamento, calcoli: la precisione di macchina; il più grande numero di macchina; il più piccolo numero di macchina normalizzato; il più piccolo numero di macchina denormalizzato. Argomentare la sua stesura, che deve prevedere solo l'utilizzo di operazioni algebriche elementari (validare i risultati con le function `realmax` e `realmin` di Matlab).],
)[
]

#esercizio(
  "3",
  [Scrivere una function Matlab che implementi il metodo di Newton per gli zeri di una funzione. Prevedere valori di default per la tolleranza di arresto e per il numero massimo di iterazioni.],
)[
]

#esercizio(
  "4",
  [Scrivere una function Matlab che implementi il metodo di bisezione. Prevedere valori di default per la tolleranza di arresto.],
)[
]

#esercizio(
  "5",
  [Inserire qui il testo ufficiale della consegna dal PDF (Esercizio 5).],
)[
]

#esercizio(
  "6",
  [Inserire qui il testo ufficiale della consegna dal PDF (Esercizio 6).],
)[
]

#esercizio(
  "7",
  [Inserire qui il testo ufficiale della consegna dal PDF (Esercizio 7).],
)[
]

#esercizio(
  "8",
  [Inserire qui il testo ufficiale della consegna dal PDF (Esercizio 8).],
)[
]

#esercizio(
  "9",
  [Inserire qui il testo ufficiale della consegna dal PDF (Esercizio 9).],
)[
]

#esercizio(
  "10",
  [Inserire qui il testo ufficiale della consegna dal PDF (Esercizio 10).],
)[
]

#esercizio(
  "11",
  [Inserire qui il testo ufficiale della consegna dal PDF (Esercizio 11).],
)[
]

#esercizio(
  "12",
  [Inserire qui il testo ufficiale della consegna dal PDF (Esercizio 12).],
)[
]

#esercizio(
  "13",
  [Inserire qui il testo ufficiale della consegna dal PDF (Esercizio 13).],
)[
]

#esercizio(
  "14",
  [Inserire qui il testo ufficiale della consegna dal PDF (Esercizio 14).],
)[
]

#esercizio(
  "15",
  [Inserire qui il testo ufficiale della consegna dal PDF (Esercizio 15).],
)[
]

