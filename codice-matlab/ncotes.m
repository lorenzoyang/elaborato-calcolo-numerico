function ci = ncotes(n)
% Function ci = ncotes(n)
%
% Calcola i coefficienti della formula chiusa di Newton-Cotes
% di grado n sui nodi equidistanti 0, 1, ..., n.
%
% La formula risultante e'
%
%   I_n(f) = h * sum_{i=0}^n ci(i+1) * f(x_i),
%
% dove x_i = a + i*h e h = (b-a)/n.
%
% Input:
%   n  - grado della formula di Newton-Cotes.
%
% Output:
%   ci - vettore colonna dei coefficienti della formula.
%
% Rel. 16-05-2026.

% controlli di consistenza
if nargin < 1
    error('Numero di argomenti insufficiente.');
end

if ~isscalar(n) || n ~= fix(n) || n < 1
    error('Il grado n deve essere un intero positivo.');
end

ci = zeros(n + 1, 1);

% Il coefficiente ci(i+1) e' l'integrale su [0,n] del polinomio
% fondamentale di Lagrange relativo al nodo i.
for i = 0:n
    ind = [0:i-1 i+1:n];

    den = prod(i - ind);
    p = poly(ind);

    pint = [p ./ (n + 1:-1:1), 0];
    ci(i + 1) = polyval(pint, n) / den;
end

end
