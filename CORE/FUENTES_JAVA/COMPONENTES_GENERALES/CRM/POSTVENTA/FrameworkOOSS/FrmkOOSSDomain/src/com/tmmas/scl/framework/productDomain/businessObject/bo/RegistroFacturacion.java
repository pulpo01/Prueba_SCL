/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 19/07/2007	     	Raúl Lozano        				Versión Inicial
 */

package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ProcesoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroCargosBatchDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.RegistroFacturacionDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.RegistroFacturacionDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class RegistroFacturacion implements RegistroFacturacionIT{
	
	private final Logger logger = Logger.getLogger(RegistroFacturacion.class);
	private Global global = Global.getInstance();
	
	private RegistroFacturacionDAOIT registroFacturacionDAO = new RegistroFacturacionDAO();
	
	
	/**
	 * Obtiene el codigo de Promedio facturado, según el monto promedio facturado por el cliente
	 * @param datos
	 * @return resultado
	 * @throws ProductException
	 */
	public RegistroFacturacionDTO getCodigoPromedioFacturado(RegistroFacturacionDTO datos) throws ProductException {
		
		logger.debug("getListadoTipoDocumento():start");
		RegistroFacturacionDTO resultado = registroFacturacionDAO.getCodigoPromedioFacturado(datos);
		logger.debug("getListadoTipoDocumento():end");
		return resultado;
	}
	
	/**
	 * @param ejecuta tareas de prebilling
	 * @return resultado
	 * @throws ProductException
	 */
	public void ejecutaPrebilling(RegistroFacturacionDTO entrada) throws ProductException {
		logger.debug("ejecutaPrebilling():start");
		registroFacturacionDAO.ejecutaPrebilling(entrada);
		logger.debug("ejecutaPrebilling():end");
	}
	
	/**
	 * @param
	 * @return resultado
	 * @throws ProductException
	 */
	public RegistroFacturacionDTO getCodigoCicloFacturacion(ClienteDTO cliente) throws ProductException {
		logger.debug("getCodigoCicloFacturacion():start");
		RegistroFacturacionDTO resultado = registroFacturacionDAO.getCodigoCicloFacturacion(cliente);
		logger.debug("getCodigoCicloFacturacion():end");
		return resultado;
	}

	public ImpuestosDTO getDatosPresupuesto(ImpuestosDTO parametroEntrada) throws ProductException {
		logger.debug("getDatosPresupuesto():start");
		ImpuestosDTO resultado = registroFacturacionDAO.getDatosPresupuesto(parametroEntrada);
		logger.debug("getDatosPresupuesto():end");
		return resultado;
	}

	public RegistroFacturacionDTO getModoGeneracion(RegistroFacturacionDTO registroFacturacion) throws ProductException {
		logger.debug("getModoGeneracion():start");
		RegistroFacturacionDTO resultado = registroFacturacionDAO.getModoGeneracion(registroFacturacion);
		logger.debug("getModoGeneracion():end");
		return resultado;
	}

	public RegistroFacturacionDTO getSecuenciaProcesoFacturacion(RegistroFacturacionDTO parametroEntrada) throws ProductException {
		logger.debug("getModoGeneracion():start");
		RegistroFacturacionDTO resultado = registroFacturacionDAO.getSecuenciaProcesoFacturacion(parametroEntrada);
		logger.debug("getModoGeneracion():end");
		return resultado;
	}
	
	/**
	 * Actualiza la facturación
	 * @param parametroEntrada
	 * @return resultado
	 * @throws ProductException
	 */
	public ProcesoDTO actualizaFacturacion(RegistroFacturacionDTO parametroEntrada)throws ProductException{
		ProcesoDTO resultado;
		logger.debug("Inicio:actualizaFacturacion()");
		resultado =registroFacturacionDAO.actualizaFacturacion(parametroEntrada); 
		logger.debug("Fin:actualizaFacturacion()");
		return resultado;
	}
	
	/**
	 * Inserta en PV_TRASPASO_CARGOS los cargos Batch
	 * @param registro
	 * @return retorno
	 * @throws ProductException
	 */
	public RetornoDTO registraCargosBatch(RegistroCargosBatchDTO registro) throws ProductException{
		RetornoDTO retorno;
		logger.debug("Inicio:registraCargosBatch()");
		retorno = registroFacturacionDAO.registraCargosBatch(registro);
		logger.debug("Fin:registraCargosBatch()");
		return retorno;
	}
	
	
	 /**
	 * Obtiene directorio donde se encuentra la factura
	 * @param factura
	 * @return ArchivoFacturaDTO
	 * @throws ProductException
	 */
	public ArchivoFacturaDTO obtenerRutaFactura(ArchivoFacturaDTO factura) throws ProductException{
		ArchivoFacturaDTO resultado;
		logger.debug("Inicio:obtenerRutaFactura()");
		resultado =registroFacturacionDAO.obtenerRutaFactura(factura); 
		logger.debug("Fin:obtenerRutaFactura()");
		return resultado;		
	}
}
