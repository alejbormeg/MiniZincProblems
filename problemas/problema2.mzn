% Autor: Alejandro Borrego Megías
% Problema 2, Asignación de Horarios

include "globals.mzn";

% 1. Definición de variables y constantes

%Horario de 8 a 14
%Lo codificamos como HORASas de una matriz con numeración de 1 a 6, luego hacemos la traducción para mostrar la salida
set of int: HORAS = 1..6; 
%Dias de la semana codificados de 1 a 5
set of int: DIAS = 1..5;
%Numero de profesores, el quinto profesor es el que irá al recreo para indicar que no está ninguno de los otros 4
set of int: PROFESORES = 1..5;

%Array con las asignaturas
array[1..10] of string: strasignaturas = ["A1","A2","A3","A4","A5","A6","A7","A8","A9","NA"];
%Codificación de las asignaturas
array[1..10] of int:    asignaturas    = [ 1,   2,   3,   4,   5,   6,   7,   8,   9  ,  10];
%Numero de horas de cada asignatura
array[1..10] of int: horasAsig         = [ 4,   2,   4,   4,   4,   2,   2,   2,   1  ,  5 ];

 %Matriz solución. Las filas indican las horas y las columnas los días.
array[HORAS,DIAS] of var 1..10: horario;
% Profesores
array[PROFESORES] of string: strProf = ["P1","P2","P3","P4","N"];
%Matriz solución 2. Es similar a la anterior pero con los profesores
array[HORAS,DIAS] of var 1..5: profes;

% 2. Definición de restricciones

%Cada asignatura debe impartirse el número de horas establecido en el enunciado   
constraint forall(k in 1..10)(count([horario[i,j] | i in HORAS, j in DIAS],k)==horasAsig[k]);

%La cuarta hora se deja libre para el recreo
constraint forall(j in DIAS)(horario[4,j] == 10);          

%Las asignaturas A1,A3,A4,A5,A8 se imparten en bloques de dos horas consecutias
%Separamos las restricciónes distinguiendo si es una hora intermedia, si es primera hora o si es última hora
%A1
constraint forall(i in 2..5)( forall(j in DIAS )( ( horario[i,j]==1 -> horario[i-1,j]==1 \/ horario[i+1,j]==1)  ));
constraint forall(i in [1] )( forall(j in DIAS )( ( horario[i,j]==1 ->  horario[i+1,j]==1)  ));
constraint forall(i in [6] )( forall(j in DIAS )( ( horario[i,j]==1 ->  horario[i-1,j]==1)  ));
%A3
constraint forall(i in 2..5)( forall(j in DIAS )( ( horario[i,j]==3 -> horario[i-1,j]==3 \/ horario[i+1,j]==3)  ));
constraint forall(i in [1] )( forall(j in DIAS )( ( horario[i,j]==3 ->  horario[i+1,j]==3)  ));
constraint forall(i in [6] )( forall(j in DIAS )( ( horario[i,j]==3 ->  horario[i-1,j]==3)  ));
%A4
constraint forall(i in 2..5)( forall(j in DIAS )( ( horario[i,j]==4 -> horario[i-1,j]==4 \/ horario[i+1,j]==4)  ));
constraint forall(i in [1] )( forall(j in DIAS )( ( horario[i,j]==4 ->  horario[i+1,j]==4)  ));
constraint forall(i in [6] )( forall(j in DIAS )( ( horario[i,j]==4 ->  horario[i-1,j]==4)  ));
%A5
constraint forall(i in 2..5)( forall(j in DIAS )( ( horario[i,j]==5 -> horario[i-1,j]==5 \/ horario[i+1,j]==5)  ));
constraint forall(i in [1] )( forall(j in DIAS )( ( horario[i,j]==5 ->  horario[i+1,j]==5)  ));
constraint forall(i in [6] )( forall(j in DIAS )( ( horario[i,j]==5 ->  horario[i-1,j]==5)  ));
%A8
constraint forall(i in 2..5)( forall(j in DIAS )( ( horario[i,j]==8 -> horario[i-1,j]==8 \/ horario[i+1,j]==8)  ));
constraint forall(i in [1] )( forall(j in DIAS )( ( horario[i,j]==8 ->  horario[i+1,j]==8)  ));
constraint forall(i in [6] )( forall(j in DIAS )( ( horario[i,j]==8 ->  horario[i-1,j]==8)  ));
                           
