// Questa riga carica il riquadro della domanda e il titolo dell'esercizio.
#import "../conf.typ": esercizio

#esercizio(
  "1", // Numero dell'esercizio: cambia solo il valore tra virgolette.
  [
    // Sostituisci il testo qui sotto con la tua domanda.
    // Conserva le parentesi quadre che lo racchiudono.
    Calcolare $f(2)$ per $f(x) = x^2 + 1$ e verificare il risultato in MATLAB.
  ],
)[
  // Sostituisci il contenuto di questo blocco con il tuo svolgimento.
  // Le righe che iniziano con // sono commenti e non appaiono nel PDF.
  Sostituendo $x = 2$ nella funzione, otteniamo:

  $ f(2) = 2^2 + 1 = 5. $

  === Verifica in MATLAB

  Il seguente codice permette di controllare il calcolo:

  ```matlab
  x = 2;
  risultato = x^2 + 1
  ```

  Eseguendolo in MATLAB si ottiene `risultato = 5`.
]
