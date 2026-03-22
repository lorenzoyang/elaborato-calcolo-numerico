#import "../conf.typ": esercizio, nota, rimando, tabella_risultati

#esercizio(
  "9",
  [
    Al seguente link: https://drive.google.com/file/d/1Fp8xFhUONS2W-l4alRKmomRxoM1SeVny/view?usp=share_link

    ```matlab
    % codice del docente per l'esercizio 9 reperibile al link sopra
    function [A,b] = linsis(n,k,simme)
    %
    %  [A,b] = linsis(n,k,simme)  Crea una matrice A nxn ed un termine noto b,
    %                             in modo che la soluzione del sistema lineare
    %                             A*x=b sia x = [1,1,...,1]^T.
    %                             k non ve lo dico a cosa serve.
    %                             Se simme è specificato, crea una matrice sdp.
    %
    %                                                          Rel. 2026-01-07.
    sigma = pi^(-2*k);
    rng(0);
    [q1,~] = qr(rand(n));
    if nargin==3
        q2 = q1';
        B  = 0;
    else
        [q2,~] = qr(rand(n));
        B      = diag(ones(n-1,1),1);
    end
    A = q1*(diag([sigma 2/n:1/n:1])+B)*q2;
    b = sum(A,2);
    return
    ```
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
  L'esperimento è stato condotto risolvendo i sistemi lineari generati dalla funzione `linsis.m` per $n=10$ e valori di $k$ da 1 a 15, utilizzando la funzione `LUSolve` implementata nell'esercizio 8. Di seguito si riportano i risultati ottenuti in termini di numero di condizionamento della matrice $A$ (in norma infinito) e di errore relativo della soluzione calcolata rispetto alla soluzione esatta $x_{e} = [1, 1, ..., 1]^T$.

  #tabella_risultati(
    caption: [Risultati numerici per $k=1 dots 15$ con $n=10$.],
    columns: (auto, auto, auto),
    [*$k$*],
    [*$op("cond")(A, infinity)$*],
    [*Errore $||x - x_e||_infinity$*],
    [1],
    [$3.72 times 10^4$],
    [$2.53 times 10^(-13)$],
    [2],
    [$3.64 times 10^5$],
    [$5.04 times 10^(-12)$],
    [3],
    [$3.59 times 10^6$],
    [$2.24 times 10^(-10)$],
    [4],
    [$3.55 times 10^7$],
    [$1.47 times 10^(-9)$],
    [5],
    [$3.50 times 10^8$],
    [$4.84 times 10^(-9)$],
    [6],
    [$3.45 times 10^9$],
    [$1.43 times 10^(-7)$],
    [7],
    [$3.41 times 10^10$],
    [$2.36 times 10^(-7)$],
    [8],
    [$3.36 times 10^11$],
    [$1.05 times 10^(-5)$],
    [9],
    [$3.32 times 10^12$],
    [$3.45 times 10^(-5)$],
    [10],
    [$3.28 times 10^13$],
    [$2.27 times 10^(-4)$],
    [11],
    [$3.24 times 10^14$],
    [$2.24 times 10^(-3)$],
    [12],
    [$3.11 times 10^15$],
    [$5.38 times 10^(-2)$],
    [13],
    [$4.82 times 10^16$],
    [---],
    [14],
    [$1.33 times 10^17$],
    [---],
    [15],
    [$1.06 times 10^17$],
    [---],
  )

  #figure(
    image("../img/es09.png", width: 80%),
    caption: [Andamento dell'errore e del limite teorico al variare del parametro $k$.],
  )

  === Analisi dei risultati

  Dalla tabella si evince chiaramente che:
  - Il numero di condizionamento $op("cond")(A, infinity)$ cresce esponenzialmente con $k$, aumentando di circa un fattore 10 per ogni incremento di $k$.
  - L'errore relativo segue lo stesso trend, crescendo proporzionalmente al numero di condizionamento. Questo è coerente con la teoria della stabilità numerica dei sistemi lineari, secondo cui l'errore sulla soluzione è limitato superiormente dal prodotto tra il numero di condizionamento e la precisione di macchina $epsilon_"mach" approx 2.22 times 10^(-16)$.
  - Per $k=12$, il numero di condizionamento raggiunge l'ordine di $10^15$. L'errore risultante è circa $10^(-2)$, indicando che la soluzione ha perso quasi tutte le cifre significative di precisione.
  - Per $k >= 13$, il numero di condizionamento supera l'inverso della precisione di macchina ($1/epsilon_"mach" approx 4.5 times 10^15$). In queste condizioni, la matrice risulta numericamente singolare. La funzione `LUSolve` identifica correttamente la situazione tramite il controllo sul valore assoluto dei pivot e interrompe l'esecuzione segnalando l'errore di singolarità.

  #nota[
    Il comportamento osservato dimostra come l'accuratezza della soluzione calcolata dipenda drasticamente dal condizionamento del problema, indipendentemente dalla stabilità dell'algoritmo di risoluzione usato (in questo caso la fattorizzazione $L U$ con pivoting parziale).
  ]

  #rimando[Lo script MATLAB utilizzato per la generazione di questi dati è `test_es09.m`.]
]
