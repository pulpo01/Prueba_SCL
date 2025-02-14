/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;


public interface BancoDTOService {
	/**
	* Entrega datos de los bancos disponibles para la contratación de PAC
	*/
	public com.tmmas.gte.integraciongtecommon.dto.BancoResponseDTO listarBancosDisponibles(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

	
}