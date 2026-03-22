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
  Per la risoluzione dei sistemi lineari con matrice simmetrica e definita positiva (s.d.p.), si è utilizzata la funzione `LDLSolve` implementata nell'Esercizio 10. Il parametro $n$ è stato fissato a 10, mentre il parametro $k$ è stato fatto variare da 1 a 15.

  La funzione `linsis(n, k, 1)` genera una matrice $A$ s.d.p. e un termine noto $b$ tale che la soluzione esatta sia il vettore unitario $x = [1, 1, dots, 1]^T$. Analizzando il codice di `linsis.m`, si osserva che gli autovalori della matrice $A$ sono definiti come $sigma = pi^(-2k)$ e l'insieme ${2/n, 3/n, dots, 1}$. Per $n=10$, gli autovalori sono quindi:
  $ lambda = {pi^(-2k), 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0} $

  Il numero di condizionamento in norma 2 per una matrice s.d.p. è dato dal rapporto tra l'autovalore massimo e quello minimo:
  $ kappa_2(A) = frac(lambda_max, lambda_min) = frac(1, min(pi^(-2k), 0.2)) $

  Al crescere di $k$, il valore $sigma = pi^(-2k)$ diminuisce rapidamente, diventando l'autovalore minimo e determinando un aumento esponenziale del numero di condizionamento: $kappa_2(A) approx pi^(2k)$.

  I risultati numerici ottenuti sono riportati nella tabella seguente:

  #tabella_risultati(
    caption: [Risultati della risoluzione dei sistemi lineari per n=10 e k=1:15],
    columns: (auto, auto, auto),
    table.header([$k$], [Numero di condizionamento], [Errore relativo]),
    [1],
    [9.8696e+00],
    [2.4576e-16],
    [2],
    [9.7409e+01],
    [2.6747e-15],
    [3],
    [9.6139e+02],
    [3.3046e-14],
    [4],
    [9.4885e+03],
    [3.3890e-14],
    [5],
    [9.3648e+04],
    [4.8483e-12],
    [6],
    [9.2427e+05],
    [4.0054e-12],
    [7],
    [9.1222e+06],
    [3.4117e-11],
    [8],
    [9.0032e+07],
    [1.9829e-09],
    [9],
    [8.8858e+08],
    [3.5502e-08],
    [10],
    [8.7700e+09],
    [4.1859e-07],
    [11],
    [8.6556e+10],
    [2.1068e-07],
    [12],
    [8.5429e+11],
    [2.6828e-05],
    [13],
    [8.4349e+12],
    [1.9865e-04],
    [14],
    [8.3045e+13],
    [1.8778e-03],
    [15],
    [7.7556e+14],
    [7.0865e-03],
  )

  Di seguito viene mostrato l'andamento dell'errore relativo e del prodotto tra il numero di condizionamento e la precisione di macchina $epsilon approx 2.22 times 10^(-16)$ (regola del pollice per l'errore atteso).

  *Conclusioni:*
  Dall'analisi dei risultati e del grafico si evince che:
  - L'errore relativo cresce linearmente (in scala semilogaritmica) rispetto a $k$, seguendo fedelmente l'andamento del numero di condizionamento.
  - Per $k=15$, il numero di condizionamento raggiunge valori prossimi a $10^(15)$, il che comporta una perdita quasi totale di cifre significative, coerentemente con il fatto che la precisione doppia di IEEE 754 garantisce circa 16 cifre decimali.
  - L'errore osservato rimane mediamente al di sotto della stima teorica $kappa(A) times epsilon$, confermando l'efficienza e la stabilità dell'algoritmo `LDLSolve` per matrici s.d.p., pur nei limiti intrinseci dell'aritmetica finita.

  #rimando[Lo script MATLAB utilizzato per questa analisi è `test_es11.m`]
]
