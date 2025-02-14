/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

import com.tmmas.gte.integraciongtecommon.dto.IdTipoPrestacionDTO;

public interface ConsPrestacionesDTOService {
	/**
	* Retorna todas las Prestaciones existentes para clientes Prepago ó clientes Pospago e Híbrido
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesResponseDTO consultarCodigosPrestacion(IdTipoPrestacionDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}