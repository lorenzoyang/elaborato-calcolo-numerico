#import "../conf.typ": esercizio, rimando, tabella_risultati

#esercizio(
  "6",
  [
    Tabulare il costo computazionale dei precedenti metodi, in termini di valutazioni di funzione, per determinare lo zero della funzione
    $ f(x) = sin(10x) + arctan(10x) $
    con la massima accuratezza possibile. Utilizzare $x_0 = 10$ per il metodo di Newton, e l'intervallo iniziale $[-10.1, 10]$ per il metodo di bisezione ed il metodo ibrido. Per quest'ultimo, utilizzare $delta = 10^(-1)$ come valore di _switch_ tra i due metodi. Commentare i risultati ottenuti.
  ],
)[
  === Analisi Teorica
  La funzione $f(x) = sin(10x) + arctan(10x)$ si annulla esattamente nell'origine ($x^* = 0$). Tuttavia, il termine trigonometrico la rende fortemente oscillante. La derivata $f'(x) = 10 cos(10x) + 10 / (1 + (10x)^2)$ cambia segno molto di frequente: questo significa che partire da un punto lontano come $x_0 = 10$ ci mette in una zona decisamente "pericolosa" e instabile per i metodi basati sulle tangenti.

  === Tabella dei Costi Computazionali
  Considerando come "massima accuratezza" una tolleranza vicina alla precisione di macchina (ordine di $10^(-15)$), i test empirici restituiscono i seguenti risultati:

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

  === Commento ai Risultati
  - *Metodo di Bisezione*: Fa il suo dovere ed è una garanzia per arrivare a convergenza, ma è decisamente lento. Avanzando in modo lineare, per dimezzare un intervallo largo 20 fino alla precisione di macchina servono ben 54 iterazioni. È un approccio sicuro, ma con un costo di 56 valutazioni totali.
  - *Metodo di Newton*: Partendo da $x_0 = 10$, è un vero e proprio disastro. Le continue oscillazioni della funzione fanno sballare il calcolo locale delle derivate. Invece di puntare verso lo zero, le tangenti proiettano le stime lontanissime dalla radice vera, portando l'algoritmo a vagare a vuoto fino a colpire il limite massimo di 1000 iterazioni senza mai convergere.
  - *Metodo Ibrido*: È senza dubbio la strategia vincente perché prende il meglio dei due mondi. Usa la bisezione per le prime 8 iterazioni, facendoci superare in sicurezza tutta la zona instabile fino a far scendere l'intervallo sotto la soglia $delta = 0.1$. A quel punto ci troviamo vicinissimi allo zero e possiamo attivare Newton senza rischi: bastano solo 3 iterazioni per far scattare la sua rapidissima convergenza quadratica. Il risultato è la massima precisione ottenuta con appena 16 valutazioni complessive.
]
