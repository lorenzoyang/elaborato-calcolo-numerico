#import "../conf.typ": esercizio, rimando, tabella_risultati

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
]
