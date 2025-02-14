/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface EquipoDTODAO {
	/**
	* Permite obtener caracter�sticas y datos de un equipo.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.EquipoResponseDTO consultarTerminal(com.tmmas.gte.integraciongtecommon.dto.EquipoAbonadoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

	/**
	* Permite obtener el c�digo y descripci�n de la causa de un cambio de equipo (OOSS 10270).
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsRenovacionDTO consultarCauCamEq(com.tmmas.gte.integraciongtecommon.dto.OrdenServicioDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
}