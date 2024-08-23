% horario(Persona, Entrada, Salida).
atiende(dodain, lunes, 9, 15).
atiende(dodain, miercoles, 9, 15).
atiende(dodain, viernes, 9, 15).
atiende(lucas, martes, 10, 20).
atiende(juanC, sabados, 18, 22).
atiende(juanC, domingos, 18, 22).
atiende(juanFds, jueves, 10, 20).
atiende(juanFds, viernes, 12, 20).
atiende(leoC, lunes, 14, 18).
atiende(leoC, miercoles, 14, 18).
atiende(martu, miercoles, 23, 24).
atiende(vale, Dia, Entrada, Salida) :-
    atiende(dodain, Dia, Entrada, Salida).
atiende(vale, Dia, Entrada, Salida) :-
    atiende(juanC, Dia, Entrada, Salida).

empleado(Empleado) :-
    atiende(Empleado, _, _, _).

% ==== PUNTO 2 ====
% turno(Empleado, Dia, Hora)
turno(Empleado, Dia, Hora) :-
    atiende(Empleado, Dia, Entrada, Salida),
    between(Entrada, Salida, Hora).

% ==== PUNTO 3 ====
estaSolo(Empleado, Dia, Hora) :-
    turno(Empleado, Dia, Hora),
    empleado(OtroEmpleado),
    not(turno(OtroEmpleado, Dia, Hora)),
    Empleado \= OtroEmpleado.

% ==== PUNTO 4 ====
atencionPorDia(StaffPorHorario, Dia) :-
    horaDelDia(UnaHora),
    findall(Empleado, turno(Empleado, Dia, UnaHora), StaffPorHorario).

horaDelDia(UnaHora) :-
    between(1, 24, UnaHora).

% ==== PUNTO 5 ====
% golocina(Precio)
% cigarrillo(Marca)
% bebida(Alcoholica)

% venta(Quien, Fecha, Venta).
venta(dodain, fecha(lunes, 10, agosto), [golosina(1200),cigarrillo(jockey),golosina(50)]).
venta(dodain, fecha(miercoles, 12, agosto), [bebida(alcoholica, 8),bebida(noAlcoholica, 1), golosina(10)]).
venta(martu, fecha(miercoles, 12, agosto), [golosina(1000), cigarrillo(chesterfield), cigarrillo(colorado), cigarrillo(parisiennes)]).
venta(lucas, fecha(martes, 11, agosto), golosinas(600)).
venta(lucas, fecha(martes, 18, agosto), [bebida(noAlcoholica, 2), cigarrillo(derby)]).


vendedorSuertudo(Empleado) :-
    venta(Empleado, _, _),
    forall(primeraVenta(Empleado, PrimeraVenta), ventaImportante(PrimeraVenta)).

primeraVenta(Empleado, PrimeraVenta) :-
    venta(Empleado, _, Ventas),
    nth1(1, Ventas, PrimeraVenta).

ventaImportante(golosina(Precio)) :-
    Precio > 100.

ventaImportante(bebida(alcoholica, _)).
ventaImportante(bebida(_, Cantidad)) :-
    Cantidad > 5.

