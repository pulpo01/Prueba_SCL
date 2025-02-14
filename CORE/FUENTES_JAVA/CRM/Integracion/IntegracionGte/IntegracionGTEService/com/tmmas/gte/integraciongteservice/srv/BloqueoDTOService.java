/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

public interface BloqueoDTOService {
	/**
	* se ingresa un numero de abonado, el metodo retorna el BloqueoDTO Los datos correspondiente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.BloqueoResponseDTO consultarBloqueoTelefono(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}