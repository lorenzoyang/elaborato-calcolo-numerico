#import "conf.typ": conf, esercizio

#set document(title: [Elaborato Calcolo Numerico 2025-2026])

#show: conf.with(
  autore: "Lorenzo Yang",
  matricola: "7136074",
  email: "lorenzo.yang@edu.unifi.it",
  anno_acc: "2025-2026",
  data: "Giugno 2026",
  logo: "img/unifi-logo.png",
)

#include "esercizi/es01.typ"

#include "esercizi/es02.typ"

#include "esercizi/es03.typ"

#include "esercizi/es04.typ"

#include "esercizi/es05.typ"

#include "esercizi/es06.typ"

#esercizio(
  "7",
  [Scrivere una function Matlab, con sintassi `x = triup(U,b)`, che risolva un sistema triangolare superiore $n times n$, in cui la matrice dei coefficienti `U` è memorizzata, per colonne, in un vettore di lunghezza $n(n+1)/2$.],
)[
]

#esercizio(
  "8",
  [Scrivere una function che implementi efficientemente la risoluzione di un sistema lineare mediante la fattorizzazione $L U$ con pivoting parziale. Validare la function su alcuni esempi significativi.],
)[
]

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

#esercizio(
  "10",
  [],
)[
]

#esercizio(
  "11",
  [],
)[
]

#esercizio(
  "12",
  [],
)[
]

#esercizio(
  "13",
  [],
)[
]

#esercizio(
  "14",
  [],
)[
]

#esercizio(
  "15",
  [Inserire qui il testo ufficiale della consegna dal PDF (Esercizio 15).],
)[
]

