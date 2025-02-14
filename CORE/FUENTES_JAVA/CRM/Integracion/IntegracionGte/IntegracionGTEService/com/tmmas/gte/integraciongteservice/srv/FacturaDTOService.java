/**
* Generated file - you can edit!
* @author Jimmy A. Lopez P.
* @version 1.0
* @xdoclet-generated
*/
package com.tmmas.gte.integraciongteservice.srv;

public interface FacturaDTOService {
	/**
	* Entrega conceptos facturables 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.LstConceptoFacturaDTO consultarConceptosFactura(com.tmmas.gte.integraciongtecommon.dto.CodClienteDTO inParam0)
	 	throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

     /**
	* Ingresa como parametros el codigo del cliente, numero de iteraciones (devuelve una lista con facturas pagas e inpagas)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturas(com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO inParam0)
	 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Consulta Link de Factura para un proceso ingresado 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaResponseDTO consultarLinkFactura(com.tmmas.gte.integraciongtecommon.dto.ConsLinkFacturaDTO inParam0)
		throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

    /**
	* Metodos Creado, se ingresa solo el numero telefonico, se trabaja para poder obtener los datos y retorna FacturaResponseDTO.  
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturasPorCliente(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
		throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	/**
	* con el número de Teléfono obtiene las Ultima factura Pagada
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO obtenerUltimaFacturaPagada(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
		throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Ingresa como parametros el codigo del cliente, y devuele una lista de 12 FacturaDTO pero solo con datos en el atributo fecHastallam
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaOutDTO consultarFechasReporteConsumo(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Ingresa como parametros el codigo del cliente, numero de iteraciones (devuelve una lista con facturas pagadas)
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturasPagadas(com.tmmas.gte.integraciongtecommon.dto.FacturaInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	/**
	* Servicio que permite consultar las facturas pendientes de pago de un cliente. 
	* Autor: Leonardo Muñoz R.
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaResponseDTO consultarFacturasImpagasPorCliente(com.tmmas.gte.integraciongtecommon.dto.NumeroPlanTarifDTO inParam0)
			throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	
	/**
	* Ingresa como parametros el codigo del cliente, numero de iteraciones, la opcion, fecha de inicio y de termino en formato (yyyymmdd)y devuelve yna lista con facturas 
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaNoCicloResponseDTO consultarFacturasNoCicloCliente(com.tmmas.gte.integraciongtecommon.dto.DistribuidorInDTO inParam0)
			 throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;
	
	
	/**
	* Consulta Factura Mes Anterior
	*/
	public com.tmmas.gte.integraciongtecommon.dto.FacturaMesAnteriorResponseDTO consultaFacturaMesAnterior(com.tmmas.gte.integraciongtecommon.dto.NumeroTelefonoDTO inParam0)
	throws com.tmmas.gte.integraciongtecommon.exception.IntegracionGTEException;

}