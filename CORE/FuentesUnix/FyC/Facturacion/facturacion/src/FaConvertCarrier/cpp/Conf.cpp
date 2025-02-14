//
// Hugo A. Sanchez D.
//
#include "Conf.h"
#include <sstream>
#include <fstream>
#include <iostream>
#include <string>
#include <stdio.h>
#include <time.h>
#include "LogReport.h"


#define OPEN_ONLY_READ       "rb"
#define OPEN_READ_WRITE     "r+"
#define CREATE_WRITE         "wb"
#define CREATE_READ_WRITE   "w+"
#define OPEN_APEND           "a"
#define OPEN_CREAT_APEND    "a+"



using namespace std;

Conf::Conf(){
	a = 0;
}
Conf::~Conf(){
	delete a;
}

ConfigSpec Conf::ReadFile(string strFilename) // throw( FileIOException, SyntaxErrorException )
{

}
// **************************************************************************************************************
// Método readXML
// **************************************************************************************************************
int Conf::readXML(char *inFileXML, char *in_tag, char *inFileDat, char *outFileErr, int row) // throw( FileIOException, SyntaxErrorException )
{
  ConfigSpecLine lstmp;
  ConfigSpecLineData lstmpData;
  ConfigSpecLineConv lstmpConv;
  LogReport logRep;
	
  ifstream archivo(inFileDat, ios::in);
  char linea[128];
  long contador = 0L;
  string cadena, rell;
  int inicio,tamano,cod;
  string test;
  int size_linea;
  int k;
 
  // Rutina para el log
  
  time_t rawtime;
  struct tm* timeinfo;
  char fechahora[255];
  char filename[255];
  char dirname[255];
  char extname[255];
  char prename[255];
  char comando[1024];

  FILE * pFileIn = (FILE *)NULL;
		
  pFileIn = fopen (inFileDat,OPEN_ONLY_READ);

  if (row == 1)
  {
  	cout << "Pre-Procesando archivo de origen..." << endl;
  		
  	while (!feof(pFileIn))
 	{
  		char c = 32;
		/*char c = fgetc (pFileIn);
		n++;
		if (n == 1) continue;
		if ((c >= 32 && c<= 126) || (c == '\n') || (c == '\t')) { fputc (c , pFileOut); }*/
		fread (&c, 1, 1, pFileIn);
		if ((c >= 32 && c<= 126) || (c == '\n') || (c == '\t'))
		{
		}
		else 
		{ 
			cout << "Error, Archivo con carácteres fuera de la normal" << endl;
			time ( &rawtime );
 			timeinfo = localtime ( &rawtime );
  			sprintf(fechahora, "%d-%d-%d.%d_%d_%d", 
  			timeinfo->tm_mday, timeinfo->tm_mon+1, 1900+timeinfo->tm_year, 
  			timeinfo->tm_hour, timeinfo->tm_min, timeinfo->tm_sec);
  
  			sprintf(prename, "%s%s%s%s", outFileErr, "/",fechahora, "/FaConvertCarrier_");				
  			sprintf(extname, "%s", "err");
  			sprintf(filename, "%s.%s.%s", prename, fechahora, extname);
  			char makedir[50]; 
			sprintf(dirname, "mkdir %s%s%s", outFileErr, "/", fechahora );
			system (dirname);
			
  			logRep.init(filename);
  			logRep.addCampo("Error, Archivo con carácteres fuera de la normal");
			logRep.printCampos();
			logRep.addCampo(inFileDat);
			logRep.printCampos();
			exit(1);
	     	}
	}
        fclose (pFileIn);
  }
  if(archivo.fail())
  	cerr << "Error al abrir el archivo origen dat" << endl;
  	
  //cout << "Procesando archivo xml origen: " << inFileXML << " Tag: " << in_tag << endl;
  XMLNode xMainNode=XMLNode::openFileHelper(inFileXML,"Buffer");
  
  XMLNode xNode=xMainNode.getChildNode("Info");  
  //printf("Nombre aplicacion: '%s'\n", xNode.getChildNode("Application").getAttribute("name"));

  
  string v1 = in_tag;
  if (v1 == "Encabezado")
  {
  	size_linea  = atoi(xNode.getChildNode("Application").getAttribute("tam_Enc"));
  }
  else
  	{
	size_linea = atoi(xNode.getChildNode("Application").getAttribute("tam_Cont"));
  	}

  xNode=xMainNode.getChildNode(in_tag); 
  int n=xNode.nChildNode("campo");
  int ini=xNode.nChildNode("ini");
  //int fin=xNode.nChildNode("fin");


  int i,iterator=0, iterator2=0, iterator3=0, iterator4=0, iterator5=0, iterator6=0, iterator7=0;

  //Lectura de una linea

  if (row==2) {
  	archivo.getline(linea, sizeof(linea));
  }
  	
  	archivo.getline(linea, sizeof(linea));
  	
  	if (strlen(linea)!=size_linea) 
  	{
  		cout << "Error, tamaño de linea no corresponde a la definición del XML de origen" << endl;
  		time ( &rawtime );
 		timeinfo = localtime ( &rawtime );
  		sprintf(fechahora, "%d-%d-%d.%d_%d_%d", 
  		timeinfo->tm_mday, timeinfo->tm_mon+1, 1900+timeinfo->tm_year, 
  		timeinfo->tm_hour, timeinfo->tm_min, timeinfo->tm_sec);
  
  		sprintf(prename, "%s%s%s%s", outFileErr,  "/", fechahora, "/FaConvertCarrier_");				
  		sprintf(extname, "%s", "err");
  		sprintf(filename, "%s.%s.%s", prename, fechahora, extname);
  		char makedir[50]; 
		sprintf(dirname, "mkdir %s%s%s", outFileErr, "/", fechahora );
		system (dirname);
		
  		logRep.init(filename);
  		logRep.addCampo("Error, tamaño de linea no corresponde a la definición del XML de origen");
		logRep.printCampos();
		logRep.addCampo(inFileDat);
		logRep.printCampos();
  		exit(1);
  	}
        
  	cadena="\0";
  	cadena.append(linea);

  	for (i=0; i<n; i++) {

    	lstmp.cod  = xNode.getChildNode("campo",&iterator).getAttribute("cod");
    	tamano = atoi(xNode.getChildNode("campo",&iterator3).getAttribute("tam"));
    	lstmp.tam = tamano;
    	inicio  = atoi(xNode.getChildNode("campo",&iterator2).getAttribute("ini"));
    
    	inicio--; // dado que el primer caracter de un archivo esta en la posicion "0"
    
    	lstmp.ini = inicio;
    	lstmp.rell = xNode.getChildNode("campo",&iterator4).getAttribute("rell");
    	lstmp.data = cadena.substr(inicio,tamano);
    	info_file.push_back(lstmp);
    	//cout << ".";
    	//cout <<  "Pushback packet ini: "<< inicio << " tam: " << tamano << " cadena: " << cadena.substr(inicio,tamano) << endl;
    	//cin >> test;
    	
    	
  	}
  	
  	if (row==2) 
		{
  			while (!archivo.eof())
  							{
  								row++;
  								//cin >> test; 
  								iterator=0, iterator2=0, iterator3=0, iterator4=0;
  								archivo.getline(linea, sizeof(linea));
    								if (strlen(linea)!=size_linea) 
  								{
  									cout << "Error, tamaño de linea no corresponde a la definición del XML de origen" << endl;
  									time ( &rawtime );
 									timeinfo = localtime ( &rawtime );
  									sprintf(fechahora, "%d-%d-%d.%d_%d_%d", 
  									timeinfo->tm_mday, timeinfo->tm_mon+1, 1900+timeinfo->tm_year, 
  									timeinfo->tm_hour, timeinfo->tm_min, timeinfo->tm_sec);
  
  									sprintf(prename, "%s%s%s%s", outFileErr, "/", fechahora, "/FaConvertCarrier_");				
  									sprintf(extname, "%s", "err");
  									sprintf(filename, "%s.%s.%s", prename, fechahora, extname);
  									char makedir[50]; 
									sprintf(dirname, "mkdir %s%s%s", outFileErr, "/", fechahora );
									system (dirname);
									
  									logRep.init(filename);
  									logRep.addCampo("Error, tamaño de linea no corresponde a la definición del XML de origen");
									logRep.printCampos();
									logRep.addCampo(inFileDat);
									logRep.printCampos();

  									exit(1);
  								}
  								cadena="\0";
  								cadena.append(linea);
  								//cout << "procesando la linea " << row << "cadena:" << cadena << endl;
  								for (i=0; i<n; i++) {

    								lstmpData.cod  = xNode.getChildNode("campo",&iterator).getAttribute("cod");
    								tamano = atoi(xNode.getChildNode("campo",&iterator3).getAttribute("tam"));
    								lstmpData.tamano_origen = tamano;
    								inicio  = atoi(xNode.getChildNode("campo",&iterator2).getAttribute("ini"));
    								inicio--; // dado que el primer caracter de un archivo esta en la posicion "0"
    								
    								lstmpData.data = cadena.substr(inicio,tamano);
    								lstmpData.row = row;
    								info_fileData.push_back(lstmpData);
    								//cout <<  "Pushback packet in info_fileData , elemento: " << i << " cadena: " << cadena.substr(inicio,tamano) << endl;
  								}
  							}
  							
  	}
  	
  	
  	xNode=xMainNode.getChildNode("Equivalencias"); 
        int eq=xNode.nChildNode("campo");
        
        //cout << "eq equivalencia = " << eq << endl;
  	
  	if (row!=1)
  	{
			for (i=0; i<eq; i++)
			 {
				  cout << "cargando equivalencias..." << i << endl;
				  //cin >> test;
					lstmpConv.cod = xNode.getChildNode("campo",&iterator5).getAttribute("cod");
					lstmpConv.valor = xNode.getChildNode("campo",&iterator6).getAttribute("valor");
					lstmpConv.conversion = xNode.getChildNode("campo",&iterator7).getAttribute("conversion");
			    		info_fileConv.push_back(lstmpConv);
  		 }
  	}
  	
	xMainNode=XMLNode::emptyXMLNode;

  return row;
}
// **************************************************************************************************************
// Método readwriteDAT que permite leer un archivo plano.
// **************************************************************************************************************
void Conf::readwriteDAT(char *outFileXML, char *out_tag, char *outFileDAT, int row, int fila)
{
  
  int inicio,inicial,tamano_xml_destino;
  string cod;
  int i,j, iterator=0, iterator2=0, iterator3=0, iterator4=0, iterator9=0;
  string relleno, rell, dat, test, direccion;
  int size, grabar, resta;
 
  const char* file=outFileDAT;
  ofstream outFileDat(file, ios::app );
  
  contenedor = getConfigSpec();
  contenedorData = getConfigSpecData();
  contenedorConv = getConfigSpecConv();

	//cout << "Procesando archivo xml destino: " << outFileXML << " Tag: " << out_tag << endl;
	XMLNode xMainNodeDes=XMLNode::openFileHelper(outFileXML,"Buffer");
	  
	XMLNode xNode=xMainNodeDes.getChildNode("Info");  
  //printf("Nombre aplicacion: '%s'\n", xNode.getChildNode("Application").getAttribute("name"));

  xNode=xMainNodeDes.getChildNode(out_tag); 
  int n=xNode.nChildNode("campo");
  int ini=xNode.nChildNode("ini");
  //int fin=xNode.nChildNode("fin");

  for (i=0; i<n; i++) 
  {
    cod    = xNode.getChildNode("campo",&iterator).getAttribute("cod");
    inicial = atoi(xNode.getChildNode("campo",&iterator2).getAttribute("ini")); 
    tamano_xml_destino = atoi(xNode.getChildNode("campo",&iterator3).getAttribute("tam"));
    rell= xNode.getChildNode("campo",&iterator4).getAttribute("rell");
    direccion = xNode.getChildNode("campo",&iterator9).getAttribute("dir");
    if (!isKeyDefined(cod))
    {
    		if (outFileDat.is_open())
    		{
    				if (cod=="idSYSDATEDD")
    				{
    					outFileDat << "24"; 
    				} else 
    				if (cod=="idSYSDATEMM")
    				{
    					outFileDat << "05"; 
    				}
    				else
    				if (cod=="idSYSDATEYYYY")
    				{
    					outFileDat << "2005"; 
    				}
    				else
    				{ 

    				if (!(isKeyDefinedInConv(cod)))
    						{
    							for (j=0; j<tamano_xml_destino; j++) 
    								outFileDat << rell ;
    						}
    						else
    						{
    							//KeyDefinedInConv(cod);
    							outFileDat << KeyDefinedInConv(cod);
    						}
    				}
    		} else
    			{//error
    			}
    } else
   		{
    		for(contenedor.itr = contenedor.begin(); contenedor.itr != contenedor.end(); contenedor.itr++)
    		{
      						if (cod == contenedor.itr->cod)
						{
							//entrega el tamaño y relleno
							size = contenedor.itr->tam;
					 	  	inicio = contenedor.itr->ini;
					 	 	relleno = contenedor.itr->rell;
					 	  	dat = contenedor.itr->data;
					 	  	resta=size - tamano_xml_destino;
					 	  	
					 	  	if (isKeyDefinedConv(cod,dat.substr(0,size)))
						  	{
						  		//cout << "DATA ENCONTRADO EN CONTENEDOR CONV  cod: " << cod << "valor : " << contenedorConv.itrconv->valor << endl;
						  		//cin >> test;
						  		if (cod == contenedorConv.itrconv->cod && dat==contenedorConv.itrconv->valor)
      								{
      									
      									//cout << "ENCONTRE UNA CONVERSION!!!!" << contenedorConv.itrconv->conversion << " por " << dat << endl;
      									outFileDat << contenedorConv.itrconv->conversion;
      									//cout << "CONVERSION DATA cod: " << cod << "data :" << contenedorConv.itrconv->conversion << endl;
      									grabar=0;
      										
      								} else 
      								if (cod == contenedorConv.itrconv->cod && contenedorConv.itrconv->valor=="*")
      								{
      									
      									//cout << "######### ENCONTRE UNA CONVERSION CON *!!!!" << contenedorConv.itrconv->conversion << " por " << dat << endl;
      									outFileDat << contenedorConv.itrconv->conversion;
      									//cout << "CONVERSION DATA cod: " << cod  << "data :" << contenedorConv.itrconv->conversion << endl;
      									grabar=0;
      								}	
						  			
						  	} 
						  	else
						  		
					 	  	if (size>tamano_xml_destino)
					 	  	{
						  		if (direccion=="DER") {
						  			outFileDat <<  dat.substr(0,tamano_xml_destino);
						  			//for (j=0; j<resta; j++)
    								 	//	outFileDat << rell ;
    								 } else
    								 {
    								 	//for (j=0; j<resta; j++)
    								 	//outFileDat << rell;
    								 	outFileDat <<  dat.substr(resta,size);
    								 	//cout << "!!!!CORTANDO por la " << direccion << " cod :" << cod<< "data :" << dat.substr(resta,size) << " tamano_xml: " << tamano_xml_destino << " size:" << size << " data original : " << dat.substr(0,size) << endl;	
						  			
    								 }
						  	}
						  	else
						  	{
	  		
						  		
						  			resta=tamano_xml_destino-size;
						  			if (direccion=="DER")
						  			{
						  				outFileDat <<  dat.substr(0,size);
						  				for (j=size; j<tamano_xml_destino; j++)
    								 			outFileDat << rell ;
    								 		//cout << "278 - !!!!RELLENANDO por la " << direccion << " cod :" << cod<< " tamano_xml: " << tamano_xml_destino << " size:" << size << " data original : " << dat.substr(0,size) << endl;	
    								        } else
    								 	{
    								 		for (j=0; j<resta; j++)
    								 			outFileDat << rell;
    								 		outFileDat <<  dat.substr(0,size);
    								 		//cout << "284 - !!!!RELLENANDO por la " << direccion << " cod :" << cod<< " tamano_xml: " << tamano_xml_destino << " size:" << size << " data original : " << dat.substr(0,size) << endl;	
    								 		
						  			
    									}
						  		
						  	}
  						  	//cin >> test;
							break;
						}
				}
    	}
    }
    outFileDat << endl ;

    if (row==2)
    {
    	row++;
    		while (row<=fila)
  		{
    			iterator=0, iterator2=0, iterator3=0, iterator4=0, iterator9=0;
    			for (i=0; i<n; i++) 
    			{
    				cod                = xNode.getChildNode("campo",&iterator).getAttribute("cod");
    				inicial            = atoi(xNode.getChildNode("campo",&iterator2).getAttribute("ini")); 
   				tamano_xml_destino = atoi(xNode.getChildNode("campo",&iterator3).getAttribute("tam"));
    				rell               = xNode.getChildNode("campo",&iterator4).getAttribute("rell");
    				direccion          = xNode.getChildNode("campo",&iterator9).getAttribute("dir");
    				
    				// cout << endl << "if (!isKeyDefined(cod)) " << cod << endl;
    				
    				
    				if (!(isKeyDefined(cod)))
    				{
    				                
    						if (!(isKeyDefinedInConv(cod)))
    						{
    							for (j=0; j<tamano_xml_destino; j++) 
    								outFileDat << rell ;
    						}
    						else
    						{
    							KeyDefinedInConv(cod);
    							//cout << "!!!!! GRABANDO CONVERSION " << endl;
    							outFileDat << KeyDefinedInConv(cod);
    						}
   					
    				} else
   					{
   						//cout << "Buscando cod " << cod << " en contenedor" << endl;
      						//cin >> test;
      								
    						for(contenedorData.itr = contenedorData.begin(); contenedorData.itr != contenedorData.end(); contenedorData.itr++)
    						{
      							
      							if (cod == contenedorData.itr->cod && row==contenedorData.itr->row)
							{
								grabar=1;
								//entrega el tamaño y relleno
								
								dat = contenedorData.itr->data;
								size = contenedorData.itr->tamano_origen;
								
								for(contenedorConv.itrconv = contenedorConv.begin(); contenedorConv.itrconv != contenedorConv.end(); contenedorConv.itrconv++)
    								{
   									if (cod == contenedorConv.itrconv->cod)
   									{
   										//cout << " CONTENEDOR codigo: " << cod << " valor :" << dat << endl;
   										if (dat==contenedorConv.itrconv->valor)
      									        { 
      										
      											// cout << "ENCONTRE UNA CONVERSION!!!!" << contenedorConv.itrconv->conversion << " por " << dat << endl;
      											outFileDat << contenedorConv.itrconv->conversion;
      											//outFileDat << " = 2" << endl;
      											//cout << "CONVERSION DATA cod: " << cod << "data :" << contenedorConv.itrconv->conversion << endl;
      											grabar=0;
      										}
      										if (contenedorConv.itrconv->valor=="*")
      										{
      											//cout << "!!!! ENCONTRE UNA CONVERSION CON *!!!!" << contenedorConv.itrconv->conversion << " por " << dat << endl;
      											outFileDat << contenedorConv.itrconv->conversion;
      											//cout << "CONVERSION DATA cod: " << cod  << "data :" << contenedorConv.itrconv->conversion << endl;
      											grabar=0;
      										}
      									}
      								}
								if (grabar==0)
								{
								}
								else
								{
									
									if (size>tamano_xml_destino)
					 	  			{	
					 	  				resta=size-tamano_xml_destino;
					 	  				if (direccion=="DER")
					 	  				{
						  					outFileDat <<  dat.substr(0,tamano_xml_destino);
						  					//for (j=0; j<resta; j++)
    								 			//	outFileDat << rell ;
    								 			//outFileDat << " = 4 " << endl;
    								 		} else 
    								 		{
    								 			//for (j=0; j<resta; j++)
    								 			//	outFileDat << rell;
						  					outFileDat <<  dat.substr(resta,size);
						  					//cout << "!!!!CORTANDO por la " << direccion << " cod :" << cod<< "data :" << dat.substr(resta,size) << " tamano_xml: " << tamano_xml_destino << " size:" << size << " data original : " << dat.substr(0,size) << endl;	
    								 		}
    								 		
    								 		
    								 	} else
    								 	{
    								 	resta=tamano_xml_destino-size;
						  			if (direccion=="DER") {
						  				outFileDat <<  dat.substr(0,size);
						  				for (j=size; j<tamano_xml_destino; j++)
    								 			outFileDat << rell ;
    								 		//cout << "405 - !!!!RELLENANDO por la " << direccion << " cod :" << cod<< " tamano_xml: " << tamano_xml_destino << " size:" << size << " data original : " << dat.substr(0,size) << endl;	
    								        } else
    								 	{
    								 		for (j=0; j<resta; j++)
    								 			outFileDat << rell;
    								 		outFileDat <<  dat.substr(0,size);
    								 		//cout << "411 - !!!!RELLENANDO por la " << direccion << " cod :" << cod<< " tamano_xml: " << tamano_xml_destino << " size:" << size << " data original : " << dat.substr(0,size) << endl;	
    								 		
						  			
    									}
    								 	}
    								 	
									//cout << "FLAG 0 !!! Saving DATA cod: " << cod << " cod :" << cod<< "data :" << dat.substr(0,tamano_xml_destino) << " tamano_xml: " << tamano_xml_destino << endl;
  									//cin >> test;
								}
								

								break;
							}
							
						}
    					}
  				}
  				outFileDat << endl ;
  				row++;
    		}
  }
  xMainNodeDes=XMLNode::emptyXMLNode;

	outFileDat.close();
}
// **************************************************************************************************************
// Método searchSave que permite buscar una llave en el contenedor, y grabarla en un archivo dat de salida.
// **************************************************************************************************************

