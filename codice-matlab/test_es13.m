% script per l'esercizio 13
% risoluzione del problema di minimi quadrati pesati con WeightedLSSolve.m

clear;
clc;

A = [1 2 3; 4 5 6; 7 8 9; 10 11 0];
b = [1; 2; 3; 4];

etichette = { ...
    'omega_i = 1', ...
    'omega_i = (5 - i)^2 / 9', ...
    'omega_i = i^2 / 9', ...
    'omega_i = sqrt(2)'};

omegas = { ...
    ones(4, 1), ...
    ((5 - (1:4)').^2) / 9, ...
    ((1:4)').^2 / 9, ...
    sqrt(2) * ones(4, 1)};

x1 = zeros(4, 1);
x2 = zeros(4, 1);
x3 = zeros(4, 1);
phi = zeros(4, 1);

for j = 1:4
    omega = omegas{j};
    x = WeightedLSSolve(A, b, omega);
    r = b - A * x;

    x1(j) = x(1);
    x2(j) = x(2);
    x3(j) = x(3);
    phi(j) = sum(omega .* (r .^ 2));
end

T = table(etichette', x1, x2, x3, phi, ...
    'VariableNames', {'pesi', 'x1', 'x2', 'x3', 'Phi'});

disp(T);
