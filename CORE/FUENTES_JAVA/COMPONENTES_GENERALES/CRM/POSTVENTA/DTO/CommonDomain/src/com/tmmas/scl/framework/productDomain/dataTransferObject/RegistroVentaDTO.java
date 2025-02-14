package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;

public class RegistroVentaDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private long numeroVenta;
	private long numeroTransaccionVenta;
	private String prefijoMin;
	private long numeroCelular;
	private String codigoSecuencia;
	private String numeroPaquete;
	private boolean existePlanFreedom;
	
	public String getCodigoSecuencia() {
		return codigoSecuencia;
	}
	public void setCodigoSecuencia(String codigoSecuencia) {
		this.codigoSecuencia = codigoSecuencia;
	}
	public boolean isExistePlanFreedom() {
		return existePlanFreedom;
	}
	public void setExistePlanFreedom(boolean existePlanFreedom) {
		this.existePlanFreedom = existePlanFreedom;
	}
	public long getNumeroCelular() {
		return numeroCelular;
	}
	public void setNumeroCelular(long numeroCelular) {
		this.numeroCelular = numeroCelular;
	}
	public String getNumeroPaquete() {
		return numeroPaquete;
	}
	public void setNumeroPaquete(String numeroPaquete) {
		this.numeroPaquete = numeroPaquete;
	}
	public long getNumeroTransaccionVenta() {
		return numeroTransaccionVenta;
	}
	public void setNumeroTransaccionVenta(long numeroTransaccionVenta) {
		this.numeroTransaccionVenta = numeroTransaccionVenta;
	}
	public long getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(long numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getPrefijoMin() {
		return prefijoMin;
	}
	public void setPrefijoMin(String prefijoMin) {
		this.prefijoMin = prefijoMin;
	}
	
	
	
}
