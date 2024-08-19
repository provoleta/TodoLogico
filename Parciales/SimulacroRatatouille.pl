% rata(Nombre, LugarDondeVive).
rata(remy, gusteaus).
rata(emile, bar). 
rata(django, pizzeria).

% cocina(NombreChef, PlatoQueCocina, Experiencia).
cocina(linguini, ratatouille, 3).
cocina(linguini, sopa, 5).
cocina(colette, salmonAsado, 9).
cocina(horst, ensaladaRusa, 8).

% trbajaEn(Lugar, Quien).
trabajaEn(gusteaus, linguini).
trabajaEn(gusteaus, colette). 
trabajaEn(gusteaus, skinner). 
trabajaEn(gusteaus, horst). 
trabajaEn(cafeDes2Moulins, amelie).

% ===== PUNTO 1 ======
inspeccionSatisfactoria(Restaurante) :-
    restaurante(Restaurante),
    not(rata(_, Restaurante)).

restaurante(Restaurante) :-
    trabajaEn(Restaurante, _). 

% ===== PUNTO 2 ======
chef(Empleado, Restaurante) :-
    cocina(Empleado, _, _),
    trabajaEn(Restaurante, Empleado).

% ===== PUNTO 3 ======
chefcito(Rata) :-
    rata(Rata, LugarDondeVive),
    trabajaEn(LugarDondeVive, linguini).

% ===== PUNTO 4 ======
cocinaBien(remy, Plato) :-
    cocina(_, Plato, _).

cocinaBien(Cocinero, Plato) :-
    cocina(Cocinero, Plato, Puntaje),
    Puntaje > 7.

% ===== PUNTO 5 ======
encargadoDe(Encargado, Plato, Restaurante) :-
    cocinaEn(Encargado, Plato, Puntaje, Restaurante),
    forall(cocinaEn(_, Plato, OtroPuntaje, Restaurante), Puntaje >= OtroPuntaje).

cocinaEn(Cocinero, Plato, Puntaje, Restaurante) :-
    chef(Cocinero, Restaurante),
    cocina(Cocinero, Plato, Puntaje).    

% ===== PUNTO 6 ======
plato(ensaladaRusa, entrada([papa, zanahoria, arvejas, huevo, mayonesa])). 
plato(bifeDeChorizo, principal(pure, 25)).
plato(frutillasConCrema, postre(265)).

saludable(Plato) :-
    plato(Plato, Caracteristicas),
    calorias(Caracteristicas, Calorias), 
    Calorias < 75.

saludable(Plato) :-
    plato(Plato, postre(_)),
    grupo(Plato).

grupo(frutillasConCrema).

calorias(entrada(Ingredientes), Calorias) :-
    length(Ingredientes, CantidadIngredientes),
    Calorias is (CantidadIngredientes * 15).

calorias(principal(Acompaniamiento, Minutos), Calorias) :-
    calorias(Acompaniamiento, CaloriasAcompaniamiento),
    Calorias is (Minutos * 5) + CaloriasAcompaniamiento.

calorias(postre(Calorias), Calorias).

calorias(pure, 20).
calorias(papasFritas, 50).
calorias(ensalada, 0).

% ===== PUNTO 7 ======
criticaPositiva(Restaurante, Critico) :-
    inspeccionSatisfactoria(Restaurante),
    tieneChefs(Restaurante),
    criterioDeCritico(Critico, Restaurante).

criterioDeCritico(antonEgo, Restaurante) :-
    especialistas(Restaurante, ratatouille).

criterioDeCritico(chrisophe, Restaurante) :-
    findall(Cocinero, chef(Cocinero, Restaurante), Cocineros),
    length(Cocineros, CantidadDeCocineros),
    CantidadDeCocineros > 3.

criterioDeCritico(cormillot, Restaurante) :-                     
    restauranteSaludable(Restaurante),                   
    entradasNaranjas(Restaurante).                   

restauranteSaludable(Restaurante) :-                     
    forall(cocinaEn(_, Plato, _, Restaurante), saludable(Plato)).                    

entradasNaranjas(Restaurante) :-                     
    forall(variantesDeEntradas(Restaurante, Ingredientes), member(zanahoria, Ingredientes)).                     

especialistas(Restaurante, Plato) :-                     
    forall(trabajaEn(Restaurante, Cocinero), cocinaBien(Cocinero, Plato)).                   

variantesDeEntradas(Restaurante, Ingredientes) :-         
    cocinaEn(_, Plato, _, Restaurante),          
    plato(Plato, ensalada(Ingredientes)).         

tieneChefs(Restaurante) :-
    chef(_, Restaurante).