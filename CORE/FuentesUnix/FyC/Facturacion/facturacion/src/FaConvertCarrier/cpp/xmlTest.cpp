//
// Hugo A. Sanchez D.
//
#include <stdio.h>
#include <sstream>
#include <fstream>
#include <iostream>
#include <string.h>
#include "ConfigSpecLine.h"
#include "ConfigSpec.h"
//#include "xmlParser.h"
#include "Conf.h"

using namespace std;

int main(int argc,char*argv[])
{
	
	if (argc == 6)
	{
		Conf Parser;
		int fila;
	
		cout << "FaConvertCarrier ver. 25/05/2005" << endl << endl;
		const char* file=argv[4];
		ofstream outFileDat(file);
  		outFileDat.close();
	
		fila = Parser.readXML(argv[1],"Encabezado", argv[3], argv[5], 1);
		Parser.readwriteDAT(argv[2],"Encabezado", argv[4], 1,fila);
	
		fila = Parser.readXML(argv[1],"Contenido", argv[3], argv[5], 2);
		Parser.readwriteDAT(argv[2],"Contenido", argv[4], 2,fila);
	}
		else
		{
			cout << "número de parámetros invalido, ejecutar: ./FaConvertCarrier plantilla_origen.xml plantilla_destino.xml origendatos.dat destinodatos.dat" << endl;
	
		}
	
  return 0;
}
