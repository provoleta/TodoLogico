% ==== PUNTO 1 ====
% jugador(Nombre, Civilizacion, Tecnologias)
jugador(ana, romanos, [herreria, forja, emplumado, laminas]).
jugador(beto, incas, [herreria, forja, fundicion]).
jugador(carola, romanos, [herreria]).
jugador(dimitri, romanos, [herreria, fundicion]).

% ==== PUNTO 2 ====
% expertoEnMetales/2
expertoEnMetales(Jugador) :-
    jugador(Jugador, _, Tecnologias),
    herreriaYForja(Jugador),
    (member(fundicion, Tecnologias);
    jugador(Jugador, romanos, _)).



herreriaYForja(Jugador) :-
    jugador(Jugador, _, Tecnologias),
    member(herreria, Tecnologias),
    member(forja, Tecnologias).