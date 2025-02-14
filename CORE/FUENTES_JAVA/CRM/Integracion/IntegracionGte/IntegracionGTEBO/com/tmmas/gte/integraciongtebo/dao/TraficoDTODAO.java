/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;


public interface TraficoDTODAO {
	/**
	* Ingresa como parametros un LlamadaInDTO y despues devuelve un cursor con datos, este se setean los datos en LlamadaDTO y se genera una lista
	*/
	public com.tmmas.gte.integraciongtecommon.dto.TraficoResponseDTO listarLlamadasNoFacturadas(com.tmmas.gte.integraciongtecommon.dto.LlamadaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* se ingresa el codigo de ciclo + las fechas (inicio y termino ), las fechas puede variar pueden ir hasta nulas o una de ella nula, de vuelve las fechas correspondiente al ciclo.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInternaDTO validarFechasTrafico(com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInternaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

	/**
	* parametros de entreda LlamadaInDTO pero sin impuestos y despues devuelve un cursor con datos, este se setean los datos en ConsumoDTO y se genera una lista
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsumoResponseDTO listarConsumoMensajesCortos(com.tmmas.gte.integraciongtecommon.dto.LlamadaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Entrega Minutos consumidos
	*/
	public com.tmmas.gte.integraciongtecommon.dto.MinutosConsumidosDTO consultarMinutosConsumidos(com.tmmas.gte.integraciongtecommon.dto.ConsumoClienteDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Servicio que entrega un listado de las llamadas facturadas para un número de teléfono y una factura específica
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LlamadasFacturadasResponseDTO consultarLlamadasFacturadas(com.tmmas.gte.integraciongtecommon.dto.LlamadaInFactDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	 * Servicio retorna el código operadora
	 */
	public com.tmmas.gte.integraciongtecommon.dto.ParamOperDTO getConsultaParametrosOperadora()
			throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
}