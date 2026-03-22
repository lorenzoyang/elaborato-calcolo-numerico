% script per l'esercizio 11: analisi errore sistemi sdp
n = 10;
ks = 1:15;
errs = zeros(size(ks));
conds = zeros(size(ks));
x_true = ones(n, 1);

fprintf('k\tCond(A, 2)\tErrore Relativo\n');
fprintf('----------------------------------------------\n');

for i = 1:length(ks)
    k = ks(i);
    [A, b] = linsis(n, k, 1);
    
    try
        x_calc = LDLSolve(A, b);
        errs(i) = norm(x_true - x_calc) / norm(x_true);
    catch ME
        fprintf('Errore per k=%d: %s\n', k, ME.message);
        errs(i) = NaN;
    end
    
    conds(i) = cond(A);
    fprintf('%d\t%.4e\t\t%.4e\n', k, conds(i), errs(i));
end

% Visualizzazione
valid = ~isnan(errs);
figure;
semilogy(ks(valid), errs(valid), '-o', 'LineWidth', 2, ...
    'DisplayName', 'Errore Relativo $\|x-x_e\|/\|x_e\|$');
hold on;
semilogy(ks(valid), conds(valid) * eps, '--s', 'LineWidth', 1.5, ...
    'DisplayName', '$\mathrm{cond}(A) \cdot \epsilon_{\mathrm{mach}}$');
hold off;
grid on;
xlabel('$k$', 'Interpreter', 'latex');
ylabel('Errore (scala logaritmica)', 'Interpreter', 'latex');
title('Analisi dell''errore per LDLSolve ($n=10$)', 'Interpreter', 'latex');
legend('Location', 'best', 'Interpreter', 'latex');