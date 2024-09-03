% ===== PUNTO 1 =====

jockey(valdivieso, 155, 52).
jockey(leguisamo, 161, 49).
jockey(lezcano, 149, 50).
jockey(baratucci, 153, 55).
jockey(falero, 157, 52).

esJockey(Jockey) :-
    jockey(Jockey, _, _).

caballo(botafogo).
caballo(oldMan).
caballo(energetica).
caballo(matBoy).
caballo(yatasto).

preferencia(botafogo, baratucci).
preferencia(botafogo, Jockey) :-
    jockeyLiviano(Jockey).

preferencia(oldMan, Jockey) :-
    tieneNombreLargo(Jockey).

preferencia(energetica, Jockey) :-
    esJockey(Jockey),
    not(preferencia(botafogo, Jockey)).

preferencia(matBoy, Jockey) :-
    esAlto(Jockey).

jockeyLiviano(Jockey) :-
    jockey(Jockey, _, Peso),
    Peso < 52.

tieneNombreLargo(Jockey) :-
    esJockey(Jockey),
    atom_length(Jockey, CantidadDeLetras),
    CantidadDeLetras > 7.

esAlto(Jockey) :-
    jockey(Jockey, Altura, _),
    Altura > 170.

caballeriza(valdivieso, elTute).
caballeriza(falero, elTute).
caballeriza(lezcano, lasHormigas).
caballeriza(baratucci, clCharabon).
caballeriza(leguisamo, clCharabon).

ganador(botafogo, granPremioNacional).
ganador(botafogo, granPremioRepublica).
ganador(oldMan, granPremioRepublica).
ganador(oldMan, campeonatoPalermoDeOro).
ganador(matBoy, granPremioCriadores).

% ===== PUNTO 2 =====
masDeUnJockey(Caballo) :-
    preferencia(Caballo, UnJockey),
    preferencia(Caballo, OtroJockey),
    UnJockey \= OtroJockey.


% ===== PUNTO 3 =====
detestaCaballeriza(Caballo, Caballeriza) :-
    caballo(Caballo),
    caballeriza(_, Caballeriza),
    forall(caballeriza(Jockey, Caballeriza), not(preferencia(Caballo, Jockey))).


% ===== PUNTO 4 =====
premioImportante(granPremioNacional).
premioImportante(granPremioRepublica).

piolin(Jockey) :-
    esJockey(Jockey),
    forall(ganadorPremioImportante(Caballo), preferencia(Caballo, Jockey)).

ganadorPremioImportante(Caballo) :-
    ganador(Caballo, Premio),
    premioImportante(Premio).

% ===== PUNTO 5 =====
salePrimero(Caballo, ResultadoCarrera) :-
    nth1(1, ResultadoCarrera, Caballo).

saleSegundo(Caballo, ResultadoCarrera) :-
    nth1(2, ResultadoCarrera, Caballo).

apuestaGanadora(aGanador(CaballoGanador), ResultadoCarrera) :-
    salePrimero(CaballoGanador, ResultadoCarrera).

apuestaGanadora(aSegundo(Caballo), ResultadoCarrera) :-
    salePrimero(Caballo, ResultadoCarrera).

apuestaGanadora(aSegundo(Caballo), ResultadoCarrera) :-
    saleSegundo(Caballo, ResultadoCarrera).

apuestaGanadora(exacta(CaballoGanador, OtroCaballo), ResultadoCarrera) :-
    salePrimero(CaballoGanador, ResultadoCarrera),
    saleSegundo(OtroCaballo, ResultadoCarrera).

apuestaGanadora(imperfecta(CaballoGanador, OtroCaballo), ResultadoCarrera) :-
    salePrimero(CaballoGanador, ResultadoCarrera),
    saleSegundo(OtroCaballo, ResultadoCarrera).

apuestaGanadora(imperfecta(OtroCaballo, CaballoGanador), ResultadoCarrera) :-
    salePrimero(CaballoGanador, ResultadoCarrera),
    saleSegundo(OtroCaballo, ResultadoCarrera).
    
    
% ===== PUNTO 6 =====
crin(botafogo, tordo).
crin(oldMan, alazan).
crin(energetica, ratonero).
crin(matBoy, palomino).
crin(yatasto, pinto).

color(tordo, [negro]).
color(alazan, [marron]).
color(ratonero, [gris, negro]).
color(palomino, [marron, blanco]).
color(pinto, [blanco, marron]).

esColor(Color) :-
    color(_, Colores),
    member(Color, Colores).

compraPorColor(Color, Caballos) :-
    esColor(Color),
    findall(Caballo, colorEnCaballo(Caballo, Color), Caballos).

colorEnCaballo(Caballo, Color) :-
    crin(Caballo, Tonalidad),
    color(Tonalidad, Colores),
    member(Color, Colores).
