#import "../conf.typ": esercizio

#esercizio(
  "23",
  [
    Dimostrare che, per una spline cubica completa interpolante una funzione $f(x)$ sulla partizione

    $
      Delta = {a = x_0 < x_1 < ... < x_n = b},
      quad
      h_i = x_i - x_(i-1),
      quad i = 1, ..., n,
    $

    i valori

    $
      m_i = s''_3(x_i),
      quad i = 0, ..., n,
    $

    sono la soluzione del sistema lineare tridiagonale con matrice a diagonale dominante per righe:

    $
      mat(
        2, 1, 0, dots.h, 0, 0;
        phi_1, 2, xi_1, dots.h, 0, 0;
        0, phi_2, 2, xi_2, dots.h, 0;
        dots.v, dots.v, dots.v, dots.v, dots.v, dots.v;
        0, 0, dots.h, phi_(n-1), 2, xi_(n-1);
        0, 0, dots.h, 0, 1, 2
      )
      mat(
        m_0;
        m_1;
        m_2;
        dots.v;
        m_(n-1);
        m_n
      )
      =
      6 mat(
        f[x_0, x_0, x_1];
        f[x_0, x_1, x_2];
        f[x_1, x_2, x_3];
        dots.v;
        f[x_(n-2), x_(n-1), x_n];
        f[x_(n-1), x_n, x_n]
      ),
    $

    con

    $
      phi_i = h_i / (h_i + h_(i+1)),
      quad
      xi_i = h_(i+1) / (h_i + h_(i+1)),
      quad i = 1, ..., n - 1.
    $
  ],
)[
  Poniamo $f_i = f(x_i)$ e indichiamo con $s_i$ la restrizione della spline
  all'intervallo $[x_(i - 1), x_i]$. Usiamo la convenzione delle differenze
  divise con nodi ripetuti, quindi $f[x_0, x_0] = f'(x_0)$ e
  $f[x_n, x_n] = f'(x_n)$. Poiche' $s_i''$ e' lineare su ciascun intervallo e
  vale $m_(i - 1)$ e $m_i$ agli estremi, si ha
  $
    s_i''(x) =
      m_(i - 1) (x_i - x) / h_i
      + m_i (x - x_(i - 1)) / h_i,
    quad x in [x_(i - 1), x_i].
  $

  Integrando due volte e imponendo $s_i(x_(i - 1)) = f_(i - 1)$,
  $s_i(x_i) = f_i$, si ottiene la formula locale
  $
    s_i(x) =
      m_(i - 1) (x_i - x)^3 / (6 h_i)
      + m_i (x - x_(i - 1))^3 / (6 h_i)
      + (f_(i - 1) / h_i - m_(i - 1) h_i / 6)(x_i - x)
      + (f_i / h_i - m_i h_i / 6)(x - x_(i - 1)).
  $
  Derivando e valutando agli estremi dell'intervallo segue
  $
    s_i'(x_(i - 1)) =
      f[x_(i - 1), x_i] - h_i / 6 (2 m_(i - 1) + m_i),
    quad
    s_i'(x_i) =
      f[x_(i - 1), x_i] + h_i / 6 (m_(i - 1) + 2 m_i).
  $

  Nei nodi interni $x_i$, $i = 1, ..., n - 1$, la spline deve avere derivata
  prima continua, quindi $s_i'(x_i) = s_(i + 1)'(x_i)$. Usando le due formule
  precedenti:
  $
    f[x_(i - 1), x_i] + h_i / 6 (m_(i - 1) + 2 m_i)
    =
    f[x_i, x_(i + 1)] - h_(i + 1) / 6 (2 m_i + m_(i + 1)).
  $
  Portando i termini con $m$ a sinistra:
  $
    h_i m_(i - 1) + 2(h_i + h_(i + 1)) m_i
      + h_(i + 1) m_(i + 1)
    =
    6 (f[x_i, x_(i + 1)] - f[x_(i - 1), x_i]).
  $
  Dividendo per $h_i + h_(i + 1)$ si ricava
  $
    phi_i m_(i - 1) + 2 m_i + xi_i m_(i + 1)
    =
    6 f[x_(i - 1), x_i, x_(i + 1)],
    quad i = 1, ..., n - 1,
  $
  perche'
  $
    f[x_(i - 1), x_i, x_(i + 1)] =
      (f[x_i, x_(i + 1)] - f[x_(i - 1), x_i])
      / (h_i + h_(i + 1)).
  $

  Restano le due condizioni che rendono la spline completa:
  $
    s_1'(x_0) = f'(x_0) = f[x_0, x_0],
    quad
    s_n'(x_n) = f'(x_n) = f[x_n, x_n].
  $
  La prima, applicata alla formula di $s_1'(x_0)$, da'
  $
    f[x_0, x_1] - h_1 / 6 (2 m_0 + m_1) = f[x_0, x_0],
  $
  cioe'
  $
    2 m_0 + m_1
    =
    6 (f[x_0, x_1] - f[x_0, x_0]) / h_1
    =
    6 f[x_0, x_0, x_1].
  $
  Analogamente, dalla condizione destra,
  $
    f[x_(n - 1), x_n] + h_n / 6 (m_(n - 1) + 2 m_n)
      = f[x_n, x_n],
  $
  quindi
  $
    m_(n - 1) + 2 m_n
    =
    6 (f[x_n, x_n] - f[x_(n - 1), x_n]) / h_n
    =
    6 f[x_(n - 1), x_n, x_n].
  $

  Le due equazioni di bordo e le $n - 1$ equazioni interne sono esattamente
  le righe del sistema indicato nel testo. Infine, poiche' $h_i > 0$, valgono
  $phi_i > 0$, $xi_i > 0$ e $phi_i + xi_i = 1$. Dunque nelle righe interne il
  coefficiente diagonale vale $2$ e la somma dei coefficienti fuori diagonale
  vale $1$; nelle righe estreme vale ancora $2 > 1$. La matrice e' quindi a
  diagonale dominante stretta per righe, e in particolare e' non singolare.
  Il sistema ammette quindi una sola soluzione, che coincide con il vettore
  delle derivate seconde nodali della spline completa.

]

