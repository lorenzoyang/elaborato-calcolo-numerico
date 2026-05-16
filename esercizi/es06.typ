#import "../conf.typ": esercizio, rimando, tabella_risultati

#esercizio(
  "6",
  [
    Tabulare il costo computazionale dei precedenti metodi, in termini di valutazioni di funzione, per determinare lo zero della funzione
    $ f(x) = sin(10x) + arctan(10x) $
    con la massima accuratezza possibile. Utilizzare $x_0 = 10$ per il metodo di Newton, e l'intervallo iniziale $[-10.1, 10]$ per il metodo di bisezione ed il metodo ibrido. Per quest'ultimo, utilizzare $delta = 10^(-1)$ come valore di _switch_ tra i due metodi. Commentare i risultati ottenuti.
  ],
)[
  === Analisi teorica
  La funzione $f(x) = sin(10x) + arctan(10x)$ si annulla esattamente nell'origine ($x^* = 0$). Il termine trigonometrico la rende però oscillante e la derivata $f'(x) = 10 cos(10x) + 10 / (1 + (10x)^2)$ cambia segno spesso; l'innesco $x_0 = 10$ è quindi sfavorevole per Newton.

  === Costi computazionali
  Con tolleranza dell'ordine di $10^(-15)$ si ottengono i risultati seguenti:

  #tabella_risultati(
    caption: [Confronto del costo computazionale dei metodi.],
    columns: (auto, auto, auto, auto),
    align: center + horizon,
    [*Metodo*],
    [*Iterazioni*],
    [*Valutazioni Totali ($f$ o $f'$)*],
    [*Esito*],
    [Bisezione],
    [54],
    [56],
    [Successo],
    [Newton ($x_0 = 10$)],
    [1000 (Max)],
    [2000],
    [Fallimento],
    [Ibrido ($delta = 0.1$)],
    [8 (Bis) + 3 (New)],
    [16],
    [Successo],
  )

  #rimando[per eseguire i test empirici e riprodurre i dati riportati in questa tabella, si faccia riferimento allo script MATLAB allegato denominato `test_metodi_zeri.m`.]

  === Commento
  - *Bisezione*: converge sempre, ma solo linearmente; servono 54 iterazioni e 56 valutazioni di funzione.
  - *Newton*: con $x_0 = 10$ non converge, perché le tangenti sono calcolate in una zona oscillante e allontanano gli iterati dalla radice, fino al limite di 1000 iterazioni.
  - *Ibrido*: la bisezione porta l'intervallo sotto $delta = 0.1$; da lì Newton converge in 3 iterazioni, con 16 valutazioni totali.
]
