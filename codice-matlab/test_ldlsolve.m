%% Test 1.Matrice s.d.p. (caso ideale)
n = 5;
X = rand(n);
A = X' * X + n * eye(n);   % garantisce s.d.p.
b = rand(n, 1);

x_ldl  = LDLSolve(A, b);
x_true = A \ b;
err_rel = norm(x_ldl - x_true) / norm(x_true);
fprintf('Errore relativo: %e\n', err_rel);

%% Test 2.Matrice non definita positiva
A2 = -eye(n);
try
    LDLSolve(A2, b);
catch e
    fprintf('Errore catturato: %s\n', e.message);
end

%% Test 3.Matrice non simmetrica
A3 = rand(n);
try
    LDLSolve(A3, b);
catch e
    fprintf('Errore catturato: %s\n', e.message);
end
