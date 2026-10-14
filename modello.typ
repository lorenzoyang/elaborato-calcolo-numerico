// Punto di partenza: segui docs/guida-typst.md.
// Nella tua nuova cartella, rinomina questo file in elaborato.typ.
// -----------------------------------------------------------------
#import "conf.typ": conf

// Titolo nelle proprietà del PDF: aggiorna anche l'anno qui sotto.
#set document(title: [Elaborato Calcolo Numerico 20XX-20XX])

// Sostituisci i valori tra virgolette con i tuoi dati.
// Conserva virgolette, virgole e parentesi. Il logo è già pronto.
#show: conf.with(
  autore: "Nome Cognome",
  matricola: "XXXXXXX",
  email: "nome.cognome@edu.unifi.it",
  anno_acc: "20XX-20XX",
  data: "Mese 20XX",
  logo: "img/unifi-logo.png",
)

// Una riga per ogni esercizio, nell'ordine in cui deve comparire nel PDF.
#include "esercizi/esempio.typ"
