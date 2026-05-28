#import "../conf.typ": esercizio, rimando

#esercizio(
  "17",
  [
    Scrivere una function MATLAB,

    ```matlab
    y = newton( xi, fi, x )
    ```

    che ha la stessa sintassi e funzione della function del precedente esercizio, ma con l'utilizzo della forma di Newton del polinomio interpolante.
  ],
)[
  La forma di Newton usa i coefficienti
  $
    a_i = f[x_0, ..., x_i],
    quad i = 0, ..., n,
  $
  cioè le differenze divise sui primi $i + 1$ nodi. Il polinomio interpolante si scrive quindi come
  $
    p_n(x) = sum_(i=0)^n a_i omega_i(x),
    quad
    omega_0(x) = 1,
    quad
    omega_i(x) = product_(j=0)^(i-1) (x - x_j).
  $
  Calcolate le differenze divise, la valutazione si effettua con Horner modificato, evitando sia la base delle potenze sia la costruzione esplicita dei polinomi $omega_i$.

  ```matlab
  function y = newton(xi, fi, x)
  % Function y = newton(xi, fi, x)
  %
  % Valuta il polinomio interpolante nella forma di Newton
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
  % Release 14-05-2026.

  % controlli di consistenza
  if nargin < 3
      error('Numero di argomenti insufficiente.');
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

  xi = xi(:);
  a = fi(:);

  % calcolo in-place delle differenze divise
  for j = 2:n
      for i = n:-1:j
          a(i) = (a(i) - a(i - 1)) / (xi(i) - xi(i - j + 1));
      end
  end

  % valutazione con Horner modificato per la base di Newton
  y = a(n) * ones(size(x));

  for i = n-1:-1:1
      y = y .* (x - xi(i)) + a(i);
  end

  end
  ```

  Il calcolo delle differenze divise richiede $O(n^2)$ operazioni, mentre la valutazione in $m$ punti richiede $O(m n)$. Rispetto alla forma di Lagrange, quella di Newton è più comoda quando si aggiungono nodi, perché basta calcolare le nuove differenze divise.
]
