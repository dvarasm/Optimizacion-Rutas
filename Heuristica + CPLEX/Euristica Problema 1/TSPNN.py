import copy
import data

def TSPNN(costos,ciudades):
	origen = 22 #Concepcion
	resultado = [int(origen)]
	iteracion = int(origen) -1 
	indicador = 0
	distancia = []
	precio = 57 #$CLP
	copia = copy.deepcopy(costos)
	for j in range(1, len(costos)):
		for x in range(len(costos)):
			costos[x][iteracion] = 999999
		distancia.append(min(costos[iteracion]))
		for i in range(len(costos)):
			if min(costos[iteracion]) == costos[iteracion][i]:
				indicador = i
		costos[indicador][iteracion] = 999999
		resultado.append(indicador+1)
		iteracion = indicador
	resultado.append(int(origen))
	a = copia[resultado[-2]-1][int(origen)-1]
	distancia.append(a)
	print("La Ruta es: " )
	print("Ciudad(ID)\n")
	print('->'.join(str(ciudades[resultado[i]-1])+"("+
	str(resultado[i])+")" for i in range(len(ciudades)+1)))
	print("\nDistancia total de " + str(sum(distancia))+"km")
	print("Costo de $" + str(sum(distancia)*precio)+" CLP")
   
#main
TSPNN(data.costos,data.ciudades)