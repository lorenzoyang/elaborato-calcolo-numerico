function [I, err, nfev] = simpsonad(fx, a, b, tol)
% Function [I, err, nfev] = simpsonad(fx, a, b, tol)
%
% Calcola l'integrale di fx in [a,b] mediante la formula adattiva
% di Simpson con tolleranza tol.
%
% Input:
%   fx  - function handle della funzione integranda;
%   a   - estremo sinistro dell'intervallo;
%   b   - estremo destro dell'intervallo;
%   tol - tolleranza richiesta.
%
% Output:
%   I    - approssimazione dell'integrale;
%   err  - stima totale dell'errore;
%   nfev - numero di valutazioni funzionali effettuate.
%
% Rel. 22-05-2026.

% controlli di consistenza
if nargin < 4
    error('Numero di argomenti insufficiente.');
end

if a >= b
    error('L''intervallo [a, b] non e'' valido.');
end

if tol <= 0
    error('La tolleranza deve essere positiva.');
end

m = (a + b) / 2;
fa = fx(a);
fm = fx(m);
fb = fx(b);

[I, err, nfev_rec] = simpsonad_rec(fx, a, b, tol, fa, fm, fb);
% aggiungo le tre valutazioni iniziali: f(a), f(m), f(b)
nfev = nfev_rec + 3;

end

function [I, err, nfev] = simpsonad_rec(fx, a, b, tol, fa, fm, fb)
% Funzione ricorsiva: riusa fa, fm e fb gia' calcolati.

m = (a + b) / 2;
x1 = (a + m) / 2;
x2 = (m + b) / 2;

% una volta noti i valori nei nodi li riuso
f1 = fx(x1);
f2 = fx(x2);
nfev = 2;

S1 = simpson(a, b, fa, fm, fb);
Ssx = simpson(a, m, fa, f1, fm);
Sdx = simpson(m, b, fm, f2, fb);
S2 = Ssx + Sdx;

err = abs(S2 - S1) / 15;

if err <= tol
    I = S2;
else
    [Isx, err_sx, nfev_sx] = simpsonad_rec(fx, a, m, ...
        tol / 2, fa, f1, fm);
    [Idx, err_dx, nfev_dx] = simpsonad_rec(fx, m, b, ...
        tol / 2, fm, f2, fb);

    I = Isx + Idx;
    err = err_sx + err_dx;
    nfev = nfev + nfev_sx + nfev_dx;
end

end

function S = simpson(a, b, fa, fm, fb)
% Formula elementare di Simpson su [a,b].

S = (b - a) * (fa + 4 * fm + fb) / 6;

end
