% Autor:Alejandro Borrego Megías
% Problema 4, Construcción Casa

include "globals.mzn";

% 1. Definición de variables y constantes
% Número de tareas 
set of int : NUMTAREAS = 1..9; 

% Tareas
array[NUMTAREAS] of string : strTareas = ["A", "B", "C", "D", "E", "F", "G", "H", "I"];

% Duración de las tareas para trabajador 1
array[NUMTAREAS] of int : duracion1 = [4, 3, 3, 2, 4, 3, 1, 1, 2];
% Duración de las tareas para trabajador 2
array[NUMTAREAS] of int : duracion2 = [7, 5, 1, 5, 2, 2, 2, 3, 3];
% Duración de las tareas para trabajador 3
array[NUMTAREAS] of int : duracion3 = [10, 7, 4, 8, 6, 1, 3, 5, 4];
% Array de tiempos
array[NUMTAREAS,1..3] of int : duraciones = array2d(NUMTAREAS,1..3,[
  4,7,10,
  3,5,7,
  3,1,4,
  2,5,8,
  4,2,6,
  3,2,1,
  1,2,3,
  1,3,5,
  2,3,4,
]);

% Duración máxima, A empieza en tiempo 1 y sumamos la duración del resto de tareas como si fuera secuencial para obtener la duracion máxima
int: DURACIONMAXIMA = sum(i in NUMTAREAS)(max([duraciones[i,j] |j in 1..3]));

% Número máximo de días
set of int : NUMDIASMAX = 1..DURACIONMAXIMA;
% Tiempo de inicio (mínimo) de cada tarea
array[NUMTAREAS] of var NUMDIASMAX : inicio;
% Tiempo transcurrido hasta finalizar cada tarea
array[NUMTAREAS] of var NUMDIASMAX : fin;
%Trabajador al que se asigna la tarea
% El trabajador 4 indica que están trabajando juntos el 1 y 4
% El trabajador 5 indica que están trabajando juntos el 2 y 4
% El trabajador 6 indica que están trabajando juntos el 3 y 4
array[NUMTAREAS] of var 1..6 : trabajador;
% Tiempo empleado
var int : tiempo;
% Matriz en la que cada fila es una tarea y tiene tres columnas, con el día de inicio de la actividad, el día de fin y el trabajador al que se asigna la tarea


% 2. Definición de restricciones
% Tarea A
% Empieza en tiempo 1
constraint inicio[1] = 1;
% Obtenemos el tiempo cuando finaliza y el trabajador
constraint (fin[1] = inicio[1] + duraciones[1,1] /\ trabajador[1]=1) 
\/ 
(fin[1] = inicio[1] + duraciones[1,2] /\ trabajador[1]=2) 
\/ 
(fin[1] = inicio[1] + duraciones[1,3] /\ trabajador[1]=3)
\/ 
(fin[1] = inicio[1] + duraciones[1,1] - 2 /\ trabajador[1]=4) 
\/ 
(fin[1] = inicio[1] + duraciones[1,2] - 2 /\ trabajador[1]=5) 
\/ 
(fin[1] = inicio[1] + duraciones[1,3] - 2 /\ trabajador[1]=6);

% Tarea B
% Empieza cuando acaba A
constraint inicio[2] >= fin[1];
% Obtenemos el tiempo cuando finaliza y el trabajador
constraint (fin[2] = inicio[2] + duraciones[2,1] /\ trabajador[2]=1) 
\/ 
(fin[2] = inicio[2] + duraciones[2,2] /\ trabajador[2]=2) 
\/ 
(fin[2] = inicio[2] + duraciones[2,3] /\ trabajador[2]=3)
\/
(fin[2] = inicio[2] + duraciones[2,1] - 2 /\ trabajador[2]=4) 
\/ 
(fin[2] = inicio[2] + duraciones[2,2] - 2 /\ trabajador[2]=5) 
\/ 
(fin[2] = inicio[2] + duraciones[2,3] - 2 /\ trabajador[2]=6);

