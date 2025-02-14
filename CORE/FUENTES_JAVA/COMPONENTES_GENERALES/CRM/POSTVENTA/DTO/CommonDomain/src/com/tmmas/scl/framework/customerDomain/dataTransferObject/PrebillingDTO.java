package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class PrebillingDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private String nombreSecuenciaTransacabo;
	private String actuacionPrebilling;
	private String productoGeneral;
	private String codigoCliente;
	private String numeroVenta;
	private String numeroTransaccionVenta;
	private String nombreSecuenciaProcesoFacturacion;
	private String modoGeneracion;
	private String categoriaTributaria;
	private String modalidadVenta;
	private String secuenciaTransacabo;
	
	public String getActuacionPrebilling() {
		return actuacionPrebilling;
	}
	public void setActuacionPrebilling(String actuacionPrebilling) {
		this.actuacionPrebilling = actuacionPrebilling;
	}
	public String getCategoriaTributaria() {
		return categoriaTributaria;
	}
	public void setCategoriaTributaria(String categoriaTributaria) {
		this.categoriaTributaria = categoriaTributaria;
	}
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getModalidadVenta() {
		return modalidadVenta;
	}
	public void setModalidadVenta(String modalidadVenta) {
		this.modalidadVenta = modalidadVenta;
	}
	public String getModoGeneracion() {
		return modoGeneracion;
	}
	public void setModoGeneracion(String modoGeneracion) {
		this.modoGeneracion = modoGeneracion;
	}
	public String getNombreSecuenciaProcesoFacturacion() {
		return nombreSecuenciaProcesoFacturacion;
	}
	public void setNombreSecuenciaProcesoFacturacion(
			String nombreSecuenciaProcesoFacturacion) {
		this.nombreSecuenciaProcesoFacturacion = nombreSecuenciaProcesoFacturacion;
	}
	public String getNombreSecuenciaTransacabo() {
		return nombreSecuenciaTransacabo;
	}
	public void setNombreSecuenciaTransacabo(String nombreSecuenciaTransacabo) {
		this.nombreSecuenciaTransacabo = nombreSecuenciaTransacabo;
	}
	public String getNumeroTransaccionVenta() {
		return numeroTransaccionVenta;
	}
	public void setNumeroTransaccionVenta(String numeroTransaccionVenta) {
		this.numeroTransaccionVenta = numeroTransaccionVenta;
	}
	public String getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(String numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getProductoGeneral() {
		return productoGeneral;
	}
	public void setProductoGeneral(String productoGeneral) {
		this.productoGeneral = productoGeneral;
	}
	public String getSecuenciaTransacabo() {
		return secuenciaTransacabo;
	}
	public void setSecuenciaTransacabo(String secuenciaTransacabo) {
		this.secuenciaTransacabo = secuenciaTransacabo;
	}
	
	
}
