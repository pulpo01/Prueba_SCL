package com.tmmas.scl.framework.serviceDomain.dataTransferObject;

import java.io.Serializable;

public class BodegaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long codBodega;
	private String desBodega;
	public long getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(long codBodega) {
		this.codBodega = codBodega;
	}
	public String getDesBodega() {
		return desBodega;
	}
	public void setDesBodega(String desBodega) {
		this.desBodega = desBodega;
	}

}
