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
  L'errore massimo e' stato stimato, come richiesto, su 10001 punti
  equispaziati dell'intervallo $[-10, 10]$. Li indichiamo con
  $
    t_j = -10 + j dot (20 / 10000),
    quad j = 0, ..., 10000,
  $
  dove $20 = 10 - (-10)$ e' la lunghezza dell'intervallo. Quindi $t_0 = -10$,
  $t_10000 = 10$ e i punti intermedi sono distanziati di $20 / 10000$.
  Su questi punti si pone
  $
    E_n = max_(0 <= j <= 10000) |f(t_j) - p_n(t_j)|.
  $
  Per il polinomio di Hermite e' stato calcolato anche
  $
    E'_n = max_(0 <= j <= 10000) |f'(t_j) - p'_n(t_j)|,
    quad
    f'(x) = - (2 x) / (1 + x^2)^2.
  $
  Poiche' gli errori variano su molti ordini di grandezza, la
  rappresentazione piu' adatta e' quella semilogaritmica.

  #figure(
    image("../img/es20.png", width: 90%),
    caption: [Errore massimo per l'interpolazione della funzione di Runge con ascisse equidistanti.],
  )

  === Commento dei risultati
  Il grafico mostra il classico fenomeno di Runge: aumentando il grado con
  ascisse equidistanti, l'interpolazione polinomiale peggiora invece di
  migliorare. Per Lagrange e Newton il polinomio interpolante e' lo stesso in
  aritmetica esatta, quindi le due curve coincidono finche' gli effetti di
  arrotondamento restano secondari. Per gradi alti le due implementazioni
  iniziano invece a separarsi, perche' la valutazione in aritmetica finita
  amplifica diversamente gli errori.

  Numericamente l'errore passa gia' da circa $4.34$ per $n = 10$ a valori
  compresi tra l'ordine di $10^30$ e quello di $10^37$ per $n = 140$. Questo
  comportamento e' dovuto alle forti oscillazioni vicino agli estremi
  dell'intervallo, tipiche dell'interpolazione della funzione di Runge con
  nodi equidistanti.

  Anche l'interpolazione di Hermite non risolve il problema. Anzi, imponendo
  anche i valori della derivata si ottiene un polinomio di grado piu' alto, e
  con queste ascisse l'errore cresce ancora piu' rapidamente: per $n = 70$
  l'errore sul polinomio e' circa $8.24 dot 10^37$, mentre quello sulla
  derivata prima e' circa $8.31 dot 10^38$.

  In conclusione, su questo intervallo le ascisse equidistanti sono una scelta
  numericamente inadatta per interpolare la funzione di Runge con polinomi di
  grado elevato.

  #rimando[Per riprodurre i valori numerici e il grafico riportato, si faccia riferimento allo script MATLAB allegato denominato `test_es20.m`.]
]
