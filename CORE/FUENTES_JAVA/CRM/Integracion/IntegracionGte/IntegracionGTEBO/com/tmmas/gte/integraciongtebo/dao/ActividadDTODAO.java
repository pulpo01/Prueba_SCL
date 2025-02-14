/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface ActividadDTODAO {
	/**
	* 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ActividadResponseDTO consultarActividad(com.tmmas.gte.integraciongtecommon.dto.ActividadDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

	/**
	* recuperacion de datos de ocupaciones
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ActividadResponseDTO consultarOcupacion(com.tmmas.gte.integraciongtecommon.dto.ActividadDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}