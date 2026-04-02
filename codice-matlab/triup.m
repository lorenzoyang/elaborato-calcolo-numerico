function x = triup(U, b)
% Function x = triup(U, b)
%
% Risolve un sistema triangolare superiore U*x = b di ordine n.
% La matrice U e' memorizzata per colonne in un vettore di
% lunghezza n*(n+1)/2.
%
% Input:
%   U - vettore contenente gli elementi della matrice triangolare superiore 
%       (memorizzati per colonne);
%   b - vettore dei termini noti.
%
% Output:
%   x - vettore soluzione del sistema.
%
% Rel. 08-03-2026.

% ricavo la dimensione n dal vettore dei termini noti
n = length(b);

% controllo consistenza dimensioni
if length(U) ~= n*(n+1)/2
    error('Dimensioni incompatibili: U deve avere lunghezza n*(n+1)/2.');
end

U = U(:); % normalizza a vettore colonna per sicurezza
% inizializzazione soluzione
x = b(:); % normalizza a vettore colonna

% indice dell'ultimo elemento del vettore U (corrisponde a U_nn)
idx_end = n*(n+1)/2;

% back-substitution per colonne
for j = n : -1 : 1
    if U(idx_end) == 0
        error('Matrice singolare: elemento diagonale nullo in j=%d.', j);
    end

    % calcolo x(j)
    x(j) = x(j) / U(idx_end);

    % aggiornamento delle componenti precedenti
    if j > 1
        idx_start = idx_end - j + 1;
        x(1:j-1) = x(1:j-1) - U(idx_start:idx_end-1) * x(j);
        idx_end   = idx_start - 1;
    end
end

end
