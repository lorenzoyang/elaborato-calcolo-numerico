% script per l'esercizio 26
% errore massimo per le spline cubiche interpolanti della funzione di Runge

clear;
clc;
close all;

a = -5;
b = 15;
N = 10000;

f = @(x) 1 ./ (1 + x .^ 2);
f1 = @(x) -2 * x ./ (1 + x .^ 2) .^ 2;

x = linspace(a, b, N + 1);
fx = f(x);

nval = (100:100:2000).';
h = (b - a) ./ nval;

err_naturale = zeros(size(nval));
err_notaknot = zeros(size(nval));
err_completa = zeros(size(nval));

for idx = 1:length(nval)
    n = nval(idx);
    xi = linspace(a, b, n + 1);
    fi = f(xi);

    y_naturale = spline3(xi, fi, x, 0);
    y_notaknot = spline3(xi, fi, x, 1);
    y_completa = spline3(xi, fi, x, 2, f1(a), f1(b));

    err_naturale(idx) = max(abs(fx - y_naturale));
    err_notaknot(idx) = max(abs(fx - y_notaknot));
    err_completa(idx) = max(abs(fx - y_completa));
end

ultimi = length(h)-9:length(h);
p_naturale = polyfit(log(h(ultimi)), log(err_naturale(ultimi)), 1);
p_notaknot = polyfit(log(h(ultimi)), log(err_notaknot(ultimi)), 1);
p_completa = polyfit(log(h(ultimi)), log(err_completa(ultimi)), 1);

T = table(nval, h, err_naturale, err_notaknot, err_completa, ...
    'VariableNames', {'n', 'h', 'err_naturale', 'err_notaknot', ...
    'err_completa'});
disp(T);

fprintf('Ordine stimato spline naturale:  %.4f\n', p_naturale(1));
fprintf('Ordine stimato spline not-a-knot: %.4f\n', p_notaknot(1));
fprintf('Ordine stimato spline completa:   %.4f\n', p_completa(1));

ref2 = err_naturale(end) * (h / h(end)) .^ 2;
ref4 = err_completa(end) * (h / h(end)) .^ 4;

figure;
loglog(h, err_naturale, 'o-', 'LineWidth', 1.5, 'MarkerSize', 5);
hold on;
loglog(h, err_notaknot, 's-', 'LineWidth', 1.5, 'MarkerSize', 5);
loglog(h, err_completa, '^-', 'LineWidth', 1.5, 'MarkerSize', 5);
loglog(h, ref2, 'k--', 'LineWidth', 1.2);
loglog(h, ref4, 'k:', 'LineWidth', 1.5);
grid on;
xlabel('h');
ylabel('Errore massimo');
title('Spline cubiche interpolanti della funzione di Runge');
legend('Naturale', 'Not-a-knot', 'Completa', 'O(h^2)', 'O(h^4)', ...
    'Location', 'northwest');
