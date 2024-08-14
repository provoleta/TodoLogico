costoEnvio(Paquete, PrecioTotal) :-
    findall(PrecioItem, precioItemPaquete(Paquete, PrecioItem), Precios),
    sumlist(Precios, PrecioTotal).
    
% precioItemPaquete(Paquete, Precio) :-
%     itemPaquete(Paquete, libro(Precio)).
% 
% precioItemPaquete(Paquete, Precio) :-
%     itemPaquete(Paquete, mp3(_, Duracion)),
%     Precio is Duracion * 0.42.
% 
% precioItemPaquete(Paquete, PrecioOferta) :-
%     itemPaquete(Paquete, productoEnOferta(_, PrecioOferta)).
    

precioItemPaquete(Paquete, Precio) :-
    itemPaquete(Paquete, precio(Precio)).

precio(Precio) :-
    libro(Precio).

precio(Precio) :-
    mp3(_, Duracion),
    Precio is Duracion * 0.42.

precio(Precio) :-
    productoEnOferta(_, PrecioOferta).

