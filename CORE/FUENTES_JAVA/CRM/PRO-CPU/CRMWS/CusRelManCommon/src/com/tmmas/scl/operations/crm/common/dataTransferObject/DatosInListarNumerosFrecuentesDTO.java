package com.tmmas.scl.operations.crm.common.dataTransferObject;

import java.io.Serializable;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AuditoriaDTO;

public class DatosInListarNumerosFrecuentesDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String numCelular;
	private String codProducto;
	private AuditoriaDTO auditoriaDTO; 
	
	
	public String getCodProducto() {
		return codProducto;
	}
	public void setCodProducto(String codProducto) {
		this.codProducto = codProducto;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	public AuditoriaDTO getAuditoriaDTO() {
		return auditoriaDTO;
	}
	public void setAuditoriaDTO(AuditoriaDTO auditoriaDTO) {
		this.auditoriaDTO = auditoriaDTO;
	}

}
