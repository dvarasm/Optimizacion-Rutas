/*********************************************
 * OPL 12.7.1.0 Model
 * Author: varas
 * Creation Date: 03-12-2018 at 12:13:27
 *********************************************/
int n= ...;
//range ciudades = 0..n-1;
range ciudades = 1..n;
int D[ciudades][ciudades]=...;

tuple  arista{
	int i;
	int j;
}

setof(arista) aristas = {<i,j> | i,j in ciudades: i != j};

int c[aristas];

execute{
	for(var e in aristas){
		if(e.i!=e.j)	
			c[e] = D[e.i][e.j];
	}
}

dvar boolean X[aristas];
dvar float+ u[2..n];

dexpr int TotalDistance  = sum (e in aristas)  c[e]*X[e];

minimize TotalDistance;

subject to {
	forall (j in ciudades)
	  entra:
	  sum(i in ciudades: i != j ) X[<i,j>] ==1;
	  
	forall (i in ciudades)
	  sale:
	  sum(j in ciudades:  j != i ) X[<i,j>] == 1;

	forall(i in ciudades : i>1, j in ciudades: j>1 && j!=i)
		subtour:
		u[i] - u[j] + (n-1)*X[<i,j>] <= n-2;
}


