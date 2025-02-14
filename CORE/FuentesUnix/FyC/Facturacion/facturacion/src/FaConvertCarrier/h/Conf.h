//
// Hugo A. Sanchez D.
//
#ifndef Conf_H
#define Conf_H

#include "ConfigSpecLine.h"
#include "ConfigSpec.h"
#include "ConfigSpecLineData.h"
#include "ConfigSpecData.h"
#include "ConfigSpecLineConv.h"
#include "ConfigSpecConv.h"
#include <sstream>
#include <iostream>
#include <string.h>
#include "xmlParser.h"
//#include "FileIOException.h"
//#include "SyntaxErrorException.h"

using namespace std;

class Conf {
	istringstream *a;
    
public:

//Contructor
    	Conf();
//Destructor
    	virtual ~Conf();
    
	istringstream& find(string strkey);
	bool isKeyDefined(string strkey);
	bool isKeyDefinedConv(string strkey, string valor);
	bool isKeyDefinedInConv(string strkey);
	string KeyDefinedInConv(string strkey);
	ConfigSpec ReadFile(string strFilename); // throw( SC5FileIOException, SC5SyntaxErrorException );
	int readXML(char *inFileXML, char *in_tag, char *inFileDat, char *outFileErr, int row); // throw( SC5FileIOException, SC5SyntaxErrorException );
	void readwriteDAT(char *outFileXML, char *out_tag, char *outFileDAT, int row, int fila);
	void setFile(std::string strFilename);
	ConfigSpec& getConfigSpec();
	ConfigSpecData& getConfigSpecData();
	ConfigSpecConv& getConfigSpecConv();
	void searchSave(string strkey);
private:

	ConfigSpec info_file;
	ConfigSpec contenedor;
	ConfigSpecData info_fileData;
	ConfigSpecData contenedorData;
	ConfigSpecConv info_fileConv;
	ConfigSpecConv contenedorConv;
	
};

#endif //Conf_H


