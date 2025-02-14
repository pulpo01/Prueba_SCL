/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface PrestacionesDTODAO {
	/**
	* Entrega datos de los grupos de prestaci�n existentes
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PrestacionResponseDTO consultarGruposPrestacion()
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Servicio que permite consultar la descripci�n de la prestaci�n asociada a un n�mero de tel�fono
	*/
	public com.tmmas.gte.integraciongtecommon.dto.TipoServicioResponseDTO consultarDescPrestacion(com.tmmas.gte.integraciongtecommon.dto.CodPrestacionDTO inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Retorna todas las Prestaciones existentes para clientes Prepago � clientes Pospago e H�brido
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesResponseDTO consultarCodigosPrestacion(com.tmmas.gte.integraciongtecommon.dto.ConsPrestacionesInDTO inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
}