/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;



public interface ArticuloDTOService {
	
	/**
	 * Valida si el equipo asociado al número de teléfono consultado tiene soporte GPRS
	 */	
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO validarSoporteGprs(com.tmmas.gte.integraciongtecommon.dto.TerminalServicioDTO inParam0)
	throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Servicio que permite consultar el PUK de una Serie Simcard
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsultaPukResponseDTO consultarPuk(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
		throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
}