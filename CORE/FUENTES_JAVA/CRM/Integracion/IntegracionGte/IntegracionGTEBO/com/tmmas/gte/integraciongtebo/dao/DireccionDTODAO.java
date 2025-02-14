/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface DireccionDTODAO {
	/**
	* Entrega el tipo de dirección, el código de dirección y las descripción
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO consultarCodigoDireccion(com.tmmas.gte.integraciongtecommon.dto.ConsDirecDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega el tipo de dirección y el código de dirección
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO consultarCodigoDireccion(com.tmmas.gte.integraciongtecommon.dto.ConsDirecTipoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega un DireccionDTO con los datos
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DireccionDTO consultarDireccion(com.tmmas.gte.integraciongtecommon.dto.DireccionInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}