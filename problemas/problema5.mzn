% Autor:Alejandro Borrego Megías
% Problema 4, Construcción Casa

include "globals.mzn";

% 1. Definición de variables y constantes
%Numero de nodos
int: NUM_NODES = 14;
int: NUM_SIDES = 91;
array[1..NUM_SIDES,1..2] of int: sides = [| 9,14 | 9,7 | 12,3 | 12,9 | 8,3 | 2,12 | 6,11 | 5,13 | 5,6 | 8,4 | 7,5 | 11,12 | 4,8 | 7,11 | 2,11 | 13,4 | 6,9 | 5,7 | 4,10 | 3,1 | 5,13 | 3,5 | 11,2 | 8,9 | 3,14 | 11,10 | 14,9 | 8,2 | 7,9 | 11,6 | 10,13 | 11,4 | 1,12 | 1,11 | 3,9 | 13,11 | 9,3 | 13,10 | 7,6 | 7,4 | 9,3 | 2,5 | 9,2 | 14,7 | 10,14 | 6,2 | 3,5 | 11,8 | 7,12 | 5,6 | 11,9 | 11,4 | 12,1 | 1,6 | 8,12 | 6,12 | 14,1 | 9,7 | 11,6 | 12,2 | 14,11 | 8,12 | 5,4 | 7,12 | 2,5 | 11,12 | 1,9 | 11,6 | 13,5 | 12,3 | 10,8 | 2,10 | 3,2 | 12,1 | 8,2 | 9,13 | 12,10 | 12,1 | 8,1 | 6,12 | 11,3 | 6,11 | 2,4 | 14,13 | 4,2 | 9,12 | 7,9 | 12,2 | 12,6 | 12,8 | 1,10 |];


%Numero de colores maximo para resolver el problema es igual al número de aristas
%Así la solución sería pintar una arista de cada color
int: MAX_COLORES =NUM_SIDES;
var int: NUM_COLORES;
%Array de colores que se asigna a cada arista
array [1..NUM_SIDES] of var 1..MAX_COLORES: colores;

% 2. Definición de restricciones
%Dos aristas distintas que comparten un nodo tienen que tener distinto color
constraint forall(i in 1..NUM_SIDES, j in 1..NUM_SIDES where i!=j) (if (sides[i,1]==sides[j,1] /\ sides[i,2]!=sides[j,2]) \/ (sides[i,1]!=sides[j,1] /\ sides[i,2]==sides[j,2]) \/ (sides[i,1]==sides[j,2] /\ sides[i,2]!=sides[j,1]) \/ (sides[i,2]==sides[j,1] /\ sides[i,1]!=sides[j,2]) then colores[i]!=colores[j] endif);

%Dos aristas iguales tienen que tener el mismo color
constraint forall(i in 1..NUM_SIDES, j in 1..NUM_SIDES where i!=j) (if sides[i,1]==sides[j,1] /\ sides[i,2]==sides[j,2] then colores[i]==colores[j] endif);

% 3. Definición del problema
% Se pretende minimizar los colores que se usan para resolver el problema
NUM_COLORES=max(colores);
solve minimize NUM_COLORES;

% 4. Definición del output
output ["NUMERO DE COLORES MINIMO = \(NUM_COLORES)\n"];
output ["Asignacion de colores:"];
output ["["];
output ["\(colores[i]) , " | i in 1..NUM_SIDES-1];
output ["\(colores[NUM_SIDES])]"];
