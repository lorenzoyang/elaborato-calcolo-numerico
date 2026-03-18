% test_lusolve.m
% Script di test per la function LUSolve

% test 1: Matrice piccola nota
A1 = [1 2 3; 2 1 1; 1 3 2];
b1 = [1; 2; 3];

x1 = LUSolve(A1, b1);

% verifica soluzione
x1_ref = A1 \ b1;
norm_x1 = norm(x1 - x1_ref);

fprintf('--- Test 1: Matrice 3x3 ---\n');
fprintf('Norma differenza sol: %e\n', norm_x1);

% test 2: Matrice casuale di ordine n
n = 100;
A2 = rand(n);
b2 = rand(n, 1);

x2 = LUSolve(A2, b2);

% verifica soluzione
x2_ref = A2 \ b2;
norm_x2 = norm(x2 - x2_ref);

fprintf('\n--- Test 2: Matrice casuale %dx%d ---\n', n, n);
fprintf('Norma differenza sol: %e\n', norm_x2);

% test 3: Matrice di Hilbert (mal condizionata)
n = 8;
A3 = hilb(n);
b3 = ones(n, 1);

x3 = LUSolve(A3, b3);

x3_ref = A3 \ b3;
norm_x3 = norm(x3 - x3_ref);

fprintf('\n--- Test 3: Matrice di Hilbert di ordine %d ---\n', n);
fprintf('Norma differenza sol: %e\n', norm_x3);