%Las asignaturas A2,A6,A7 y A9 se imparten en huecos de una hora                                            
%Indicamos que ni antre ni despúes de cierta hora se puede dar otra hora de estas asignaturas
%A2
constraint forall(i in 2..5)( forall(j in DIAS )( ( horario[i,j]==2 -> horario[i-1,j]!=2 /\ horario[i+1,j]!=2)  ));
constraint forall(i in [1] )( forall(j in DIAS )( ( horario[i,j]==2 ->  horario[i+1,j]!=2)  ));
constraint forall(i in [6] )( forall(j in DIAS )( ( horario[i,j]==2 ->  horario[i-1,j]!=2)  ));
%A6
constraint forall(i in 2..5)( forall(j in DIAS )( ( horario[i,j]==6 -> horario[i-1,j]!=6 /\ horario[i+1,j]!=6)  ));
constraint forall(i in [1] )( forall(j in DIAS )( ( horario[i,j]==6 ->  horario[i+1,j]!=6)  ));
constraint forall(i in [6] )( forall(j in DIAS )( ( horario[i,j]==6 ->  horario[i-1,j]!=6)  ));
%A7
constraint forall(i in 2..5)( forall(j in DIAS )( ( horario[i,j]==7 -> horario[i-1,j]!=7 /\ horario[i+1,j]!=7)  ));
constraint forall(i in [1] )( forall(j in DIAS )( ( horario[i,j]==7 ->  horario[i+1,j]!=7)  ));
constraint forall(i in [6] )( forall(j in DIAS )( ( horario[i,j]==7 ->  horario[i-1,j]!=7)  ));
%A9
constraint forall(i in 2..5)( forall(j in DIAS )( ( horario[i,j]==9 -> horario[i-1,j]!=9 /\ horario[i+1,j]!=9)  ));
constraint forall(i in [1] )( forall(j in DIAS )( ( horario[i,j]==9 ->  horario[i+1,j]!=9)  ));
constraint forall(i in [6] )( forall(j in DIAS )( ( horario[i,j]==9 ->  horario[i-1,j]!=9)  ));

%En cada dia de la semana solo se puede impartir, como maximo, un bloque de cada asignatura
%Para las asignatuas de dos bloques
constraint forall(i in HORAS)(forall (j in DIAS)(
    (horario[i,j]==1 \/ horario[i,j]==3 \/ horario[i,j]==4 \/ horario[i,j]==5 \/ horario[i,j]==8) 
      -> (count([horario[k,j] | k in HORAS],horario[i,j])==2)
    ));
%Para las asignaturas de un bloque
constraint forall(i in HORAS)(forall (j in DIAS)(
    (horario[i,j]==2 \/ horario[i,j]==6 \/ horario[i,j]==7 \/ horario[i,j]==9)
    -> (count([horario[k,j] | k in HORAS],horario[i,j])==1)
  ));

%Asociamos a cada asignatura su correspondiente profesor
%El recreo no tenía profesor asociado
constraint forall(j in DIAS)(profes[4,j] == 5); 
%El profesor 5 que hemos añadido no puede estar en ningún otro sitio que no sea el recreo
constraint forall( i in HORAS where i!= 4)(forall(j in DIAS)(profes[i,j] != 5));
%El profesor 1 da en A1 y A3
constraint forall( i in HORAS where i!= 4)(forall(j in DIAS)((profes[i,j]==1->(horario[i,j]==1 \/ horario[i,j]==3)) ));  
%El profesor 2 da en A4 y A5 
constraint forall( i in HORAS where i!= 4)(forall(j in DIAS)((profes[i,j]==2->(horario[i,j]==4 \/ horario[i,j]==5)) ));
%El profesor 3 da en A6 y A9  
constraint forall( i in HORAS where i!= 4)(forall(j in DIAS)((profes[i,j]==3->(horario[i,j]==6 \/ horario[i,j]==9)) ));
%El profesor 4 da en A2, A7 y A8  
constraint forall( i in HORAS where i!= 4)(forall(j in DIAS)((profes[i,j]==4->(horario[i,j]==2 \/ horario[i,j]==7 \/ horario[i,j]==8))));

%Cada profesor solo puede impartir un bloque de alguna de sus asignatuas cada día, excepto P4, que puede impartir más de una
constraint forall(i in HORAS)(forall (j in DIAS)(
    ( (profes[i,j]==1 \/ profes[i,j]==2 \/ profes[i,j]==3) /\ (horario[i,j]!=1 /\ horario[i,j]!=3 /\ horario[i,j]!=4 /\ horario[i,j]!=5 /\ horario[i,j]!=8)) 
      -> (count([profes[k,j] | k in HORAS],profes[i,j])==1)
    ));
    
