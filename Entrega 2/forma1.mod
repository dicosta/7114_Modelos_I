# Conjuntos
set BANCOS;
set NODOS;

# Parametros
param DIST{i in NODOS, j in NODOS};

#Definicion de variables
var tramo{i in NODOS, j in NODOS} binary;
var orden{i in BANCOS} integer >= 0;

/* Funcional */
minimize z: sum{i in NODOS, j in NODOS} DIST[i,j] * tramo[i,j];

/* Restricciones */
# Entra y Sale de todos
s.t. dest{j in NODOS}: sum{i in NODOS: i <> j} tramo[i,j] = 1;
s.t. orig{i in NODOS}: sum{j in NODOS: j <> i} tramo[i,j] = 1;
# Sin SubTour
s.t. orde{i in BANCOS, j in BANCOS: i <> j}: orden[i]-orden[j]+(10*tramo[i,j])<=9;

end;