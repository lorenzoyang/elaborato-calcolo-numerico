% script per l'esercizio 11
% risoluzione dei sistemi s.d.p. generati da linsis.m con LDLSolve.m

clear;
clc;
close all;

n = 10;
k_vals = (1:15).';
x_esatta = ones(n, 1);

sigma = zeros(size(k_vals));
err_inf = zeros(size(k_vals));
cond2 = zeros(size(k_vals));

for idx = 1:length(k_vals)
    k = k_vals(idx);
    [A, b] = linsis(n, k, 1);

    x = LDLSolve(A, b);

    sigma(idx) = pi^(-2 * k);
    err_inf(idx) = norm(x - x_esatta, inf);
    cond2(idx) = cond(A);
end

T = table(k_vals, sigma, cond2, err_inf, ...
    'VariableNames', {'k', 'sigma', 'cond2', 'err_inf'});

disp(T);

f = figure;
semilogy(k_vals, err_inf, 'o-', 'LineWidth', 1.5, 'MarkerSize', 6);
grid on;
xlim([1 15]);
xticks(1:15);
xlabel('k');
ylabel('Errore in norma infinito');
title('Esercizio 11: errore di LDLSolve al variare di k');
