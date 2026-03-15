#import "../conf.typ": esercizio

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
