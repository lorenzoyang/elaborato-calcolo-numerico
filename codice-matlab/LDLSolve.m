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
%
% Rel. 14-03-2026.

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
