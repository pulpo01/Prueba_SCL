/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

public interface DistribuidorDTOService {
	/**
	* Retorna los Datos del Distribuidor asociado al C�digo de Distribuidor ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO consultarDatosDistribuidor(com.tmmas.gte.integraciongtecommon.dto.ConsDistribuidorInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

	/**
	* Retorna los Datos del Distribuidor y datos del Pedido asociados al C�digo de Distribuidor y C�digo de Pedido ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.DistribuidorResponseDTO consultarDatosDistribuidor(com.tmmas.gte.integraciongtecommon.dto.DistribPedidoInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}