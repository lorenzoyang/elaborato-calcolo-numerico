#import "../conf.typ": esercizio

#esercizio(
  "5",
  [Scrivere una function Matlab che implementi un metodo ibrido: inizialmente il metodo di bisezione e, non appena l'ampiezza dell'intervallo di confidenza diventi minore dell'ampiezza prefissata $delta$ (e se non si sia usciti in precedenza) passi ad utilizzare il metodo di Newton, a partire dall'ultima approssimazione trovata dal metodo di bisezione, fino ad ottenere la massima accuratezza possibile.],
)[
  L'approccio ibrido unisce i punti di forza di due metodi classici:
  - Bisezione: garantisce sempre la convergenza (globale), ma è lenta (lineare).
  - Newton: è velocissimo (quadratica), ma converge solo se innescato da un punto sufficientemente vicino alla radice.

  La strategia consiste nell'usare la bisezione per restringere in modo sicuro l'intervallo fino a un'ampiezza prefissata $delta$. L'approssimazione ottenuta funge da innesco ideale per il metodo di Newton, che può così convergere rapidamente alla soluzione con la massima precisione di macchina (ordine di eps).

  ```matlab
  function [x, it_bis, it_new] = metodoIbrido(f, f1, a, b, delta)
  % Function [x, it_bis, it_new] = metodoIbrido(f, f1, a, b, delta)
  %
  % Metodo ibrido per la ricerca degli zeri di una funzione: inizialmente
  % utilizza il metodo di bisezione e, quando l'ampiezza dell'intervallo
  % diventa minore di delta, passa al metodo di Newton per ottenere la
  % massima accuratezza possibile.
  %
  % Input:
  %   f, f1 - function che implementano la funzione e la sua derivata;
  %   a, b  - estremi dell'intervallo iniziale;
  %   delta - ampiezza dell'intervallo per lo switch a Newton.
  %
  % Output:
  %   x      - approssimazione della radice;
  %   it_bis - numero di iterazioni di bisezione effettuate;
  %   it_new - numero di iterazioni di Newton effettuate.

  % gestione input e valori di default
  if nargin < 5
      error('Numero di argomenti insufficiente.');
  end

  if a >= b
      error('Intervallo [a, b] non valido.');
  end

  if delta <= 0
      error('Parametro delta deve essere positivo.');
  end

  % inizializzazione
  it_bis = 0;
  it_new = 0;

  % valutazione iniziale e controllo dei segni
  fa = feval(f, a);
  fb = feval(f, b);

  if fa == 0
      x = a; return;
  elseif fb == 0
      x = b; return;
  elseif fa * fb > 0
      error('Condizione f(a)*f(b) < 0 non soddisfatta.');
  end

  % --- FASE 1: Metodo di Bisezione ---
  % prosegue finche' l'ampiezza dell'intervallo e' >= delta
  while (b - a) >= delta
      it_bis = it_bis + 1;

      % calcolo punto medio
      x = a + (b - a) / 2;
      fx = feval(f, x);

      if fx == 0
          return; % radice esatta trovata con bisezione
      end

      % aggiornamento intervallo
      if fa * fx < 0
          b = x;
          % inutile aggiornare fb, non viene mai usato nei controlli del ciclo
          % fb = fx;
      else
          a = x;
          fa = fx;
      end
  end

  % l'ultima approssimazione trovata e' il punto medio dell'intervallo corrente
  x = a + (b - a) / 2;

  % --- FASE 2: Metodo di Newton ---
  % si parte dall'ultimo valore x trovato dalla bisezione
  % per la massima accuratezza si utilizza una tolleranza prossima a eps
  tol_new = 10 * eps;
  maxit_new = 100; % valore di sicurezza

  for i = 1:maxit_new
      x0 = x;

      fx = feval(f, x);
      f1x = feval(f1, x);

      if fx == 0
          break;
      end

      if f1x == 0
          warning('Arresto Newton: derivata nulla.');
          break;
      end

      it_new = it_new + 1;
      x = x0 - fx / f1x;

      % criterio di arresto per massima accuratezza
      if abs(x - x0) <= tol_new * (1 + abs(x))
          break;
      end
  end

  end
  ```
]
