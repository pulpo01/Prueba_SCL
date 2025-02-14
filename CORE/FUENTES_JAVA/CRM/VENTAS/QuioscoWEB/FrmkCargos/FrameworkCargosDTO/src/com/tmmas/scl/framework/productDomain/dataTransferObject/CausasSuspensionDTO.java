package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class CausasSuspensionDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String descripcionCausa;
	private String codigoCausa;
	
	public String getCodigoCausa() {
		return codigoCausa;
	}
	public void setCodigoCausa(String codigoCausa) {
		this.codigoCausa = codigoCausa;
	}
	public String getDescripcionCausa() {
		return descripcionCausa;
	}
	public void setDescripcionCausa(String descripcionCausa) {
		this.descripcionCausa = descripcionCausa;
	}

} // CausasSuspensionDTO
