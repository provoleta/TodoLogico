esDragon(juan, 1).
esDragon(pedro, pedro).

esPoderoso(Personaje) :-
    esDragon(Personaje, Amigo),
    Amigo \= Personaje.