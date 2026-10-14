# Consigli pratici per preparare l'elaborato

Due accorgimenti per risparmiare tempo con la trascrizione delle tracce e
l'uso delle dispense. Per preparare il documento, segui la [guida Typst](guida-typst.md).

## Dallo screenshot alla domanda in Typst

Allega uno screenshot leggibile della traccia a una **chat AI che accetta
immagini** e chiedi:

> Trascrivi la domanda in Typst, mantenendo testo, formule e sottopunti.
> Restituisci solo il contenuto della domanda, senza titolo, svolgimento o
> spiegazioni. Non aggiungere funzioni, parentesi quadre esterne o delimitatori
> Markdown. Se qualcosa non è leggibile, segnalamelo senza indovinarlo.

Incolla la risposta nel blocco della domanda del tuo file:

```typst
#esercizio("1", [
  // Incolla qui il testo della domanda.
])[
  Scrivi qui lo svolgimento.
]
```

La chat non deve conoscere `#esercizio()`: il titolo è già gestito dal modello.
Controlla che formule e dati corrispondano allo screenshot. Per una traccia
breve puoi anche scrivere direttamente la domanda, senza usare l'AI.

## Usa le dispense pertinenti con un AI Agent

Raccogli le dispense del **tuo anno** in una cartella, per esempio `dispense/`.
Prima di affrontare un esercizio, individua le lezioni che trattano l'argomento.

Se usi un **AI Agent con accesso alla cartella e in grado di leggere i PDF**,
indicagli i file specifici da consultare. Per esempio:

> Aiutami a capire questo esercizio: [incolla la traccia].
> Leggi soltanto queste dispense locali: [percorsi dei file pertinenti].
> Segui la notazione e i metodi del corso e spiegami i passaggi.
> Se non puoi leggere un file o serve altro materiale, segnalamelo.

Sostituisci i segnaposto con la traccia e i percorsi reali, per esempio
`dispense/lezione-20-interpolazione.pdf`. Non serve fargli leggere tutte le
lezioni ogni volta. In una normale chat, invece, allega i PDF selezionati:
il solo percorso sul tuo computer non le permette di aprirli.

## Prima di consegnare

- Verifica i passaggi matematici con la traccia e le dispense.
- Esegui il codice in MATLAB e usa i risultati ottenuti per tabelle e grafici:
  Typst mostra il codice nel PDF, ma non lo esegue.
- Controlla il PDF esportato, comprese formule e dati della copertina.

[Torna alla guida](guida-typst.md) · [Torna al README](../README.md)
