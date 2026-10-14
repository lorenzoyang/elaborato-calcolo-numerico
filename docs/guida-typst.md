# Scrivi il tuo elaborato con questo stile

Questa guida ti accompagna dal download al primo PDF, anche se non hai mai
usato Typst. Le istruzioni sono pensate soprattutto per Windows.

Lo stile è una mia scelta personale per l'elaborato, non un modello imposto
dal professore. Usa le tracce del tuo anno e controlla le indicazioni di
consegna del corso.

## 1. Capisci quali strumenti userai

- **Typst** trasforma testo e poche istruzioni di formattazione in un PDF.
  Scrivi nei file `.typ` e vedi il documento impaginato nell'anteprima.
- **Visual Studio Code (VS Code)** è il programma in cui apri e modifichi i file.
- **Tinymist Typst** è l'estensione di VS Code che aggiunge il supporto a
  Typst, l'anteprima e l'esportazione del PDF.

Tinymist include già il compilatore Typst: per questo progetto bastano
**VS Code e Tinymist**, senza installare Typst separatamente.
Vedi la [documentazione ufficiale di Tinymist](https://myriad-dreamin.github.io/tinymist/feature/compiler-settings.html).

## 2. Installa VS Code e Tinymist

1. Scarica **Visual Studio Code** dal [sito ufficiale](https://code.visualstudio.com/download).
   Su Windows scegli l'installer **User Installer** per il tuo computer,
   aprilo e segui la procedura. Sono disponibili anche le
   [istruzioni ufficiali per Windows](https://code.visualstudio.com/docs/setup/windows).
2. Apri VS Code. Nella barra a sinistra premi **Estensioni / Extensions**
   (l'icona con i quadratini), oppure premi **Ctrl+Shift+X**.
3. Cerca **Tinymist Typst** e installa l'estensione con identificativo
   `myriad-dreamin.tinymist`. Puoi riconoscerla dalla
   [pagina ufficiale nel Marketplace](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist).

Non servono altre estensioni per seguire questa guida.

## 3. Scarica ed estrai il progetto

1. Vai alla [pagina GitHub del progetto](https://github.com/lorenzoyang/elaborato-calcolo-numerico).
2. Premi il pulsante **Code**, poi **Download ZIP**.
3. In Esplora file fai clic destro sullo ZIP e scegli **Estrai tutto**.
4. Apri la cartella estratta che contiene `conf.typ`, `modello.typ` e le
   cartelle `esercizi` e `img`.

Il download ZIP contiene i sorgenti che ci servono. I file delle Releases
sono invece il mio PDF finale e il codice MATLAB per la consegna.
Non occorre installare Git o creare un account GitHub.

## 4. Prepara una cartella tutta tua

Crea una cartella, per esempio **Il-mio-elaborato**, fuori dalla cartella
scaricata. Al suo interno:

1. Copia i file `conf.typ` e `modello.typ` dal progetto scaricato.
2. Rinomina **la copia** di `modello.typ` in `elaborato.typ`.
3. Crea una sottocartella `esercizi` e copiaci soltanto `esempio.typ`, preso
   dalla cartella `esercizi` del progetto scaricato.
4. Crea una sottocartella `img` e copiaci soltanto `unifi-logo.png`, preso
   dalla cartella `img` del progetto scaricato.

Il risultato deve essere questo:

```text
Il-mio-elaborato/
├── conf.typ
├── elaborato.typ
├── esercizi/
│   └── esempio.typ
└── img/
    └── unifi-logo.png
```

Questi quattro file bastano per iniziare. Gli esercizi originali, i PDF,
il codice MATLAB e le dispense del mio anno non servono al modello.

Su Windows, se non vedi le estensioni, in Esplora file attiva
**Visualizza → Mostra → Estensioni nomi file**. Il nome deve essere
`elaborato.typ`, senza aggiungere una seconda estensione `.typ` o `.txt`.

## 5. Apri la cartella e inserisci i tuoi dati

In VS Code scegli **File → Apri cartella / Open Folder** e seleziona
**Il-mio-elaborato**. Nel pannello a sinistra apri `elaborato.typ`.

Sostituisci i valori segnaposto con i tuoi dati:

| Campo | Cosa inserire |
| --- | --- |
| `autore` | Il tuo nome e cognome. |
| `matricola` | Il tuo numero di matricola, sempre tra virgolette. |
| `email` | Il tuo indirizzo email universitario. |
| `anno_acc` | L'anno accademico del tuo elaborato, per esempio `2026-2027`. |
| `data` | Il mese e l'anno della consegna, per esempio `Giugno 2027`. |

Aggiorna anche il titolo nella riga:

```typst
#set document(title: [Elaborato Calcolo Numerico 2026-2027])
```

Questa riga imposta il titolo nelle **proprietà del PDF**. Il titolo visibile
in copertina viene composto dallo stile usando `anno_acc`.

Conserva virgolette, virgole e parentesi; cambia solo i valori.
Lascia `logo: "img/unifi-logo.png"` com'è e salva con **Ctrl+S**.
`conf.typ` contiene già lo stile: per scrivere il tuo elaborato non devi modificarlo.

## 6. Scrivi gli esercizi

Apri `esercizi/esempio.typ`. Contiene una piccola domanda con svolgimento,
formula e codice MATLAB, così puoi vedere subito come funziona.

La struttura da mantenere è questa:

```typst
#import "../conf.typ": esercizio

#esercizio(
  "1",
  [Scrivi qui la domanda.],
)[
  Scrivi qui il tuo svolgimento.
]
```

- `"1"` è il numero che appare nel titolo **Esercizio 1**.
- Il primo blocco `[ ... ]` contiene la **domanda**, nel riquadro grigio.
- Il blocco dopo `)[` contiene lo **svolgimento**.
- Le righe che iniziano con `//` sono commenti di aiuto e non appaiono nel PDF.

Sostituisci domanda e svolgimento, mantenendo le parentesi che li racchiudono,
la virgola dopo il blocco della domanda e la riga `#import`.
Non è necessario aggiungere a mano il titolo «Svolgimento».

Per scrivere una formula basta racchiuderla tra due simboli `$`, per esempio
`$x^2 + 1$`. Nel file trovi anche un blocco delimitato da tre accenti gravi
(\`\`\`) con la parola `matlab`: il testo al suo interno viene mostrato come
codice. Typst lo impagina, ma **non lo esegue**: il calcolo va fatto in MATLAB.

### Aggiungi un secondo esercizio

1. Nel pannello di VS Code fai clic destro su `esempio.typ`, scegli **Copia**,
   poi fai clic destro sulla cartella `esercizi` e scegli **Incolla**.
2. Rinomina la nuova copia in `es02.typ`.
3. Nella copia cambia `"1"` in `"2"` e inserisci la nuova domanda e il nuovo svolgimento.
4. In `elaborato.typ`, sotto la riga già presente, aggiungi:

   ```typst
   #include "esercizi/es02.typ"
   ```

Il file principale avrà quindi queste due righe, in quest'ordine:

```typst
#include "esercizi/esempio.typ"
#include "esercizi/es02.typ"
```

Ripeti per `es03.typ`, `es04.typ` e così via, aggiornando sia il numero interno
sia la riga `#include`. L'ordine delle righe determina l'ordine nel PDF;
l'indice viene aggiornato automaticamente. Il primo file può continuare a
chiamarsi `esempio.typ`: il titolo dipende dal numero scritto al suo interno.

## 7. Vedi l'anteprima ed esporta il PDF

1. Salva i file e apri **`elaborato.typ`** nell'editor.
2. Premi **Ctrl+Shift+P**: si apre la barra dei comandi di VS Code.
3. Cerca **Typst Pin Main** e selezionalo. In questo modo Tinymist usa
   `elaborato.typ` come documento principale anche quando modifichi un esercizio.
   Dopo aver chiuso e riaperto VS Code potrebbe essere necessario ripeterlo.
4. Apri di nuovo la barra dei comandi, cerca **Typst Preview:** e scegli
   l'anteprima nell'editor. Vedrai copertina, indice ed esercizi; salvando le
   modifiche potrai controllare il risultato.
5. Per ottenere il file da consegnare, torna su `elaborato.typ` e premi
   **Export PDF** in cima al file, oppure cerca **Typst Export PDF** nella
   barra dei comandi.
6. Con le impostazioni predefinite, troverai **`elaborato.pdf` accanto a
   `elaborato.typ`**. Aprilo anche dal normale lettore PDF per un ultimo controllo.

I comandi sono descritti nella
[documentazione ufficiale dell'estensione](https://marketplace.visualstudio.com/items?itemName=myriad-dreamin.tinymist).
Il PDF raccoglie ciò che hai scritto: eventuali file MATLAB richiesti per la
consegna vanno preparati a parte, secondo le indicazioni del professore.

## 8. Se qualcosa non funziona

| Problema | Cosa controllare |
| --- | --- |
| Stai lavorando dentro lo ZIP | Usa **Estrai tutto** e apri la cartella estratta, poi prepara la tua cartella come al punto 4. |
| Compare «file not found» | Verifica nomi e cartelle rispetto allo schema del punto 4 e alle righe `#include`. Il logo deve essere in `img/unifi-logo.png`. |
| Compare un errore dopo aver incollato del testo | Controlla le parentesi `()`, `[]`, le virgolette e i simboli `$`. Premi **Ctrl+Z** per annullare l'ultima modifica e riprova con un pezzo più piccolo. |
| Vedi solo un esercizio, senza copertina e indice | Apri `elaborato.typ`, esegui **Typst Pin Main** e riapri l'anteprima. |
| Non trovi i comandi Typst | Controlla che Tinymist Typst sia installata e abilitata, poi apri un file con estensione `.typ`. |
| Il PDF non riflette le ultime modifiche | Salva tutti i file e ripeti **Export PDF** dal documento principale. |

Per trascrivere le tracce da screenshot e usare le dispense come contesto,
continua con i **[consigli pratici](consigli.md)**.

[Torna al README](../README.md)
