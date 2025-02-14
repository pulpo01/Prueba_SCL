/*
 * HostId.h
 *
 *  Created on: 27-ago-2008
 *      Author: mwt00237
 */


///
/// \file HostId.h
///


#ifndef HOSTID_H_
#define HOSTID_H_

#include "genFact.h"
#include "data_service.h"


///@ Brief ...
class HostId {
private:
	bool HostId::bGetRangoHostId (DataService* db,
								  const char* hostId,
								  const int codCiclFact);
public:
	char   _nombre[20+1];   ///< Nombre del hosts_Id.
    int	   _clienteInicial; ///< cliente inicial del rango de clientes para el host.
    int	   _clienteFinal;   ///< cliente final del rango de clientes para el host.
    bool   _hostIdValido;

	HostId();
	virtual ~HostId();
	void validaHostId( DataService* db,
					   const int codCiclFact);
};

#endif /* HOSTID_H_ */
