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
% Rel. 16-05-2026.

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
