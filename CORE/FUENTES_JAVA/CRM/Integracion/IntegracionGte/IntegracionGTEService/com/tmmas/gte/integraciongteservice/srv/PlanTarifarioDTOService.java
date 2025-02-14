/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;


public interface PlanTarifarioDTOService {
	/**
	* Retorna plan Tarifario correspondiente a numero de teléfono
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseOutDTO consultarPlanTarifario(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna todos los planes tarifarios vigentes filtrando por grpPrestacion y codPrestacion
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO consultarPlanesDisponibles(com.tmmas.gte.integraciongtecommon.dto.GrpCodPrestacionListDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna todos los planes tarifarios vigentes filtrando por grpPrestacion
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO consultarPlanesDisponibles(com.tmmas.gte.integraciongtecommon.dto.GrupoPrestacionListDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna todos los planes tarifarios vigentes 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO consultarPlanesDisponibles(AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}