/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

import com.tmmas.gte.integraciongtecommon.dto.AuditoriaDTO;

public interface TarjetaDeCreditoDTOService {

	/**
	* Servicio que permite el registro de los datos asociados a una tarjeta de crédito para el pago automático de cuentas
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespBooleanDTO registrarDatosTarjCredito(com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoInDTO inParam0)
			throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

	/**
	* Entrega Listado de Tarjetas de Credito
	*/
	public com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoResponseDTO listarTarjetasDeCredito(AuditoriaDTO parametro)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
}