/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.pagoonlinebo.dao;

public interface ClientePagoDTODAO {
	/**
	* Obtiene Saldo Vencido y Saldo por Vencer de un Cliente
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO obtenerSaldo(com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException;
	/**
	* Obtiene Saldo Limite Consumo por Plan Tarifario y Saldo por Plan Adicional
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO obtenerSaldoLimite(com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException;
	/**
	* Obtiene Cliente asociado a un Numero de Celular
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO obtenerCodCliente(com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException;
	/**
	* Obtiene Nombre completo de un cliente
	*/
	public com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO obtenerNombreCliente(com.tmmas.gte.pagoonlinecommon.dto.ClientePagoDTO inParam0)
			 throws com.tmmas.gte.pagoonlinecommon.exception.PagoOnLineException;

}