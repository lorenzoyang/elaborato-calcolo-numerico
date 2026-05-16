#import "../conf.typ": esercizio

#esercizio(
  "19",
  [
    Scrivere una function Matlab,

    ```matlab
    x = chebyshev( a, b, n )
    ```

    che restituisca le ascisse di Chebyshev per il polinomio interpolante di grado $n$ sull'intervallo $[a,b]$.
  ],
)[
  Per un polinomio interpolante di grado $n$ servono $n + 1$ nodi. Si usano
  quindi gli zeri di $T_(n+1)$, trasportati linearmente da $[-1, 1]$ a
  $[a, b]$:
  $
    x_i = (a + b) / 2 + (b - a) / 2
      cos((2 i + 1) pi / (2 (n + 1))),
    quad i = 0, ..., n.
  $
  Nel codice si prende `i = n:-1:0`, così le ascisse sono restituite in ordine
  crescente.

  ```matlab
  function x = chebyshev(a, b, n)
  % Function x = chebyshev(a, b, n)
  %
  % Restituisce le n + 1 ascisse di Chebyshev per il polinomio
  % interpolante di grado n sull'intervallo [a, b].
  %
  % Input:
  %   a, b - estremi dell'intervallo di interpolazione;
  %   n    - grado del polinomio interpolante.
  %
  % Output:
  %   x    - vettore riga delle ascisse di Chebyshev in [a, b].
  %
  % Rel. 15-05-2026.

  % controlli di consistenza
  if nargin < 3
      error('Numero di argomenti insufficiente.');
  end

  if a >= b
      error('Intervallo [a, b] non valido.');
  end

  if n < 0 || n ~= fix(n)
      error('Il grado n deve essere un intero non negativo.');
  end

  i = n:-1:0;

  % zeri di T_(n+1) su [-1, 1] e trasformazione affine in [a, b]
  x = cos((2 * i + 1) * pi / (2 * (n + 1)));
  x = (a + b) / 2 + (b - a) / 2 * x;

  return
  end
  ```
]
