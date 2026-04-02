function x = WeightedLSSolve(A, b, omega)
% Function x = WeightedLSSolve(A, b, omega)
%
% Risolve un problema di minimi quadrati pesati
% con A matrice m x n a rango colonna massimo e m >= n,
% mediante una fattorizzazione QR del sistema scalato
% calcolata con riflessioni di Householder.
%
% Input:
%   A     - matrice dei coefficienti m x n;
%   b     - vettore dei dati m x 1;
%   omega - vettore dei pesi positivi m x 1.
%
% Output:
%   x     - soluzione di minimi quadrati pesati n x 1.
% Rel. 14-03-2026.

[m, n] = size(A);

% controlli di consistenza
if m < n
    error('Il sistema deve essere sovradeterminato o quadrato.');
end

if length(b) ~= m || length(omega) ~= m
    error('Dimensioni incompatibili tra A, b e omega.');
end

% normalizzazione a vettori colonna
b = b(:);
omega = omega(:);

% controllo positivita' dei pesi
if any(omega <= 0)
    error('I pesi devono essere strettamente positivi.');
end

% costruzione implicita del sistema scalato:
% Aw = W^(1/2) A, bw = W^(1/2) b
d = sqrt(omega);
A = A .* d;
b = d .* b;

% fattorizzazione QR ridotta tramite riflessioni di Householder
tol = max(m, n) * eps * norm(A, 'inf');

for k = 1:n
    xk = A(k:m, k);
    sigma = norm(xk);

    if sigma <= tol
        error('La matrice A non ha rango colonna massimo.');
    end

    if xk(1) >= 0
        alpha = -sigma;
    else
        alpha = sigma;
    end

    v = xk;
    v(1) = v(1) - alpha;
    beta = v' * v;

    A(k:m, k:n) = A(k:m, k:n) - (2 / beta) * v * (v' * A(k:m, k:n));
    b(k:m) = b(k:m) - (2 / beta) * v * (v' * b(k:m));

    A(k, k) = alpha;
    A(k+1:m, k) = 0;
end

R = triu(A(1:n, 1:n));
y = b(1:n);

% risoluzione Rx = y (backward substitution)
x = y;
for i = n:-1:1
    x(i) = x(i) / R(i, i);
    x(1:i-1) = x(1:i-1) - R(1:i-1, i) * x(i);
end

end
