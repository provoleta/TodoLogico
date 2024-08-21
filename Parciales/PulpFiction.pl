personaje(pumkin,     ladron([licorerias, estacionesDeServicio])).
personaje(honeyBunny, ladron([licorerias, estacionesDeServicio])).
personaje(vincent,    mafioso(maton)).
personaje(jules,      mafioso(maton)).
personaje(marsellus,  mafioso(capo)).
personaje(winston,    mafioso(resuelveProblemas)).
personaje(mia,        actriz([foxForceFive])).
personaje(butch,      boxeador).

pareja(marsellus, mia).
pareja(pumkin,    honeyBunny).

% trabajaPara(Empleador, Empleado)
trabajaPara(marsellus, vincent).
trabajaPara(marsellus, jules).
trabajaPara(marsellus, winston).

% ==== PUNTO 1 ====
esPeligroso(Personaje) :-
    personaje(Personaje, _),
    realizaActividadPeligrosa(Personaje).

esPeligroso(Personaje) :-
    trabajaPara(Personaje, Empleado),
    realizaActividadPeligrosa(Empleado).

realizaActividadPeligrosa(Personaje) :-
    personaje(Personaje, Actividad),
    actividadPeligrosa(Actividad).

actividadPeligrosa(ladron(LugaresARobar)) :-
    member(licorerias, LugaresARobar).
actividadPeligrosa(mafioso(maton)).

% ==== PUNTO 2 ====
amigo(vincent, jules).
amigo(jules, jimmie).
amigo(vincent, elVendedor).

sonAmigos(Amigo1, Amigo2) :-
    amigo(Amigo1, Amigo2).

sonAmigos(Amigo1, Amigo2) :-
    amigo(Amigo2, Amigo1).

duoTemible(Personaje1, Personaje2) :-
    esPeligroso(Personaje1),
    esPeligroso(Personaje2),
    duo(Personaje1, Personaje2).

duo(Personaje1, Personaje2) :-
    pareja(Personaje1, Personaje2).

duo(Personaje1, Personaje2) :-
    sonAmigos(Personaje1, Personaje2).

% ==== PUNTO 3 ====
encargo(marsellus, vincent,   cuidar(mia)).
encargo(vincent,  elVendedor, cuidar(mia)).
encargo(marsellus, winston, ayudar(jules)).
encargo(marsellus, winston, ayudar(vincent)).
encargo(marsellus, vincent, buscar(butch, losAngeles)).

estaEnPeligro(butch).

estaEnPeligro(Personaje) :-
    personaje(Personaje, _),
    tieneEncargoPeligroso(Personaje).

tieneEncargoPeligroso(Personaje) :-
    encargo(Jefe, Personaje, cuidar(Pareja)),
    esPeligroso(Jefe),
    pareja(Jefe, Pareja).

tieneEncargoPeligroso(Personaje) :-
    encargo(_, Personaje, buscar(OtroPersonaje, _)),
    personaje(OtroPersonaje, boxeador).

% ==== PUNTO 4 ====
sanCayetano(Personaje) :-
    estanCerca(Personaje, _),
    forall(estanCerca(Personaje, OtroPersonaje), encargo(Personaje, OtroPersonaje, _)).

estanCerca(Personaje1, Personaje2) :-
    trabajaPara(Personaje1, Personaje2).

estanCerca(Personaje1, Personaje2) :-
    sonAmigos(Personaje1, Personaje2).

% ==== PUNTO 5 ====
masAtareado(Personaje) :-
    cantidadDeEncargos(Personaje, Cantidad),
    forall(cantidadDeEncargos(_, OtraCantidad), Cantidad >= OtraCantidad).

cantidadDeEncargos(Personaje, Cantidad) :-
    encargo(_, Personaje, _),
    findall(Encargo, encargo(_, Personaje, Encargo), Encargos),
    length(Encargos, Cantidad).

% ==== PUNTO 6 ====
personajesRespetables(Personajes) :-
    findall(Personaje, personajeRespetable(Personaje), Personajes).

personajeRespetable(Personaje) :-
    personaje(Personaje, Actividad),
    nivelDeRespeto(Actividad, Nivel),
    Nivel > 9.

nivelDeRespeto(actriz(PeliculasActuadas), Nivel) :-
    length(PeliculasActuadas, Cantidad),
    Nivel is Cantidad / 10.

nivelDeRespeto(mafioso(resuelveProblemas), 10).
nivelDeRespeto(mafioso(maton), 1).
nivelDeRespeto(mafioso(capo), 20).

% ==== PUNTO 7 ====

hartoDe(Personaje1, Personaje2) :-
    encargo(_, Personaje1, _),
    personaje(Personaje2, _),
    forall(encargo(_, Personaje1, Tarea), interactua(Personaje2, Tarea)).

interactua(Personaje, Tarea) :-
    involucrado(Personaje, Tarea).

interactua(Personaje, Tarea) :-
    sonAmigos(Personaje, OtroPersonaje),
    involucrado(OtroPersonaje, Tarea).

involucrado(Personaje, cuidar(Personaje)).
involucrado(Personaje, buscar(Personaje, _)).
involucrado(Personaje, ayudar(Personaje)).

% ==== PUNTO 8 ====
caracteristicas(vincent,  [negro, muchoPelo, tieneCabeza]).
caracteristicas(jules,    [tieneCabeza, muchoPelo]).
caracteristicas(marvin,   [negro]).

duoDiferenciable(Personaje1, Personaje2) :-
    duo(Personaje1, Personaje2),
    tienenAlgoDistinto(Personaje1, Personaje2).

tienenAlgoDistinto(Personaje1, Personaje2) :-
    tieneCaracteristica(Personaje1, Caracteristica),
    tieneCaracteristica(Personaje2, _),
    not(tieneCaracteristica(Personaje2, Caracteristica)).

tieneCaracteristica(Personaje, Caracteristica) :-
    caracteristicas(Personaje, Caracteristicas),
    member(Caracteristica, Caracteristicas).