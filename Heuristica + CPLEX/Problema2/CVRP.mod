/*********************************************
 * OPL 12.7.1.0 Model
 * Author: varas
 * Creation Date: 02-12-2018 at 17:31:33
 *********************************************/
int n= ...;
int k=...;
range locales=0..n;
range autos = 1..k;
int C[locales][locales]=...;
int Q;
int d[locales];

tuple  arista{
	int i;
	int j;
}

int suma=0;
execute{
	for(var i in locales){
		d[i] = Opl.rand(100);
	}
	for(var i in locales){
		suma = suma + d[i];	
	}
	Q= Opl.round(suma/k); 
}

setof(arista) aristas = {<i,j> | i,j in locales: i!=j};

int c[aristas];

execute{
	for(var e in aristas){
		if(e.i!=e.j)	
			c[e] = C[e.i][e.j];
	}
}
execute{
	writeln(c);
}


dvar boolean X[autos][aristas];
dvar float+ u[2..n];

dexpr int Mincost  = sum (r in autos,e in aristas)  c[e]*X[r][e];

minimize Mincost;

subject to{
	  max_auto:
		sum(r in autos,j in locales: j>0) X[r][<0,j>] <=k;
	
	forall (r in autos,j in locales)
	  entra:
	  sum(i in locales: i != j ) X[r][<i,j>] ==1;
	  
	forall (r in autos,i in locales)
	  sale:
	  sum(j in locales:  j != i ) X[r][<i,j>] == 1;
	
   forall(r in autos)
    	demanda:
    		sum(i in locales,j in locales:j>0 && i!=j && j!=i) d[j]*X[r][<i,j>]<=Q;
  
   forall(r in autos,i in locales : i>1, j in locales: j>1 && j!=i)
		subtour:
		u[i] - u[j] + (n-1)*X[r][<i,j>] <= (n-2);
}
execute{
	writeln("Minimo Costo: ",Mincost);
}