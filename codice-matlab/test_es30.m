% script per l'esercizio 30
% confronto tra Simpson composita e adattiva

clear;
clc;

a = 0;
b = 1;
k = 2;

f = @(x) 100 * sin(100 * x) .* exp(-100 * x);
Iex = (1 - exp(-100) * (sin(100) + cos(100))) / 2;

nval = [40; 80; 160; 320];
Icomp = zeros(size(nval));
err_comp = zeros(size(nval));
stima_comp = zeros(size(nval));
nfev_comp = zeros(size(nval));

for idx = 1:length(nval)
    n = nval(idx);

    [Icomp(idx), stima_comp(idx)] = ncotescomp(f, a, b, k, n);
    err_comp(idx) = abs(Icomp(idx) - Iex);
    nfev_comp(idx) = n + 1;
end

Tcomp = table(nval, Icomp, err_comp, stima_comp, nfev_comp, ...
    'VariableNames', {'n', 'I', 'errore', 'stima', 'nfev'});
disp(Tcomp);

tolval = (10 .^ (-3:-1:-6)).';
Iad = zeros(size(tolval));
err_ad = zeros(size(tolval));
stima_ad = zeros(size(tolval));
nfev_ad = zeros(size(tolval));

for idx = 1:length(tolval)
    [Iad(idx), stima_ad(idx), nfev_ad(idx)] = ...
        simpsonad(f, a, b, tolval(idx));
    err_ad(idx) = abs(Iad(idx) - Iex);
end

Tad = table(tolval, Iad, err_ad, stima_ad, nfev_ad, ...
    'VariableNames', {'tol', 'I', 'errore', 'stima', 'nfev'});
disp(Tad);
