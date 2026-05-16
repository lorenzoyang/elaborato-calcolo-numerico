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
  Il miglioramento rispetto ai nodi equidistanti e' netto: per Lagrange
  l'errore scende da circa $3.59 dot 10^(-1)$ per $n = 10$ a
  $7.70 dot 10^(-7)$ per $n = 140$, senza il fenomeno di Runge osservato
  nell'esercizio 20.

  La curva di Newton coincide con quella di Lagrange solo per gradi bassi;
  da circa $n = 50$ dominano gli errori di arrotondamento della forma di
  Newton. Per Hermite l'effetto e' ancora piu' evidente, perche' il grado e'
  maggiore e le differenze divise usano nodi ripetuti. Le ascisse di
  Chebyshev migliorano quindi il problema di interpolazione, ma la stabilita'
  della forma numerica resta decisiva.

  #rimando[Per riprodurre i valori numerici e il grafico riportato, si faccia riferimento allo script MATLAB allegato denominato `test_es21.m`.]
]
