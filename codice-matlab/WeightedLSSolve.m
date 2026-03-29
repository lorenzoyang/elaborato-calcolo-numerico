function x = WeightedLSSolve(A, b, omega)
% Function x = WeightedLSSolve(A, b, omega)
%
% Risolve un problema di minimi quadrati pesati
% con A matrice m x n a rango colonna massimo e m >= n,
% mediante la fattorizzazione QR del sistema scalato.
%
% Input:
%   A     - matrice dei coefficienti m x n;
%   b     - vettore dei dati m x 1;
%   omega - vettore dei pesi positivi m x 1.
%
% Output:
%   x     - soluzione di minimi quadrati pesati n x 1.

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
Aw = A .* d;
bw = d .* b;

% fattorizzazione QR ridotta del sistema scalato
[Q, R] = qr(Aw, 0);

% controllo numerico di rango
tol = max(m, n) * eps * norm(R, 'inf');
if any(abs(diag(R)) <= tol)
    error('La matrice A non ha rango colonna massimo.');
end

% termine noto del sistema triangolare
y = Q' * bw;

% risoluzione Rx = y (backward substitution)
x = y;
for i = n:-1:1
    x(i) = x(i) / R(i, i);
    x(1:i-1) = x(1:i-1) - R(1:i-1, i) * x(i);
end

end
