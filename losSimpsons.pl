padreDe(abe, abbie).
padreDe(abe, homero).
padreDe(abe, herbert).
padreDe(clancy, marge).
padreDe(clancy, patty).
padreDe(clancy, selma).
padreDe(homero, bart).
padreDe(homero, hugo).
padreDe(homero, lisa).
padreDe(homero, maggie).
padreDe(juan, abe).
padreDe(sven, juan).


madreDe(edwina, abbie).
madreDe(mona, homero).
madreDe(gaby, herbert).
madreDe(jacqueline, marge).
madreDe(jacqueline, patty).
madreDe(jacqueline, selma).
madreDe(marge, bart).
madreDe(marge, hugo).
madreDe(marge, lisa).
madreDe(marge, maggie).
madreDe(selma, ling).


/*Punto 1*/
tieneHijo(Personaje):-
    padreDe(Personaje, _).

tieneHijo(Personaje):-
    madreDe(Personaje, _).


hermanos(Personaje, Hermano):-
    madreDe(Madre, Personaje),
    madreDe(Madre, Hermano),
    padreDe(Padre, Personaje),
    padreDe(Padre, Hermano).


medioHermano(Personaje, MedioHermano):-
    madreDe(Madre, Personaje),
    madreDe(Madre, MedioHermano).

medioHermano(Personaje, MedioHermano):-
    padreDe(Padre, Personaje),
    padreDe(Padre, MedioHermano).


tioDe(Personaje, Sobrino):-
    padreDe(Padre, Sobrino),
    hermanos(Personaje, Padre).

tioDe(Personaje, Sobrino):-
    madreDe(Madre, Sobrino),
    hermanos(Personaje, Madre).

tioDe(Personaje, Sobrino):-
    padreDe(Padre, Sobrino),
    medioHermano(Personaje, Padre).

tioDe(Personaje, Sobrino):-
    madreDe(Madre, Sobrino),
    medioHermano(Personaje, Madre).


abueloMultiple(Abuelo):-
    padreDe(Abuelo, Padre),
    padreDe(Padre, Hijo1),
    padreDe(Padre, Hijo2),
    Hijo1 \= Hijo2.

abueloMultiple(Abuelo):-
    padreDe(Abuelo, Madre),
    madreDe(Madre, Hijo1),
    madreDe(Madre, Hijo2),
    Hijo1 \= Hijo2.

abueloMultiple(Abuelo):-
    padreDe(Abuelo, Padre1),
    padreDe(Abuelo, Padre2),
    Padre1 \= Padre2,
    tieneHijo(Padre1),
    tieneHijo(Padre2).

/*Punto 2*/
descendiente(Personaje, Familiar):-
    padreDe(Padre, Personaje),
    descendiente(Padre, Familiar).

descendiente(Personaje, Familiar):-
    madreDe(Madre, Personaje),
    descendiente(Madre, Familiar).

descendiente(Personaje, Familiar):-
    padreDe(Familiar, Personaje).

descendiente(Personaje, Familiar):-
    madreDe(Familiar, Personaje).

