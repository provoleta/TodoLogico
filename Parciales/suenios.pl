% ==== PUNTO 1 ====
% creeEn(Quien, Personaje).
creeEn(gabriel, campanita).
creeEn(gabriel, magoDeOz).
creeEn(gabriel, cavenaghi).

creeEn(juan, conejoDePascua).

creeEn(macarena, reyesMagos).
creeEn(macarena, magoCapria).
creeEn(macarena, campanita).

% suenio(Quien, Suenio). 
% futbolista(Club), loteria(NumerosApostados), cantante(DiscosVendidos)
suenio(gabriel, loteria([5, 9])).
suenio(gabriel, futbolista(arsenal)).

suenio(juan, cantante(100000)).
suenio(macarena, cantante(10000)).

% ==== PUNTO 2 ====
personaAmbiciosa(Persona) :-
    suenio(Persona, _),
    findall(Dificultad, dificultadDeUnSuenio(Persona, Dificultad), Dificultades),
    sumlist(Dificultades, Ambicion),
    Ambicion > 20.

dificultadDeUnSuenio(Persona, Dificultad) :-
    suenio(Persona, Suenio),
    dificultad(Suenio, Dificultad).

dificultad(cantante(DiscosVendidos), 6) :-
    DiscosVendidos > 500000.
dificultad(cantante(DiscosVendidos), 6) :-
    DiscosVendidos =< 500000.
dificultad(loteria(NumerosApostados), Dificultad) :-
    length(NumerosApostados, Cantidad),
    Dificultad is Cantidad * 10.
dificultad(futbolista(Equipo), 3) :-
    equipoChico(Equipo).
dificultad(futbolista(Equipo), 16) :-
    not(equipoChico(Equipo)).

equipoChico(aldosivi).
equipoChico(boca).
equipoChico(arsenal).

% ==== PUNTO 3 ====
quimica(Personaje, Persona) :-
    creeEn(Persona, Personaje),
    tienenQuimica(Personaje, Persona).

tienenQuimica(campanita, Persona) :-
    suenio(Persona, Suenio),
    dificultad(Suenio, DificultadDelSuenio),
    DificultadDelSuenio < 5.

tienenQuimica(_, Persona) :-
    forall(suenio(Persona, UnSuenio), suenioPuro(UnSuenio)),
    not(personaAmbiciosa(Persona)).

suenioPuro(futbolista(_)).
suenioPuro(cantante(DiscosVendidos)) :-
    DiscosVendidos < 200000.

% ==== PUNTO 4 ====
amistad(campanita, reyesMagos).
amistad(campanita, conejoDePascua).
amistad(conejoDePascua, cavenaghi).

sonAmigos(Personaje1, Personaje2) :-
    amistad(Personaje1, Personaje2).

sonAmigos(Personaje1, Personaje2) :-
    amistad(Personaje2, Personaje1).

alegra(Personaje, Persona) :-
    suenio(Persona, _),
    quimica(Personaje, Persona),
    escapaEnfermedad(Personaje).

escapaEnfermedad(Personaje) :-
    not(enfermo(Personaje)).

escapaEnfermedad(Personaje) :-
    amigoEnComun(Personaje, Amigo), 
    not(enfermo(Amigo)).

amigoEnComun(Personaje, Amigo) :-
    sonAmigos(Personaje, Amigo).

amigoEnComun(Personaje, Contacto) :-
    sonAmigos(Personaje, Amigo),
    sonAmigos(Amigo, Contacto),
    Personaje \= Contacto.

enfermo(campanita).
enfermo(conejoDePascua).
enfermo(reyesMagos).
