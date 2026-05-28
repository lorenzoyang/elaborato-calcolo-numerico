#import "../conf.typ": esercizio, rimando, tabella_risultati

#esercizio(
  "13",
  [
    Siano assegnati:
    $
      A = mat(
        1, 2, 3;
        4, 5, 6;
        7, 8, 9;
        10, 11, 0
      ),
      quad
      bold(b) = mat(
        1;
        2;
        3;
        4
      ).
    $

    Risolvere il sistema $A bold(x) = bold(b)$ nel senso dei minimi quadrati pesati, cioè minimizzando (1), nei seguenti casi:
    - $omega_i = 1, quad i = 1, dots, 4 quad$ (minimi quadrati standard);
    - $omega_i = (5 - i)^2 / 9, quad i = 1, dots, 4$;
    - $omega_i = i^2 / 9, quad i = 1, dots, 4$;
    - $omega_i = sqrt(2), quad i = 1, dots, 4$.

    Riportare la norma (il quadrato della norma pesata) (1) del corrispondente residuo per tutti i casi. Commentare i risultati ottenuti.

    (1) Il quadrato della norma pesata del residuo: $Phi(bold(x)) = sum_(i=1)^4 omega_i (bold(b)_i - (A bold(x))_i)^2$.
  ],
)[
  Indichiamo con
  $
    bold(r)(bold(x)) = bold(b) - A bold(x)
  $
  il residuo associato a $bold(x)$. La quantità da minimizzare è
  $
    Phi(bold(x)) = sum_(i=1)^4 omega_i r_i(bold(x))^2,
  $
  cioè il quadrato della norma pesata del residuo. Poiché i pesi sono positivi, $Phi(bold(x)) >= 0$ e il valore minimo possibile è $0$.

  In questo caso il sistema è compatibile. Infatti la sottomatrice $3 times 3$ ottenuta scegliendo le righe $1, 2, 4$ di $A$ ha determinante
  $
    36 != 0,
  $
  quindi $A$ ha rango colonna massimo, cioè $"rank"(A) = 3$. Ricaviamo esplicitamente la soluzione.

  Le quattro equazioni sono
  $
    x_1 + 2 x_2 + 3 x_3 = 1,
    quad
    4 x_1 + 5 x_2 + 6 x_3 = 2,
  $
  $
    7 x_1 + 8 x_2 + 9 x_3 = 3,
    quad
    10 x_1 + 11 x_2 = 4.
  $
  Sottraendo la prima equazione dalla seconda e la seconda dalla terza si ottiene in entrambi i casi
  $
    x_1 + x_2 + x_3 = 1/3.
  $
  Sottraendo invece la terza equazione dalla quarta si ha
  $
    x_1 + x_2 - 3 x_3 = 1/3.
  $
  Facendo ora la differenza tra le ultime due relazioni segue
  $
    4 x_3 = 0,
    quad "quindi" quad
    x_3 = 0.
  $
  Sostituendo in $x_1 + x_2 + x_3 = 1/3$ si ricava
  $
    x_1 + x_2 = 1/3.
  $
  Insieme alla prima equazione,
  $
    x_1 + 2 x_2 = 1,
  $
  si ottiene
  $
    x_2 = 2/3,
    quad
    x_1 = -1/3.
  $
  Dunque la soluzione esatta è
  $
    bold(x)^* = mat(
      -1/3;
      2/3;
      0
    ).
  $
  Si verifica infatti immediatamente che
  $
    A bold(x)^* = bold(b),
  $
  perciò il residuo corrispondente è
  $
    bold(r)(bold(x)^*) = bold(b) - A bold(x)^* = bold(0).
  $
  e dunque, per *ogni* scelta di pesi positivi,
  $
    Phi(bold(x)^*) = sum_(i=1)^4 omega_i (r_i^*)^2 = 0.
  $
  Quindi tutti e quattro i casi hanno la stessa soluzione di minimi quadrati, coincidente con la soluzione esatta del sistema.

  === Risultati numerici
  Il calcolo numerico conferma la soluzione esatta:

  #tabella_risultati(
    caption: [Soluzioni di minimi quadrati pesati per i quattro insiemi di pesi assegnati.],
    columns: (auto, auto, auto, auto),
    align: center + horizon,
    [*Caso*],
    [*Pesi*],
    [*$bold(x)$ calcolata*],
    [*$Phi(bold(x))$*],
    [1],
    [$omega_i = 1$],
    [$(-1/3, 2/3, 0)^T$],
    [$2.4652 dot 10^(-31)$],
    [2],
    [$omega_i = (5 - i)^2 / 9$],
    [$(-1/3, 2/3, 0)^T$],
    [$5.0947 dot 10^(-31)$],
    [3],
    [$omega_i = i^2 / 9$],
    [$(-1/3, 2/3, 0)^T$],
    [$2.4981 dot 10^(-30)$],
    [4],
    [$omega_i = sqrt(2)$],
    [$(-1/3, 2/3, 0)^T$],
    [$5.5781 dot 10^(-31)$],
  )

  I valori in tabella sono dell'ordine di $10^(-30)$, quindi compatibili con un residuo nullo a meno degli arrotondamenti. In aritmetica esatta si avrebbe
  $
    bold(r)(bold(x)^*) = bold(0)
    quad
    "e quindi"
    quad
    Phi(bold(x)^*) = 0
  $
  in tutti e quattro i casi.

  #rimando[Script MATLAB: `test_es13.m`.]
]
