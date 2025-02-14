package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.productDomain.dataTransferObject.DocumentoFacturacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface DocumentoDAOIT {
	
	public DocumentoFacturacionDTO getPromedioDocumentosFacturados(DocumentoFacturacionDTO entrada) throws ProductException;
	
	
}
