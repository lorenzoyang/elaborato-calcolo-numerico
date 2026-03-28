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

  Successivamente si riportano i risultati di alcuni esempi significativi di applicazione della funzione, volti a verificarne l'accuratezza e la robustezza nella gestione degli errori:

  + *Matrice simmetrica e definita positiva (caso ideale)*: generando una matrice s.d.p. casuale (ad esempio ponendo $A = X^T X$ con $X$ matrice quadrata non singolare generata con `rand`) e un vettore termine noto $b$, il vettore soluzione calcolato risulta del tutto accurato. L'errore relativo rispetto alla soluzione esatta (ottenuta tramite l'operatore `\` di MATLAB) risulta trascurabile e dell'ordine della precisione di macchina (circa $10^{-16}$).

  + *Matrice non definita positiva (gestione errori)*: e' stato testato un sistema con una matrice simmetrica ma non definita positiva (ad esempio con elementi negativi sulla diagonale). L'algoritmo identifica prontamente l'anomalia durante il calcolo dell'elemento diagonale del fattore $D$, interrompendo l'esecuzione e restituendo correttamente il messaggio di errore previsto: `La matrice A non è definita positiva`.

  + *Matrice non simmetrica (Gestione Errori)*: fornendo in input una matrice $A$ tale per cui $A != A^T$, il controllo preventivo all'inizio della funzione basato sulla norma infinito rileva immediatamente la discrepanza strutturale. L'algoritmo si blocca segnalando tempestivamente `La matrice A deve essere simmetrica`, prevenendo così operazioni aritmetiche prive di senso per questo specifico metodo.

  #rimando[Lo script MATLAB utilizzato per la validazione della funzione `LDLSolve` è `test_ldlsolve.m`]
]
