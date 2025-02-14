/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface AuditoriaDTODAO {
	/**
	* Inserta registros para auditoria
	*/
	public com.tmmas.gte.integraciongtecommon.dto.AuditoriaResponseDTO insertarAuditoria(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Inserta Parametros de Servicio para auditoria
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO insertarServicios(com.tmmas.gte.integraciongtecommon.dto.AuditoriaServicioDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Consulta Punto de acceso para auditoria
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PuntoAccesoResponseDTO consultarPuntoAcceso(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Valida si existe un Servicio para auditoria
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO validarServicio(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Valida si existe una Aplicación para auditoria
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO validarAplicacion(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Valida si existe un Usuario para auditoria
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO validarNombreUsuario(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}