package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.DocumentoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DocumentoFacturacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public class Documento implements DocumentoBOIT {
	
	private DocumentoDAO documentoDAO  = new DocumentoDAO();
	private final Logger logger = Logger.getLogger(Documento.class);
	private Global global = Global.getInstance();
	
	/**
	 * Calcula Promedio de Documentos Facturados a un cliente especifico
	 * @param datos 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public DocumentoFacturacionDTO getPromedioDocumentosFacturados(DocumentoFacturacionDTO datos) throws ProductException {
		
		logger.debug("getPromedioDocumentosFacturados():start");
		DocumentoFacturacionDTO resultado = documentoDAO.getPromedioDocumentosFacturados(datos);
		logger.debug("getPromedioDocumentosFacturados():end");
		return resultado;
	}
	
}
