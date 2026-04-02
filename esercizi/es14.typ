#import "../conf.typ": esercizio

#esercizio(
  "14",
  [Scrivere una function che implementi efficientemente il metodo di Newton per risolvere sistemi di equazioni nonlineari. Utilizzare le function sviluppate in precedenza come risolutori per i sistemi lineari coinvolti.],
)[
  Sia assegnato un sistema nonlineare
  $
    bold(F)(bold(x)) = bold(0),
    quad
    bold(F): RR^n -> RR^n.
  $
  Linearizzando $bold(F)$ attorno all'iterato corrente $bold(x)^(k)$ si ottiene
  $
    bold(F)(bold(x)^(k) + Delta bold(x)^(k))
    approx
    bold(F)(bold(x)^(k)) + J_(bold(F))(bold(x)^(k)) Delta bold(x)^(k),
  $
  dove $J_(bold(F))(bold(x)^(k))$ e' la matrice Jacobiana. Imporre che il termine lineare approssimi uno zero porta quindi al sistema lineare di Newton
  $
    J_(bold(F))(bold(x)^(k)) Delta bold(x)^(k) = -bold(F)(bold(x)^(k)),
  $
  seguito dall'aggiornamento
  $
    bold(x)^(k+1) = bold(x)^(k) + Delta bold(x)^(k).
  $

  Per ottenere un'implementazione efficiente conviene:
  - non calcolare mai esplicitamente l'inversa della Jacobiana;
  - far restituire alla function `fun` sia $bold(F)(bold(x))$ sia $J_(bold(F))(bold(x))$, cosi' eventuali quantita' intermedie possono essere riutilizzate;
  - risolvere il sistema lineare del passo di Newton con una delle routine gia' sviluppate, usando `LUSolve` come scelta di default nel caso generale e lasciando la possibilita' di passare un altro risolutore, ad esempio `LDLSolve`, quando la Jacobiana abbia struttura favorevole.

  Per il criterio di arresto si usa la naturale estensione vettoriale del criterio misto assoluto/relativo gia' adottato per Newton scalare:
  $
    ||Delta bold(x)^(k) ./ (1 + abs(bold(x)^(k+1)))||_infinity <= "tol".
  $
  Qui il denominatore contiene l'approssimazione corrente $bold(x)^(k+1) = bold(x)^(k) + Delta bold(x)^(k)$. Questo controllo arresta l'iterazione quando il passo diventa piccolo rispetto alla scala delle componenti della soluzione.

  ```matlab
  function [x, it] = metodoNewtonSistemi(fun, x0, tol, maxit, solverLineare)
  % Function [x, it] = metodoNewtonSistemi(fun, x0, tol, maxit, solverLineare)
  %
  % Metodo di Newton per risolvere sistemi nonlineari F(x) = 0.
  % La function fun deve restituire sia F(x) sia la Jacobiana J(x)
  % mediante la sintassi [Fx, Jx] = fun(x).
  %
  % Input:
  %   fun           - function handle che restituisce [F(x), J(x)];
  %   x0            - punto iniziale;
  %   tol           - tolleranza di arresto (default 10*eps);
  %   maxit         - numero massimo di iterazioni (default 1000);
  %   solverLineare - risolutore del sistema J(x)*dx = -F(x)
  %                   (default @LUSolve).
  %
  % Output:
  %   x             - approssimazione della soluzione;
  %   it            - numero di iterazioni effettuate.
  %
  % Rel. 21-03-2026.

  % gestione degli argomenti di input e valori di default
  if nargin < 2
      error('Numero di argomenti insufficiente.');
  end
  if nargin < 5 || isempty(solverLineare)
      solverLineare = @LUSolve;
  end
  if nargin < 4 || isempty(maxit)
      maxit = 1000;
  end
  if nargin < 3 || isempty(tol)
      tol = 10 * eps;
  end

  % controllo validita' input
  if ~isa(fun, 'function_handle')
      error('Il primo argomento deve essere una function.');
  end
  if ~isa(solverLineare, 'function_handle')
      error('Il risolutore lineare deve essere una function.');
  end
  if tol <= 0
      error('Tolleranza non corretta: deve essere > 0.');
  end
  if maxit < 1 || maxit ~= fix(maxit)
      error('Numero massimo di iterazioni non corretto.');
  end

  % inizializzazione
  x = x0(:);
  it = 0;
  flag = 0;

  % ciclo iterativo di Newton
  for k = 1:maxit
      [Fx, Jx] = feval(fun, x);
      Fx = Fx(:);
      [m, n] = size(Jx);

      if m ~= n || length(Fx) ~= n
          error('La function fun deve restituire F(x) e una Jacobiana quadrata compatibili.');
      end

      % controllo se ho gia' trovato uno zero esatto
      if norm(Fx, inf) == 0
          flag = 1;
          break;
      end

      % passo di Newton: J(x_k) * dx = -F(x_k)
      dx = feval(solverLineare, Jx, -Fx);
      x_new = x + dx;
      it = k;

      % criterio di arresto misto assoluto/relativo:
      % nel denominatore compare l'approssimazione corrente x_{k+1}
      if norm(dx ./ (1 + abs(x_new)), inf) <= tol
          x = x_new;
          flag = 1;
          break;
      end

      x = x_new;
  end

  % avviso se non si e' raggiunta la convergenza
  if flag == 0
      warning('Accuratezza non raggiunta entro il numero massimo di iterazioni.');
  end

  end
  ```
]
