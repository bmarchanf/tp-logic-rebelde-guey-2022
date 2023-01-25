% ----------------------------------------------------------------------------
% PUNTO 1
% ----------------------------------------------------------------------------

persona(bakunin).
persona(ravachol).
persona(rosaDubovsky).
persona(emmaGoldman).
persona(judithButler).
persona(elisaBachofen).
persona(juanSuriano).
persona(sebastienFaure).

trabajaEn(bakunin, aviacionMilitar).
trabajaEn(ravachol, inteligenciaMilitar).
trabajaEn(emmaGoldman, profesoraDeJudo).
trabajaEn(emmaGoldman, cineasta).
trabajaEn(judithButler, profesoraDeJudo).
trabajaEn(judithButler, inteligenciaMilitar).
trabajaEn(elisaBachofen, ingenieriaMecanica).

esBuenoEn(bakunin,conducirAutos).
esBuenoEn(ravachol,tiroAlBlanco).
esBuenoEn(rosaDubovsky,construirPuentes).
esBuenoEn(rosaDubovsky,mirarPeppaPig).
esBuenoEn(judithButler,judo).  
esBuenoEn(elisaBachofen,armarBombas).
esBuenoEn(emmaGoldman,Habilidad) :-
  esBuenoEn(judithButler,Habilidad).
esBuenoEn(emmaGoldman,Habilidad) :-
  esBuenoEn(elisaBachofen,Habilidad).
esBuenoEn(juanSuriano,judo).
esBuenoEn(juanSuriano,armarBombas).
esBuenoEn(juanSuriano,ringRaje).

:- dynamic leGusta/2.
leGusta(ravachol,juegosDeAzar).
leGusta(ravachol,ajedrez).
leGusta(ravachol,tiroAlBlanco).
leGusta(rosaDubovsky,construirPuentes).
leGusta(rosaDubovsky,mirarPeppaPig).
leGusta(rosaDubovsky,fisicaCuantica).
leGusta(judithButler,judo).
leGusta(judithButler,carrerasDeAutomovilismo).
leGusta(elisaBachofen,fuego).
leGusta(elisaBachofen,destruccion).
leGusta(emmaGoldman,Gusto) :-
  leGusta(judithButler,Gusto).
leGusta(juanSuriano,judo).
leGusta(juanSuriano,armarBombas).
leGusta(juanSuriano,ringRaje).

historialCriminal(bakunin, roboDeAeronaves).
historialCriminal(bakunin, fraude).
historialCriminal(bakunin, tenenciaDeCafeina).
historialCriminal(ravachol, falsificacionDeVacunas).
historialCriminal(ravachol, fraude).
historialCriminal(judithButler, falsificacionDeCheques).
historialCriminal(judithButler, fraude).
historialCriminal(juanSuriano, falsificacionDeDinero).
historialCriminal(juanSuriano, fraude).

% ----------------------------------------------------------------------------
% PUNTO 2
% ----------------------------------------------------------------------------

:- discontiguous vivienda/1.
vivienda(laSeverino).
vivienda(comisaria48).
vivienda(laCasaDelSolNaciente).
vivienda(laCasaDePapel).

:- discontiguous zonaClandestinaCasa/2.
zonaClandestinaCasa(laSeverino,pasadizos(1)).
zonaClandestinaCasa(laSeverino,tunel(8,construido)).
zonaClandestinaCasa(laSeverino,tunel(5,construido)).
zonaClandestinaCasa(laSeverino,tunel(1,sinConstruir)).
zonaClandestinaCasa(laSeverino,cuartoSecreto(4,8)).
zonaClandestinaCasa(laCasaDePapel,pasadizos(2)).
zonaClandestinaCasa(laCasaDePapel,tunel(9,construido)).
zonaClandestinaCasa(laCasaDePapel,tunel(2,construido)).
zonaClandestinaCasa(laCasaDePapel,cuartoSecreto(5,3)).
zonaClandestinaCasa(laCasaDePapel,cuartoSecreto(4,7)).
zonaClandestinaCasa(laCasaDelSolNaciente,pasadizos(1)).
zonaClandestinaCasa(laCasaDelSolNaciente,tunel(3,sinConstruir)).

:- discontiguous viveEn/2.
viveEn(laSeverino,bakunin).
viveEn(laSeverino,elisaBachofen).
viveEn(laSeverino,rosaDubovsky).
viveEn(comisaria48,ravachol).
viveEn(laCasaDePapel,emmaGoldman).
viveEn(laCasaDePapel,juanSuriano).
viveEn(laCasaDePapel,judithButler).

% ----------------------------------------------------------------------------
% PUNTO 3
% ----------------------------------------------------------------------------

