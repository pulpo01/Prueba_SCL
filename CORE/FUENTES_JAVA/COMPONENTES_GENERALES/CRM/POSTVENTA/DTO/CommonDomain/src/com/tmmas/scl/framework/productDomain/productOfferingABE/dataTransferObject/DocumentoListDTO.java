/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 12/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DocumentoDTO;

public class DocumentoListDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private DocumentoDTO[] documentos;

	public DocumentoDTO[] getDocumentos() {
		return documentos;
	}

	public void setDocumentos(DocumentoDTO[] documentos) {
		this.documentos = documentos;
	}
	
}
