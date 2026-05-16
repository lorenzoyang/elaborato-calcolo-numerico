#import "../conf.typ": esercizio, rimando

#esercizio(
  "28",
  [
    Costruire una function Matlab,

    ```matlab
    [Ikn,err] = ncotescomp( fx, a, b, k, n )
    ```

    che calcoli l'approssimazione dell'integrale della funzione `fx` sull'intervallo $[a,b]$, utilizzando la formula di Newton-Cotes di grado $k$ su $n + 1$ ascisse equidistanti, con $n$ multiplo pari di $k$, insieme ad una stima dell'errore di quadratura.
  ],
)[
  Siano
  $
    x_i = a + i h,
    quad
    h = (b - a) / n,
    quad
    i = 0, ..., n.
  $
  Se $n = k ell$, la formula composita si ottiene applicando la formula
  chiusa di Newton-Cotes di grado $k$ su ciascun blocco
  $[x_(j k), x_((j + 1) k)]$:
  $
    I_n^k(f)
    =
    h sum_(j = 0)^(ell - 1) sum_(i = 0)^k c_i
    f(x_(j k + i)).
  $
  I coefficienti $c_i$ sono quelli calcolati dalla function `ncotes`
  dell'esercizio precedente.

  La richiesta che $n$ sia un multiplo pari di $k$ serve per costruire,
  senza nuove valutazioni di funzione, anche la formula composita sui soli
  nodi di indice pari, cioe' con passo $2 h$. Indicando con $p$ l'ordine
  dell'errore della formula composita,
  $
    p = cases(
      k + 1, "se " k " e' dispari",
      k + 2, "se " k " e' pari",
    ),
  $
  si usa la stima
  $
    "err" approx |I_n^k(f) - I_(n / 2)^k(f)| / (2^p - 1).
  $
  Come nelle dispense e nell'esercizio 27, il codice accetta solo i gradi
  ammissibili per condizionamento: $k = 1, ..., 7$ e $k = 9$.

  ```matlab
  function [Ikn, err] = ncotescomp(fx, a, b, k, n)
  % Function [Ikn, err] = ncotescomp(fx, a, b, k, n)
  %
  % Calcola la formula composita di Newton-Cotes chiusa di grado k
  % sull'intervallo [a,b], usando n + 1 ascisse equidistanti.
  % Il parametro n deve essere un multiplo pari di k, cosi' da poter
  % costruire anche la formula sui soli nodi di indice pari.
  %
  % Input:
  %   fx - function handle della funzione integranda;
  %   a  - estremo sinistro dell'intervallo;
  %   b  - estremo destro dell'intervallo;
  %   k  - grado della formula elementare di Newton-Cotes;
  %   n  - numero di sottointervalli.
  %
  % Output:
  %   Ikn - approssimazione dell'integrale;
  %   err - stima dell'errore di quadratura.
  %
  % Rel. 16-05-2026.

  % controlli di consistenza
  if nargin < 5
      error('Numero di argomenti insufficiente.');
  end

  if a >= b
      error('L''intervallo [a, b] non e'' valido.');
  end

  if ~isscalar(k) || k ~= fix(k) || ~ismember(k, [1:7 9])
      error('Il grado k deve appartenere all''insieme [1:7 9].');
  end

  if ~isscalar(n) || n ~= fix(n) || n < k || ...
          mod(n, k) ~= 0 || mod(n / k, 2) ~= 0
      error('n deve essere un multiplo pari di k.');
  end

  ci = ncotes(k);
  h = (b - a) / n;
  x = linspace(a, b, n + 1);
  fi = zeros(n + 1, 1);

  for i = 1:n+1
      fi(i) = fx(x(i));
  end

  Ikn = formula_composita(fi, ci, h, k, n, 1);
  Icoarse = formula_composita(fi, ci, 2 * h, k, n, 2);

  if mod(k, 2) == 0
      p = k + 2;
  else
      p = k + 1;
  end

  err = abs(Ikn - Icoarse) / (2 ^ p - 1);

  end

  function I = formula_composita(fi, ci, h, k, n, passo)

  num_blocchi = n / (k * passo);
  I = 0;

  for j = 0:num_blocchi-1
      ind = j * k * passo + (0:k) * passo + 1;
      I = I + h * (ci.' * fi(ind));
  end

  end
  ```
]
