/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface PlanTarifarioDTODAO {
	/**
	* 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO consultarPlanTarifario(com.tmmas.gte.integraciongtecommon.dto.ConPlanDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna todos los planes tarifarios vigentes
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO consultarPlanesDisponibles()
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna todos los planes tarifarios vigentes filtrando por grpPrestacion
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO consultarPlanesDisponibles(com.tmmas.gte.integraciongtecommon.dto.GrupoPrestacionDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna todos los planes tarifarios vigentes filtrando por grpPrestacion y codPrestacion
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioResponseDTO consultarPlanesDisponibles(com.tmmas.gte.integraciongtecommon.dto.GrpCodPrestacionDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna las bolsa asociada a un plan tarifario
	*/
	public com.tmmas.gte.integraciongtecommon.dto.BolsaResponseDTO consultarBolsaPlanTarifario(com.tmmas.gte.integraciongtecommon.dto.PlanTarifarioDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}