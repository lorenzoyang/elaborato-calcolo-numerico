function [x, itnum] = metodoBisezione(f, a, b, tol)
% Function [x, itnum] = metodoBisezione(f, a, b, tol)
% 
% Trova la radice di f in [a,b] usando il metodo di bisezione.
%
% Input:
%   f   - funzione per cui trovare la radice
%   a   - estremo sinistro dell'intervallo
%   b   - estremo destro dell'intervallo
%   tol - tolleranza per il criterio di arresto (default 1e-3)
%
% Output:
%   x     - stima della radice
%   itnum - numero di iterazioni effettuate
%
% Release 07-03-2026.

% gestione input e valori di default
if nargin < 3
    error('Numero di argomenti insufficiente.');
end

if nargin < 4
    tol = 1e-3;
end

if a >= b
    error('Intervallo [a, b] non valido.');
end

% valutazione iniziale e controllo dei segni
fa = f(a);
fb = f(b);

if fa == 0
    x = a; itnum = 0; return;
elseif fb == 0
    x = b; itnum = 0; return;
elseif fa * fb > 0
    error('Condizione f(a)*f(b) < 0 non soddisfatta.');
end

% calcolo del numero di iterazioni necessarie a priori
itmax = ceil(log2(b - a) - log2(tol));
itnum = 0;

% ciclo di bisezione
for k = 1:itmax
    itnum = itnum + 1;

    % calcolo del punto medio
    x = a + (b - a) / 2;
    fx = f(x);

    if fx == 0
        return;
    end

    % aggiornamento dell'intervallo
    if fa * fx < 0
        b = x;
    else
        a = x;
        fa = fx;
    end
end

end
