# Elaborato di Calcolo Numerico

Repository dell'elaborato universitario di **Calcolo Numerico** per l'anno
accademico **2025-2026**.

Il progetto contiene il documento sorgente in **Typst**, le soluzioni dei 30
esercizi, il codice **MATLAB** sviluppato per gli esercizi e gli script usati
per produrre test numerici, tabelle e figure. Il codice MATLAB non e' quindi
solo materiale di verifica: molte funzioni sono parte integrante della
consegna degli esercizi.

La versione pronta per la consegna e' disponibile nella sezione **Releases**,
dove si possono scaricare direttamente il PDF finale e lo ZIP del codice
MATLAB.

## Struttura del progetto

| Percorso | Contenuto |
| --- | --- |
| `elaborato.typ` | File principale dell'elaborato; include tutti gli esercizi. |
| `conf.typ` | Template Typst, stile del documento e componenti riutilizzabili. |
| `esercizi/` | Sorgenti Typst dei singoli esercizi, da `es01.typ` a `es30.typ`. |
| `codice-matlab/` | Funzioni MATLAB richieste dagli esercizi, funzioni di supporto e script di test. |
| `img/` | Logo e immagini/figure inserite nel documento. |
| `dispense/` | Materiale di riferimento del corso. |
| `elaborato.pdf` | Versione PDF compilata dell'elaborato. |
| `consegna-progetto-elaborato/` | Copia del PDF finale e archivio ZIP del codice MATLAB per la consegna. |

## Documento Typst

Il file `elaborato.typ` imposta i dati del documento e include in sequenza i 30
file presenti in `esercizi/`. La configurazione grafica, la copertina,
l'indice, lo stile dei blocchi di codice, delle tabelle e dei rimandi sono
definiti in `conf.typ`.

Per rigenerare il PDF, con Typst installato:

```powershell
typst compile elaborato.typ elaborato.pdf
```

## Codice MATLAB

La cartella `codice-matlab/` contiene sia le implementazioni richieste dalle
tracce sia gli script usati per validare i risultati o generare dati e grafici
riportati nell'elaborato.

Le funzioni principali coprono:

- costanti di macchina: `calcola_costanti_macchina.m`;
- ricerca di zeri: `metodoBisezione.m`, `metodoNewton.m`, `metodoIbrido.m`;
- sistemi lineari: `triup.m`, `LUSolve.m`, `LDLSolve.m`, `tridia.m`;
- sistemi di test forniti dal corso: `linsis.m`;
- minimi quadrati pesati: `WeightedLSSolve.m`;
- sistemi non lineari: `metodoNewtonSistemi.m`;
- interpolazione polinomiale e nodi: `lagrange.m`, `newton.m`, `hermite.m`,
  `chebyshev.m`;
- spline cubiche: `spline3.m`;
- formule di quadratura: `ncotes.m`, `ncotescomp.m`, `simpsonad.m`.

Sono presenti anche script di verifica e produzione risultati, tra cui:

- `test_lusolve.m`, `test_ldlsolve.m`, `test_metodi_zeri.m`;
- `test_es09.m`, `test_es11.m`, `test_es13.m`, `test_es15.m`;
- `test_es20.m`, `test_es21.m`, `test_es25.m`, `test_es26.m`,
  `test_es30.m`.

Per eseguire uno script, aprire MATLAB nella cartella del progetto oppure
aggiungere `codice-matlab/` al path. Ad esempio:

```matlab
cd codice-matlab
test_es09
```

## Materiale di consegna

La cartella `consegna-progetto-elaborato/` raccoglie i file preparati per la
consegna:

- `elaborato_Lorenzo_Yang.pdf`;
- `codice-matlab_Lorenzo_Yang.zip`.

Il PDF `elaborato.pdf` nella root e' la versione compilata del sorgente Typst
presente nel repository.
