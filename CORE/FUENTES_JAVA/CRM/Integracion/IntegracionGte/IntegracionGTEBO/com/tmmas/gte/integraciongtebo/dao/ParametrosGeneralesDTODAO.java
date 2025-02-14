/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface ParametrosGeneralesDTODAO {
	/**
	* Retorna el campo Valor Parámetro de la tabla GED_PARAMETROS
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ParametrosGeneralesResponseDTO consultarParametros(com.tmmas.gte.integraciongtecommon.dto.ParametrosGeneralesDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega numero Secuencia
	*/
	public com.tmmas.gte.integraciongtecommon.dto.SecuenciaDTO consultarSecuencia(com.tmmas.gte.integraciongtecommon.dto.SecuenciaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}