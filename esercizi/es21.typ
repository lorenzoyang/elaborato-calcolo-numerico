#import "../conf.typ": esercizio, rimando

#esercizio(
  "21",
  [
    Ripetere l'esercizio precedente, utilizzando le ascisse di Chebyshev in luogo di quelle equidistanti. Commentare i risultati ottenuti.
  ],
)[
  Si ripete il calcolo dell'esercizio 20 sostituendo le ascisse equidistanti
  con le ascisse di Chebyshev dell'esercizio 19:
  $
    x_i = (a + b) / 2 + (b - a) / 2
      cos((2 i + 1) pi / (2 (n + 1))),
    quad i = 0, ..., n,
  $
  con $a = -10$ e $b = 10$. L'errore massimo e' ancora stimato sui 10001
  punti equispaziati dell'intervallo $[-10, 10]$, quindi si usano le stesse
  quantita'
  $
    E_n = max_(0 <= j <= 10000) |f(t_j) - p_n(t_j)|,
    quad
    E'_n = max_(0 <= j <= 10000) |f'(t_j) - p'_n(t_j)|
  $
  dell'esercizio precedente.

  La ragione della scelta di Chebyshev e' che questi nodi
  minimizzano il massimo del prodotto nodale e portano a una crescita
  logaritmica, quindi ottimale, della costante di Lebesgue. Per questo sono
  molto piu' adatti dei nodi equidistanti quando il grado cresce.

  #figure(
    image("../img/es21.png", width: 90%),
    caption: [Errore massimo per l'interpolazione della funzione di Runge con ascisse di Chebyshev.],
  )

  === Commento dei risultati
  Rispetto all'esercizio 20 il miglioramento e' netto per l'interpolazione in
  forma di Lagrange: l'errore passa da circa $3.59 dot 10^(-1)$ per $n = 10$
  a circa $7.70 dot 10^(-7)$ per $n = 140$. Quindi, usando questi nodi, non si
  osserva il fenomeno di Runge visto con le ascisse equidistanti.

  In aritmetica esatta Lagrange e Newton rappresentano lo stesso polinomio
  interpolante. Nel grafico pero' la curva di Newton coincide con quella di
  Lagrange solo per gradi bassi; da circa $n = 50$ gli errori di arrotondamento
  della costruzione e della valutazione in forma di Newton diventano
  dominanti, fino a produrre valori molto grandi. Questo non contraddice il
  vantaggio delle ascisse di Chebyshev: mostra piuttosto che, per gradi alti,
  conta anche la stabilita' della forma numerica usata per valutare il
  polinomio.

  Per Hermite il comportamento e' analogo ma ancora piu' marcato. L'errore
  migliora inizialmente, passando da circa $2.25 dot 10^(-1)$ per $n = 10$ a
  circa $4.20 dot 10^(-2)$ per $n = 20$, ma poi cresce rapidamente. Il
  polinomio di Hermite ha grado piu' elevato e richiede differenze divise con
  nodi ripetuti; in doppia precisione questa scelta amplifica fortemente gli
  errori di arrotondamento. Anche l'errore sulla derivata prima segue lo
  stesso andamento.

  In conclusione, le ascisse di Chebyshev risolvono il problema principale dei
  nodi equidistanti per l'interpolazione della funzione di Runge, ma i risultati
  numerici dipendono ancora dalla forma con cui il polinomio viene costruito e
  valutato.

  #rimando[Per riprodurre i valori numerici e il grafico riportato, si faccia riferimento allo script MATLAB allegato denominato `test_es21.m`.]
]
