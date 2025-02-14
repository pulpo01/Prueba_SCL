package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DatosGeneralesBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.DatosGeneralesDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.DocumentoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.DatosGeneralesDAOIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;


public class DatosGenerales implements DatosGeneralesBOIT{

	private DatosGeneralesDAOIT datosGeneralesDAO  = new DatosGeneralesDAO();
	private final Logger logger = Logger.getLogger(DocumentoDAO.class);

	/**
	 * Obtiene Valor del parametro pasando como filtro el nombre del parametro mas el código de producto y código de módulo.
	 * @param datosGenerales
	 * @return datosGenerales
	 * @throws CustomerDomainException
	 */
	
	public DatosGeneralesDTO getValorParametro(DatosGeneralesDTO datosGenerales) 
	throws ProductException {
		DatosGeneralesDTO resultado = new DatosGeneralesDTO();
		logger.debug("Inicio:getValorParametro()");
		resultado = datosGeneralesDAO.getValorParametro(datosGenerales);
		logger.debug("Fin:getValorParametro");
		return resultado;
	}

	
	/**
	 * Obtiene resultado de la transaccion
	 * @param datosGenerales
	 * @return datosGenerales
	 * @throws ProductException
	 */
	public DatosGeneralesDTO getResultadoTransaccion(DatosGeneralesDTO datosGenerales) 
	throws ProductException {
		DatosGeneralesDTO resultado = new DatosGeneralesDTO();
		logger.debug("Inicio:getResultadoTransaccion()");
		resultado = datosGeneralesDAO.getResultadoTransaccion(datosGenerales);
		logger.debug("Fin:getResultadoTransaccion");
		return resultado;
	}//fin getResultadoTransaccion	

}//fin CLASS DatosGenerales