/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

public interface LlamadaDTOService {
	/**
	* Ingresa como parametros un LlamadaInDTO y despues devuelve un cursor con datos, este se setean los datos en LlamadaDTO y se genera una lista
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LlamadoResponseDTO lstLlamadasNoFacturadas(com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}