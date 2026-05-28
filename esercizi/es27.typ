#import "../conf.typ": esercizio, rimando, tabella_risultati

#esercizio(
  "27",
  [
    Costruire una function MATLAB,

    ```matlab
    ci = ncotes( n )
    ```

    che calcoli i coefficienti della formula di Newton-Cotes di grado $n$. Costruire una tabella con tutti i coefficienti delle formule ammissibili per ragioni di condizionamento. I coefficienti della tabella devono essere riportati come numeri razionali.
  ],
)[
  Per la formula chiusa di Newton-Cotes si prendono i nodi
  $x_i = a + i h$, con $i = 0, ..., n$ e $h = (b - a) / n$. Scrivendo
  $x = a + h t$, i coefficienti sono
  $
    c_i = integral_0^n L_i(t) dif t,
    quad
    L_i(t) = product_(j = 0, j != i)^n (t - j) / (i - j),
  $
  e la formula assume la forma
  $
    I_n(f) = h sum_(i = 0)^n c_i f(x_i).
  $
  Quindi è sufficiente costruire il polinomio fondamentale di Lagrange
  relativo al nodo $i$ e integrarlo esattamente.

  ```matlab
  function ci = ncotes(n)
  % Function ci = ncotes(n)
  %
  % Calcola i coefficienti della formula chiusa di Newton-Cotes
  % di grado n sui nodi equidistanti 0, 1, ..., n.
  %
  % La formula risultante e'
  %
  %   I_n(f) = h * sum_{i=0}^n ci(i+1) * f(x_i),
  %
  % dove x_i = a + i*h e h = (b-a)/n.
  %
  % Input:
  %   n  - grado della formula di Newton-Cotes.
  %
  % Output:
  %   ci - vettore colonna dei coefficienti della formula.
  %
  % Release 20-05-2026.

  % controlli di consistenza
  if nargin < 1
      error('Numero di argomenti insufficiente.');
  end

  if ~isscalar(n) || n ~= fix(n) || n < 1
      error('Il grado n deve essere un intero positivo.');
  end

  ci = zeros(n + 1, 1);

  % Il coefficiente ci(i+1) e' l'integrale su [0,n] del polinomio
  % fondamentale di Lagrange relativo al nodo i.
  for i = 0:n
      ind = [0:i-1 i+1:n];

      den = prod(i - ind);
      p = poly(ind);

      pint = [p ./ (n + 1:-1:1), 0];
      ci(i + 1) = polyval(pint, n) / den;
  end

  end
  ```

  Il condizionamento della formula discreta è governato da
  $h sum_i |c_i|$. Poiché $sum_i c_i = n$, se tutti i coefficienti sono
  non negativi il numero di condizionamento discreto coincide con quello
  del problema continuo; altrimenti peggiora. Come indicato nelle dispense,
  i gradi ammissibili sono dunque $n = 1, ..., 7$ e $n = 9$.

  #tabella_risultati(
    caption: [Coefficienti $c_i$ tali che $I_n(f) = h sum_i c_i f(x_i)$, scritti singolarmente come frazioni.],
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    [*$n$*],
    [*$c_0, ..., c_n$*],
    [$1$],
    [$1 / 2, 1 / 2$],
    [$2$],
    [$1 / 3, 4 / 3, 1 / 3$],
    [$3$],
    [$3 / 8, 9 / 8, 9 / 8, 3 / 8$],
    [$4$],
    [$14 / 45, 64 / 45, 8 / 15, 64 / 45, 14 / 45$],
    [$5$],
    [
      $95 / 288, 125 / 96, 125 / 144,$ \
      $125 / 144, 125 / 96, 95 / 288$
    ],
    [$6$],
    [
      $41 / 140, 54 / 35, 27 / 140, 68 / 35,$ \
      $27 / 140, 54 / 35, 41 / 140$
    ],
    [$7$],
    [
      $5257 / 17280, 25039 / 17280, 343 / 640, 20923 / 17280,$ \
      $20923 / 17280, 343 / 640, 25039 / 17280, 5257 / 17280$
    ],
    [$9$],
    [
      $25713 / 89600, 141669 / 89600, 243 / 2240,$ \
      $10881 / 5600, 26001 / 44800, 26001 / 44800,$ \
      $10881 / 5600, 243 / 2240, 141669 / 89600, 25713 / 89600$
    ],
  )

  Il grado $8$ non compare nella tabella perché produce coefficienti
  negativi e quindi una formula peggio condizionata rispetto all'integrale continuo.
]
