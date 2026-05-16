#import "../conf.typ": esercizio, rimando, tabella_risultati

#esercizio(
  "27",
  [
    Costruire una function Matlab,

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
  % Rel. 20-05-2026.

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
    caption: [Coefficienti $c_i$ tali che $I_n(f) = h sum_i c_i f(x_i)$.],
    columns: (auto, 1fr),
    align: (center + horizon, center + horizon),
    [*$n$*],
    [*$c_0, ..., c_n$*],
    [$1$],
    [$1 / 2 (1, 1)$],
    [$2$],
    [$1 / 3 (1, 4, 1)$],
    [$3$],
    [$3 / 8 (1, 3, 3, 1)$],
    [$4$],
    [$1 / 45 (14, 64, 24, 64, 14)$],
    [$5$],
    [$1 / 288 (95, 375, 250, 250, 375, 95)$],
    [$6$],
    [$1 / 140 (41, 216, 27, 272, 27, 216, 41)$],
    [$7$],
    [$1 / 17280 (5257, 25039, 9261, 20923, 20923, 9261, 25039, 5257)$],
    [$9$],
    [$1 / 89600 (25713, 141669, 9720, 174096, 52002, 52002, 174096, 9720, 141669, 25713)$],
  )

  Il grado $8$ non compare nella tabella perché produce coefficienti
  negativi e quindi una formula peggio condizionata rispetto all'integrale continuo.
]
