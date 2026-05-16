#import "../conf.typ": esercizio, rimando

#esercizio(
  "24",
  [
    Utilizzando la function del precedente esercizio 22, scrivere la function Matlab,

    ```matlab
    y = spline3( xi, fi, x, type, f1a, f1b )
    ```

    in cui `(xi, fi)` sono i dati di interpolazione e `x` è un vettore (riga o colonna), contenente i punti in cui valutare la spline cubica interpolante, restituiti nel vettore `y`, che avrà le stesse dimensioni di `x`. Infine, `type` è un flag che vale 1 (valore di default) per la spline cubica not-a-knot, 0 per quella naturale, 2 per la spline cubica completa. In quest'ultimo caso, gli ultimi due parametri di ingresso (opzionali) contengono il valore della derivata della funzione interpolante negli estremi.
  ],
)[
  Si cercano prima i valori delle derivate seconde nodali
  $
    m_i = s''(xi_i)
  $
  nei nodi. Una volta noti questi valori, su ciascun intervallo
  $[xi_i, xi_(i + 1)]$ la spline si valuta con la formula
  $
    s(x) =
    m_i (xi_(i + 1) - x)^3 / (6 h_i)
    + m_(i + 1) (x - xi_i)^3 / (6 h_i)
    + (f_i / h_i - m_i h_i / 6)(xi_(i + 1) - x)
    + (f_(i + 1) / h_i - m_(i + 1) h_i / 6)(x - xi_i),
  $
  dove $h_i = xi_(i + 1) - xi_i$.

  Le equazioni interne:
  $
    phi_i m_(i - 1) + 2 m_i + eta_i m_(i + 1)
    =
    6 (f[x_i, x_(i + 1)] - f[x_(i - 1), x_i]) /
    (h_(i - 1) + h_i),
  $
  con
  $
    phi_i = h_(i - 1) / (h_(i - 1) + h_i),
    quad
    eta_i = h_i / (h_(i - 1) + h_i).
  $
  Le condizioni di bordo cambiano in base al valore di `type`: per la spline
  naturale si impone $m_0 = m_n = 0$, per quella completa si usano le derivate
  assegnate agli estremi, mentre per la not-a-knot si impone la continuita'
  della derivata terza nel primo e nell'ultimo nodo interno.

  ```matlab
  function y = spline3(xi, fi, x, type, f1a, f1b)
  % Function y = spline3(xi, fi, x, type, f1a, f1b)
  %
  % Valuta la spline cubica interpolante associata ai dati (xi, fi)
  % nei punti contenuti nel vettore x.
  %
  % Input:
  %   xi   - vettore delle ascisse di interpolazione;
  %   fi   - vettore dei valori della funzione nelle ascisse xi;
  %   x    - vettore dei punti di valutazione;
  %   type - tipo di spline:
  %          0 naturale, 1 not-a-knot, 2 completa.
  %   f1a  - derivata prima nell'estremo sinistro, per type = 2;
  %   f1b  - derivata prima nell'estremo destro, per type = 2.
  %
  % Output:
  %   y    - valori della spline nei punti x, con le stesse dimensioni di x.
  %
  % Rel. 18-05-2026.

  % controlli di consistenza
  if nargin < 3
      error('Numero di argomenti insufficiente.');
  end

  if nargin < 4 || isempty(type)
      type = 1;
  end

  if ~isscalar(type) || ~ismember(type, [0 1 2])
      error('Il parametro type deve valere 0, 1 oppure 2.');
  end

  n = length(xi);

  if length(fi) ~= n
      error('Dimensioni incompatibili tra xi e fi.');
  end

  if n < 2
      error('Servono almeno due ascisse di interpolazione.');
  end

  if length(unique(xi)) ~= n
      error('Le ascisse di interpolazione devono essere distinte.');
  end

  % uso vettori colonna per trattare allo stesso modo input riga o colonna
  xi = xi(:);
  fi = fi(:);

  h = diff(xi);

  if any(h <= 0)
      error('Le ascisse xi devono essere strettamente crescenti.');
  end

  d = diff(fi) ./ h;

  % calcolo delle derivate seconde nodali m(i) = s''(xi(i))
  switch type
      case 0
          m = spline_naturale(h, d, n);

      case 1
          if n < 4
              error('La spline not-a-knot richiede almeno quattro ascisse.');
          end

          m = spline_notaknot(h, d, n);

      case 2
          if nargin < 6
              error('Per la spline completa servono f1a e f1b.');
          end

          m = spline_completa(h, d, n, f1a, f1b);
  end

  % lavoro sui punti di valutazione come vettore colonna
  xx = x(:);

  % ind(k) indica il tratto [xi(ind(k)), xi(ind(k)+1)] che contiene xx(k)
  [~, ind] = histc(xx, xi);

  % xx < xi(1) e xx >= xi(n) sono vettori logici: selezionano in ind
  % solo le posizioni dei punti esterni, da valutare col primo o ultimo tratto
  ind(xx < xi(1)) = 1;
  ind(xx >= xi(n)) = n - 1;
  ind(ind == 0) = 1;

  hi = h(ind);
  sinistra = xi(ind + 1) - xx;
  destra = xx - xi(ind);

  % valutazione della formula locale della spline cubica
  yy = m(ind) .* sinistra .^ 3 ./ (6 * hi) ...
      + m(ind + 1) .* destra .^ 3 ./ (6 * hi) ...
      + (fi(ind) ./ hi - m(ind) .* hi / 6) .* sinistra ...
      + (fi(ind + 1) ./ hi - m(ind + 1) .* hi / 6) .* destra;

  % ripristino la stessa forma di x: riga se x era riga, colonna se era colonna
  y = reshape(yy, size(x));

  end

  function m = spline_naturale(h, d, n)

  b = zeros(n, 1);
  a = zeros(n, 1);
  c = zeros(n, 1);
  rhs = zeros(n, 1);

  a(1) = 1;
  a(n) = 1;

  for i = 2:n-1
      den = h(i - 1) + h(i);
      b(i) = h(i - 1) / den;
      a(i) = 2;
      c(i) = h(i) / den;
      rhs(i) = 6 * (d(i) - d(i - 1)) / den;
  end

  m = tridia(b, a, c, rhs);

  end

  function m = spline_completa(h, d, n, f1a, f1b)

  b = zeros(n, 1);
  a = zeros(n, 1);
  c = zeros(n, 1);
  rhs = zeros(n, 1);

  a(1) = 2;
  c(1) = 1;
  rhs(1) = 6 * (d(1) - f1a) / h(1);

  for i = 2:n-1
      den = h(i - 1) + h(i);
      b(i) = h(i - 1) / den;
      a(i) = 2;
      c(i) = h(i) / den;
      rhs(i) = 6 * (d(i) - d(i - 1)) / den;
  end

  b(n) = 1;
  a(n) = 2;
  rhs(n) = 6 * (f1b - d(n - 1)) / h(n - 1);

  m = tridia(b, a, c, rhs);

  end

  function m = spline_notaknot(h, d, n)

  N = n - 2;
  b = zeros(N, 1);
  a = zeros(N, 1);
  c = zeros(N, 1);
  rhs = zeros(N, 1);

  for j = 1:N
      i = j + 1;
      den = h(i - 1) + h(i);
      rhs(j) = 6 * (d(i) - d(i - 1)) / den;

      if j == 1
          a(j) = 2 + h(1) / h(2);
          c(j) = (h(2) - h(1)) / h(2);
      elseif j == N
          b(j) = (h(n - 2) - h(n - 1)) / h(n - 2);
          a(j) = 2 + h(n - 1) / h(n - 2);
      else
          b(j) = h(i - 1) / den;
          a(j) = 2;
          c(j) = h(i) / den;
      end
  end

  u = tridia(b, a, c, rhs);

  m = zeros(n, 1);
  m(2:n-1) = u;
  m(1) = (h(1) + h(2)) / h(2) * m(2) - h(1) / h(2) * m(3);
  m(n) = (h(n - 2) + h(n - 1)) / h(n - 2) * m(n - 1) ...
      - h(n - 1) / h(n - 2) * m(n - 2);

  end
  ```

  La function costruisce solo il sistema tridiagonale necessario per le
  derivate seconde nodali e lo risolve con `tridia`, come richiesto
  dall'esercizio. La valutazione finale usa poi direttamente la formula locale
  della spline, preservando la forma del vettore `x` anche quando e' un
  vettore riga.

]
