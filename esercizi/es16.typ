#import "../conf.typ": esercizio, rimando

#esercizio(
  "16",
  [
    Scrivere una function Matlab,

    ```matlab
    y = lagrange( xi, fi, x )
    ```

    in cui `(xi,fi)` contengono i dati del problema e `x` è un vettore di punti a cui corrispondono le valutazioni del polinomio interpolante in forma di Lagrange restituite nel vettore `y`.
  ],
)[
  Dal punto di vista implementativo non conviene costruire il polinomio nella base delle potenze: e' sufficiente valutare, per ogni $i$, il corrispondente polinomio fondamentale $L_(i,n)$ nei punti richiesti e accumulare il contributo $f_i L_(i,n)$.

  ```matlab
  function y = lagrange(xi, fi, x)
  % Function y = lagrange(xi, fi, x)
  %
  % Valuta il polinomio interpolante nella forma di Lagrange
  % associato ai dati (xi, fi) nei punti contenuti nel vettore x.
  %
  % Input:
  %   xi - vettore delle ascisse di interpolazione;
  %   fi - vettore dei valori della funzione nelle ascisse xi;
  %   x  - vettore dei punti di valutazione.
  %
  % Output:
  %   y  - valori del polinomio interpolante nei punti x.
  %
  % Rel. 14-05-2026.

  % controlli di consistenza
  if nargin < 3
      error('Numero di argomenti insufficiente.');
  end

  if ~isvector(xi) || ~isvector(fi) || ~isvector(x)
      error('Gli argomenti xi, fi e x devono essere vettori.');
  end

  n = length(xi);

  if length(fi) ~= n
      error('Dimensioni incompatibili tra xi e fi.');
  end

  if n == 0
      error('Il vettore xi non puo'' essere vuoto.');
  end

  if length(unique(xi)) ~= n
      error('Le ascisse di interpolazione devono essere distinte.');
  end

  y = zeros(size(x));

  % valutazione del polinomio p(x) = sum_i fi_i * L_i(x)
  for i = 1:n
      Li = ones(size(x));

      for j = 1:n
          if j ~= i
              Li = Li .* (x - xi(j)) / (xi(i) - xi(j));
          end
      end

      y = y + fi(i) * Li;
  end

  end
  ```

  Il costo della valutazione e' dell'ordine di $O(m n^2)$, dove $m$ e' il numero di punti contenuti in `x` e $n + 1$ e' il numero di dati di interpolazione.
]
