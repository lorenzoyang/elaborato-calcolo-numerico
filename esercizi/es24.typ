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
  Indichiamo con $m_i = s''(x_i)$ le derivate seconde della spline nei nodi e
  poniamo
  $
    h_i = x_(i + 1) - x_i,
    quad
    d_i = (f_(i + 1) - f_i) / h_i,
    quad i = 0, ..., n - 1.
  $
  Una volta calcolati i valori $m_i$, su $[x_i, x_(i + 1)]$ si valuta la
  spline con la formula
  $
    s_i(x) =
      m_i (x_(i + 1) - x)^3 / (6 h_i)
      + m_(i + 1) (x - x_i)^3 / (6 h_i)
      + (f_i / h_i - m_i h_i / 6)(x_(i + 1) - x)
      + (f_(i + 1) / h_i - m_(i + 1) h_i / 6)(x - x_i).
  $
  Le equazioni interne sono quelle dell'esercizio precedente:
  $
    h_(i - 1) m_(i - 1) + 2(h_(i - 1) + h_i) m_i + h_i m_(i + 1)
    =
    6(d_i - d_(i - 1)),
    quad i = 1, ..., n - 1.
  $
  Alle due estremita' si aggiungono le condizioni richieste: $m_0 = m_n = 0$
  per la naturale, le due condizioni su $s'$ per la completa e la continuita'
  di $s'''$ nei nodi $x_1$ e $x_(n - 1)$ per la not-a-knot. In quest'ultimo
  caso il codice elimina $m_0$ e $m_n$, cosi' il sistema risolto resta
  tridiagonale e puo' essere trattato con `tridia`.

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
  %          0 naturale, 1 not-a-knot (default), 2 completa;
  %   f1a  - derivata prima nell'estremo sinistro, se type = 2;
  %   f1b  - derivata prima nell'estremo destro, se type = 2.
  %
  % Output:
  %   y    - valori della spline nei punti x, con le stesse dimensioni di x.
  %
  % Rel. 15-05-2026.

  % gestione degli argomenti di input e valori di default
  if nargin < 3
      error('Numero di argomenti insufficiente.');
  end

  if nargin < 4 || isempty(type)
      type = 1;
  end

  if type ~= 0 && type ~= 1 && type ~= 2
      error('Tipo di spline non valido.');
  end

  n = length(xi);

  if length(fi) ~= n
      error('Dimensioni incompatibili tra xi e fi.');
  end

  if n < 2
      error('Servono almeno due nodi di interpolazione.');
  end

  xi = xi(:);
  fi = fi(:);

  if any(diff(xi) <= 0)
      error('Le ascisse di interpolazione devono essere strettamente crescenti.');
  end

  if type == 2 && nargin < 6
      error('Per la spline completa servono f1a e f1b.');
  end

  h = diff(xi);
  d = diff(fi) ./ h;
  m = zeros(n, 1);

  % costruzione e soluzione del sistema per le derivate seconde m_i
  switch type
      case 0
          % spline naturale: m_0 = m_n = 0
          if n > 2
              b = zeros(n, 1);
              a = zeros(n, 1);
              c = zeros(n, 1);
              rhs = zeros(n, 1);

              a(1) = 1;
              a(n) = 1;

              for i = 2:n-1
                  b(i) = h(i - 1);
                  a(i) = 2 * (h(i - 1) + h(i));
                  c(i) = h(i);
                  rhs(i) = 6 * (d(i) - d(i - 1));
              end

              m = tridia(b, a, c, rhs);
          end

      case 1
          % spline not-a-knot
          if n == 2
              m(:) = 0;
          elseif n == 3
              m(:) = 2 * (d(2) - d(1)) / (xi(3) - xi(1));
          else
              ni = n - 2; % numero di nodi interni
              b = zeros(ni, 1);
              a = zeros(ni, 1);
              c = zeros(ni, 1);
              rhs = zeros(ni, 1);

              a(1) = (h(1) + h(2)) * (h(1) + 2 * h(2)) / h(2);
              c(1) = (h(2)^2 - h(1)^2) / h(2);
              rhs(1) = 6 * (d(2) - d(1));

              for i = 2:ni-1
                  b(i) = h(i);
                  a(i) = 2 * (h(i) + h(i + 1));
                  c(i) = h(i + 1);
                  rhs(i) = 6 * (d(i + 1) - d(i));
              end

              b(ni) = (h(end - 1)^2 - h(end)^2) / h(end - 1);
              a(ni) = (h(end - 1) + h(end)) ...
                  * (2 * h(end - 1) + h(end)) / h(end - 1);
              rhs(ni) = 6 * (d(end) - d(end - 1));

              m(2:n-1) = tridia(b, a, c, rhs);
              m(1) = (1 + h(1) / h(2)) * m(2) - h(1) / h(2) * m(3);
              m(n) = (1 + h(end) / h(end - 1)) * m(n - 1) ...
                  - h(end) / h(end - 1) * m(n - 2);
          end

      case 2
          % spline completa: sono assegnate le derivate agli estremi
          b = zeros(n, 1);
          a = zeros(n, 1);
          c = zeros(n, 1);
          rhs = zeros(n, 1);

          a(1) = 2 * h(1);
          c(1) = h(1);
          rhs(1) = 6 * (d(1) - f1a);

          for i = 2:n-1
              b(i) = h(i - 1);
              a(i) = 2 * (h(i - 1) + h(i));
              c(i) = h(i);
              rhs(i) = 6 * (d(i) - d(i - 1));
          end

          b(n) = h(end);
          a(n) = 2 * h(end);
          rhs(n) = 6 * (f1b - d(end));

          m = tridia(b, a, c, rhs);
  end

  % valutazione della formula locale della spline
  if isempty(x)
      y = zeros(size(x));
      return;
  end

  intervallo = discretize(x, xi);

  if any(isnan(intervallo(:)))
      error('I punti di valutazione devono appartenere all''intervallo dei nodi.');
  end

  intervallo = intervallo(:);
  xx = x(:);

  hi = h(intervallo);
  xa = xi(intervallo);
  xb = xi(intervallo + 1);
  fa = fi(intervallo);
  fb = fi(intervallo + 1);
  ma = m(intervallo);
  mb = m(intervallo + 1);

  yy = ma .* (xb - xx) .^ 3 ./ (6 * hi) ...
      + mb .* (xx - xa) .^ 3 ./ (6 * hi) ...
      + (fa ./ hi - ma .* hi / 6) .* (xb - xx) ...
      + (fb ./ hi - mb .* hi / 6) .* (xx - xa);

  y = reshape(yy, size(x));

  end
  ```
]
