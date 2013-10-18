# Conjuntos
set BANCOS;
set NODOS;
set ORDENES;

# Parametros
param DIST{i in NODOS, j in NODOS};
param MONTOS{i in NODOS};
param M;

#Definicion de variables
var tramo{i in NODOS, j in NODOS} binary;
var orden{i in BANCOS} integer >= 0;
var visord{i in BANCOS, j in ORDENES} binary;
var montocam{i in ORDENES} >= 0;


/* Funcional */
minimize z: sum{i in NODOS, j in NODOS} DIST[i,j] * tramo[i,j];

/* Restricciones */
# Entra y Sale de todos
s.t. dest{j in NODOS}: sum{i in NODOS: i <> j} tramo[i,j] = 1;
s.t. orig{i in NODOS}: sum{j in NODOS: j <> i} tramo[i,j] = 1;

# Sin SubTour
s.t. orde{i in BANCOS, j in BANCOS: i <> j}: orden[i]-orden[j]+(10*tramo[i,j])<=9;

s.t. ord_unico{i in BANCOS}: sum{j in ORDENES: j<>0 } visord[i,j] = 1;
s.t. region_ord{i in BANCOS}: sum{j in ORDENES: j<>0} j*visord[i,j]  = orden[i];

s.t. inicial: montocam[0]=0;
s.t. carga{j in ORDENES: j<>0}: montocam[j-1] + sum{i in BANCOS} MONTOS[i] * visord[i, j] = montocam[j];

s.t. tope{i in ORDENES: i<>0}: montocam[i] <= 200000;
s.t. piso{i in ORDENES: i<>0}: montocam[i] >=0;

end;