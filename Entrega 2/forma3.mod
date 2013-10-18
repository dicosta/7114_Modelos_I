# Conjuntos
set BANCOS;
set NODOS;

# Parametros
param DIST{i in NODOS, j in NODOS};
param MONTOS{i in NODOS};
param M;

#Definicion de variables
var tramo{i in NODOS, j in NODOS} binary;
var orden{i in BANCOS} integer >= 0;
var indic{i in BANCOS, j in BANCOS} binary;
var montocam{i in BANCOS} >= 0;

/* Funcional */
minimize z: sum{i in NODOS, j in NODOS} DIST[i,j] * tramo[i,j];

/* Restricciones */
# Entra y Sale de todos
s.t. dest{j in NODOS}: sum{i in NODOS: i <> j} tramo[i,j] = 1;
s.t. orig{i in NODOS}: sum{j in NODOS: j <> i} tramo[i,j] = 1;

# Sin SubTour
s.t. orde{i in BANCOS, j in BANCOS: i <> j}: orden[i]-orden[j]+(10*tramo[i,j])<=9;

s.t. ord_unico{i in BANCOS}: sum{j in BANCOS: i<>j } indic[i,j] = 1;

#s.t. carga{j in BANCOS}: sum{i in BANCOS} MONTOS[i] * visant[i, j] = montocam[j];

s.t. sol{i in BANCOS, j in BANCOS: i <> j}: -1000000000*(1-indic[j,i]) + (montocam[i] + MONTOS[i]) <= montocam[j];

s.t. soldos{i in BANCOS, j in BANCOS: i <> j}:  montocam[j]<= (1-indic[j,i])*10000000 + (montocam[i] + MONTOS[i]);


#s.t. carga{j in BANCOS}: sum{i in BANCOS} MONTOS[i] * visant[i, j] = montocam[j];

s.t. tope{i in BANCOS}: montocam[i] <= 20000;
s.t. piso{i in BANCOS}: montocam[i] >=0;

end;