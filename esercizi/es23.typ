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

]
