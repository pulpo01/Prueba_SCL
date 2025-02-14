/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface ServicioSuplementarioDTODAO {
	/**
	* Entrega Datos de los servicios suplementario
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ServicioSupleRespondeDTO consultarServicioSuplem(com.tmmas.gte.integraciongtecommon.dto.ConServSupleDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Activa o desactiva Servicios Suplementarios
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO activarDesactivarSS(com.tmmas.gte.integraciongtecommon.dto.ActDesSSDto inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega lista de Servicio Suplementario Activos de un Abonado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstComponentesDTO consultarSSActivos(com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega lista de Servicio Suplementario Inactivos de un Abonado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstComponentesDTO consultarSSInactivos(com.tmmas.gte.integraciongtecommon.dto.AbonadoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* se ingresa el numero de abonado y retorna un SeguroDTO con todos los datos del seguro.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.SeguroDTO consultarSeguroTelefonico(com.tmmas.gte.integraciongtecommon.dto.SeguroInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

	
	
	
}