% Tarea C
% Empieza cuando acaba B
constraint inicio[3] >= fin[2]; 
% Obtenemos el tiempo cuando finaliza y el trabajador
constraint (fin[3] = inicio[3] + duraciones[3,1] /\ trabajador[3]=1) 
\/ 
(fin[3] = inicio[3] + duraciones[3,2] /\ trabajador[3]=2) 
\/ 
(fin[3] = inicio[3] + duraciones[3,3] /\ trabajador[3]=3)
\/
(fin[3] = inicio[3] + duraciones[3,1] - 2 /\ trabajador[3]=4) 
\/ 
(fin[3] = inicio[3] + duraciones[3,2] - 2 /\ trabajador[3]=5) 
\/ 
(fin[3] = inicio[3] + duraciones[3,3] - 2 /\ trabajador[3]=6);

% Tarea D
% Empieza cuando acaba A
constraint inicio[4] >= fin[1];
% Obtenemos el tiempo cuando finaliza y el trabajador
constraint (fin[4] = inicio[4] + duraciones[4,1] /\ trabajador[4]=1) 
\/ 
(fin[4] = inicio[4] + duraciones[4,2] /\ trabajador[4]=2) 
\/ 
(fin[4] = inicio[4] + duraciones[4,3] /\ trabajador[4]=3)
\/
(fin[4] = inicio[4] + duraciones[4,1] - 2 /\ trabajador[4]=4) 
\/ 
(fin[4] = inicio[4] + duraciones[4,2] - 2 /\ trabajador[4]=5) 
\/ 
(fin[4] = inicio[4] + duraciones[4,3] - 2 /\ trabajador[4]=6);

% Tarea E
% Empieza cuando acaba C y D
constraint inicio[5] >= fin[3] /\ inicio[5] >= fin[4];
% Obtenemos el tiempo cuando finaliza y el trabajador
constraint (fin[5] = inicio[5] + duraciones[5,1] /\ trabajador[5]=1) 
\/ 
(fin[5] = inicio[5] + duraciones[5,2] /\ trabajador[5]=2) 
\/ 
(fin[5] = inicio[5] + duraciones[5,3] /\ trabajador[5]=3)
\/
(fin[5] = inicio[5] + duraciones[5,1] - 2 /\ trabajador[5]=4) 
\/ 
(fin[5] = inicio[5] + duraciones[5,2] - 2 /\ trabajador[5]=5) 
\/ 
(fin[5] = inicio[5] + duraciones[5,3] - 2 /\ trabajador[5]=6);


% Tarea F
% Empieza cuando acaba C y D
constraint inicio[6] >= fin[3] /\ inicio[6] >= fin[4];
% Obtenemos el tiempo cuando finaliza y el trabajador
constraint (fin[6] = inicio[6] + duraciones[6,1] /\ trabajador[6]=1) 
\/ 
(fin[6] = inicio[6] + duraciones[6,2] /\ trabajador[6]=2) 
\/ 
(fin[6] = inicio[6] + duraciones[6,3] /\ trabajador[6]=3)
\/
(fin[6] = inicio[6] + duraciones[6,1] - 2 /\ trabajador[6]=4) 
\/ 
(fin[6] = inicio[6] + duraciones[6,2] - 2 /\ trabajador[6]=5) 
\/ 
(fin[6] = inicio[6] + duraciones[6,3] - 2 /\ trabajador[6]=6);

% Tarea G
% Empieza cuando acaban C y D
constraint inicio[7] >= fin[3] /\ inicio[7] >= fin[4];
% Obtenemos el tiempo cuando finaliza y el trabajador
constraint (fin[7] = inicio[7] + duraciones[7,1] /\ trabajador[7]=1) 
\/ 
(fin[7] = inicio[7] + duraciones[7,2] /\ trabajador[7]=2) 
\/ 
(fin[7] = inicio[7] + duraciones[7,3] /\ trabajador[7]=3)
\/
(fin[7] = inicio[7] + duraciones[7,1] - 2 /\ trabajador[7]=4) 
\/ 
(fin[7] = inicio[7] + duraciones[7,2] - 2 /\ trabajador[7]=5) 
\/ 
(fin[7] = inicio[7] + duraciones[7,3] - 2 /\ trabajador[7]=6);

