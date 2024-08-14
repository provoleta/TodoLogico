pieza(codo(rojo)).
pieza(cano(rojo, 3)).
pieza(canilla(triangular, azul, 30)).
pieza(extremo(izquierda, rojo)).
pieza(extremo(derecha, azul)).
pieza(codo(_)).
pieza(cano(_, _)).
pieza(canilla(_, _, _)).

listadoDePiezas([codo(rojo), cano(rojo, 3), canilla(triangular, azul, 30)]).

precioDeCaneria(ListaPiezas, Precio) :-
  listadoDePiezas(ListaPiezas),
  findall(PrecioPieza, precioEnLista(ListaPiezas, PrecioPieza), ListaDePrecios),
  sumlist(ListaDePrecios, Precio).

precioEnLista(ListaPiezas, PrecioPieza) :-
  member(Pieza, ListaPiezas),
  precioDePieza(Pieza, PrecioPieza).

precioDePieza(codo(_), 5).
precioDePieza(cano(_, Longitud), Precio) :-
  Precio is Longitud * 5.
precioDePieza(canilla(triangular, _, _), 20).
precioDePieza(canilla(_, _, Ancho), 12) :-
  Ancho < 5.
precioDePieza(canilla(_, _, _), 15).

% PUNTO 2 y 3
% puedoEnchufar(CaneriaIzquierda, CaneriaDerecha)

puedoEnchufar(CaneriaIzquierda, CaneriaDerecha) :-
  listadoDePiezas(CaneriaIzquierda),
  last(CaneriaIzquierda, PiezaIzquierda),
  puedoEnchufar(PiezaIzquierda, CaneriaDerecha).

puedoEnchufar(PiezaIzquierda, CaneriaDerecha) :-
  listadoDePiezas(CaneriaDerecha),
  nth1(1, CaneriaDerecha, PiezaDerecha),
  puedoEnchufar(PiezaIzquierda, PiezaDerecha).

puedoEnchufar(PiezaIzquierda, PiezaDerecha) :-
  PiezaIzquierda \= (extremo(derecha, _)),
  PiezaDerecha \= (extremo(izquierda, _)),
  color(PiezaIzquierda, Color1),
  color(PiezaDerecha, Color2),
  coloresCompatibles(Color1, Color2).

color(codo(Color), Color).
color(cano(Color, _), Color).
color(canilla(_, Color, _), Color).
color(extremo(_, Color), Color).

coloresCompatibles(Color, Color).
coloresCompatibles(azul, rojo).
coloresCompatibles(rojo, negro).

% Punto 4
caneriaBienArmada(Caneria) :-
  listadoDePiezas(Caneria),
  forall(piezasContiguas(Caneria, PiezaIzquierda, PiezaDerecha), puedoEnchufar(PiezaIzquierda, PiezaDerecha)).

piezasContiguas(Caneria, PiezaIzquierda, PiezaDerecha) :-
  nth1(Posicion1, Caneria, PiezaIzquierda),
  Posicion2 is Posicion1 + 1,
  nth1(Posicion2, Caneria, PiezaDerecha).

% Punto 5
