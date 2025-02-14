/*
 * HostId.cpp
 *
 *  Created on: 27-ago-2008
 *      Author: rao.
 */

///
/// \file HostId.cpp
///

#include "HostId.h"

///@ Brief Obtención Host_ID
HostId::HostId() {
	_nombre[0] = '\0';
	_clienteInicial = 0;
	_clienteFinal = 0;
	_hostIdValido = false;
}

HostId::~HostId() {
}

///@ Brief Validacion de la configuracion para ejecucion por Host_Id
void HostId::validaHostId( DataService* db,
			   const int codCiclFact)
{
	STRING extVar;
	STRING1000 nombreFile;

	FILE* pFile=NULL;
	char c;
	int i=0;

	extVar << getEnvVar(ENV_VAR_FOR_CFGPATH);
	nombreFile.clear();
	nombreFile << extVar.c_str();
	if (!nombreFile.empty())
		nombreFile << "/";
	nombreFile << "host_id.dat";

	cout << "Obteniendo Nombre Host_Id del archivo : [" << nombreFile << "]" << endl;

	if (!nombreFile.empty()){

	    if ((pFile = fopen(nombreFile.c_str(),"rt")) == (FILE *)NULL)
	    {
	    	cout << "NO existe configuracion de Host_ID" << endl;
	    	return;
	    }

	    c = fgetc(pFile);
		while((isalnum(c) || ispunct(c)) && (c != EOF) )
		{
			_nombre[i] = c;
			i++;
			c = fgetc(pFile);
		}
		_nombre[i] = '\0';

		cout << "HostId : [" << _nombre << "]" << endl;
		if (bGetRangoHostId (db,_nombre, codCiclFact)){
			_hostIdValido = true;
		}
	}


    fclose(pFile);
}

///@ Brief Consulta de rangos de clientes para el Host_Id
bool HostId::bGetRangoHostId (DataService* db,
							  const char* hostId,
							  const int codCiclFact)
{
	RECORD_FA_RANGOSHOST_TO_DTO my_hostID;

	try {
		my_hostID = db->selectFA_RANGOSHOST_TO(hostId,codCiclFact);
		if (my_hostID.RECORD_FOUND){
			_clienteInicial= my_hostID.COD_CLIENTEINI;
			_clienteFinal = my_hostID.COD_CLIENTEFIN;
			return true;
		} else {
			return false;
		}
	}
    catch(otl_exception& error)
    {
        cout << "ERROR CONSULTANDO RANGO PARA HOSTS:" << endl;
        cout << ": " << error.msg << endl << ": " << error.stm_text << endl << ": " << error.var_info << endl;

        return 0;
    }
    catch(ProcessCoreException& error)
    {
        cout << "NO SE HA PODIDO INICIAR PROCESO:" << endl;
        cout << ": " << error.what() << endl;
        cout << ": " << error.errCase() << endl;
        cout << ": " << error.errNum() << endl;

        return 0;
    }
}


