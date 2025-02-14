/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface TarjetaDeCreditoDTODAO {
	/**
	* Valida que el número de tarjeta de crédito que se ha ingresado sea un número válido
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO validarNumTarjCredito(com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Actualiza el registro de la tabla de clientes asociado al código de cliente del número ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO actualizarDatosClieTarjeta(com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Actualiza la información de la tarjeta de crédito en el módulo de cobranza
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO insertarPagoAutomatico(com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega Listado de Tarjetas de Credito
	*/
	public com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoResponseDTO listarTarjetasDeCredito()
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}