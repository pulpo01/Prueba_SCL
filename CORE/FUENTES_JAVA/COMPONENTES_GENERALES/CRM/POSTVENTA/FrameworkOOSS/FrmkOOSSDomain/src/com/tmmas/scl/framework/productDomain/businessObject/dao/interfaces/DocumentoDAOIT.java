package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DatosComercialesDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DocumentoFacturacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface DocumentoDAOIT {
	
	public DocumentoDTO[] getListadoTipoDocumento(DatosComercialesDTO datos) throws ProductException;
	
	public DocumentoFacturacionDTO getPromedioDocumentosFacturados(DocumentoFacturacionDTO entrada) throws ProductException;
	
	
}
