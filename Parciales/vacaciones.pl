% destino(Quien, Destino)
destino(dodain, pehuenia).
destino(dodain, sanMartinDeLosAndes).
destino(dodain, esquel).
destino(dodain, sarmiento).
destino(dodain, camarones).
destino(dodain, playasDoradas).

destino(alf, bariloche).
destino(alf, sanMartinDeLosAndes).
destino(alf, elBolson).

destino(nico, marDelPlata).

destino(vale, calafate).
destino(vale, elBolson).

destino(martu, Destino) :-
    destino(nico, Destino).

destino(martu, Destino) :-
    destino(alf, Destino).

persona(Persona) :-
    destino(Persona, _).
% ===== PUNTO 2 =====
atraccion(esquel, parqueNacional(losAlerces)).
atraccion(esquel, excursion(trochita)).
atraccion(esquel, excursion(trevelin)).

atraccion(pehuenia,  cerro(bateaMahuida, 2000)).
atraccion(pehuenia,  agua(moquehue, pesca, 14)).
atraccion(pehuenia,  agua(alumine, pesca, 19)).

vacacionesCopadas(Persona) :-
    persona(Persona),
    forall(destino(Persona, Destino), destinoCopado(Destino)).

destinoCopado(Destino) :-
    atraccion(Destino, Atraccion),
    atraccionCopada(Atraccion).

atraccionCopada(cerro(_, Altura)) :-
    Altura > 2000.
atraccionCopada(agua(_, pesca, _)).
atraccionCopada(agua(_, _, Temperatura)) :-
    Temperatura > 20.
atraccionCopada(playa(_, DiefenciaMareas)) :-
    DiefenciaMareas < 5.
atraccionCopada(excursion(Nombre)) :-
    atom_length(Nombre, Letras),
    Letras > 7.

atraccionCopada(parqueNacional(_)).

% ===== PUNTO 3 =====
noSeCruzan(Persona1, Persona2) :-
    persona(Persona1),
    persona(Persona2),
    not(seCruzan(Persona1, Persona2)).

seCruzan(Persona1, Persona2) :-
    destino(Persona1, Destino),
    destino(Persona2, Destino).

% ===== PUNTO 4 =====
costoDeVida(sarmiento, 100).
costoDeVida(esquel, 150).
costoDeVida(pehuenia, 180).
costoDeVida(sanMartinDeLosAndes, 150).
costoDeVida(camarones, 135).
costoDeVida(playasDoradas, 170).
costoDeVida(bariloche, 140).
costoDeVida(elCalafate, 240).
costoDeVida(elBolson, 145).
costoDeVida(marDelPlata, 140).

vacacionesGasoleras(Persona) :-
    persona(Persona),
    forall(destino(Persona, Destino), destinoGasolero(Destino)).

destinoGasolero(Destino) :-
    costoDeVida(Destino, CostoDeVida),
    CostoDeVida < 160.

% ===== PUNTO 5 =====
itinerariosPosibles(Persona, Destinos) :-
    persona(Persona),
    findall(Destino, destino(Persona, Destino), Destinos).


%% predicado para calcular precio de vida
precioDeVida(Destino, Precio) :-
    costoDeVida(Destino, Precio).

