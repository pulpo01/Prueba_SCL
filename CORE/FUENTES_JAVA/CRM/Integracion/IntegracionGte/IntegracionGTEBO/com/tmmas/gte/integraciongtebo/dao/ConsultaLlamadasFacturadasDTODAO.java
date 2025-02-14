/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface ConsultaLlamadasFacturadasDTODAO {
	/**
	* Servicio que entrega un listado de las llamadas facturadas para un número de teléfono y una factura específica
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsultaLlamadasFacturadasResponseDTO consultarLlamadasFacturadas(com.tmmas.gte.integraciongtecommon.dto.ConsultaLlamadasFacturadasInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}