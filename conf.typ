// ============================================================
//  conf.typ — Template per Elaborato di Calcolo Numerico
//  Università degli Studi di Firenze
// ============================================================

// Funzione template principale
#let conf(
  autore: "Nome Cognome",
  matricola: "XXXXXXX",
  email: "nome.cognome@edu.unifi.it",
  anno_acc: "2025-2026",
  data: "Giugno 2026",
  logo: "unifi_logo.png",
  doc,
) = {
  // Palette sobria centralizzata
  let color-primary = rgb("#003b66")
  let color-secondary = rgb("#005b99")
  let color-muted = luma(120)

  // Impostazioni pagina
  set page(
    paper: "a4",
    margin: (top: 2.5cm, bottom: 2.5cm, left: 3cm, right: 2.5cm),
    numbering: "1",
    number-align: center,
    header: context {
      if counter(page).get().first() > 1 {
        set text(size: 9.2pt, fill: color-muted)
        grid(
          columns: (1fr, 1fr),
          align(left)[Elaborato Calcolo Numerico #anno_acc], align(right)[#autore],
        )
        line(length: 100%, stroke: 0.5pt + luma(180))
      }
    },
  )

  // Tipografia base
  set text(
    font: "New Computer Modern",
    size: 11pt,
    lang: "it",
  )

  set par(
    justify: true,
    leading: 1em,
    spacing: 1.15em,
  )

  // Stile titoli
  show heading.where(level: 1): it => {
    v(1.1em)
    text(size: 13.5pt, weight: "bold", fill: color-primary)[#it.body]
    v(0.45em)
  }

  show heading.where(level: 2): it => {
    v(0.8em)
    text(size: 11.8pt, weight: "bold", fill: color-secondary)[#it.body]
    v(0.4em)
  }

  show heading.where(level: 3): it => {
    v(0.6em)
    text(size: 10.8pt, weight: "bold", fill: luma(55))[#it.body]
    v(0.3em)
  }

  // Stile blocchi di codice
  show raw.where(block: true): it => {
    set text(font: "DejaVu Sans Mono", size: 9pt)
    block(
      fill: luma(248),
      stroke: (left: 3pt + color-secondary, rest: 0.5pt + luma(210)),
      radius: 3pt,
      inset: (left: 12pt, rest: 8pt),
      width: 100%,
      it,
    )
  }

  show raw.where(block: false): it => {
    set text(font: "DejaVu Sans Mono", size: 9.5pt)
    box(
      fill: luma(245),
      inset: (x: 3pt, y: 1pt),
      radius: 2pt,
      it,
    )
  }

  // Stile tabelle
  set table(
    stroke: (_, y) => {
      if y == 0 { (bottom: 1.5pt + black) } else if y == 1 { (top: 0.5pt + luma(180)) } else {
        (top: 0.5pt + luma(220))
      }
    },
    fill: (_, y) => {
      if y == 0 { luma(235) } else if calc.odd(y) { luma(250) } else { white }
    },
    inset: (x: 8pt, y: 5pt),
  )

  set table.header(repeat: true)

  // Copertina
  page[
    #v(2cm)

    #align(center)[
      #box(width: 10cm)[
        #image(logo, width: 100%)
      ]
    ]

    #v(3cm)

    #align(center)[
      #text(size: 16pt, style: "italic")[
        Elaborato Calcolo Numerico #anno_acc
      ]
      #v(1.8cm)
      #text(size: 11pt)[
        Autore: #autore \
        Matricola: #matricola \
        E-mail: #link("mailto:" + email)[#email]
      ]
      #v(0.8cm)
      #text(size: 11pt)[#data]
    ]
  ]

  // Indice
  page[
    #outline(
      title: [Indice],
      indent: 1.5em,
      depth: 1,
    )
  ]

  // Corpo del documento
  doc
}


// ============================================================
//  Componenti riutilizzabili esportati dal template
// ============================================================

// Blocco esercizio con riquadro domanda
#let esercizio(numero, consegna, corpo, titolo: [Svolgimento]) = {
  v(1.2em)
  heading(level: 1, [Esercizio #numero])
  block(
    width: 100%,
    fill: luma(247),
    stroke: (left: 3pt + rgb("#005b99"), rest: 0.5pt + luma(200)),
    radius: 3pt,
    inset: 10pt,
  )[
    #text(size: 10.5pt, fill: luma(45))[#consegna]
  ]
  v(0.75em)
  if titolo != none {
    heading(level: 2, titolo)
  }
  corpo
}

// Box avviso/nota operativa (stile giallo)
#let nota(testo) = block(
  fill: rgb("#fff8e1"),
  stroke: (left: 3pt + rgb("#f9a825")),
  inset: 8pt,
  radius: 2pt,
  width: 100%,
)[
  #text(size: 9.5pt)[⚠ #testo]
]

// Tabella risultati preformattata con caption
#let tabella_risultati(caption: none, ..args) = {
  if caption != none {
    align(center)[
      #text(size: 9.5pt, style: "italic")[#caption]
    ]
    v(4pt)
  }
  align(center)[
    #table(..args)
  ]
}

// Rimando informativo a risorse esterne (codice, file allegati, ecc.)
#let rimando(testo) = block(
  fill: rgb("#eef4fa"), // azzurro molto tenue, nella famiglia del primario
  stroke: (left: 2pt + rgb("#005b99")), // stesso blu di esercizio e codice, ma 2pt invece di 3pt
  inset: 8pt,
  radius: 2pt,
  width: 100%,
)[
  #text(size: 9.5pt, fill: rgb("#003b66"))[↳ #testo]
]
