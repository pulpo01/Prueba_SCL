/**
* Generated file - You can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/

package com.tmmas.gte.integraciongtebo.dao;

public interface FacturaDTODAO {
	/**
	* Entrega Datos de Conceptos de Factura
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstConceptoFacturaDTO consultarConceptosFactura(com.tmmas.gte.integraciongtecommon.dto.ConsultarConscFactDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Ingresa como parametros el codigo del cliente, numero de iteraciones (devuelve una lista con facturas pagas e inpagas)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturas(com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Ingresa como parametros el codigo del cliente, numero de iteraciones (devuelve una lista con facturas impagas)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturasImpagas(com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Consulta Link de Factura para un proceso ingresado
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaResponseDTO consultarLinkFactura(com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Ingresa como parametros el codigo del cliente, y devuele una lista de 12 FacturaDTO pero solo con datos en el atributo fecHastallam
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFechasReporteConsumo(com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Ingresa como parametros el codigo del cliente, numero de iteraciones (devuelve una lista con facturas pagadas)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturasPagadas(com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Retorna codCicloFacturacion a partir de un codCiclo pospago
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsAbonadoPospagoDTO consultarCicloFact(com.tmmas.gte.integraciongtecommon.dto.ConsCicloFactDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Ingresa como parametros el codigo del cliente, numero de iteraciones, la opcion, fecha de inicio y de termino en formato (yyyymmdd)y devuelve yna lista con facturas 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturasNoCicloCliente(com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* Obtiene la fecha de corte del ciclo de facturacion
	*/
	public com.tmmas.gte.integraciongtecommon.dto.MinutosConsumidosDTO obtenerFechaCorte(com.tmmas.gte.integraciongtecommon.dto.CodCicloFacturaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;		 		 
	/**
	* Llama a la funcion FA_ObtenerImpuesto_FN
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ImpuestoResponseDTO consultarImpuesto(com.tmmas.gte.integraciongtecommon.dto.FacturaDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
}