/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface ArticuloDTODAO {
	/**
	* Valida si el equipo asociado al número de teléfono consultado tiene soporte GPRS
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO validarSoporteGPRS(com.tmmas.gte.integraciongtecommon.dto.ArticuloDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Servicio que permite consultar el PUK de una Serie Simcard
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsultaPukResponseDTO consultarPuk(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

	/**
	* Retorna el número de kit asociado al número de serie de un abonado.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AbonadoProductoResponseDTO consultarKit(com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
}