#import "../conf.typ": esercizio

#esercizio(
  "8",
  [Scrivere una function che implementi efficientemente la risoluzione di un sistema lineare mediante la fattorizzazione $L U$ con pivoting parziale. Validare la function su alcuni esempi significativi.],
)[

  ```matlab
  function x = LUSolve(A, b)
  % Function x = LUSolve(A, b)
  %
  % Risolve un sistema lineare Ax = b mediante fattorizzazione LU con pivoting
  % parziale. La funzione implementa l'algoritmo di decomposizione PA = LU in-place
  % e risolve i sistemi triangolari risultanti.
  %
  % Input:
  %   A - matrice quadrata dei coefficienti (n x n);
  %   b - vettore dei termini noti (n x 1).
  %
  % Output:
  %   x - vettore soluzione del sistema (n x 1).

  [n, m] = size(A);
  if n ~= m
      error('LUSolve: Matrice non quadrata.');
  end
  if length(b) ~= n
      error('LUSolve: Dimensioni incompatibili tra A e b.');
  end

  b = b(:);   % forza b come vettore colonna
  p = (1:n)'; % inizializzazione vettore di permutazione

  % fattorizzazione LU con pivoting parziale (in place su A)
  for k = 1:n-1
      % ricerca del pivot massimo nella colonna k (da riga k a n)
      [pivot_val, relative_idx] = max(abs(A(k:n, k)));
      pivot_idx = relative_idx + k - 1;

      if pivot_val == 0
          error('LUSolve: Matrice singolare incontrata alla colonna %d.', k);
      end

      % scambio delle righe in A e nel vettore di permutazione p
      if pivot_idx ~= k
          A([k, pivot_idx], :) = A([pivot_idx, k], :);
          p([k, pivot_idx]) = p([pivot_idx, k]);
      end

      % calcolo dei moltiplicatori (colonna k, righe k+1 a n)
      % questi elementi costituiscono la parte triangolare inferiore L (esclusa diag)
      A(k+1:n, k) = A(k+1:n, k) / A(k, k);

      % aggiornamento della sottomatrice (operazione di rango 1)
      A(k+1:n, k+1:n) = A(k+1:n, k+1:n) - A(k+1:n, k) * A(k, k+1:n);
  end

  % controllo singolarità ultimo elemento (non catturato dal ciclo)
  if A(n, n) == 0
      error('LUSolve: Matrice singolare (elemento diagonale nullo in posizione %d,%d).', n, n);
  end

  % risoluzione dei sistemi triangolari
  % inizializzazione x con il termine noto permutato (Pb)
  x = b(p);

  % sostituzione in avanti (Ly = Pb)
  % L ha diagonale unitaria. Gli elementi L(i,j) sono in A(i,j) con i > j.
  for k = 1:n-1
      x(k+1:n) = x(k+1:n) - A(k+1:n, k) * x(k);
  end

  % sostituzione all'indietro (Ux = y)
  % U ha diagonale generale. Gli elementi U(i,j) sono in A(i,j) con i <= j.
  for k = n:-1:1
      x(k) = x(k) / A(k, k);
      x(1:k-1) = x(1:k-1) - A(1:k-1, k) * x(k);
  end

  end
  ```

  L'implementazione proposta è efficiente in quanto:
  1. Esegue la fattorizzazione "in place", sovrascrivendo la matrice $A$ originale con i moltiplicatori di $L$ e i coefficienti di $U$.
  2. Utilizza operazioni vettorializzate di Matlab per l'aggiornamento della sottomatrice.
  3. Risolve il sistema lineare $A x = b$ mediante la successione di due sistemi triangolari diretti (sostituzione in avanti e all'indietro) sfruttando la matrice fattorizzata senza allocare memoria aggiuntiva per $L$ e $U$.

  === Validazione e Risultati

  La function è stata validata confrontando la soluzione ottenuta con quella fornita dall'operatore `\` di Matlab (`mldivide`) su diverse tipologie di matrici.

  - *Matrice 3x3*: Utilizzando $A = [1, 2, 3; 2, 1, 1; 1, 3, 2]$ e $b = [1; 2; 3]$, l'errore normato della soluzione rispetto a quella di riferimento è nullo (nell'ordine di $10^{-16}$).
  - *Matrice casuale (n=100)*: Su una matrice con elementi estratti da una distribuzione uniforme, la norma del residuo della soluzione $||x - x_{"ref"}||$ si attesta su $10^{-14}$.
  - *Matrice di Hilbert (n=8)*: Nonostante l'elevato numero di condizionamento ($K(H_8) approx 1.5 dot 10^{10}$), la function produce una soluzione accurata con un errore di circa $10^{-13}$ rispetto alla soluzione di riferimento, confermando la bontà dell'approccio con pivoting.
]
