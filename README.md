# Elaborato di Calcolo Numerico

Questo repository contiene un elaborato universitario di **Calcolo Numerico** per l'anno accademico **2025-2026**, composto da:

- il testo dell'elaborato in **Typst**
- gli esercizi suddivisi in file separati
- il codice **MATLAB** usato per test numerici e verifiche
- il PDF finale gia generato

## Struttura del progetto

- `elaborato.typ`: file principale dell'elaborato
- `conf.typ`: configurazione comune del documento
- `esercizi/`: contenuto dei singoli esercizi
- `codice-matlab/`: funzioni e script MATLAB
- `img/`: immagini usate nel documento
- `dispense/`: materiale di riferimento
- `elaborato.pdf`: versione compilata del documento

## Codice MATLAB

Nella cartella `codice-matlab/` sono presenti implementazioni e script di test relativi ad alcuni argomenti classici del corso:

- risoluzione di sistemi lineari con fattorizzazione `LU` (`LUSolve.m`)
- risoluzione di sistemi simmetrici definiti positivi con fattorizzazione `LDL^T` (`LDLSolve.m`)
- generazione di sistemi di test (`linsis.m`)
- metodi per la ricerca degli zeri: bisezione, Newton e metodo ibrido
- Newton per sistemi non lineari (`metodoNewtonSistemi.m`)
- minimi quadrati pesati (`WeightedLSSolve.m`)
- calcolo di alcune costanti di macchina

Sono inclusi anche script pronti da eseguire, ad esempio:

- `test_lusolve.m`
- `test_ldlsolve.m`
- `test_metodi_zeri.m`
- `test_es09.m`
- `test_es11.m`
- `test_es13.m`
- `test_es15.m`

## Note

Il repository raccoglie sia il materiale di stesura dell'elaborato sia il codice sperimentale usato per supportare gli esercizi numerici.
