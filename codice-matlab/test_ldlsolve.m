% Script di test per LDLSolve.m (Esercizio 10)
n = 10;
fprintf('k \t cond(A, inf) \t errore (inf)\n');
fprintf('-------------------------------------------\n');

ks = 1:15;
conds = zeros(size(ks));
errors = zeros(size(ks));

for i = 1:length(ks)
    k = ks(i);
    [A, b] = linsis(n, k, 1); % Matrice SPD
    x_esatta = ones(n, 1);
    
    try
        x_calc = LDLSolve(A, b);
        err = norm(x_calc - x_esatta, inf);
    catch ME
        fprintf('Errore per k=%d: %s\n', k, ME.message);
        err = NaN;
    end
    
    c = cond(A, inf);
    conds(i) = c;
    errors(i) = err;
    
    fprintf('%d \t %.2e \t %.2e\n', k, c, err);
end

% Visualizzazione grafica
figure;
semilogy(ks, errors, '-o', 'LineWidth', 1.5, 'MarkerFaceColor', 'b');
hold on;
semilogy(ks, conds * eps, '--r', 'LineWidth', 1.2);
grid on;
xlabel('Parametro k');
ylabel('Errore / Limite teorico');
legend('Errore ||x - x_e||_\infty', 'cond(A) * \epsilon_{mach}', 'Location', 'northwest');
title('Validazione LDLSolve (Matrici SPD)');
