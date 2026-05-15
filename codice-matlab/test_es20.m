% script per l'esercizio 20
% errore massimo per l'interpolazione della funzione di Runge

clear;
clc;
close all;

a = -10;
b = 10;
N = 10000;

f = @(x) 1 ./ (1 + x .^ 2);
f1 = @(x) -2 * x ./ (1 + x .^ 2) .^ 2;

x = linspace(a, b, N + 1);
fx = f(x);
f1x = f1(x);

n_poly = (10:10:140).';
n_hermite = (10:10:70).';

err_lagrange = zeros(size(n_poly));
err_newton = zeros(size(n_poly));
err_hermite = zeros(size(n_hermite));
err_hermite1 = zeros(size(n_hermite));

for idx = 1:length(n_poly)
    n = n_poly(idx);
    xi = linspace(a, b, n + 1);
    fi = f(xi);

    y_lagrange = lagrange(xi, fi, x);
    y_newton = newton(xi, fi, x);

    err_lagrange(idx) = max(abs(fx - y_lagrange));
    err_newton(idx) = max(abs(fx - y_newton));
end

for idx = 1:length(n_hermite)
    n = n_hermite(idx);
    xi = linspace(a, b, n + 1);
    fi = f(xi);
    fi1 = f1(xi);

    [y_hermite, y_hermite1] = hermite(xi, fi, fi1, x);

    err_hermite(idx) = max(abs(fx - y_hermite));
    err_hermite1(idx) = max(abs(f1x - y_hermite1));
end

T_poly = table(n_poly, err_lagrange, err_newton, ...
    'VariableNames', {'n', 'err_lagrange', 'err_newton'});
T_hermite = table(n_hermite, err_hermite, err_hermite1, ...
    'VariableNames', {'n', 'err_hermite', 'err_hermite_derivata'});

disp(T_poly);
disp(T_hermite);

figure;
tiledlayout(2, 1);

nexttile;
semilogy(n_poly, err_lagrange, 'o-', 'LineWidth', 1.5, 'MarkerSize', 5);
hold on;
semilogy(n_poly, err_newton, 's-', 'LineWidth', 1.5, 'MarkerSize', 5);
semilogy(n_hermite, err_hermite, '^-', 'LineWidth', 1.5, 'MarkerSize', 5);
grid on;
xlabel('n');
ylabel('Errore massimo');
title('Funzione di Runge: errore di interpolazione');
legend('Lagrange', 'Newton', 'Hermite', 'Location', 'northwest');

nexttile;
semilogy(n_hermite, err_hermite1, 'd-', 'LineWidth', 1.5, 'MarkerSize', 5);
grid on;
xlabel('n');
ylabel('Errore massimo');
title('Hermite: errore sulla derivata prima');
