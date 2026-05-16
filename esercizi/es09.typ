#import "../conf.typ": esercizio, nota, rimando, tabella_risultati

#esercizio(
  "9",
  [
    Al seguente link: https://drive.google.com/file/d/1Fp8xFhUONS2W-l4alRKmomRxoM1SeVny/view?usp=share_link

    ```matlab
    % codice fornito dal professore per l'esercizio 9

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
  Misuriamo l'accuratezza con l'errore in norma infinito
  $
    e_k = ||x_k - x^*||_infinity,
  $
  e lo rappresentiamo in scala semilogaritmica rispetto a $k$, così da evidenziarne la crescita su più ordini di grandezza.

  === Risultati numerici
  I test empirici forniscono i seguenti risultati:

  #tabella_risultati(
    caption: [Andamento dell'errore di `LUSolve` al variare di $k$ per $n = 10$.],
    columns: (auto, auto, auto, auto),
    align: center + horizon,
    [*k*],
    [*$sigma_k = pi^(-2k)$*],
    [*$kappa_2(A_k)$*],
    [*$||x_k - 1||_infinity$*],
    [1],
    [$1.0132 dot 10^(-1)$],
    [$9.2774 dot 10^3$],
    [$2.5313 dot 10^(-13)$],
    [2],
    [$1.0266 dot 10^(-2)$],
    [$9.1082 dot 10^4$],
    [$5.0440 dot 10^(-12)$],
    [3],
    [$1.0402 dot 10^(-3)$],
    [$8.9890 dot 10^5$],
    [$2.2374 dot 10^(-10)$],
    [4],
    [$1.0539 dot 10^(-4)$],
    [$8.8717 dot 10^6$],
    [$1.4721 dot 10^(-9)$],
    [5],
    [$1.0678 dot 10^(-5)$],
    [$8.7561 dot 10^7$],
    [$4.8428 dot 10^(-9)$],
    [6],
    [$1.0819 dot 10^(-6)$],
    [$8.6419 dot 10^8$],
    [$1.4339 dot 10^(-7)$],
    [7],
    [$1.0962 dot 10^(-7)$],
    [$8.5292 dot 10^9$],
    [$2.3587 dot 10^(-7)$],
    [8],
    [$1.1107 dot 10^(-8)$],
    [$8.4180 dot 10^10$],
    [$1.0476 dot 10^(-5)$],
    [9],
    [$1.1254 dot 10^(-9)$],
    [$8.3084 dot 10^11$],
    [$3.4464 dot 10^(-5)$],
    [10],
    [$1.1403 dot 10^(-10)$],
    [$8.2068 dot 10^12$],
    [$2.2674 dot 10^(-4)$],
    [11],
    [$1.1553 dot 10^(-11)$],
    [$8.1185 dot 10^13$],
    [$2.2438 dot 10^(-3)$],
    [12],
    [$1.1706 dot 10^(-12)$],
    [$8.3345 dot 10^14$],
    [$5.3792 dot 10^(-2)$],
    [13],
    [$1.1861 dot 10^(-13)$],
    [$1.4299 dot 10^16$],
    [arresto della routine],
    [14],
    [$1.2017 dot 10^(-14)$],
    [$4.2866 dot 10^16$],
    [arresto della routine],
    [15],
    [$1.2176 dot 10^(-15)$],
    [$2.3192 dot 10^16$],
    [arresto della routine],
  )

  #figure(
    image("../img/es09.png", width: 78%),
    caption: [Grafico semilogaritmico dell'errore in norma infinito rispetto a $k$.],
  )

  #nota[
    Per $k = 13, 14, 15$ la function `LUSolve` si interrompe con il messaggio `"Matrice singolare o quasi singolare."`. Questo comportamento non contraddice la costruzione teorica del sistema: segnala che, in aritmetica finita, i pivot diventano confrontabili con la soglia di sicurezza usata nel codice.
  ]

  === Commento dei risultati
  I dati evidenziano tre fenomeni.

  - *Per valori piccoli di $k$* la matrice è ancora moderatamente ben condizionata e l'errore resta vicino alla precisione di macchina; per $k = 1$ è circa $2.5 dot 10^(-13)$.

  - *All'aumentare di $k$* il parametro $sigma_k = pi^(-2k)$ si riduce di circa un fattore $pi^2$ a ogni passo, mentre il numero di condizionamento cresce approssimativamente come $1 / sigma_k$. Nei primi dodici casi il prodotto $kappa_2(A_k) sigma_k$ resta quasi costante, quindi il peggioramento è governato dal primo elemento diagonale.

  - *L'errore cresce rapidamente*: quando $kappa_2(A_k)$ arriva a circa $10^15$, gli errori di arrotondamento vengono fortemente amplificati. È il comportamento previsto per un problema mal condizionato.

  Per $k = 12$ si osserva infatti un salto netto dell'errore a circa $5 dot 10^(-2)$. Da $k = 13$ in poi la matrice entra in una zona numericamente quasi singolare: la soglia
  $
    "tol" = n dot "eps" dot ||A||_1
  $
  inserita in `LUSolve` intercetta pivot troppo piccoli e interrompe opportunamente l'algoritmo.

  Il risultato distingue quindi il condizionamento del problema, che peggiora rapidamente con $k$, dall'accuratezza della soluzione, che decade fino al fallimento pratico della risoluzione numerica.

  #rimando[Per riprodurre tabella e grafico riportati, si faccia riferimento allo script MATLAB allegato denominato `test_es09.m`.]
]
