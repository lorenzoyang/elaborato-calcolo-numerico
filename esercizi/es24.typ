#import "../conf.typ": esercizio

#esercizio(
  "24",
  [
    Utilizzando la function del precedente esercizio 22, scrivere la function Matlab,

    ```matlab
    y = spline3( xi, fi, x, type, f1a, f1b )
    ```

    in cui `(xi, fi)` sono i dati di interpolazione e `x` è un vettore (riga o colonna), contenente i punti in cui valutare la spline cubica interpolante, restituiti nel vettore `y`, che avrà le stesse dimensioni di `x`. Infine, `type` è un flag che vale 1 (valore di default) per la spline cubica not-a-knot, 0 per quella naturale, 2 per la spline cubica completa. In quest'ultimo caso, gli ultimi due parametri di ingresso (opzionali) contengono il valore della derivata della funzione interpolante negli estremi.
  ],
)[

]
