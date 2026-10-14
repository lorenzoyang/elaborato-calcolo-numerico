# Elaborato di Calcolo Numerico

Il mio elaborato di **Calcolo Numerico**, anno accademico **2025–2026**:
30 esercizi svolti, sorgenti **Typst** e codice **MATLAB** per implementazioni,
test numerici, tabelle e grafici.

**[Scarica il PDF finale e il codice MATLAB dalle Releases](https://github.com/lorenzoyang/elaborato-calcolo-numerico/releases).**
Puoi anche [sfogliare il PDF nel repository](elaborato.pdf).

## Vuoi usare questo stile per il tuo elaborato?

Il professore non aveva imposto uno stile per il PDF, quindi ho scelto di
realizzare l'impaginazione con Typst: copertina, indice, riquadri delle domande,
formule, tabelle e blocchi di codice.

Le tracce cambiano ogni anno: questo elaborato resta un esempio del lavoro
svolto nel 2025–2026. Puoi però **riutilizzare lo stile per scrivere il tuo**,
con gli esercizi e le dispense del tuo anno.

- **[Inizia dalla guida passo passo](docs/guida-typst.md)**: installa VS Code
  e Tinymist Typst, personalizza il modello ed esporta il PDF.
- **[Leggi i consigli pratici](docs/consigli.md)**: trascrivi le tracce,
  organizza le dispense e usa un AI Agent con i file locali pertinenti.

La guida parte da zero ed è pensata soprattutto per Windows. Per questo
progetto bastano **VS Code e l'estensione Tinymist Typst**.

## Cosa trovi nel progetto

| Percorso | Contenuto |
| --- | --- |
| `elaborato.typ` | Documento principale del mio elaborato completo. |
| `conf.typ` | Stile condiviso e componenti riutilizzabili. |
| `modello.typ` | Punto di partenza con dati da personalizzare e un solo esercizio. |
| `esercizi/` | I 30 esercizi originali e il file iniziale `esempio.typ`. |
| `codice-matlab/` | Funzioni richieste dagli esercizi e script di verifica. |
| `img/` | Logo e figure del documento. |
| `dispense/` | Dispense di riferimento del corso 2025–2026. |
| `docs/` | Guida all'uso dello stile e consigli pratici. |
| `consegna-progetto-elaborato/` | PDF finale e ZIP MATLAB preparati per la consegna. |

Per visualizzare o esportare il documento completo in VS Code, apri
`elaborato.typ` e segui il [passaggio dedicato della guida](docs/guida-typst.md#7-vedi-lanteprima-ed-esporta-il-pdf).

## Eseguire il codice MATLAB

La cartella `codice-matlab/` contiene sia le implementazioni richieste dalle
tracce sia gli script per verificarle e produrre i risultati dell'elaborato.

Apri MATLAB e seleziona la cartella principale del progetto come **Cartella
corrente / Current Folder**. Nella finestra dei comandi, per esempio:

```matlab
cd codice-matlab
test_es09
```

Puoi eseguire gli altri script `test_*.m` nello stesso modo. Se sei già dentro
`codice-matlab/`, scrivi direttamente il nome dello script senza `.m`.
