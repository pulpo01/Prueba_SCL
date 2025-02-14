/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

public interface EquipoDTOService {
	
	/**
	* Servicio que permite consultar la descripción de un terminal asociado a un número de teléfono.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsultarTerminalResponseDTO consultarTerminal(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0) 
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}