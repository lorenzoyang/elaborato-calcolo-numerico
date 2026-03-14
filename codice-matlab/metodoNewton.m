function x = metodoNewton(f, f1, x0, tol, maxit, molt)
% Function x = metodoNewton(f, f1, x0, tol, maxit, molt)
% 
% Metodo di Newton (modificato) per gli zeri di funzione.
%
% Input:
%   f, f1 - function che implementano la funzione e la sua derivata;
%   x0    - punto iniziale;
%   tol   - tolleranza di arresto (default 1e-12);
%   maxit - numero massimo di iterazioni (default 1000);
%   molt  - molteplicita' della radice (default 1).
%
% Output:
%   x     - approssimazione della radice.

% gestione degli argomenti di input e valori di default
if nargin < 3
    error('Numero di argomenti insufficiente.');
end
if nargin < 6
    molt = 1;
end
if nargin < 5
    maxit = 1000;
end
if nargin < 4
    tol = 1e-12;
end

% controllo validita' input
if molt < 1 || molt ~= fix(molt)
    error('Molteplicita'' non corretta: deve essere un intero positivo.');
end
if maxit < 1
    error('Numero massimo di iteraterazioni non corretto.');
end
if tol <= 0
    error('Tolleranza non corretta: deve essere > 0.');
end

% inizializzazione
x = x0;
flag = 1;

% ciclo iterativo di Newton
for i = 1:maxit
    x0 = x; % salvo il valore precedente

    % valutazione funzione e derivata
    fx = feval(f, x);
    f1x = feval(f1, x);

    % controllo se ho già trovato la radice esatta
    if fx == 0
        flag = 0;
        break;
    end

    % evito divisione per zero
    if f1x == 0
        error('Arresto: derivata nulla nel punto x = %g', x);
    end

    % aggiornamento passo di Newton modificato
    x = x0 - molt * (fx / f1x);

    % criterio di arresto (errore misto assoluto/relativo)
    if abs(x - x0) <= tol * (1 + abs(x))
        flag = 0;
        break;
    end
end

% avviso se non si è raggiunta la convergenza
if flag
    warning('Accuratezza non raggiunta entro il numero massimo di iterazioni.');
end

end