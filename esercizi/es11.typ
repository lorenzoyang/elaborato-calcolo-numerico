#import "../conf.typ": esercizio, nota, rimando, tabella_risultati

#esercizio(
  "11",
  [
    Utilizzando la function `linsis.m` su menzionata, utilizzare la function del precedente esercizio per risolvere i sistemi lineari, con matrice sdp, ottenuti con le seguenti istruzioni:

    ```matlab
    n = 10;
    for k = 1:15
        [A,b] = linsis(n,k,1);
    end
    ```

    Rappresentare _convenientemente_ l'andamento dell'errore, rispetto ad `k`, e spiegare _esaurientemente_ i risultati ottenuti.
  ],
)[
  Nella tabella seguente sono riportati il numero di condizionamento in norma 2 della matrice $A$ e l'errore relativo calcolato come $E_"rel" = frac(||x - x_e||_2, ||x_e||_2)$, dove $x_e$ è la soluzione esatta $[1, dots, 1]^T$.

  #tabella_risultati(
    caption: [Analisi dell'errore per sistemi s.d.p. ($n=10$).],
    columns: (auto, auto, auto),
    [*$k$*],
    [*$op("cond")_2(A)$*],
    [*Errore Relativo*],
    [1],
    [$9.87 times 10^0$],
    [$2.46 times 10^(-16)$],
    [2],
    [$9.74 times 10^1$],
    [$2.67 times 10^(-15)$],
    [3],
    [$9.61 times 10^2$],
    [$3.30 times 10^(-14)$],
    [4],
    [$9.49 times 10^3$],
    [$3.39 times 10^(-14)$],
    [5],
    [$9.36 times 10^4$],
    [$4.85 times 10^(-12)$],
    [6],
    [$9.24 times 10^5$],
    [$4.01 times 10^(-12)$],
    [7],
    [$9.12 times 10^6$],
    [$3.41 times 10^(-11)$],
    [8],
    [$9.00 times 10^7$],
    [$1.98 times 10^(-09)$],
    [9],
    [$8.89 times 10^8$],
    [$3.55 times 10^(-08)$],
    [10],
    [$8.77 times 10^9$],
    [$4.19 times 10^(-07)$],
    [11],
    [$8.66 times 10^10$],
    [$2.11 times 10^(-07)$],
    [12],
    [$8.54 times 10^11$],
    [$2.68 times 10^(-05)$],
    [13],
    [$8.43 times 10^12$],
    [$1.99 times 10^(-04)$],
    [14],
    [$8.30 times 10^13$],
    [$1.88 times 10^(-03)$],
    [15],
    [$7.76 times 10^14$],
    [$7.09 times 10^(-03)$],
  )

  #figure(
    image("../img/es11.png", width: 80%),
    caption: [Andamento dell'errore relativo e del limite teorico per il caso s.d.p.],
  )

  === Analisi dei risultati

  Dall'analisi dei dati e del grafico si possono trarre le seguenti conclusioni:

  - *Legame tra errore e condizionamento*: L'errore relativo cresce (in scala
    semi-logaritmica) approssimativamente in modo lineare rispetto a $k$,
    seguendo l'andamento del numero di condizionamento. Come stabilito
    dall'analisi perturbativa, vale la maggiorazione
    $
      frac(||Delta x||, ||x||)
      <= kappa(A) lr((frac(||Delta b||, ||b||) + frac(||Delta A||, ||A||)))
    $
    dove i termini $||Delta b|| \/ ||b||$ e $||Delta A|| \/ ||A||$ sono
    dell'ordine della precisione di macchina $epsilon_"mach" approx 2.22 times
    10^(-16)$. Il grafico mostra che la curva dell'errore si mantiene al di
    sotto del limite teorico $kappa_2(A) dot.op epsilon_"mach"$ per tutti i
    valori di $k$, confermando la stabilità numerica dell'algoritmo $L D L^T$.

  - *Stabilità numerica della fattorizzazione $L D L^T$*: La proprietà di
    essere simmetrica definita positiva non implica di per sé un migliore
    condizionamento rispetto al caso generale, ma garantisce l'esistenza e
    l'unicità della fattorizzazione $L D L^T$ senza necessità di pivoting,
    e la stabilità numerica del metodo.

  #rimando[Lo script MATLAB utilizzato per la generazione di questi dati è `test_es11.m`.]
]
