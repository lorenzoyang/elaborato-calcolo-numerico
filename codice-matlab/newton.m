function y = newton(xi, fi, x)
% Function y = newton(xi, fi, x)
%
% Valuta il polinomio interpolante nella forma di Newton
% associato ai dati (xi, fi) nei punti contenuti nel vettore x.
%
% Input:
%   xi - vettore delle ascisse di interpolazione;
%   fi - vettore dei valori della funzione nelle ascisse xi;
%   x  - vettore dei punti di valutazione.
%
% Output:
%   y  - valori del polinomio interpolante nei punti x.
%
% Rel. 14-05-2026.

% controlli di consistenza
if nargin < 3
    error('Numero di argomenti insufficiente.');
end

n = length(xi);

if length(fi) ~= n
    error('Dimensioni incompatibili tra xi e fi.');
end

if n == 0
    error('Il vettore xi non puo'' essere vuoto.');
end

if length(unique(xi)) ~= n
    error('Le ascisse di interpolazione devono essere distinte.');
end

xi = xi(:);
a = fi(:);

% calcolo in-place delle differenze divise
for j = 2:n
    for i = n:-1:j
        a(i) = (a(i) - a(i - 1)) / (xi(i) - xi(i - j + 1));
    end
end

% valutazione con Horner modificato per la base di Newton
y = a(n) * ones(size(x));

for i = n-1:-1:1
    y = y .* (x - xi(i)) + a(i);
end

end
