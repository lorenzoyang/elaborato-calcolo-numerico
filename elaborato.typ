#import "conf.typ": conf, esercizio

#set document(title: [Elaborato Calcolo Numerico 2025-2026])

#show: conf.with(
  autore: "Lorenzo Yang",
  matricola: "7136074",
  email: "lorenzo.yang@edu.unifi.it",
  anno_acc: "2025-2026",
  data: "Giugno 2026",
  logo: "img/unifi-logo.png",
)

#esercizio(
  "1",
  [Combinare linearmente $y(t + h), y(t), h y'(t), h y'(t - h), h y'(t - 2h)$, con coefficienti non nulli e indipendenti da $h$, in modo da ottenere un residuo che sia $O(h^4)$. Dettagliare il procedimento.],
)[
  Dobbiamo combinare linearmente i termini assegnati in modo che i termini di ordine inferiore dello sviluppo di Taylor si annullino, lasciando un residuo (errore di troncamento) di ordine $O(h^4)$.

  === Sviluppo di Taylor dei termini
  Espandiamo le funzioni e le loro derivate arrestandoci al terzo ordine (poiché moltiplicando per $h$ arriveremo al termine $h^3$, e il resto sarà inglobato in $O(h^4)$):

  - $y(t + h) = y(t) + h y'(t) + h^2/2 y''(t) + h^3/6 y'''(t) + O(h^4)$
  - $y(t) = y(t)$
  - $h y'(t) = h y'(t)$
  - $h y'(t - h) = h (y'(t) - h y''(t) + h^2/2 y'''(t) + O(h^3)) = h y'(t) - h^2 y''(t) + h^3/2 y'''(t) + O(h^4)$
  - $h y'(t - 2h) = h (y'(t) - 2h y''(t) + (2h)^2/2 y'''(t) + O(h^3)) = h y'(t) - 2h^2 y''(t) + 2h^3 y'''(t) + O(h^4)$

  === Definizione della combinazione lineare
  Vogliamo determinare i coefficienti $a, b, c, d, e$ tali per cui:
  $ a y(t+h) + b y(t) + c h y'(t) + d h y'(t-h) + e h y'(t-2h) = O(h^4) $

  Sostituendo gli sviluppi appena ottenuti e raccogliendo a fattor comune rispetto alle derivate di $y(t)$, imponiamo che i coefficienti dei termini di ordine inferiore a $h^4$ siano nulli:
  - Termini in $y(t)$: $a + b = 0$
  - Termini in $h y'(t)$: $a + c + d + e = 0$
  - Termini in $h^2 y''(t)$: $a/2 - d - 2e = 0$
  - Termini in $h^3 y'''(t)$: $a/6 + d/2 + 2e = 0$

  === Risoluzione del sistema
  Abbiamo un sistema lineare omogeneo di 4 equazioni in 5 incognite. Possiamo fissare un parametro libero. Per evitare frazioni e ottenere coefficienti interi, poniamo $a = 12$ (il minimo comune multiplo tra 2 e 6):

  Dalla prima equazione:
  $ 12 + b = 0 => b = -12 $

  Sostituendo $a = 12$ nella terza e quarta equazione, otteniamo un sottosistema in $d$ ed $e$:
  $ 12/2 - d - 2e = 0 => d + 2e = 6 $
  $ 12/6 + d/2 + 2e = 0 => d/2 + 2e = -2 $

  Sottraendo la seconda equazione dalla prima:
  $ (d + 2e) - (d/2 + 2e) = 6 - (-2) => d/2 = 8 => d = 16 $

  Sostituendo $d = 16$ in $d + 2e = 6$:
  $ 16 + 2e = 6 => 2e = -10 => e = -5 $

  Infine, sostituiamo $a, d, e$ nella seconda equazione per trovare $c$:
  $ 12 + c + 16 - 5 = 0 => c + 23 = 0 => c = -23 $

  === Risultato finale
  I coefficienti richiesti sono $a = 12$, $b = -12$, $c = -23$, $d = 16$, $e = -5$.
  La combinazione lineare finale è:
  $ 12 y(t + h) - 12 y(t) - 23 h y'(t) + 16 h y'(t - h) - 5 h y'(t - 2h) = O(h^4) $
]

#esercizio(
  "2",
  [Scrivere una function Matlab che, sapendo solamente che l'aritmetica finita implementata utilizza la base binaria con arrotondamento, calcoli: la precisione di macchina; il più grande numero di macchina; il più piccolo numero di macchina normalizzato; il più piccolo numero di macchina denormalizzato. Argomentare la sua stesura, che deve prevedere solo l'utilizzo di operazioni algebriche elementari (validare i risultati con le function `realmax` e `realmin` di Matlab).],
)[
  === Argomentazione Teorica

  - *Precisione di macchina ($u$)*: È il più piccolo numero positivo tale per cui il calcolatore percepisce $1 + u > 1$. Partendo da $u = 1.0$, lo si divide iterativamente per $2.0$ finché la somma arrotondata non coincide con $1.0$. L'ultimo valore valido riscontrato è la precisione cercata.
  - *Più grande numero di macchina*: La massima mantissa rappresentabile in base $2$ è pari a $2.0 - u$. Moltiplicando iterativamente per $2.0$ questo valore di base, si arriverà inevitabilmente all'overflow (infinito in macchina). Per testare l'avvenuto overflow senza usare funzioni predefinite come `isinf`, si sfrutta la proprietà algebrica per cui il reciproco dell'infinito informatico è esattamente zero: $1.0 / (x dot 2.0) == 0.0$.
  - *Più piccolo numero normalizzato*: Si ottiene partendo da $1.0$ e dividendo iterativamente per $2.0$. Entrando nella zona dei numeri denormalizzati, i bit significativi cominciano a scivolare fuori dalla mantissa. Un numero $x$ è da considerarsi ancora normalizzato se la moltiplicazione per $(1.0 + u)$ produce un risultato strettamente maggiore di $x$ (ovvero, non si è ancora perso l'ultimo bit di precisione disponibile).
  - *Più piccolo numero denormalizzato*: Partendo dal più piccolo numero normalizzato appena trovato, si continua a dividere iterativamente per $2.0$ finché il numero non diventa matematicamente $0.0$ a causa della perdita totale dei bit (Underflow). L'ultimo valore strettamente positivo registrato è il nostro minimo denormalizzato.

  === Codice Matlab: La Function
  ```matlab
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

  % 1. calcolo della precisione di macchina
  u_mac = 1.0;
  while (1.0 + u_mac / 2.0) > 1.0
      u_mac = u_mac / 2.0;
  end

  % 2. calcolo del piu' grande numero di macchina
  max_mac = 2.0 - u_mac;
  while (1.0 / (max_mac * 2.0)) > 0.0
      max_mac = max_mac * 2.0;
  end

  % 3. calcolo del piu' piccolo numero di macchina normalizzato
  min_norm = 1.0;
  while ((min_norm / 2.0) * (1.0 + u_mac)) > (min_norm / 2.0)
      min_norm = min_norm / 2.0;
  end

  % 4. Calcolo del piu' piccolo numero di macchina denormalizzato
  min_denorm = min_norm;
  while (min_denorm / 2.0) > 0.0
      min_denorm = min_denorm / 2.0;
  end

  % stampa e validazione dei risultati
  fprintf('VALIDAZIONE COSTANTI DI MACCHINA\n');
  fprintf('Precisione(u): calcolato=%e | Matlab(eps)=%e\n', u_mac, eps);
  fprintf('Realmax: calcolato=%e | Matlab(realmax)=%e\n', max_mac, realmax);
  fprintf('Realmin Norm: calcolato=%e | Matlab(realmin)=%e\n', min_norm, realmin);
  % il valore esatto corrisponde a realmin * eps
  fprintf('Min Denorm: calcolato=%e | Atteso=%e\n', min_denorm, realmin * eps);

  end

  ```
]

#esercizio(
  "3",
  [Scrivere una function Matlab che implementi il metodo di Newton per gli zeri di una funzione. Prevedere valori di default per la tolleranza di arresto e per il numero massimo di iterazioni.],
)[
  La soluzione proposta implementa il metodo di Newton includendo anche la gestione della molteplicità della radice (metodo di Newton modificato). Viene inoltre utilizzato un criterio di arresto robusto basato sull'errore misto assoluto/relativo.

  ```matlab
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
  ```
]

#esercizio(
  "4",
  [Scrivere una function Matlab che implementi il metodo di bisezione. Prevedere valori di default per la tolleranza di arresto.],
)[
  ```matlab
  function [x, itnum] = metodoBisezione(f, a, b, tol)
  % Function [x, itnum] = metodoBisezione(f, a, b, tol)
  %
  % Trova la radice di f in [a,b] usando il metodo di bisezione.
  %
  % Input:
  %   f   - funzione per cui trovare la radice
  %   a   - estremo sinistro dell'intervallo
  %   b   - estremo destro dell'intervallo
  %   tol - tolleranza per il criterio di arresto (default 1e-3)
  %
  % Output:
  %   x     - stima della radice
  %   itnum - numero di iterazioni effettuate

  % gestione input e valori di default
  if nargin < 3
      error('Numero di argomenti insufficiente.');
  end

  if nargin < 4
      tol = 1e-3;
  end

  if a >= b
      error('Intervallo [a, b] non valido.');
  end

  % valutazione iniziale e controllo dei segni
  fa = f(a);
  fb = f(b);

  if fa == 0
      x = a; itnum = 0; return;
  elseif fb == 0
      x = b; itnum = 0; return;
  elseif fa * fb > 0
      error('Condizione f(a)*f(b) < 0 non soddisfatta.');
  end

  % calcolo del numero di iterazioni necessarie a priori
  itmax = ceil(log2(b - a) - log2(tol));
  itnum = 0;

  % ciclo di bisezione
  for k = 1:itmax
      itnum = itnum + 1;

      % calcolo del punto medio
      x = a + (b - a) / 2;
      fx = f(x);

      if fx == 0
          return;
      end

      % aggiornamento dell'intervallo
      if fa * fx < 0
          b = x;
      else
          a = x;
          fa = fx;
      end
  end

  end
  ```
]

#esercizio(
  "5",
  [Scrivere una function Matlab che implementi un metodo ibrido: inizialmente il metodo di bisezione e, non appena l'ampiezza dell'intervallo di confidenza diventi minore dell'ampiezza prefissata $delta$ (e se non si sia usciti in precedenza) passi ad utilizzare il metodo di Newton, a partire dall'ultima approssimazione trovata dal metodo di bisezione, fino ad ottenere la massima accuratezza possibile.],
)[
]

#esercizio(
  "6",
  [
    Tabulare il costo computazionale dei precedenti metodi, in termini di valutazioni di funzione, per determinare lo zero della funzione
    $ f(x) = sin(10x) + arctan(10x) $
    con la massima accuratezza possibile. Utilizzare $x_0 = 10$ per il metodo di Newton, e l'intervallo iniziale $[-10.1, 10]$ per il metodo di bisezione ed il metodo ibrido. Per quest'ultimo, utilizzare $delta = 10^(-1)$ come valore di _switch_ tra i due metodi. Commentare i risultati ottenuti.
  ],
)[
]

#esercizio(
  "7",
  [Scrivere una function Matlab, con sintassi `x = triup(U,b)`, che risolva un sistema triangolare superiore $n times n$, in cui la matrice dei coefficienti `U` è memorizzata, per colonne, in un vettore di lunghezza $n(n+1)/2$.],
)[
]

#esercizio(
  "8",
  [Scrivere una function che implementi efficientemente la risoluzione di un sistema lineare mediante la fattorizzazione $L U$ con pivoting parziale. Validare la function su alcuni esempi significativi.],
)[
]

#esercizio(
  "9",
  [
    Al seguente link: https://drive.google.com/file/d/1Fp8xFhUONS2W-l4alRKmomRxoM1SeVny/view?usp=share_link

    è reperibile la function `linsis.m`, che crea la matrice dei coefficienti ed il termine noto di un sistema lineare $n times n$, la cui soluzione è il vettore con tutte le componenti uguali ad 1. Utilizzare la function del precedente esercizio per risolvere i sistemi lineari ottenuti con le seguenti istruzioni:
    ```matlab
    n = 10;
    for k = 1:15
        [A,b] = linsis(n,k);
    end
    ```
    Rappresentare _convenientemente_ l'andamento dell'errore, rispetto ad `k`, e spiegare _esaurientemente_ i risultati ottenuti.
  ],
)[
]

#esercizio(
  "10",
  [],
)[
]

#esercizio(
  "11",
  [],
)[
]

#esercizio(
  "12",
  [],
)[
]

#esercizio(
  "13",
  [],
)[
]

#esercizio(
  "14",
  [],
)[
]

#esercizio(
  "15",
  [Inserire qui il testo ufficiale della consegna dal PDF (Esercizio 15).],
)[
]

