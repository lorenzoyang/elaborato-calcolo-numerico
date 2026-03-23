#import "../conf.typ": esercizio

#esercizio(
  "12",
  [
    Dato un generico sistema lineare sovradeterminato a rango massimo,
    $ A x = b, quad A in RR^(m times n), quad m > n = "rank"(A), $
    ed indicato, al solito, con $r := A x - b in RR^m$ il corrispondente vettore residuo, scrivere una function Matlab che risolva il precedente problema nel senso dei minimi quadrati _pesati_. Ovvero, minimizzando la seguente norma pesata:
    $ ||r||_omega^2 = sum_(i=1)^m omega_i r_i^2, $ <eq1>
    dove $omega_1, ..., omega_m$ sono pesi positivi assegnati.
  ],
)[
]
