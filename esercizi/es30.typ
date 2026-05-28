#import "../conf.typ": esercizio, rimando, tabella_risultati

#esercizio(
  "30",
  [
    Utilizzare le function dei precedenti due esercizi per approssimare

    $
      integral_0^1 10^2 sin(10^2 x) e^(-10^2 x) dif x approx 1 / 2,
    $

    con la formula composita, e quella adattativa, di Simpson. Per la formula composita, tabulare l'errore e la sua stima, per $n = 40, 80, 160, 320$. Per la formula adattiva, tabulare l'errore e `tol`, per $"tol" = 10^(-3), 10^(-4), 10^(-5), 10^(-6)$. In entrambi i casi, riportare il numero di valutazioni funzionali effettuate.
  ],
)[
  Si prende come valore di riferimento
  $
    I =
    integral_0^1 100 sin(100 x) e^(-100 x) dif x
    =
    (1 - e^(-100)(sin(100) + cos(100))) / 2.
  $
  In doppia precisione questo valore coincide con $1 / 2$, perché il termine
  con $e^(-100)$ è dell'ordine di $10^(-44)$.

  Per la formula composita di Simpson si usa `ncotescomp` con $k = 2$.
  Indico con $S_n$ il valore ottenuto usando $n + 1$ nodi equidistanti. La stima dell'errore è ottenuta confrontando la
  formula su tutti i nodi con quella sui soli nodi di indice pari; in questo
  caso l'ordine è $p = 4$, quindi
  $
    "err" =
    abs(S_n - S_(n / 2)) / (2^4 - 1).
  $
  Le valutazioni funzionali sono $n + 1$, perché la formula con passo doppio
  riusa valori già calcolati.

  #tabella_risultati(
    caption: [Formula composita di Simpson per $f(x) = 100 sin(100 x) e^(-100 x)$.],
    columns: (auto, auto, auto, auto, auto),
    align: center + horizon,
    [*$n$*],
    [*$S_n$*],
    [*Errore*],
    [*Stima*],
    [*Valutazioni*],
    [$40$],
    [$1.5467 dot 10^(-1)$],
    [$3.4533 dot 10^(-1)$],
    [$1.3188 dot 10^(-2)$],
    [$41$],
    [$80$],
    [$4.6675 dot 10^(-1)$],
    [$3.3251 dot 10^(-2)$],
    [$2.0805 dot 10^(-2)$],
    [$81$],
    [$160$],
    [$4.9816 dot 10^(-1)$],
    [$1.8392 dot 10^(-3)$],
    [$2.0941 dot 10^(-3)$],
    [$161$],
    [$320$],
    [$4.9989 dot 10^(-1)$],
    [$1.0838 dot 10^(-4)$],
    [$1.1539 dot 10^(-4)$],
    [$321$],
  )

  Per la formula adattiva si applica direttamente `simpsonad` all'intervallo
  $[0, 1]$, con le tolleranze richieste.

  #tabella_risultati(
    caption: [Formula adattiva di Simpson applicata su $[0, 1]$.],
    columns: (auto, auto, auto, auto),
    align: center + horizon,
    [*$"tol"$*],
    [*$I$*],
    [*Errore*],
    [*Valutazioni*],
    [$10^(-3)$],
    [$-6.1270 dot 10^(-11)$],
    [$5.0000 dot 10^(-1)$],
    [$5$],
    [$10^(-4)$],
    [$-6.1270 dot 10^(-11)$],
    [$5.0000 dot 10^(-1)$],
    [$5$],
    [$10^(-5)$],
    [$-6.1270 dot 10^(-11)$],
    [$5.0000 dot 10^(-1)$],
    [$5$],
    [$10^(-6)$],
    [$-6.1270 dot 10^(-11)$],
    [$5.0000 dot 10^(-1)$],
    [$5$],
  )

  Il risultato adattivo non migliora al diminuire di `"tol"`. Già al primo
  confronto tra Simpson su $[0, 1]$ e le due formule su $[0, 1 / 2]$,
  $[1 / 2, 1]$, la stima locale è
  $
    abs(S_2 - S_1) / 15 approx 4.08 dot 10^(-12).
  $
  Questo valore è minore di tutte le tolleranze richieste, quindi la routine
  si arresta subito e usa solo i nodi
  $0, 1 / 4, 1 / 2, 3 / 4, 1$.

  L'errore reale resta grande perché questi nodi non descrivono la parte
  significativa dell'integranda, concentrata molto vicino a $0$. In questo
  esempio lo stimatore locale è quindi troppo ottimistico.

  #rimando[Script MATLAB: `test_es30.m`.]
]
