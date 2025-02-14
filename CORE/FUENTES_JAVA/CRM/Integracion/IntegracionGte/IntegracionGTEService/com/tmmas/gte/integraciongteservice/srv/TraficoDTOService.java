/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

public interface TraficoDTOService {
	/**
	* Ingresa como parametros un LlamadaInDTO y despues devuelve un cursor con datos, este se setean los datos en LlamadaDTO y se genera una lista
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LlamadasFacturadasOutDTO listarLlamadasNoFacturadas(com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

	/**
	* parametros de entreda LlamadaInDTO pero sin impuestos y despues devuelve un cursor con datos, este se setean los datos en ConsumoDTO y se genera una lista
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsumoResponseOutDTO listarConsumoMensajesCortos(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* retorna Los minutos Consumidos
	*/
	public com.tmmas.gte.integraciongtecommon.dto.MinutosConsumidosDTO consultarMinutosConsumidos(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
	throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Devuelve el total de minutos consumidos y el saldo de llamadas LDI para números pospago.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.MinutosLdiResponseDTO consultarMinutosLDI(com.tmmas.gte.integraciongtecommon.dto.MinutosLdiInDTO inParam0)
		throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	
	/**
	* Servicio que entrega un listado de las llamadas facturadas para un número de teléfono y una factura específica
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LlamadasFacturadasOutDTO consultarLlamadasFacturadas(com.tmmas.gte.integraciongtecommon.dto.LlamadaClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
}