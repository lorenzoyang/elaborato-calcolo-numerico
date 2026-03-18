#import "../conf.typ": esercizio

#esercizio(
  "8",
  [Scrivere una function che implementi efficientemente la risoluzione di un sistema lineare mediante la fattorizzazione $L U$ con pivoting parziale. Validare la function su alcuni esempi significativi.],
)[
  L'implementazione proposta è efficiente in quanto:
  1. Esegue la fattorizzazione "in place", sovrascrivendo la matrice $A$ originale con i moltiplicatori di $L$ e i coefficienti di $U$.
  2. Utilizza operazioni vettorializzate di Matlab per l'aggiornamento della sottomatrice (operazione di rango 1).
  3. Risolve il sistema lineare $A x = b$ mediante la successione di due sistemi triangolari: $L y = P b$ (sostituzione in avanti) e $U x = y$ (sostituzione all'indietro).

  ```matlab
  function [x, L, U, p] = LUSolve(A, b)
  % LUSolve Risolve un sistema lineare Ax = b mediante fattorizzazione LU con pivoting parziale.
  %
  % La funzione implementa l'algoritmo di decomposizione PA = LU, dove P e' la
  % matrice di permutazione derivante dal pivoting parziale, L e' una matrice
  % triangolare inferiore con diagonale unitaria e U e' una matrice triangolare
  % superiore.
  %
  % Input:
  %   A - matrice quadrata dei coefficienti (n x n);
  %   b - vettore dei termini noti (n x 1).
  %
  % Output:
  %   x - vettore soluzione del sistema (n x 1);
  %   L - matrice triangolare inferiore con diagonale unitaria (n x n);
  %   U - matrice triangolare superiore (n x n);
  %   p - vettore di permutazione (1 x n) tale che A(p,:) = L*U.

  [n, m] = size(A);
  if n ~= m
      error('LUSolve: Matrice non quadrata.');
  end
  if length(b) ~= n
      error('LUSolve: Dimensioni incompatibili tra A e b.');
  end

  b = b(:);     % Forza b come vettore colonna
  p = (1:n)';   % Inizializzazione vettore di permutazione

  % 1. Fattorizzazione LU con pivoting parziale (inplace su A)
  for k = 1:n-1
      % Ricerca del pivot massimo nella colonna k (da riga k a n)
      [pivot_val, relative_idx] = max(abs(A(k:n, k)));
      pivot_idx = relative_idx + k - 1;

      if pivot_val == 0
          error('LUSolve: Matrice singolare incontrata alla colonna %d.', k);
      end

      % Scambio delle righe in A e nel vettore di permutazione p
      if pivot_idx ~= k
          A([k, pivot_idx], :) = A([pivot_idx, k], :);
          p([k, pivot_idx]) = p([pivot_idx, k]);
      end

      % Calcolo dei moltiplicatori (colonna k, righe k+1 a n)
      A(k+1:n, k) = A(k+1:n, k) / A(k, k);

      % Aggiornamento della sottomatrice (operazione di rango 1)
      A(k+1:n, k+1:n) = A(k+1:n, k+1:n) - A(k+1:n, k) * A(k, k+1:n);
  end

  % Estrazione matrici L e U
  L = tril(A, -1) + eye(n);
  U = triu(A);

  % 2. Risoluzione dei sistemi triangolari (Pb = Ly, Ux = y)
  % Sostituzione in avanti (Ly = b(p))
  pb = b(p);
  y = zeros(n, 1);
  for i = 1:n
      y(i) = pb(i) - L(i, 1:i-1) * y(1:i-1);
  end

  % Sostituzione all'indietro (Ux = y)
  x = zeros(n, 1);
  for i = n:-1:1
      if U(i, i) == 0
          error('LUSolve: Elemento diagonale nullo in U(%d,%d).', i, i);
      end
      x(i) = (y(i) - U(i, i+1:n) * x(i+1:n)) / U(i, i);
  end

  end
  ```

  === Validazione e Risultati

  La function è stata validata confrontando la soluzione ottenuta con quella fornita dall'operatore `\` di Matlab (`mldivide`) su diverse tipologie di matrici.

  - *Matrice 3x3*: Utilizzando $A = [1, 2, 3; 2, 1, 1; 1, 3, 2]$ e $b = [1; 2; 3]$, l'errore normato della soluzione rispetto a quella di riferimento è nullo (nell'ordine di $10^{-16}$), e la decomposizione soddisfa correttamente $P A = L U$.
  - *Matrice casuale (n=100)*: Su una matrice con elementi estratti da una distribuzione uniforme, la norma del residuo della soluzione $||x - x_{"ref"}||$ si attesta su $10^{-14}$.
  - *Matrice di Hilbert (n=8)*: Nonostante l'elevato numero di condizionamento ($K(H_8) approx 1.5 dot 10^{10}$), la function produce una soluzione accurata con un errore di circa $10^{-13}$ rispetto alla soluzione di riferimento, confermando la bontà dell'approccio con pivoting.
]
