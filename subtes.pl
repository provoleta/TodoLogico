linea(a,[plazaMayo,peru,lima,congreso,miserere,rioJaneiro,primeraJunta,nazca]).
linea(b,[alem,pellegrini,callao,pueyrredonB,gardel,medrano,malabia,lacroze,losIncas,urquiza]).
linea(c,[retiro,diagNorte,avMayo,independenciaC,plazaC]).
linea(d,[catedral,nueveJulio,medicina,pueyrredonD,plazaItalia,carranza,congresoTucuman]).
linea(e,[bolivar,independenciaE,pichincha,jujuy,boedo,varela,virreyes]).
linea(h,[lasHeras,santaFe,corrientes,once,venezuela,humberto1ro,inclan,caseros]).
combinacion([lima, avMayo]). % A C
combinacion([once, miserere]). % H A
combinacion([pellegrini, diagNorte, nueveJulio]). % B C D
combinacion([independenciaC, independenciaE]). % C E
combinacion([jujuy, humberto1ro]). % E H
combinacion([santaFe, pueyrredonD]). % H D
combinacion([corrientes, pueyrredonB]). % H B

% 1 %
estaEn(Linea, Estacion) :-
    linea(Linea, Estaciones),
    member(Estacion, Estaciones).

% 2 %
distancia(Estacion1, Estacion2, Distancia) :-
    mismaLinea(Estacion1, Estacion2),
    posicionEnLinea(Estacion1, Posicion1),
    posicionEnLinea(Estacion2, Posicion2),
    DistanciaRelativa is Posicion1 - Posicion2,
    abs(DistanciaRelativa, Distancia).

posicionEnLinea(Estacion, Posicion) :-
    estaEn(Linea, Estacion),
    linea(Linea, Estaciones),
    nth1(Posicion, Estaciones, Estacion).

mismaLinea(Estacion1, Estacion2) :-
    estaEn(Linea, Estacion1),
    estaEn(Linea, Estacion2).

% 3 % 
mismaAltura(Estacion1, Estacion2) :-
    posicionEnLinea(Estacion1, Posicion),
    posicionEnLinea(Estacion2, Posicion).

% 4 
granCombinacion(Estaciones) :-
    length(Estaciones, Cuantas),
    Cuantas > 2.

% 5 %
cuantasCombinan(Linea, Cuantas) :-
    linea(Linea, _),
    findall(Estacion, combinaParaLinea(Estacion, Linea), Estaciones),
    length(Estaciones, Cuantas).
  
combinaParaLinea(Estacion, Linea) :-
    estaEn(Linea, Estacion),
    combinacion(Estaciones),
    member(Estacion, Estaciones).

% 6 %
lineaMasLarga(Linea) :-
    estacionesDeUnaLinea(Linea, Cantidad),
    forall(estacionesDeUnaLinea(_, Cantidades), Cantidades =< Cantidad).

estacionesDeUnaLinea(Linea, Cantidad) :-
    linea(Linea, Estaciones),
    length(Estaciones, Cantidad).

% 7 %
viajeFacil(Estacion1, Estacion2) :-
    mismaLinea(Estacion1, Estacion2).

viajeFacil(Estacion1, Estacion2) :-
    estaEn(Linea1, Estacion1),
    estaEn(Linea2, Estacion2),
    lineasCombinan(Linea1, Linea2).

lineasCombinan(Linea1, Linea2) :-
    combinaParaLinea(EstacionDe1, Linea1),
    combinaParaLinea(EstacionDe2, Linea2),
    combinacion(UnaCombinacion),
    member(EstacionDe1, UnaCombinacion),
    member(EstacionDe2, UnaCombinacion).