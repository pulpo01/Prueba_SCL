/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface ConsPrestacionesDTODAO {
	/**
	* Retorna todas las Prestaciones existentes para clientes Prepago � clientes Pospago e H�brido
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesResponseDTO consultarCodigosPrestacion(com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}