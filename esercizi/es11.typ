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
  Anche qui la soluzione esatta è
  $
    x^* = (1, dots, 1)^T,
  $
  e l'accuratezza si misura con l'errore in norma infinito
  $
    e_k = ||x_k - x^*||_infinity.
  $
  Poiché l'errore varia su più ordini di grandezza, conviene rappresentare $e_k$ in scala semilogaritmica rispetto a $k$.

  === Risultati numerici
  Per i quindici sistemi richiesti si ottengono i valori seguenti.

  #tabella_risultati(
    caption: [Andamento dell'errore di `LDLSolve` al variare di $k$ per $n = 10$.],
    columns: (auto, auto, auto, auto),
    align: center + horizon,
    [*k*],
    [*$sigma_k = pi^(-2k)$*],
    [*$kappa_2(A_k)$*],
    [*$||x_k - 1||_infinity$*],
    [1],
    [$1.0132 dot 10^(-1)$],
    [$9.8696$],
    [$5.5511 dot 10^(-16)$],
    [2],
    [$1.0266 dot 10^(-2)$],
    [$9.7409 dot 10^(1)$],
    [$3.7748 dot 10^(-15)$],
    [3],
    [$1.0402 dot 10^(-3)$],
    [$9.6139 dot 10^(2)$],
    [$4.5297 dot 10^(-14)$],
    [4],
    [$1.0539 dot 10^(-4)$],
    [$9.4885 dot 10^(3)$],
    [$4.6407 dot 10^(-14)$],
    [5],
    [$1.0678 dot 10^(-5)$],
    [$9.3648 dot 10^(4)$],
    [$6.6367 dot 10^(-12)$],
    [6],
    [$1.0819 dot 10^(-6)$],
    [$9.2427 dot 10^(5)$],
    [$5.4831 dot 10^(-12)$],
    [7],
    [$1.0962 dot 10^(-7)$],
    [$9.1222 dot 10^(6)$],
    [$4.6703 dot 10^(-11)$],
    [8],
    [$1.1107 dot 10^(-8)$],
    [$9.0032 dot 10^(7)$],
    [$2.7144 dot 10^(-9)$],
    [9],
    [$1.1254 dot 10^(-9)$],
    [$8.8858 dot 10^(8)$],
    [$4.8598 dot 10^(-8)$],
    [10],
    [$1.1403 dot 10^(-10)$],
    [$8.7700 dot 10^(9)$],
    [$5.7300 dot 10^(-7)$],
    [11],
    [$1.1553 dot 10^(-11)$],
    [$8.6556 dot 10^(10)$],
    [$2.8839 dot 10^(-7)$],
    [12],
    [$1.1706 dot 10^(-12)$],
    [$8.5429 dot 10^(11)$],
    [$3.6724 dot 10^(-5)$],
    [13],
    [$1.1861 dot 10^(-13)$],
    [$8.4349 dot 10^(12)$],
    [$2.7192 dot 10^(-4)$],
    [14],
    [$1.2017 dot 10^(-14)$],
    [$8.3045 dot 10^(13)$],
    [$2.5704 dot 10^(-3)$],
    [15],
    [$1.2176 dot 10^(-15)$],
    [$7.7556 dot 10^(14)$],
    [$9.7005 dot 10^(-3)$],
  )

  #figure(
    image("../img/es11.png", width: 78%),
    caption: [Grafico semilogaritmico dell'errore in norma infinito rispetto a $k$ nel caso s.d.p..],
  )

  === Commento dei risultati
  L'errore cresce con $k$: $sigma_k = pi^(-2k)$ diminuisce, il numero di condizione aumenta e gli arrotondamenti vengono amplificati. In questo caso la matrice resta s.d.p., quindi la fattorizzazione $L D L^T$ rimane adatta; l'accuratezza però peggiora fino a circa $10^(-2)$ per $k = 15$.

  La differenza rispetto all'esercizio 9 non è che il condizionamento sparisca, ma che la struttura s.d.p. consente di arrivare alla fine della fattorizzazione senza la soglia di arresto incontrata da `LUSolve`.

  #rimando[Script MATLAB: `test_es11.m`.]
]
