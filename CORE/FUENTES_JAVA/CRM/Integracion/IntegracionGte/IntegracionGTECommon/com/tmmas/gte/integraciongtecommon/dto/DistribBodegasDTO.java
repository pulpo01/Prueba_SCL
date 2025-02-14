package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class DistribBodegasDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
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