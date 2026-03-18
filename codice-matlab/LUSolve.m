function [x, L, U, p] = LUSolve(A, b)
% Function [x, L, U, p] = LUSolve(A, b)
%
% Risolve un sistema lineare Ax = b mediante fattorizzazione LU con 
% pivoting parziale. La funzione implementa l'algoritmo di decomposizione 
% PA = LU, dove P e' la matrice di permutazione derivante dal pivoting parziale, 
% L e' una matrice triangolare inferiore con diagonale unitaria e 
% U e' una matrice triangolare superiore.
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
    A(k+1:n, k) = A(k+1:n, k) / A(k, k);

    % aggiornamento della sottomatrice (operazione di rango 1)
    A(k+1:n, k+1:n) = A(k+1:n, k+1:n) - A(k+1:n, k) * A(k, k+1:n);
end

% estrazione matrici L e U
L = tril(A, -1) + eye(n);
U = triu(A);

% risoluzione dei sistemi triangolari (Pb = Ly, Ux = y)
% sostituzione in avanti (Ly = b(p))
pb = b(p);
y = zeros(n, 1);
for i = 1:n
    y(i) = pb(i) - L(i, 1:i-1) * y(1:i-1);
end

% sostituzione all'indietro (Ux = y)
x = zeros(n, 1);
for i = n:-1:1
    if U(i, i) == 0
        error('LUSolve: Elemento diagonale nullo in U(%d,%d).', i, i);
    end
    x(i) = (y(i) - U(i, i+1:n) * x(i+1:n)) / U(i, i);
end

end