constraint forall(i in HORAS)(forall (j in DIAS)(
    ( (profes[i,j]==1 \/ profes[i,j]==2 \/ profes[i,j]==3) /\ (horario[i,j]!=2 /\ horario[i,j]!=6 /\ horario[i,j]!=7 /\ horario[i,j]!=9)) 
      -> (count([profes[k,j] | k in HORAS],profes[i,j])==2)
    ));
                              
%Varios profesores tienen ciertas restricciones horarias:
%1) El profesor 1 solo puede dar clase en las dos ultimas horas de la mañana
constraint forall( i in HORAS where i!= 5 /\ i!= 6)( forall(j in DIAS)(profes[i,j]!=1 ));
%2) El profesor 2 solo puede dar clase en las dos primeras horas de la mañana
constraint forall( i in HORAS where i!=1 /\ i!=2)( forall(j in DIAS)(profes[i,j]!=2));
%3) El profesor 3 solo puede dar clase en la hora justo antes del recreo
constraint forall( i in HORAS where i != 3)(forall (j in DIAS)(profes[i,j]!=3));
  
%Varias asignatuas también deben ser impartidas ciertos días concretos de la semana
%A1: lunes o martes
constraint forall(i in HORAS)(forall(j in DIAS where j!=1 /\ j!=2 )(horario[i,j]!=1));
%A3: miercoles o jueves
constraint forall(i in HORAS)(forall(j in DIAS where j!=3 /\ j!= 4)(horario[i,j]!=3));
%A4: lunes o martes
constraint forall(i in HORAS)(forall(j in DIAS where j!=1 /\ j!=2 )(horario[i,j]!=4));
%A5: jueves o viernes
constraint forall(i in HORAS)(forall(j in DIAS where j!=4 /\ j!=5 )(horario[i,j]!=5));
%A6: miercoles o viernes
constraint forall(i in HORAS)(forall(j in DIAS where j!=3 /\ j!=5 )(horario[i,j]!=6));
%A7: martes o viernes
constraint forall(i in HORAS)(forall(j in DIAS where j!=2 /\ j!=5 )(horario[i,j]!=7));
%A8: miercoles
constraint forall(i in HORAS)(forall(j in DIAS where j!=3 )(horario[i,j]!=8));
%A9: lunes
constraint forall(i in HORAS)(forall(j in DIAS where j!=1 )(horario[i,j]!=9));
  
% 3. Definición del problema
solve satisfy;
   
        
% 4. Definición del output
output ["\n\t\t\tLunes   \tMartes   \tMiercoles   \tJueves   \tViernes \n"] ++
[ "8-9   ->"] ++ [if (fix(horario[1,z]) == k /\ fix(profes[1,z]) == j) then "\t\tA\(asignaturas[k]) - " ++ "P\(j)" else "" endif | z in DIAS,k in 1..10,j in 1..5 ] ++
[ "\n9-10  -> "] ++ [if (fix(horario[2,z]) == k /\ fix(profes[2,z]) == j) then "\t\tA\(asignaturas[k]) - " ++ "P\(j)" else "" endif | z in DIAS,k in 1..10,j in 1..5 ] ++
[ "\n10-11 -> "] ++ [if (fix(horario[3,z]) == k /\ fix(profes[3,z]) == j) then "\t\tA\(asignaturas[k]) - " ++ "P\(j)" else "" endif | z in DIAS,k in 1..10,j in 1..5 ] ++
[ "\n11-12 -> "] ++ [if (fix(horario[4,z]) == k /\ fix(profes[4,z]) == j) then "\t\tNA" else "" endif | z in DIAS,k in 1..10,j in 1..5 ] ++
[ "\n12-13 -> "] ++ [if (fix(horario[5,z]) == k /\ fix(profes[5,z]) == j) then "\t\tA\(asignaturas[k]) - " ++ "P\(j)" else "" endif | z in DIAS,k in 1..10,j in 1..5 ] ++
[ "\n13-14 -> "] ++ [if (fix(horario[6,z]) == k /\ fix(profes[6,z]) == j) then "\t\tA\(asignaturas[k]) - " ++ "P\(j)" else "" endif | z in DIAS,k in 1..10,j in 1..5 ];