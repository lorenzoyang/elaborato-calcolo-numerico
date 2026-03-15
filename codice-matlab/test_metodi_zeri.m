% Script di test per verificare i costi computazionali dei metodi

clear; % rimuove tutte le variabili dalla memoria
clc; % pulisce la finestra dei comandi

% definizione della funzione e della sua derivata esatta 
% con l'uso di funzioni anonime
f = @(x) sin(10*x) + atan(10*x);
f1 = @(x) 10*cos(10*x) + 10./(1 + (10*x).^2);

% parametri iniziali come da l'esercizio 6
a = -10.1;
b = 10;
x0_newton = 10;
delta = 1e-1;
tol = 10 * eps; % richiesta di "massima accuratezza possibile"
maxit_newton = 1000;

fprintf('=== TEST METODI PER LA RICERCA DEGLI ZERI ===\n\n');

%% --- TEST METODO DI BISEZIONE ---
fprintf('1. METODO DI BISEZIONE\n');
try
    [x_bis, it_bis] = metodoBisezione(f, a, b, tol);
    
    % 2 valutazioni iniziali f(a), f(b) + 1 valutazione f(x) per iterazione
    valutazioni_bis = 2 + it_bis; 
    
    fprintf('   Esito: Successo\n');
    fprintf('   Radice stimata: %.15e\n', x_bis);
    fprintf('   Iterazioni: %d\n', it_bis);
    fprintf('   Valutazioni totali di funzione: %d\n\n', valutazioni_bis);
catch ME
    fprintf('   Esito: Fallimento (%s)\n\n', ME.message);
end

%% --- TEST METODO DI NEWTON ---
fprintf('2. METODO DI NEWTON (Innesco x0 = 10)\n');
try
    % disattiviamo temporaneamente il warning di MATLAB 
    % per avere un output pulito in console
    warning('off', 'all');

    [x_new, it_new] = metodoNewton(f, f1, x0_newton, tol, maxit_newton, 1);

    warning('on', 'all');

    % valutazione di f(x) e f1(x) ad ogni iterazione del ciclo
    valutazioni_new = 2 * it_new; 
    
    if it_new == maxit_newton
        fprintf('   Esito: Fallimento (Raggiunto limite di iterazioni senza convergere)\n');
    else
        fprintf('   Esito: Successo\n');
    end
    fprintf('   Ultima approssimazione trovata: %.15e\n', x_new);
    fprintf('   Iterazioni: %d\n', it_new);
    fprintf('   Valutazioni totali di funzione: %d\n\n', valutazioni_new);
catch ME
    warning('on', 'all'); % riattiva i warning in caso di errore (es. derivata nulla)
    fprintf('   Esito: Fallimento (%s)\n\n', ME.message);
end

%% --- TEST METODO IBRIDO ---
fprintf('3. METODO IBRIDO\n');
try
    [x_ibr, it_ibr_bis, it_ibr_new] = metodoIbrido(f, f1, a, b, delta);
    
    % 2 iniziali (fa, fb) + 1 per ogni it. di bisezione + 2 per ogni it. di Newton
    valutazioni_ibr = 2 + it_ibr_bis + (2 * it_ibr_new);
    
    fprintf('   Esito: Successo\n');
    fprintf('   Radice stimata: %.15e\n', x_ibr);
    fprintf('   Iterazioni: %d (Bisezione) + %d (Newton)\n', it_ibr_bis, it_ibr_new);
    fprintf('   Valutazioni totali di funzione: %d\n\n', valutazioni_ibr);
catch ME
    fprintf('   Esito: Fallimento (%s)\n\n', ME.message);
end