#import "../conf.typ": esercizio, rimando, tabella_risultati

#esercizio(
  "25",
  [
    Utilizzare la function `spline3` per approssimare la funzione di Runge, come nell'esercizio 20, utilizzando $n + 1$ ascisse equidistanti, con $n = 100, 200, ..., 2000$. Detta $h = 20 / n$ la distanza tra due punti consecutivi, graficare, in formato loglog l'errore massimo, calcolato come nell'esercizio 20, rispetto ad $h$. Con che potenza di $h$ decresce, asintoticamente l'errore, per le tre spline interpolanti?
  ],
)[
  Si usa lo stesso criterio dell'esercizio 20. Fissati i 10001 punti
  equispaziati
  $
    t_j = -10 + j dot 20 / 10000,
    quad j = 0, ..., 10000,
  $
  l'errore massimo viene calcolato come
  $
    E_n = max_(0 <= j <= 10000) |f(t_j) - s_n(t_j)|,
    quad
    f(x) = 1 / (1 + x^2).
  $
  Per la spline completa sono state usate le derivate esatte agli estremi:
  $
    f'(x) = - (2 x) / (1 + x^2)^2.
  $
  Nelle chiamate a `spline3`, `type = 0` corrisponde alla spline naturale,
  `type = 1` alla not-a-knot e `type = 2` alla completa.

  #figure(
    image("../img/es25.png", width: 90%),
    caption: [Errore massimo delle tre spline cubiche interpolanti per la funzione di Runge.],
  )

  Per stimare la potenza di $h$ si è approssimata con una retta la parte
  finale del grafico nel piano $log(E_n)$-$log(h)$, usando gli ultimi dieci
  valori di $h$. Se $E_n approx C h^p$, allora la pendenza della retta
  fornisce proprio una stima di $p$.

  #tabella_risultati(
    caption: [Ordini asintotici stimati dal grafico loglog, usando gli ultimi dieci valori di $h$.],
    columns: (auto, auto, auto, auto),
    align: center + horizon,
    [*Spline*],
    [*Ordine stimato*],
    [*$E_1000$*],
    [*$E_2000$*],
    [Naturale],
    [$1.9908$],
    [$1.1375 dot 10^(-8)$],
    [$2.8437 dot 10^(-9)$],
    [Not-a-knot],
    [$4.0475$],
    [$1.0015 dot 10^(-8)$],
    [$5.7631 dot 10^(-10)$],
    [Completa],
    [$4.0475$],
    [$1.0015 dot 10^(-8)$],
    [$5.7631 dot 10^(-10)$],
  )

  === Commento
  Asintoticamente la spline naturale decresce come $h^2$, mentre not-a-knot
  e completa come $h^4$. La differenza dipende dalle condizioni al
  bordo: la completa usa le derivate prime corrette e la not-a-knot mantiene
  il quarto ordine; la naturale impone invece $s''(-10) = s''(10) = 0$, ma per
  la funzione di Runge
  $
    f''(x) = (6 x^2 - 2) / (1 + x^2)^3
  $
  e quindi $f''(plus.minus 10) != 0$. Il vincolo naturale non è compatibile
  con la funzione interpolata e l'errore globale resta di ordine $h^2$.

  Per griglie non ancora fini le curve sono quasi sovrapposte; il diverso
  ordine della spline naturale emerge solo nel regime asintotico.

  #rimando[Script MATLAB: `test_es25.m`.]
]
