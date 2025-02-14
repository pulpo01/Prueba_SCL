/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

public interface AuditoriaDTOService {
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

}