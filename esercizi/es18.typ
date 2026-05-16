#import "../conf.typ": esercizio

#esercizio(
  "18",
  [
    Scrivere una function Matlab,

    ```matlab
    [y,y1] = hermite( xi, fi, fi1, x )
    ```

    in cui `(xi,fi,fi1)` contengono i dati del problema e `x` è un vettore di punti a cui corrispondono le valutazioni del polinomio interpolante di Hermite, e della sua derivata prima, rispettivamente restituite nei vettori `y` e `y1`.
  ],
)[
  Per costruire il polinomio di Hermite usiamo ancora la forma di
  Newton, ripetendo ogni nodo due volte. Se
  $z_(2 i - 1) = z_(2 i) = x_i$, allora la differenza divisa relativa alla
  coppia di nodi coincidenti non si calcola con un quoziente, ma si pone
  uguale al dato sulla derivata:
  $
    f[z_(2 i - 1), z_(2 i)] = f'_i.
  $
  Ottenuti i coefficienti di Newton, polinomio e derivata prima si valutano
  con Horner modificato.

  ```matlab
  function [y, y1] = hermite(xi, fi, fi1, x)
  % Function [y, y1] = hermite(xi, fi, fi1, x)
  %
  % Valuta il polinomio interpolante di Hermite associato ai dati
  % (xi, fi, fi1) nei punti contenuti nel vettore x.
  %
  % Input:
  %   xi  - vettore delle ascisse di interpolazione;
  %   fi  - vettore dei valori della funzione nelle ascisse xi;
  %   fi1 - vettore dei valori della derivata prima nelle ascisse xi;
  %   x   - vettore dei punti di valutazione.
  %
  % Output:
  %   y   - valori del polinomio interpolante nei punti x;
  %   y1  - valori della derivata prima del polinomio nei punti x.
  %
  % Rel. 15-05-2026.

  % controlli di consistenza
  if nargin < 4
      error('Numero di argomenti insufficiente.');
  end

  n = length(xi);

  if length(fi) ~= n || length(fi1) ~= n
      error('Dimensioni incompatibili tra xi, fi e fi1.');
  end

  if n == 0
      error('Il vettore xi non puo'' essere vuoto.');
  end

  if length(unique(xi)) ~= n
      error('Le ascisse di interpolazione devono essere distinte.');
  end

  xi = xi(:);
  fi = fi(:);
  fi1 = fi1(:);

  N = 2 * n;
  z = zeros(N, 1);
  a = zeros(N, 1);

  z(1:2:N) = xi;
  z(2:2:N) = xi;
  a(1:2:N) = fi;
  a(2:2:N) = fi;

  % calcolo in-place delle differenze divise con nodi ripetuti
  for j = 2:N
      for i = N:-1:j
          if j == 2 && rem(i, 2) == 0
              a(i) = fi1(i / 2);
          else
              a(i) = (a(i) - a(i - 1)) / (z(i) - z(i - j + 1));
          end
      end
  end

  % valutazione simultanea di p e p' con Horner modificato
  y = a(N) * ones(size(x));
  y1 = zeros(size(x));

  for i = N-1:-1:1
      y1 = y + (x - z(i)) .* y1;
      y = y .* (x - z(i)) + a(i);
  end

  end
  ```

  La costruzione delle differenze divise richiede $O(n^2)$ operazioni, dove
  `n` è il numero di nodi passati alla function. La valutazione in $m$ punti
  richiede $O(m n)$ operazioni e produce direttamente sia `y` sia `y1`.
]
