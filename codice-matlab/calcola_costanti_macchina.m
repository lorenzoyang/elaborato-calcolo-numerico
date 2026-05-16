function [u_mac, max_mac, min_norm, min_denorm] = calcola_costanti_macchina()
% Function [u_mac, max_mac, min_norm, min_denorm] = calcola_costanti_macchina()
%
% Calcola le costanti fondamentali della macchina assumendo che l'aritmetica
% finita implementata utilizzi la base binaria con arrotondamento.
% Il calcolo utilizza esclusivamente operazioni algebriche elementari.
% La function provvede inoltre a stampare a video la validazione dei
% risultati confrontandoli con le costanti native di Matlab.
%
% Input:
%   Nessuno
%
% Output:
%   u_mac      - precisione di macchina
%   max_mac    - piu' grande numero di macchina
%   min_norm   - piu' piccolo numero di macchina normalizzato
%   min_denorm - piu' piccolo numero di macchina denormalizzato
%
% Rel. 05-03-2026.

% 1. calcolo della distanza tra 1 e il numero di macchina successivo
eps1 = 1.0;
while (1.0 + eps1 / 2.0) > 1.0
    eps1 = eps1 / 2.0;
end
% con arrotondamento la precisione di macchina (unit roundoff) e' eps1/2
u_mac = eps1 / 2.0;

% 2. calcolo del piu' grande numero di macchina
max_mac = 2.0 - eps1;
while (1.0 / (max_mac * 2.0)) > 0.0
    max_mac = max_mac * 2.0;
end

% 3. calcolo del piu' piccolo numero di macchina normalizzato
min_norm = 1.0;
while ((min_norm / 2.0) * (1.0 + eps1)) > (min_norm / 2.0)
    min_norm = min_norm / 2.0;
end

% 4. Calcolo del piu' piccolo numero di macchina denormalizzato
min_denorm = min_norm;
while (min_denorm / 2.0) > 0.0
    min_denorm = min_denorm / 2.0;
end

% stampa e validazione dei risultati
fprintf('VALIDAZIONE COSTANTI DI MACCHINA\n');
fprintf('Precisione(u): calcolato=%e | Atteso(eps/2)=%e\n', u_mac, eps / 2);
fprintf('Realmax: calcolato=%e | Matlab(realmax)=%e\n', max_mac, realmax);
fprintf('Realmin Norm: calcolato=%e | Matlab(realmin)=%e\n', min_norm, realmin);
% il valore esatto corrisponde a realmin * eps
fprintf('Min Denorm: calcolato=%e | Atteso=%e\n', min_denorm, realmin * eps);

end
