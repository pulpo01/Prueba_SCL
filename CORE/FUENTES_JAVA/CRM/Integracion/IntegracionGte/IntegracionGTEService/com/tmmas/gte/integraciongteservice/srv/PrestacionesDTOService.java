/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

import com.tmmas.gte.integraciongtecommon.dto.IdTipoPrestacionInDTO;

public interface PrestacionesDTOService {
	
	/**
	* Retorna todas las Prestaciones existentes para clientes Prepago ó clientes Pospago e Híbrido
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesResponseDTO consultarCodigosPrestacion(IdTipoPrestacionInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Entrega datos de los grupos de prestación existentes
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PrestacionResponseDTO consultarGruposPrestacion(com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Servicio que permite consultar la descripción de la prestación asociada a un número de teléfono
	*/
	public com.tmmas.gte.integraciongtecommon.dto.TipoServicioResponseDTO consultarTipoServicio(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}