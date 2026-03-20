% codice fornito dal docente per l'esercizio 9

function [A,b] = linsis(n,k,simme)
%
%  [A,b] = linsis(n,k,simme)  Crea una matrice A nxn ed un termine noto b,
%                             in modo che la soluzione del sistema lineare 
%                             A*x=b sia x = [1,1,...,1]^T.
%                             k non ve lo dico a cosa serve.
%                             Se simme è specificato, crea una matrice sdp.
%
%                                                          Rel. 2026-01-07.
sigma = pi^(-2*k);
rng(0);
[q1,~] = qr(rand(n));
if nargin==3
    q2 = q1';
    B  = 0;
else    
    [q2,~] = qr(rand(n));
    B      = diag(ones(n-1,1),1);
end    
A = q1*(diag([sigma 2/n:1/n:1])+B)*q2;
b = sum(A,2);
return