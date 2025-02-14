package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class ValidaPermanenciaDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private long numAbonado;
	private int tiempoMin;
	private String codCausaBaja;
	private String desCausaBaja;
	private String codCausaBajaParam;
	
	public String getCodCausaBajaParam() {
		return codCausaBajaParam;
	}
	public void setCodCausaBajaParam(String codCausaBajaParam) {
		this.codCausaBajaParam = codCausaBajaParam;
	}
	public String getCodCausaBaja() {
		return codCausaBaja;
	}
	public void setCodCausaBaja(String codCausaBaja) {
		this.codCausaBaja = codCausaBaja;
	}
	public String getDesCausaBaja() {
		return desCausaBaja;
	}
	public void setDesCausaBaja(String desCausaBaja) {
		this.desCausaBaja = desCausaBaja;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public int getTiempoMin() {
		return tiempoMin;
	}
	public void setTiempoMin(int tiempoMin) {
		this.tiempoMin = tiempoMin;
	}
}
