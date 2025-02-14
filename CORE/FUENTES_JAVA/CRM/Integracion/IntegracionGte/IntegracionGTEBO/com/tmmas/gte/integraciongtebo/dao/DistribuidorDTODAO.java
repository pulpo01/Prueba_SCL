/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface DistribuidorDTODAO {
	/**
	* Retorna los Datos del Distribuidor asociado al C�digo de Distribuidor ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO consDatosDistrib(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna un listado de Bodegas asociadas al C�digo de Distribuidor ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribBodegasResponseDTO consBodegasDistrib(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna los Datos del Pedido asociados al C�digo de Distribuidor y C�digo de Pedido ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO consPedidoDistrib(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* ingresa el codigo del distribuidor para sacar el codigo del cliente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO consultarDistribuidor(com.tmmas.gte.integraciongtecommon.dto.DistribuidorDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;


}

          