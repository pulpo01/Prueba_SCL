/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface PrestacionesDTODAO {
	/**
	* Entrega datos de los grupos de prestación existentes
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PrestacionResponseDTO consultarGruposPrestacion()
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Servicio que permite consultar la descripción de la prestación asociada a un número de teléfono
	*/
	public com.tmmas.gte.integraciongtecommon.dto.TipoServicioResponseDTO consultarDescPrestacion(com.tmmas.gte.integraciongtecommon.dto.CodPrestacionDTO inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Retorna todas las Prestaciones existentes para clientes Prepago ó clientes Pospago e Híbrido
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesResponseDTO consultarCodigosPrestacion(com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesInDTO inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
}