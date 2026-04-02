#import "../conf.typ": esercizio, rimando, tabella_risultati

#esercizio(
  "8",
  [Scrivere una function che implementi efficientemente la risoluzione di un sistema lineare mediante la fattorizzazione $L U$ con pivoting parziale. Validare la function su alcuni esempi significativi.],
)[
  Di seguito viene riportata l'implementazione della function `LUSolve`, che realizza la fattorizzazione con pivoting parziale nella forma $P A = L U$ e memorizza i coefficienti in-place, così da ottimizzare l'uso della memoria. In particolare, nella parte strettamente inferiore di `A` vengono conservati i moltiplicatori di `L`, mentre nella parte triangolare superiore restano i coefficienti di `U`.

  ```matlab
  function x = LUSolve(A, b)
  % Function x = LUSolve(A, b)
  %
  % Risolve un sistema lineare A*x = b di ordine n usando la
  % fattorizzazione LU con pivoting parziale.
  %
  % Input:
  %   A - matrice dei coefficienti nxn;
  %   b - vettore dei termini noti nx1.
  %
  % Output:
  %   x - vettore soluzione del sistema nx1.
  %
  % Rel. 08-03-2026.

  [m, n] = size(A);

  % controlli di consistenza
  if m ~= n
      error('La matrice A deve essere quadrata.');
  end

  if length(b) ~= n
      error('Dimensioni incompatibili tra A e b.');
  end

  % normalizzazione di b a vettore colonna
  b = b(:);

  % fattorizzazione LU con pivoting parziale (in-place)
  p = 1:n;
  tol = n * eps * norm(A, 1);

  for i = 1:n
      % ricerca del pivot sulla colonna i
      [mi, ki] = max(abs(A(i:n, i)));
      ki = ki + i - 1;

      if mi <= tol
          error('Matrice singolare o quasi singolare.');
      end

      % scambio righe se necessario
      if ki > i
          A([i, ki], :) = A([ki, i], :);
          p([i, ki]) = p([ki, i]);
      end

      % eliminazione gaussiana
      if i < n
          A(i+1:n, i) = A(i+1:n, i) / A(i, i);
          A(i+1:n, i+1:n) = A(i+1:n, i+1:n) - A(i+1:n, i) * A(i, i+1:n);
      end
  end

  % risoluzione sistema PAx = Pb -> LUx = Pb
  % risoluzione Ly = Pb (forward substitution)
  y = b(p);
  for i = 1:n-1
      y(i+1:n) = y(i+1:n) - A(i+1:n, i) * y(i);
  end

  % risoluzione Ux = y (backward substitution)
  x = y;
  for i = n:-1:1
      x(i) = x(i) / A(i, i);
      x(1:i-1) = x(1:i-1) - A(1:i-1, i) * x(i);
  end

  end
  ```
  Una volta costruita la fattorizzazione, la soluzione del sistema si ottiene risolvendo in successione i due sistemi triangolari associati a `L` e `U`. Successivamente si riportano i risultati di alcuni esempi significativi di applicazione della funzione:

  + *Sistema ben condizionato*: Risolvendo un sistema quadrato non singolare di base, il vettore $x$ calcolato coincide con la soluzione restituita da MATLAB tramite l'operatore `\`. L'errore osservato risulta quindi trascurabile e dell'ordine della precisione di macchina.

  + *Sistema che richiede pivoting*: Si è testato un sistema in cui l'elemento in posizione $(1,1)$ è nullo. Senza il pivoting l'algoritmo fallirebbe per divisione per zero, mentre la funzione seleziona correttamente il pivot di modulo massimo nella colonna corrente, esegue le permutazioni necessarie e calcola una soluzione coincidente con quella di MATLAB.

  + *Matrice singolare (Gestione Errori)*: Testata con una matrice avente righe linearmente dipendenti (es. la seconda riga è un multiplo della prima). Il controllo sul pivot, confrontato con la soglia di tolleranza introdotta nel codice, individua il problema e la funzione si interrompe restituendo correttamente l'errore `"Matrice singolare o quasi singolare."`.

  #rimando[Per eseguire i test empirici e riprodurre i risultati riportati, si faccia riferimento allo script MATLAB allegato denominato `test_lusolve.m`.]

]
