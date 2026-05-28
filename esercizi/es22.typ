#import "../conf.typ": esercizio, rimando

#esercizio(
  "22",
  [
    Scrivere una function MATLAB,

    ```matlab
    x = tridia( b, a, c, y )
    ```

    che risolve un sistema tridiagonale, in cui `b`, `a`, `c` sono i vettori contenenti gli elementi sulle 3 diagonali, e `y` è un vettore contenente il termine noto.
  ],
)[
  Si considera il sistema tridiagonale nella forma:
  $
    b_i x_(i - 1) + a_i x_i + c_i x_(i + 1) = y_i,
    quad i = 1, ..., n,
  $
  con $b_1 = 0$ e $c_n = 0$. La risoluzione applica
  l'eliminazione gaussiana solo sulle tre diagonali, cioè una
  fattorizzazione $A = L U$ implicita. Così non si costruisce mai
  la matrice completa e il costo resta lineare in $n$.

  ```matlab
  function x = tridia(b, a, c, y)
  % Function x = tridia(b, a, c, y)
  %
  % Risolve un sistema lineare tridiagonale Ax = y di ordine n, dove
  % b, a, c contengono rispettivamente sottodiagonale, diagonale
  % principale e sopradiagonale:
  %
  %   b(i)*x(i-1) + a(i)*x(i) + c(i)*x(i+1) = y(i),
  %   i = 1, ..., n, con b(1) = 0 e c(n) = 0.
  %
  % Input:
  %   b - vettore della sottodiagonale;
  %   a - vettore della diagonale principale;
  %   c - vettore della sopradiagonale;
  %   y - vettore dei termini noti.
  %
  % Output:
  %   x - vettore soluzione del sistema.
  %
  % Release 17-05-2026.

  % controlli di consistenza
  if nargin < 4
      error('Numero di argomenti insufficiente.');
  end

  n = length(a);

  if length(b) ~= n || length(c) ~= n || length(y) ~= n
      error('Dimensioni incompatibili tra b, a, c e y.');
  end

  if n == 0
      error('Il sistema non puo'' essere vuoto.');
  end

  % normalizzazione a vettori colonna
  b = b(:);
  a = a(:);
  c = c(:);
  x = y(:);

  errore = 'Matrice non fattorizzabile senza pivoting.';

  if a(1) == 0
      error(errore);
  end

  % eliminazione in avanti: A = L*U, memorizzando i moltiplicatori in b
  for i = 2:n
      b(i) = b(i) / a(i - 1);
      a(i) = a(i) - b(i) * c(i - 1);

      if a(i) == 0
          error(errore);
      end

      x(i) = x(i) - b(i) * x(i - 1);
  end

  % sostituzione all'indietro sul sistema triangolare superiore
  x(n) = x(n) / a(n);

  for i = n-1:-1:1
      x(i) = (x(i) - c(i) * x(i + 1)) / a(i);
  end

  end
  ```

  L'algoritmo usa solo vettori di lunghezza $n$ e richiede $O(n)$ operazioni.
  Il controllo sui pivot nulli serve a intercettare i casi in cui la
  fattorizzazione senza pivoting non è possibile; in particolare, per matrici
  tridiagonali a diagonale dominante la fattorizzazione esiste.

  #rimando[File MATLAB: `tridia.m`.]
]
