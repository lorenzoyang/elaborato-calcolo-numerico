#import "../conf.typ": esercizio, rimando, tabella_risultati

#esercizio(
  "26",
  [
    Ripetere il precedente esercizio considerando, invece dell'intervallo $[-10, 10]$, l'intervallo $[-5, 15]$. Commentare i risultati ottenuti, rispetto a quelli del precedente esercizio.
  ],
)[
  Si mantiene lo stesso procedimento dell'esercizio 25, cambiando solo
  l'intervallo di interpolazione. I punti di controllo dell'errore sono
  quindi
  $
    t_j = -5 + j dot 20 / 10000,
    quad j = 0, ..., 10000,
  $
  e, per ogni $n = 100, 200, ..., 2000$, si pone ancora $h = 20 / n$ e
  $
    E_n = max_(0 <= j <= 10000) |f(t_j) - s_n(t_j)|,
    quad
    f(x) = 1 / (1 + x^2).
  $
  Per la spline completa si usano le derivate esatte agli estremi:
  $
    f'(x) = - (2 x) / (1 + x^2)^2.
  $

  #figure(
    image("../img/es26.png", width: 90%),
    caption: [Errore massimo delle tre spline cubiche interpolanti sull'intervallo $[-5, 15]$.],
  )

  Come nell'esercizio precedente, la potenza di $h$ è stata stimata
  approssimando con una retta la parte finale del grafico nel piano
  $log(E_n)$-$log(h)$, usando gli ultimi dieci valori di $h$.

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
    [$1.6502 dot 10^(-7)$],
    [$4.1256 dot 10^(-8)$],
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
  Gli ordini asintotici restano quelli dell'esercizio 25: $h^2$ per la spline
  naturale e $h^4$ per not-a-knot e completa. Cambia invece la costante
  dell'errore della spline naturale. Sul nuovo intervallo il vincolo naturale
  impone $s''(-5) = s''(15) = 0$, ma
  $
    f''(x) = (6 x^2 - 2) / (1 + x^2)^3
  $
  e in particolare $f''(-5) approx 8.42 dot 10^(-3)$, molto più grande di
  $f''(plus.minus 10) approx 5.80 dot 10^(-4)$ dell'esercizio precedente.
  Per questo l'errore della spline naturale è circa quindici volte più
  grande: ad esempio $E_2000$ passa da $2.8437 dot 10^(-9)$ a
  $4.1256 dot 10^(-8)$.

  Le curve not-a-knot e completa restano praticamente coincidenti con quelle
  dell'esercizio 25: il massimo dell'errore è vicino a $x = 0$ e il passo $h$
  è lo stesso nei due intervalli.

  #rimando[Per riprodurre i valori numerici e il grafico riportato, si faccia riferimento allo script MATLAB allegato denominato `test_es26.m`.]
]
