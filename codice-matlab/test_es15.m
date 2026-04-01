% script per l'esercizio 15
% risoluzione del sistema nonlineare con metodoNewtonSistemi.m

clear;
clc;

tol = 10 * eps;
maxit = 1000;

x0 = [ ...
    0.4,  0.4,  1.4,  1.4;
    2.0, -2.0, -2.0,  2.0;
    0.4, -0.4, -1.4,  1.4;
    2.0,  2.0,  2.0,  2.0];

n_casi = size(x0, 2);
x = zeros(4, n_casi);
it = zeros(n_casi, 1);
res_inf = zeros(n_casi, 1);

for j = 1:n_casi
    [x(:, j), it(j)] = metodoNewtonSistemi(@sistema_es15, x0(:, j), tol, maxit, @LUSolve);
    [Fx, ~] = sistema_es15(x(:, j));
    res_inf(j) = norm(Fx, inf);
end

T = table((1:n_casi)', x0(1, :)', x0(2, :)', x0(3, :)', x0(4, :)', ...
    x(1, :)', x(2, :)', x(3, :)', x(4, :)', it, res_inf, ...
    'VariableNames', {'caso', 'x01', 'x02', 'x03', 'x04', ...
    'x1', 'x2', 'x3', 'x4', 'it', 'res_inf'});

disp(T);

% funzione locale
function [F, J] = sistema_es15(x)
% sistema nonlineare dell'esercizio 15 e sua Jacobiana
x = x(:);
x1 = x(1);
x2 = x(2);
x3 = x(3);
x4 = x(4);

F = [ ...
    x1^2 + x2^2 - 5;
    x3^2 + x4^2 - 5;
    cos(pi * x1) + cos(pi * x3);
    x2^2 - x4^2];

if nargout > 1
    J = [ ...
        2 * x1, 2 * x2, 0, 0;
        0, 0, 2 * x3, 2 * x4;
        -pi * sin(pi * x1), 0, -pi * sin(pi * x3), 0;
        0, 2 * x2, 0, -2 * x4];
end
end
