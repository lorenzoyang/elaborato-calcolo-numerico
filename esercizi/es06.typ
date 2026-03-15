#import "../conf.typ": esercizio

#esercizio(
  "6",
  [
    Tabulare il costo computazionale dei precedenti metodi, in termini di valutazioni di funzione, per determinare lo zero della funzione
    $ f(x) = sin(10x) + arctan(10x) $
    con la massima accuratezza possibile. Utilizzare $x_0 = 10$ per il metodo di Newton, e l'intervallo iniziale $[-10.1, 10]$ per il metodo di bisezione ed il metodo ibrido. Per quest'ultimo, utilizzare $delta = 10^(-1)$ come valore di _switch_ tra i due metodi. Commentare i risultati ottenuti.
  ],
)[
  === Analisi Teorica
  La funzione $f(x) = sin(10x) + arctan(10x)$ si annulla esattamente nell'origine ($x^* = 0$). Tuttavia, il termine trigonometrico introduce forti oscillazioni lontano dallo zero. La derivata $f'(x) = 10 cos(10x) + 10 / (1 + (10x)^2)$ cambia di segno molto frequentemente, rendendo l'intorno di $x_0 = 10$ una zona estremamente instabile per i metodi basati sulle tangenti.

  === Tabella dei Costi Computazionali
  Considerando come "massima accuratezza" una tolleranza prossima alla precisione di macchina (ordine di $10^(-15)$), i test empirici restituiscono i seguenti risultati:

  #figure(
    table(
      columns: (auto, auto, auto, auto),
      inset: 10pt,
      align: center + horizon,
      [*Metodo*], [*Iterazioni*], [*Valutazioni Totali ($f$ o $f'$)*], [*Esito*],
      [Bisezione], [54], [56], [Successo],
      [Newton ($x_0 = 10$)], [1000 (Max)], [2000], [Fallimento],
      [Ibrido ($delta = 0.1$)], [8 (Bis) + 4 (New)], [18], [Successo],
    ),
    caption: [Confronto del costo computazionale dei metodi.],
  )

  === Commento ai Risultati
  - *Metodo di Bisezione*: Si dimostra robusto garantendo la convergenza globale. Il costo è di 2 valutazioni iniziali più 1 per ogni iterazione. Essendo la convergenza lineare, per raggiungere la precisione massima su un intervallo di ampiezza $approx 20$ sono necessarie ben 54 iterazioni, risultando affidabile ma lento.
  - *Metodo di Newton*: Con innesco in $x_0 = 10$, il metodo fallisce. Le marcate oscillazioni della funzione "ingannano" le tangenti calcolate localmente, proiettando le approssimazioni successive sempre più lontano dal vero zero, portando l'algoritmo a divergere o a ciclare a vuoto.
  - *Metodo Ibrido*: Risulta di gran lunga l'approccio più efficiente. Sfrutta la sicurezza della bisezione per i primi 8 passi, "navigando" in modo sicuro oltre le zone di instabilità fino a che l'intervallo non scende sotto la soglia $delta = 0.1$. Trovandosi ora nel bacino di attrazione di $x^* = 0$, attiva il metodo di Newton che garantisce una rapidissima convergenza quadratica in sole 4 iterazioni. Il costo totale crolla a sole 18 valutazioni complessive.
]
