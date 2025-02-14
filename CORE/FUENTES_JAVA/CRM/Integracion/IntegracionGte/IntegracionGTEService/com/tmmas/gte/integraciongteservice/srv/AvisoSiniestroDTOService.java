/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

public interface AvisoSiniestroDTOService {
	/**
	*  Entrega Datos del Aviso Siniestro
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsAvisoSiniestroResponseDTO consultarAvisoSiniestro(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	*  Entrega Fecha de Formalización y Datos del Aviso Siniestro
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsAvisoSiniestroResponseDTO consultarFechaAvisoSiniestro(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

	
	
}