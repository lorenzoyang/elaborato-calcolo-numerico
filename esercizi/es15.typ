#import "../conf.typ": esercizio

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
]
