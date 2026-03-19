% script di validazione per LUSolve

disp('--- TEST 1: Sistema ben condizionato ---');
A1 = [4, 3; 6, 3];
b1 = [10; 12];
x1 = LUSolve(A1, b1);
x1_exact = A1 \ b1;
err1 = norm(x1 - x1_exact);
fprintf('Errore rispetto alla soluzione esatta: %e\n\n', err1);

disp('--- TEST 2: Sistema che richiede pivoting ---');
% l'elemento A(1,1) è 0, senza pivoting l'algoritmo fallirebbe
A2 = [0, 2, 3; 1, -1, 1; -1, 1, 0];
b2 = [8; 0; 1];
x2 = LUSolve(A2, b2);
x2_exact = A2 \ b2;
err2 = norm(x2 - x2_exact);
fprintf('Errore rispetto alla soluzione esatta: %e\n\n', err2);

disp('--- TEST 3: Matrice singolare (Gestione Errori) ---');
A3 = [1, 2, 3; 2, 4, 6; 1, 1, 1]; % la seconda riga è multipla della prima
b3 = [1; 2; 1];
try
    x3 = LUSolve(A3, b3);
    disp('ERRORE: La funzione non ha rilevato la matrice singolare.');
catch ME
    fprintf('Successo: La funzione ha intercettato l''errore correttamente.\n');
    fprintf('Messaggio restituito: "%s"\n', ME.message);
end