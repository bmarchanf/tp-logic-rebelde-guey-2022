:- include(rebeldeGuey).

:- begin_tests(personas).

test("Habilidades de una persona",set(Habilidad == [armarBombas,judo])) :-
    esBuenoEn(emmaGoldman,Habilidad).

test("Gustos de una persona",set(Gusto == [carrerasDeAutomovilismo,judo])) :-
    leGusta(emmaGoldman,Gusto).

:- end_tests(personas).


:- begin_tests(superficieClandestina).

test("Superficie de una vivienda con lugares para actividades clandestinas",nondet) :-
    superficieClandestina(laSeverino,59).

test("Superficie de una vivienda sin lugares para actividades clandestinas",nondet) :-
    superficieClandestina(comisaria48,0).

test("Superficie de una vivienda con un nuevo de tipo ambiente",nondet) :-
    superficieClandestina(laCasaDePatricia,13).

:- end_tests(superficieClandestina).


:- begin_tests(tienePotencialRebelde).

test("La vivienda contiene guaridas de potenciales rebeliones",set(Vivienda == [laSeverino,laCasaDePapel])) :-
    tienePotencialRebelde(Vivienda).

:- end_tests(tienePotencialRebelde).


:- begin_tests(noViveNadie).

test("Casa donde no vive nadie",nondet) :-
    noViveNadie(laCasaDelSolNaciente).

:- end_tests(noViveNadie).


cambiarGustosAJuanSuriano :-
    retract(leGusta(juanSuriano,judo)).

resetearEstadoDeJuanSuriano :-
    assert(leGusta(juanSuriano,judo)).


:- begin_tests(habitantesConGustosEnComun).

test("Vivienda con habitantes de al menos un gusto en comun",nondet) :-
    habitantesConGustosEnComun(laCasaDePapel).

test("Vivienda con un unico habitante",nondet) :-
    habitantesConGustosEnComun(comisaria48).

test("Vivienda sin habitantes de al menos un gusto en comun",[nondet,setup(cambiarGustosAJuanSuriano),cleanup(resetearEstadoDeJuanSuriano)]) :-
    not(habitantesConGustosEnComun(laCasaDePapel)).

:- end_tests(habitantesConGustosEnComun).


:- begin_tests(tieneHabilidadTerrorista).

test("Persona con Habilidad Terrorista",set(Persona == [elisaBachofen,emmaGoldman,juanSuriano,ravachol,rosaDubovsky])) :-
    tieneHabilidadTerrorista(Persona).

:- end_tests(tieneHabilidadTerrorista).


:- begin_tests(gustosSospechosos).

test("Persona sin gustos registrados o que le gusta en lo que es bueno",set(Persona == [bakunin,juanSuriano,judithButler,ravachol,rosaDubovsky,sebastienFaure])) :-
    gustosSospechosos(Persona).

:- end_tests(gustosSospechosos).


:- begin_tests(potencialCriminal).

test("Persona con Registro Criminal o con convive criminal",set(Persona == [bakunin,elisaBachofen,emmaGoldman,juanSuriano,judithButler,ravachol,rosaDubovsky])) :-
    potencialCriminal(Persona).

:- end_tests(potencialCriminal).


:- begin_tests(posibleDisidente).

test("Posible disidente",set(Persona == [juanSuriano,ravachol,rosaDubovsky])) :-
    posibleDisidente(Persona).

:- end_tests(posibleDisidente).
