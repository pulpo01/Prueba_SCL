/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

public interface DireccionDTOService {
	/**
	* Entrega el tipo de direcci�n, el c�digo de direcci�n y las descripci�n
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO consultarCodigoDireccion(com.tmmas.gte.integraciongtecommon.dto.ConsDirecDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega el tipo de direcci�n y el c�digo de direcci�n
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DireccionResponseDTO consultarCodigoDireccion(com.tmmas.gte.integraciongtecommon.dto.ConsDirecTipoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega un DireccionDTO con los datos
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DireccionDTO consultarDireccion(com.tmmas.gte.integraciongtecommon.dto.DireccionInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	 * Retorna Detalle Direccion para un Numero de Telefono Ingresado
	 */
	public com.tmmas.gte.integraciongtecommon.dto.DireccionRespOutDTO consultarDireccionTelefono(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
}