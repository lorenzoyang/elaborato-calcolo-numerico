#import "../conf.typ": esercizio, rimando, tabella_risultati

#esercizio(
  "15",
  [
    Utilizzare la precedente function per risolvere il sistema nonlineare:

    $
      x_1^2 + x_2^2 = 5,
      quad
      x_3^2 + x_4^2 = 5,
      quad
      cos(pi x_1) + cos(pi x_3) = 0,
      quad
      x_2^2 - x_4^2 = 0.
    $

    Quante iterazioni sono necessarie per ottenere la massima accuratezza possibile, partendo dai punti iniziali:

    $
      bold(x)^0 = mat(
        0.4;
        2;
        0.4;
        2
      ),
      quad
      bold(x)^0 = mat(
        0.4;
        -2;
        -0.4;
        2
      ),
      quad
      bold(x)^0 = mat(
        1.4;
        -2;
        -1.4;
        2
      ),
      quad
      bold(x)^0 = mat(
        1.4;
        2;
        1.4;
        2
      ).
    $

    Riportare le soluzioni ottenute e commentare i risultati. Sarebbe possibile utilizzare il vettore nullo come punto iniziale (argomentare la risposta)?
  ],
)[
  Introduciamo il sistema in forma vettoriale
  $
    bold(F)(bold(x)) = mat(
      x_1^2 + x_2^2 - 5;
      x_3^2 + x_4^2 - 5;
      cos(pi x_1) + cos(pi x_3);
      x_2^2 - x_4^2
    ),
  $
  con Jacobiana
  $
    J_(bold(F))(bold(x)) = mat(
      2 x_1, 2 x_2, 0, 0;
      0, 0, 2 x_3, 2 x_4;
      -pi sin(pi x_1), 0, -pi sin(pi x_3), 0;
      0, 2 x_2, 0, -2 x_4
    ).
  $
  Ad ogni iterazione si risolve il sistema lineare
  $
    J_(bold(F))(bold(x)^(k)) Delta bold(x)^(k) = -bold(F)(bold(x)^(k))
  $
  e si aggiorna
  $
    bold(x)^(k+1) = bold(x)^(k) + Delta bold(x)^(k).
  $
  In questo esercizio la Jacobiana non e' simmetrica in generale, quindi il risolutore naturale e' `LUSolve`, gia' usato come default nella function `metodoNewtonSistemi` dell'esercizio 14. Per richiedere la massima accuratezza possibile si pone `tol = 10 * eps`.

  Prima di riportare i risultati numerici conviene descrivere la struttura delle soluzioni esatte. Dalla quarta equazione segue
  $
    x_2^2 = x_4^2.
  $
  Sottraendo poi la seconda equazione dalla prima si ottiene
  $
    x_1^2 - x_3^2 = 0,
    quad "cioe'" quad
    x_3 = plus.minus x_1.
  $
  Poiche' il coseno e' una funzione pari, risulta allora
  $
    cos(pi x_3) = cos(plus.minus pi x_1) = cos(pi x_1),
  $
  e la terza equazione diventa
  $
    2 cos(pi x_1) = 0,
    quad "da cui" quad
    x_1 = 1/2 + k,
    quad k in ZZ.
  $
  Imporre anche $x_1^2 + x_2^2 = 5$ limita i valori ammissibili a
  $
    x_1 in {plus.minus 1/2, plus.minus 3/2}.
  $
  Ne segue che le soluzioni del sistema hanno necessariamente una delle forme
  $
    x_1 = plus.minus 1/2,
    quad
    x_2 = plus.minus sqrt(19)/2,
  $
  oppure
  $
    x_1 = plus.minus 3/2,
    quad
    x_2 = plus.minus sqrt(11)/2,
  $
  con inoltre $x_3 = plus.minus x_1$ e $x_4 = plus.minus x_2$.

  === Risultati numerici
  Applicando `metodoNewtonSistemi` ai quattro punti iniziali assegnati si ottengono i risultati seguenti.

  #tabella_risultati(
    caption: [Soluzioni ottenute con `metodoNewtonSistemi` e `tol = 10 * eps` per i quattro inneschi assegnati.],
    columns: (auto, auto, auto, auto, auto),
    align: center + horizon,
    [*Caso*],
    [*$bold(x)^0$*],
    [*$bold(x)^*$ ottenuta*],
    [*Iterazioni*],
    [*$||bold(F)(bold(x)^*)||_infinity$*],
    [1],
    [$ (0.4, 2, 0.4, 2)^T $],
    [$ (1/2, sqrt(19)/2, 1/2, sqrt(19)/2)^T $],
    [5],
    [$8.8818 dot 10^(-16)$],
    [2],
    [$ (0.4, -2, -0.4, 2)^T $],
    [$ (1/2, -sqrt(19)/2, -1/2, sqrt(19)/2)^T $],
    [5],
    [$8.8818 dot 10^(-16)$],
    [3],
    [$ (1.4, -2, -1.4, 2)^T $],
    [$ (3/2, -sqrt(11)/2, -3/2, sqrt(11)/2)^T $],
    [5],
    [$3.6739 dot 10^(-16)$],
    [4],
    [$ (1.4, 2, 1.4, 2)^T $],
    [$ (3/2, sqrt(11)/2, 3/2, sqrt(11)/2)^T $],
    [5],
    [$3.6739 dot 10^(-16)$],
  )

  In tutti e quattro i casi il metodo di Newton raggiunge quindi la precisione di macchina in $5$ iterazioni. I residui finali sono dell'ordine di $10^(-16)$, cioe' perfettamente compatibili con la richiesta di massima accuratezza possibile in doppia precisione.

  I primi due inneschi convergono verso soluzioni con $|x_1| = |x_3| = 1/2$, mentre gli ultimi due convergono verso soluzioni con $|x_1| = |x_3| = 3/2$. In altre parole, il metodo seleziona la radice appartenente al bacino di attrazione del punto iniziale scelto. Il numero di iterazioni coincide nei quattro casi perche' tutti gli inneschi sono gia' abbastanza vicini a una radice semplice, e quindi il metodo entra rapidamente nel regime di convergenza quadratica.

  === Punto iniziale nullo
  Non e' possibile usare il vettore nullo come punto iniziale. Infatti
  $
    bold(F)(bold(0)) = mat(
      -5;
      -5;
      2;
      0
    )
    !=
    bold(0),
  $
  mentre la Jacobiana nel punto nullo e'
  $
    J_(bold(F))(bold(0)) = mat(
      0, 0, 0, 0;
      0, 0, 0, 0;
      0, 0, 0, 0;
      0, 0, 0, 0
    ).
  $
  Il primo passo di Newton richiederebbe quindi di risolvere il sistema
  $
    J_(bold(F))(bold(0)) Delta bold(x) = -bold(F)(bold(0)),
  $
  ossia un sistema con matrice nulla e termine noto non nullo, impossibile da risolvere. Questo e' esattamente il motivo per cui, il metodo di Newton per sistemi richiede che la Jacobiana sia invertibile almeno nei punti in cui viene eseguito il passo.

  #rimando[Per riprodurre i valori numerici riportati, si faccia riferimento allo script MATLAB allegato denominato `test_es15.m`.]
]
