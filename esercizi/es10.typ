#import "../conf.typ": esercizio, nota, rimando, tabella_risultati

#esercizio(
  "10",
  [Scrivere una function che implementi efficientemente la risoluzione di un sistema lineare, con matrice sdp, mediante la fattorizzazione $L D L^T$. Validare la function su alcuni esempi significativi.],
)[
  Di seguito si riporta l'implementazione della funzione `LDLSolve`, che esegue la fattorizzazione in-place per massimizzare l'efficienza.

  ```matlab
  function x = LDLSolve(A, b)
  % Function x = LDLSolve(A, b)
  %
  % Risolve un sistema lineare Ax = b con A s.d.p.
  % mediante la fattorizzazione L D L^T.
  % La funzione implementa la fattorizzazione in-place, sovrascrivendo
  % la parte triangolare inferiore di A con il fattore L (parte strettamente
  % inferiore, essendo la diagonale unitaria) e la diagonale di A con
  % il fattore D.
  %
  % Input:
  %   A - matrice simmetrica e definita positiva nxn;
  %   b - vettore dei termini noti nx1.
  %
  % Output:
  %   x - vettore soluzione nx1.

  [m, n] = size(A);

  % controlli di consistenza
  if m ~= n || length(b) ~= n
      error('Dimensioni incompatibili o matrice non quadrata.');
  end

  % normalizzazione di b a vettore colonna
  b = b(:);

  % controllo simmetria
  if norm(A - A', 'inf') > 1e-12 * norm(A, 'inf')
      error('La matrice A deve essere simmetrica.');
  end

  % fattorizzazione L D L^T in-place
  d = zeros(n, 1);
  for j = 1:n
      % v_i = L_{ji} * D_{ii} per i = 1...j-1
      % (vettore vuoto per j=1, il prodotto seguente vale 0)
      v = A(j, 1:j-1)' .* d(1:j-1);

      % D_{jj} = A_{jj} - L_{j, 1:j-1} * v
      A(j, j) = A(j, j) - A(j, 1:j-1) * v;

      if A(j, j) <= 0
          error('La matrice A non è definita positiva (d_%d = %g).', j, A(j,j));
      end

      % salvataggio elemento diagonale nel vettore d
      d(j) = A(j, j);

      % L_{j+1:n, j} = (A_{j+1:n, j} - A_{j+1:n, 1:j-1} * v) / D_{jj}
      if j < n
          A(j+1:n, j) = (A(j+1:n, j) - A(j+1:n, 1:j-1) * v) / d(j);
      end
  end

  % risoluzione sistema L D L^T x = b

  % risoluzione L z = b (forward substitution)
  z = b;
  for j = 1:n-1
      z(j+1:n) = z(j+1:n) - A(j+1:n, j) * z(j);
  end

  % risoluzione D y = z (scaling)
  y = z ./ d;

  % risoluzione L^T x = y (backward substitution)
  x = y;
  for j = n:-1:2
      x(1:j-1) = x(1:j-1) - A(j, 1:j-1)' * x(j);
  end

  end
  ```

  === Validazione e risultati

  La funzione è stata validata utilizzando matrici sdp generate tramite `linsis(n, k, 1)` per $n=10$ e $k=1 dots 15$. I risultati mostrano un comportamento analogo a quello della fattorizzazione $L U$, con l'errore che cresce proporzionalmente al numero di condizionamento.

  #tabella_risultati(
    caption: [Risultati numerici per LDLSolve con matrici sdp.],
    columns: (auto, auto, auto),
    [*$k$*],
    [*$op("cond")(A, infinity)$*],
    [*Errore $||x - x_e||_infinity$*],
    [1],
    [1.71e+01],
    [5.55e-16],
    [5],
    [1.71e+05],
    [6.64e-12],
    [10],
    [1.60e+10],
    [5.73e-07],
    [15],
    [1.48e+15],
    [9.70e-03],
  )

  Come atteso, la fattorizzazione $L D L^T$ risulta stabile per matrici ben condizionate e decade man mano che il numero di condizionamento si avvicina a $1/epsilon_"mach"$. Rispetto alla fattorizzazione $L U$ con pivoting, il vantaggio principale risiede nel minor costo computazionale ($n^3/3$ operazioni anziché $2n^3/3$).

  #rimando[Lo script MATLAB per la validazione è `test_ldlsolve.m`.]
]
