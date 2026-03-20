% script per testare l'esercizio 9
n = 10;
fprintf('k \t cond(A, inf) \t errore (inf)\n');
fprintf('-------------------------------------------\n');

ks = 1:15;
conds = zeros(size(ks));
errors = zeros(size(ks));

for i = 1:length(ks)
    k = ks(i);
    [A, b] = linsis(n, k);
    x_esatta = ones(n, 1);
    
    try
        x_calc = LUSolve(A, b);
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

% --- aggiunta per il grafico ---

% indici validi (errore calcolato con successo)
valid = ~isnan(errors) & errors > 0;

figure;
semilogy(ks(valid), errors(valid), '-o', ...
    'LineWidth', 1.5, 'Color', [0.2 0.2 0.8], ...
    'MarkerFaceColor', [0.2 0.2 0.8], ...
    'DisplayName', 'Errore $\|x - x_e\|_\infty$');
hold on;

% limite teorico solo sui punti validi
semilogy(ks(valid), conds(valid) * eps, '--r', ...
    'LineWidth', 1.2, ...
    'DisplayName', 'Limite teorico $\mathrm{cond}(A)\cdot\varepsilon_{\mathrm{mach}}$');

% linea verticale che marca il collasso numerico
k_singular = find(~valid, 1);
if ~isempty(k_singular)
    xline(ks(k_singular), '--k', ...
        'LineWidth', 1, ...
        'Label', sprintf('k=%d: matrice singolare', ks(k_singular)), ...
        'LabelVerticalAlignment', 'bottom', ...
        'DisplayName', 'Soglia singolarità numerica');
end

hold off;

xlim([1 15]);
grid on;
set(gca, 'XTick', ks, 'TickLabelInterpreter', 'latex');
xlabel('Parametro $k$', 'Interpreter', 'latex');
ylabel('Valore (scala logaritmica)', 'Interpreter', 'latex');
title('Errore e limite teorico al variare di $k$ ($n=10$)', 'Interpreter', 'latex');
legend('Location', 'northwest', 'Interpreter', 'latex');