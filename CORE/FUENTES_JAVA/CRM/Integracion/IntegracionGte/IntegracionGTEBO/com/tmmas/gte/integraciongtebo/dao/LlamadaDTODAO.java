/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface LlamadaDTODAO {
	/**
	* Ingresa como parametros un LlamadaInDTO y despues devuelve un cursor con datos, este se setean los datos en LlamadaDTO y se genera una lista
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LlamadoResponseDTO lstLlamadasNoFacturadas(com.tmmas.gte.integraciongtecommon.dto.LlamadaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* se ingresa el codigo de ciclo + las fechas (inicio y termino ), las fechas puede variar pueden ir hasta nulas o una de ella nula, de vuelve las fechas correspondiente al ciclo.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInternaDTO validacionFechasCicloFacturacion(com.tmmas.gte.integraciongtecommon.dto.ConsLlamadaInternaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;


}