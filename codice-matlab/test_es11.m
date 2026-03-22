% script test_es11.m
% risoluzione di sistemi lineari con matrice sdp generati da linsis.m
% n = 10, k = 1:15

n = 10;
ks = 1:15;
errs = zeros(size(ks));
conds = zeros(size(ks));
x_e = ones(n, 1);

fprintf('k \t cond(A, 2) \t errore (rel)\n');
fprintf('-------------------------------------------\n');

for i = 1:length(ks)
    k = ks(i);
    [A, b] = linsis(n, k, 1); % matrice SPD

    try
        x = LDLSolve(A, b);
        errs(i) = norm(x - x_e) / norm(x_e);
    catch ME
        fprintf('Errore per k=%d: %s\n', k, ME.message);
        errs(i) = NaN;
    end

    conds(i) = cond(A);
    fprintf('%d \t %.2e \t %.2e\n', k, conds(i), errs(i));
end

% Plotting results
figure;
semilogy(ks, errs, '-o', ...
    'LineWidth', 1.5, 'Color', [0.2 0.2 0.8], ...
    'MarkerFaceColor', [0.2 0.2 0.8], ...
    'DisplayName', 'Errore relativo $\|x - x_e\|_2 / \|x_e\|_2$');
hold on;

% Limite teorico: cond(A) * eps
semilogy(ks, conds * eps, '--r', ...
    'LineWidth', 1.2, ...
    'DisplayName', 'Limite teorico $\mathrm{cond}_2(A)\cdot\varepsilon_{\mathrm{mach}}$');

hold off;

xlim([1 15]);
grid on;
set(gca, 'XTick', ks, 'TickLabelInterpreter', 'latex');
xlabel('Parametro $k$', 'Interpreter', 'latex');
ylabel('Valore (scala logaritmica)', 'Interpreter', 'latex');
title('Errore e limite teorico (SPD) al variare di $k$ ($n=10$)', 'Interpreter', 'latex');
legend('Location', 'northwest', 'Interpreter', 'latex');
