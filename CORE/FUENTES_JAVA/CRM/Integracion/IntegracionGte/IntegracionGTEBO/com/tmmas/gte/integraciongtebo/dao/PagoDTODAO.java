/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface PagoDTODAO {
	/**
	* Ingresa como parametros un objeto de tipo PagoInDTO y despues devuelve un cursor con datos de los pagos, este se setean los datos en PagoResponseDTO
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PagoResponseDTO consultaPagosRealizados(com.tmmas.gte.integraciongtecommon.dto.PagoInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Ingresa como parametros un objeto de tipo PagoDTO y despues devuelve un objeto PagoRecaudadoraOutDTO, devuelve la recuadadora y la descripcion del la empresa
	*/
	public com.tmmas.gte.integraciongtecommon.dto.PagoRecaudadoraOutDTO consultarRecaudadora(com.tmmas.gte.integraciongtecommon.dto.PagoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	

}