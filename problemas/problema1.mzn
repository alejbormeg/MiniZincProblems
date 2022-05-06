% Autor: Alejandro Borrego Megías
% Problema 1
%Problema de las monedas

include "globals.mzn";

% 1. Definición de variables y constantes
% Importe en céntimos
int : IMPORTE = 499;
int : PARTE_ENTERA=(IMPORTE div 100)*100;
int : PARTE_DECIMAL=IMPORTE-PARTE_ENTERA;
%  Tipos de monedas distintas, hay 8
set of int : TIPOS = 1..8;
% Almacenamos las monedas para centimos y euros por separado
set of int : TIPOS1 = 1..6;
set of int : TIPOS2 = 7..8;

% Número de monedas de cada que puede haber
set of int : VALUES = 0..IMPORTE;
% Array con el número de monedas seleccionadas de cada moneda
array[TIPOS] of var VALUES: numMonedas;
% Array con las diferentes monedas
array[TIPOS] of int : monedas = [1, 2, 5, 10, 20, 50, 100, 200];

% 2. Definición de restricciones

% La suma de las monedas escogidas entre los centimos tiene que ser la parte decimal
constraint sum(i in TIPOS1)(monedas[i]*numMonedas[i]) == PARTE_DECIMAL;
% La suma de las monedas escogidas entre los euros tiene que ser la parte entera
constraint sum(i in TIPOS2)(monedas[i]*numMonedas[i]) == PARTE_ENTERA;

% 3. Definición del problema
solve minimize sum(i in TIPOS)(numMonedas[i]);

% 4. Definición del output
output ["Monedas: \(numMonedas[TIPOS])"];
output ["\nTotal monedas: \(sum(i in TIPOS)(numMonedas[i]))"];