tienePotencialRebelde(Vivienda) :-
  viveAlgunDisidente(Vivienda),
  superficieClandestina(Vivienda,SuperficieClandestina),
  SuperficieClandestina > 50.

viveAlgunDisidente(Vivienda) :-
  viveEn(Vivienda,Persona),
  posibleDisidente(Persona).

superficieClandestina(Vivienda,SuperficieClandestina) :-  
  vivienda(Vivienda),
  aggregate_all(sum(SuperficieZonaCasa),calculoDeSuperficieZonaCasa(Vivienda,SuperficieZonaCasa), SuperficieClandestina).

calculoDeSuperficieZonaCasa(Vivienda,SuperficieZonaCasa) :-
  zonaClandestinaCasa(Vivienda,Zona),
  superficie(Zona,SuperficieZonaCasa).

:- discontiguous superficie/2.
superficie(cuartoSecreto(Largo,Ancho),Superficie) :-
  Superficie is Largo*Ancho.  

superficie(pasadizos(Cantidad),Superficie) :-
  Superficie is Cantidad.

superficie(tunel(Longitud,construido),Superficie) :-
  Superficie is 2*Longitud.

% ----------------------------------------------------------------------------
% PUNTO 4
% ----------------------------------------------------------------------------

noViveNadie(Vivienda) :-
  vivienda(Vivienda),
  not(viveEn(Vivienda,_)).

habitantesConGustosEnComun(Vivienda) :-
  viveEn(Vivienda,Persona1),
  leGusta(Persona1,Gusto),
  forall(viveEn(Vivienda,Persona2),leGusta(Persona2,Gusto)).

% ----------------------------------------------------------------------------
% PUNTO 5
% ----------------------------------------------------------------------------

esTerrorista(armarBombas).
esTerrorista(mirarPeppaPig).
esTerrorista(tiroAlBlanco).

posibleDisidente(Persona) :-
  tieneHabilidadTerrorista(Persona),
  gustosSospechosos(Persona),
  potencialCriminal(Persona).

tieneHabilidadTerrorista(Persona) :-
  esBuenoEn(Persona,Habilidad),
  esTerrorista(Habilidad).

:- discontiguous gustosSospechosos/1.
gustosSospechosos(Persona) :-
  persona(Persona),
  not(leGusta(Persona,_)).

gustosSospechosos(Persona) :-
  persona(Persona),
  forall(esBuenoEn(Persona,Actividad),leGusta(Persona,Actividad)).

viveCon(Persona1,Persona2) :-
  viveEn(Vivienda,Persona1),
  viveEn(Vivienda,Persona2),
  Persona1 \= Persona2.

:- discontiguous potencialCriminal/1.
potencialCriminal(Persona) :-
  tieneVariosRegistrosCriminales(Persona).

potencialCriminal(Persona) :-
  viveCon(Persona,Persona2),
  tieneVariosRegistrosCriminales(Persona2).

tieneVariosRegistrosCriminales(Persona):-
  persona(Persona),
  aggregate_all(count,historialCriminal(Persona,_),RegistrosCriminales),
  RegistrosCriminales > 1.


% ----------------------------------------------------------------------------
% PUNTO 6
% ----------------------------------------------------------------------------

vivienda(laCasaDePatricia).

zonaClandestinaCasa(laCasaDePatricia,pasadizos(1)).
zonaClandestinaCasa(laCasaDePatricia,bunker(10,2)).

viveEn(laCasaDePatricia,sebastienFaure).

superficie(bunker(SuperficieInterna,Perimetro),Superficie) :-
  Superficie is SuperficieInterna + Perimetro.
  

% ----------------------------------------------------------------------------
% PUNTO 7
% ----------------------------------------------------------------------------

cantidadHabilidades(Persona,CantidadHabilidades) :-
  persona(Persona),
  aggregate_all(count,esBuenoEn(Persona,_),CantidadHabilidades).

batallonRebelde(Batallon) :-
  findall(Persona,persona(Persona),PersonasPosibles),
  batallon(PersonasPosibles,Batallon,CantidadHabilidadesTotales),
  CantidadHabilidadesTotales > 3.

batallon([],[],0).

batallon([PersonaPosible|PersonasPosibles],[PersonaPosible|PersonasBatallon],CantidadHabilidadesTotales) :-
  potencialCriminal(PersonaPosible),
  cantidadHabilidades(PersonaPosible,CantidadHabilidadesPersona),
  batallon(PersonasPosibles,PersonasBatallon,CantidadHabilidadesRestantes),
  CantidadHabilidadesTotales is CantidadHabilidadesPersona + CantidadHabilidadesRestantes.

batallon([_|PersonasPosibles],Batallon,CantidadHabilidadesTotales) :-
  batallon(PersonasPosibles,Batallon,CantidadHabilidadesTotales).
