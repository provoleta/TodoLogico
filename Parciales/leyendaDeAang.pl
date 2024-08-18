% esPersonaje/1 nos permite saber qué personajes tendrá el juego
esPersonaje(aang).
esPersonaje(katara).
esPersonaje(zoka).
esPersonaje(appa).
esPersonaje(momo).
esPersonaje(toph).
esPersonaje(tayLee).
esPersonaje(zuko).
esPersonaje(azula).
esPersonaje(iroh).

% esElementoBasico/1 nos permite conocer los elementos básicos que pueden controlar algunos personajes
esElementoBasico(fuego).
esElementoBasico(agua).
esElementoBasico(tierra).
esElementoBasico(aire).

% elementoAvanzadoDe/2 relaciona un elemento básico con otro avanzado asociado
elementoAvanzadoDe(fuego, rayo).
elementoAvanzadoDe(agua, sangre).
elementoAvanzadoDe(tierra, metal).

% controla/2 relaciona un personaje con un elemento que controla
controla(zuko, rayo).
controla(toph, metal).
controla(katara, sangre).
controla(aang, aire).
controla(aang, agua).
controla(aang, tierra).
controla(aang, fuego).
controla(azula, rayo).
controla(iroh, rayo).

% visito/2 relaciona un personaje con un lugar que visitó. Los lugares son functores que tienen la siguiente forma:
% reinoTierra(nombreDelLugar, estructura)
% nacionDelFuego(nombreDelLugar, soldadosQueLoDefienden)
% tribuAgua(puntoCardinalDondeSeUbica)
% temploAire(puntoCardinalDondeSeUbica)
visito(aang, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(iroh, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(zuko, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).
visito(toph, reinoTierra(fortalezaDeGralFong, [cuartel, dormitorios, enfermeria, salaDeGuerra, templo, zonaDeRecreo])).
visito(aang, nacionDelFuego(palacioReal, 1000)).
visito(katara, tribuAgua(norte)).
visito(katara, tribuAgua(sur)).
visito(aang, temploAire(norte)).
visito(aang, temploAire(oeste)).
visito(aang, temploAire(este)).
visito(aang, temploAire(sur)).

% ===== PUNTO 1 =====
avatar(Personaje) :-
    esPersonaje(Personaje),
    forall(esElementoBasico(Elemento), controla(Personaje, Elemento)).

% ===== PUNTO 2 =====
clasificacion(Personaje, Clasificacion) :-
    esPersonaje(Personaje),
    grupo(Personaje, Clasificacion).

grupo(Personaje, noEsMaestro) :-
    not(controla(Personaje, _)).

grupo(Personaje, esMaestroPrincipiante) :-
    controla(Personaje, _),
    not(avatar(Personaje)),
    forall(controla(Personaje, Elemento), not(elementoAvanzadoDe(_, Elemento))).

grupo(Personaje, esMaestroAvanzado) :-
    controla(Personaje, Elemento),
    elementoAvanzadoDe(_, Elemento).

grupo(Personaje, esMaestroAvanzado) :-
    avatar(Personaje).

% ===== PUNTO 3 =====
sigueA(zuko, aang).
sigueA(Seguidor, Personaje) :-
    visito(Personaje, _),
    visito(Seguidor, _),
    Seguidor \= Personaje,
    forall(visito(Personaje, Lugar), visito(Seguidor, Lugar)).

% ===== PUNTO 4 =====
dignoDeConocer(temploAire(_)).
dignoDeConocer(tribuAgua(norte)).
dignoDeConocer(reinoTierra(_, Estructura)) :-
    member(muro, Estructura).

% ===== PUNTO 5 =====
lugarPopular(Lugar) :-
    visito(_, Lugar),
    findall(Lugar, visito(_, Lugar), Lugares),
    length(Lugares, Cantidad),
    Cantidad >= 5.
    
% ===== PUNTO 6 =====
% Bumi
esPersonaje(bumi).
controla(bumi, tierra).
visito(bumi, reinoTierra(baSingSe, [muro, zonaAgraria, sectorBajo, sectorMedio])).

% Suki
esPersonaje(suki).
visito(suki, nacionDelFuego(prisionMaximaSeguridad, 200)).
