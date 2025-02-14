/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface TarjetaDeCreditoDTODAO {
	/**
	* Valida que el n�mero de tarjeta de cr�dito que se ha ingresado sea un n�mero v�lido
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO validarNumTarjCredito(com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Actualiza el registro de la tabla de clientes asociado al c�digo de cliente del n�mero ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO actualizarDatosClieTarjeta(com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Actualiza la informaci�n de la tarjeta de cr�dito en el m�dulo de cobranza
	*/
	public com.tmmas.gte.integraciongtecommon.dto.RespuestaDTO insertarPagoAutomatico(com.tmmas.gte.integraciongtecommon.dto.TarjetaDeCreditoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega Listado de Tarjetas de Credito
	*/
	public com.tmmas.gte.integraciongtecommon.dto.TarjetaCreditoResponseDTO listarTarjetasDeCredito()
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}