% Tarea H
% Empieza cuando acaba A
constraint inicio[8] >= fin[1]; 
% Obtenemos el tiempo cuando finaliza y el trabajador
constraint (fin[8] = inicio[8] + duraciones[8,1] /\ trabajador[8]=1) 
\/ 
(fin[8] = inicio[8] + duraciones[8,2] /\ trabajador[8]=2) 
\/ 
(fin[8] = inicio[8] + duraciones[8,3] /\ trabajador[8]=3)
\/
(fin[8] = inicio[8] + duraciones[8,1] - 2 /\ trabajador[8]=4) 
\/ 
(fin[8] = inicio[8] + duraciones[8,2] - 2 /\ trabajador[8]=5) 
\/ 
(fin[8] = inicio[8] + duraciones[8,3] - 2 /\ trabajador[8]=6);

% Tarea I
% Empieza cuando acaban F y H
constraint inicio[9] >= fin[6] /\ inicio[9] >= fin[8];
% Obtenemos el tiempo cuando finaliza y el trabajador
constraint (fin[9] = inicio[9] + duraciones[9,1] /\ trabajador[9]=1) 
\/ 
(fin[9] = inicio[9] + duraciones[9,2] /\ trabajador[9]=2) 
\/ 
(fin[9] = inicio[9] + duraciones[9,3] /\ trabajador[9]=3)
\/
(fin[9] = inicio[9] + duraciones[9,1] - 2 /\ trabajador[9]=4) 
\/ 
(fin[9] = inicio[9] + duraciones[9,2] - 2 /\ trabajador[9]=5) 
\/ 
(fin[9] = inicio[9] + duraciones[9,3] - 2 /\ trabajador[9]=6);

%Desde que se inicia una tarea hasta que acaba ese trabajador no puede hacer otra cosa
constraint forall(i in NUMTAREAS, j in NUMTAREAS where i!=j) (if trabajador[i]==trabajador[j] then (fin[i]<=inicio[j] \/ fin[j]<=inicio[i]) endif);
%Los trabajadores 4,5 y 6 hacen referencia al mismo trabajador, el 4, por lo que no pueden realizarse tareas simultáneamente
constraint forall (i in NUMTAREAS, j in NUMTAREAS where i!=j) (if (trabajador[i]==4 \/ trabajador[i]==5 \/ trabajador[i]==6) /\ (trabajador[j]==4 \/ trabajador[j]==5 \/ trabajador[j]==6) then (fin[i]<=inicio[j] \/ fin[j]<=inicio[i]) endif);
% Si el trabajador 4 está trabajando no puede trabajar 1 en otra cosa
constraint forall (i in NUMTAREAS, j in NUMTAREAS where i!=j) (if trabajador[i]==1 /\ trabajador[j]==4 then (fin[i]<=inicio[j] \/ fin[j]<=inicio[i]) endif);
% Si el trabajador 5 está trabajando no puede trabajar 2 en otra cosa
constraint forall (i in NUMTAREAS, j in NUMTAREAS where i!=j) (if trabajador[i]==2 /\ trabajador[j]==5 then (fin[i]<=inicio[j] \/ fin[j]<=inicio[i]) endif);
% Si el trabajador 6 está trabajando no puede trabajar 3 en otra cosa
constraint forall (i in NUMTAREAS, j in NUMTAREAS where i!=j) (if trabajador[i]==3 /\ trabajador[j]==6 then (fin[i]<=inicio[j] \/ fin[j]<=inicio[i]) endif);
%Restricción que impide que el trabajador 4 apoye en tareas de menos de 3 días
constraint forall(i in NUMTAREAS) (fin[i]- inicio[i]>=1);





% 3. Definición del problema
% Hay que restar uno porque si no restamos 1 estaríamos mostrando el tiempo en el que empezaría la siguiente tarea
tiempo = max(fin)-1;
solve minimize tiempo;

% 4. Definición del output
output ["TIEMPO MINIMO = \(tiempo)\n"];
output ["TAREA \(strTareas[i]) empieza en tiempo \(inicio[i]), acaba en tiempo \(fin[i]), y la realiza el trabajador \(trabajador[i])\n" | i in NUMTAREAS];
