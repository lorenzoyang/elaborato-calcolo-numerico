% script per l'esercizio 9
% risoluzione dei sistemi generati da linsis.m con LUSolve.m

clear;
clc;
close all;

n = 10;
k_vals = (1:15).';
x_esatta = ones(n, 1);

sigma = zeros(size(k_vals));
err_inf = nan(size(k_vals));
cond2 = nan(size(k_vals));
stato = cell(size(k_vals));

for idx = 1:length(k_vals)
    k = k_vals(idx);
    [A, b] = linsis(n, k);

    sigma(idx) = pi^(-2 * k);
    cond2(idx) = cond(A);

    try
        x = LUSolve(A, b);
        err_inf(idx) = norm(x - x_esatta, inf);
        stato{idx} = 'ok';
    catch ME
        stato{idx} = ME.message;
    end
end

T = table(k_vals, sigma, cond2, err_inf, stato, ...
    'VariableNames', {'k', 'sigma', 'cond2', 'err_inf', 'stato'});

disp(T);

figure;
semilogy(k_vals, err_inf, 'o-', 'LineWidth', 1.5, 'MarkerSize', 6);
grid on;
xlabel('k');
ylabel('Errore in norma infinito');
title('Esercizio 9: errore di LUSolve al variare di k');
