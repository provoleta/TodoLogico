%primeraMarca(Marca)
primeraMarca(laSerenisima).
primeraMarca(gallo).
primeraMarca(vienisima).

%precioUnitario(Producto,Precio)
%donde Producto puede ser arroz(Marca), lacteo(Marca,TipoDeLacteo), salchicas(Marca,Cantidad)
precioUnitario(arroz(gallo), 25.10).
precioUnitario(lacteo(laSerenisima,leche), 6.00).
precioUnitario(lacteo(laSerenisima,crema), 4.00).
precioUnitario(lacteo(gandara,queso(gouda)), 13.00).
precioUnitario(lacteo(vacalin,queso(mozzarella)), 12.50).
precioUnitario(salchichas(vienisima,12), 9.80).
precioUnitario(salchichas(vienisima, 6), 5.80).
precioUnitario(salchichas(granjaDelSol, 8), 5.10).

%compro(Cliente,Producto,Cantidad)
compro(juan,lacteo(laSerenisima,crema),2).
compro(juan, arroz(gallo), 3).
%descuento(Producto, Descuento)
descuento(lacteo(laSerenisima,leche), 0.20).
descuento(lacteo(laSerenisima,crema), 0.70).
descuento(lacteo(gandara,queso(gouda)), 0.70).
descuento(lacteo(vacalin,queso(mozzarella)), 0.05).

% ==== PUNTO 1 ====
descuento(arroz(Marca), Descuento) :-
    descuentoEnCantidadPlata(arroz(Marca), 1.50, Descuento).

descuento(salchichas(Marca), Descuento) :-
    Marca \= vienisima,
    descuentoEnCantidadPlata(salchica(Marca), 0.50, Descuento).

descuento(lacteos(Marca, leche), Descuento) :-
    descuentoEnCantidadPlata(lacteo(Marca, leche), 2, Descuento).

descuento(lacteos(Marca, queso), Descuento) :-
    primeraMarca(Marca),
    descuentoEnCantidadPlata(lacteo(Marca, queso), 2, Descuento).

descuento(Producto, 0.05) :-
    productoMasCaro(Producto).

descuentoEnCantidadPlata(Producto, PlataDescontada, Descuento) :-
    precioUnitario(Producto, Precio),
    Descuento is 1 - ((Precio - PlataDescontada) / Precio).

productoMasCaro(Producto) :-
    precioUnitario(Producto, MayorPrecio),
    forall(precioUnitario(_, OtroPrecio), OtroPrecio =< MayorPrecio).

% ==== PUNTO 2 ====
clienteCompulsivo(Cliente) :-
    compro(Cliente, _, _),
    forall(primeraMarcaConDescuento(Producto), compro(Cliente, Producto, _)).

primeraMarcaConDescuento(Producto) :-
    descuento(Producto, _),
    marca(Producto, Marca),
    primeraMarca(Marca).

marca(arroz(Marca), Marca).
marca(lacteo(Marca, _), Marca).
marca(salchicas(Marca, _), Marca).

% ==== PUNTO 3 ====
totalAPagar(Cliente, Total) :-
    compro(Cliente, _, _),
    findall(Precio, precioAPagar(Cliente, Precio), Precios),
    sum_list(Precios, Total).

precioAPagar(Cliente, Precio) :-
    compro(Cliente, Producto, Cantidad),
    precioConDescuento(Producto, PrecioProducto),
    Precio is PrecioProducto * Cantidad.

precioConDescuento(Producto, Precio) :-
    precioUnitario(Producto, PrecioUnitario),
    descuento(Producto, Descuento),
    Precio is PrecioUnitario - PrecioUnitario * Descuento.

% ==== PUNTO 4 ====
clienteFiel(Cliente, Marca) :-
    compro(Cliente, Producto, _),
    marca(Producto, Marca),
    forall((compro(Cliente, OtroProducto, _), marca(OtroProducto, OtraMarca)), not(compiten(Marca, OtraMarca, OtroProducto))).

compiten(Marca1, Marca2, Producto) :-
    marca(Marca1, OtroProducto),
    mismoRubro(Producto, OtroProducto),
    Marca1 \= Marca2.

mismoRubro(arroz(_), arroz(_)).
mismoRubro(lacteo(_, leche), lacteo(_, leche)).
mismoRubro(lacteo(_, crema), lacteo(_, crema)).
mismoRubro(lacteo(_, queso(_)), lacteo(_, queso)).
mismoRubro(salchicha(_, _), salchicha(_, _)).

% ==== PUNTO 5 ====
duenio(laSerenisima, gandara).
duenio(gandara, vacalin).

provee(Marca, Productos) :-
    marca(_, Marca),
    findall(Producto, productoDe(Marca, Producto), Productos).

productoDe(Empresa, Producto) :-
    precioUnitario(Producto, _),
    ofreceProducto(Empresa, Producto).

ofreceProducto(Marca, Producto) :-
    marca(Producto, Marca).

ofreceProducto(Marca, Producto) :-
    duenio(Marca, Subsidiaria),
    ofreceProducto(Subsidiaria, Producto).