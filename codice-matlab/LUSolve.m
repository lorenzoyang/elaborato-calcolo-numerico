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