void Conf::searchSave(string strkey)
{
			
	contenedor = getConfigSpec();
	
	string relleno, dat;
      	int size, inicio;
		  if (isKeyDefined(strkey))
		  {
  			for(contenedor.itr = contenedor.begin(); contenedor.itr != contenedor.end(); contenedor.itr++)
    			{
      				if (strkey == contenedor.itr->cod)
						{
							//entrega el tamaño y relleno
							//cout << " cod = " << strkey << " encontrado, obteniendo parametros" << endl;  
							size = contenedor.itr->tam;
					 	  	inicio = contenedor.itr->ini;
					 	  	relleno = contenedor.itr->rell;
					 	  	dat = contenedor.itr->data;
						  	cout << dat;
							break;
						}
				}
			} else
			 {
			 	  cout << "no hay data para codigo " << strkey << endl;
			 }
				
}

// **************************************************************************************************************
// Método 
// **************************************************************************************************************



istringstream& Conf::find(string strkey)
{

}

bool Conf::isKeyDefined(string strkey)
{
 
   for(info_file.itr = info_file.begin(); info_file.itr != info_file.end(); info_file.itr++)
   {
   	if (strkey== info_file.itr->cod)
   	    {
   		return(true);
   	    }
   }
   return(false);

}
// **************************************************************************************************************
// Método 
// **************************************************************************************************************
bool Conf::isKeyDefinedConv(string strkey, string valor)
{
   contenedorConv = getConfigSpecConv();
   for( contenedorConv.itrconv =  contenedorConv.begin();  contenedorConv.itrconv !=  contenedorConv.end();  contenedorConv.itrconv++)
   {
   	if (strkey==  contenedorConv.itrconv->cod)

   	    {
   	    	//cout << "################## valor: " << contenedorConv.itrconv->valor << endl;
   		if (valor==contenedorConv.itrconv->valor)
   			return(true);
   	    }
   }
   return(false);

}
// **************************************************************************************************************
// Método 
// **************************************************************************************************************
bool Conf::isKeyDefinedInConv(string strkey)
{
   contenedorConv = getConfigSpecConv();
   for( contenedorConv.itrconv =  contenedorConv.begin();  contenedorConv.itrconv !=  contenedorConv.end();  contenedorConv.itrconv++)
   {
   	if (strkey==  contenedorConv.itrconv->cod)

   	    {

   			return(true);
   	    }
   }
   return(false);

}
// **************************************************************************************************************
// Método 
// **************************************************************************************************************
string Conf::KeyDefinedInConv(string strkey)
{
   contenedorConv = getConfigSpecConv();
   for( contenedorConv.itrconv =  contenedorConv.begin();  contenedorConv.itrconv !=  contenedorConv.end();  contenedorConv.itrconv++)
   {
   	if (strkey==  contenedorConv.itrconv->cod)

   	    {
			return( contenedorConv.itrconv->conversion);
   	    }
   }
   //return(false);

}



// **************************************************************************************************************
// Método 
// **************************************************************************************************************


void Conf::setFile(std::string strFilename) // throw(FileIOException)
{

}
ConfigSpec& Conf::getConfigSpec()
{
		return info_file;
}
ConfigSpecData& Conf::getConfigSpecData()
{
		return info_fileData;
}

ConfigSpecConv& Conf::getConfigSpecConv()
{
		return info_fileConv;
}
