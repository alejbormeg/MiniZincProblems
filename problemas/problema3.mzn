% Autor: Alejandro Borrego Megías
% Problema 3, Problema lógico

include "globals.mzn";

% 1. Definición de variables y constantes
%Elementos distintos
set of int : NUM = 1..5;

%Array regiones
array[NUM] of string : regiones= ["vasco", "catalan", "gallego","andaluz", "navarro"];
%Array de Casas
array[NUM] of string : casas= ["casa roja", "casa verde", "casa blanca","casa amarilla", "casa azul"];
%Array Profesiones
array[NUM] of string : profesiones= ["pintor", "escultor", "diplomatico","violinista", "medico"];
%Array Animales
array[NUM] of string : animales= ["perro", "caracoles", "zorro","caballo", "cebra"];
%Array Bebidas
array[NUM] of string : bebidas= ["te", "cafe", "leche","zumo", "agua"];

%Creamos grid solución 5x5
array[NUM,NUM] of var NUM: grid;

%2. Restricciones

% Todos diferentes por filas
constraint forall (i in NUM) ( alldifferent( [ grid[i,j] | j in NUM ]) );
%El vasco vive en la casa roja 
constraint forall (i in NUM) ( grid [1,i]==1 <-> grid[2,i]==1 );
%El catalan tiene un perro
constraint forall (i in NUM) ( grid [1,i]==2 <-> grid[4,i]==1 );
%El gallego es un pintor
constraint forall (i in NUM) ( grid [1,i]==3 <-> grid[3,i]==1 );
%El navarro bebe te
constraint forall (i in NUM) ( grid [1,i]==5 <-> grid[5,i]==1 );
%El andaluz vive en la primera casa de la izquierda
constraint grid[1,1]==4;
%El de la casa verde bebe cafe
constraint forall (i in NUM) ( grid [2,i]==2 <-> grid[5,i]==2 );
%La casa verde está a la derecha de la Blanca
constraint forall (i in NUM) (grid [2,i]==2 <-> grid[2,i-1]==3 );
%El escultor cría caracoles
constraint forall (i in NUM) ( grid [3,i]==2 <-> grid[4,i]==2 );
%El diplomático vive en la casa amarilla
constraint forall (i in NUM) ( grid [3,i]==3 <-> grid[2,i]==4 );
%En la casa central se bebe leche
constraint grid[5,3]==3;
%La casa del andaluz está al lado de la azul 
constraint forall (i in 2..4) (grid[1,i]==4 -> grid[2,i+1]==5 \/ grid[2,i-1]==5);
constraint grid[1,1]==4 -> grid[2,2]==5;
constraint grid[1,5]==4 -> grid[2,4]==5;

%El violinista bebe zumo
constraint forall (i in NUM) ( grid [3,i]==4 <-> grid[5,i]==4 );
%El zorro está en una casa al lado del médico
constraint forall (i in 2..4) (grid[4,i]==3 -> grid[3,i+1]==5 \/ grid[3,i-1]==5);
constraint grid[4,1]==3 -> grid[3,2]==5;
constraint grid[4,5]==3 -> grid[3,4]==5;

%El caballo está en una casa al lado del diplomático
constraint forall (i in 2..4) (grid[4,i]==4 -> grid[3,i+1]==3 \/ grid[3,i-1]==3);
constraint grid[4,1]==4 -> grid[3,2]==3;
constraint grid[4,5]==4 -> grid[3,4]==3;

% 3. Definición del problema
solve satisfy; 

% 4. Definición del output
output ["\t\t    \(i)      " | i in NUM];
output ["\n 1 -> \t"];
output ["\(regiones[fix(grid[1,i])]) \t\t" | i in NUM];
output ["\n 2 -> \t"];
output ["\(casas[fix(grid[2,i])]) \t\t" | i in NUM];
output ["\n 3 -> \t"];
output ["\(profesiones[fix(grid[3,i])]) \t\t" | i in NUM];
output ["\n 4 -> \t"];
output ["\(animales[fix(grid[4,i])]) \t\t" | i in NUM];
output ["\n 5 -> \t"];
output ["\(bebidas[fix(grid[5,i])]) \t\t\t" | i in NUM];


