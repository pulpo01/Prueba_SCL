/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

public interface MovimientoCtaCteDTOService {
	/**
	* Ingresa como parametros un objeto de tipo PagoInDTO y despues devuelve un cursor con datos de los pagos, este se setean los datos en PagoResponseDTO
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PagoOutDTO consultarPagosRealizados(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Retorna saldo total de un Cliente a partir del codigo_cliente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.CarteraResponseDTO consultarSaldo(com.tmmas.gte.integraciongtecommon.dto.NumeroPlanTarifDTO inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	 
	/**
	* Retorna deuda vencida y deuda por vencer de un Cliente a partir del codigo_cliente
	*/
	public com.tmmas.gte.integraciongtecommon.dto.SaldoMorosidadDTO consultarSaldo(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}