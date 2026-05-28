#import "../conf.typ": esercizio, rimando

#esercizio(
  "20",
  [
    Graficare l'errore massimo (calcolato come il massimo di 10001 punti equispaziati nell'intervallo) per i polinomi interpolanti degli esercizi 16-18, relative alla funzione di Runge,

    $
      f(x) = (1 + x^2)^(-1),
      quad x in [-10, 10],
    $

    utilizzando $n + 1$ ascisse equispaziate, con $n = 10, 20, 30, ..., 140$, per i polinomi interpolanti in 16-17, e $n = 10, 20, 30, ..., 70$, per il polinomio interpolante di Hermite. Per quest'ultimo polinomio, graficare anche l'errore della derivata prima. Utilizzare il modo più appropriato per graficare i risultati. Commentare i risultati ottenuti.
  ],
)[
  L'errore massimo è stato stimato, come richiesto, su 10001 punti
  equispaziati dell'intervallo $[-10, 10]$. Li indichiamo con
  $
    t_j = -10 + j dot (20 / 10000),
    quad j = 0, ..., 10000,
  $
  dove $20$ è la lunghezza dell'intervallo.
  Su questi punti si pone
  $
    E_n = max_(0 <= j <= 10000) |f(t_j) - p_n(t_j)|.
  $
  Per il polinomio di Hermite è stato calcolato anche
  $
    E'_n = max_(0 <= j <= 10000) |f'(t_j) - p'_n(t_j)|,
    quad
    f'(x) = - (2 x) / (1 + x^2)^2.
  $
  Poiché gli errori variano su molti ordini di grandezza, la
  rappresentazione più adatta è quella semilogaritmica.

  #figure(
    image("../img/es20.png", width: 90%),
    caption: [Errore massimo per l'interpolazione della funzione di Runge con ascisse equidistanti.],
  )

  === Commento dei risultati
  Il grafico mostra il fenomeno di Runge: con ascisse equidistanti l'errore
  aumenta al crescere del grado, soprattutto vicino agli estremi. Lagrange e
  Newton rappresentano lo stesso polinomio in aritmetica esatta; la separazione
  delle curve, per gradi alti, dipende quindi dalla diversa stabilità numerica
  delle due valutazioni.

  L'errore passa da circa $4.34$ per $n = 10$ a valori tra $10^30$ e
  $10^37$ per $n = 140$. Anche Hermite peggiora: imponendo pure le derivate
  si ottiene un polinomio di grado più alto, e per $n = 70$ gli errori su
  funzione e derivata sono rispettivamente circa $8.24 dot 10^37$ e
  $8.31 dot 10^38$. Le ascisse equidistanti sono quindi inadatte a questo
  esempio per gradi elevati.

  #rimando[Script MATLAB: `test_es20.m`.]
]
