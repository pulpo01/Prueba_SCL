/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

public interface ServicioSuplementarioDTOService {
	/**
	* Entrega Datos de los servicios suplementario
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ServicioSupleRespondeDTO consultaServicioSuplem(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Activa o desactiva Servicios Suplementarios
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO activarDesactivarSS(com.tmmas.gte.integraciongtecommon.dto.ActDesServSupleDto inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Entrega numero Secuencia
	*/
	public com.tmmas.gte.integraciongtecommon.dto.SecuenciaDTO consultarSecuencia(com.tmmas.gte.integraciongtecommon.dto.SecuenciaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Activa o desactiva Servicios Suplementarios
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ComponentesResponseDTO consultarEstadoComponentes(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
		 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* se ingresa el numero de abonado y retorna un SeguroDTO con todos los datos del seguro.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.SeguroResponseDTO consultarSeguroTelefono(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	
	
}