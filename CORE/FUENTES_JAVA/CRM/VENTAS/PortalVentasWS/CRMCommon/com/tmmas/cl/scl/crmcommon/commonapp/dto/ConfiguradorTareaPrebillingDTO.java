/**
 * Copyright © 2007 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 01/05/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.crmcommon.commonapp.dto;

public class ConfiguradorTareaPrebillingDTO extends ConfiguradorTareasDTO {
	/**
	 * 
	 */
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
	private boolean facturacionaCiclo;
		
	public boolean isFacturacionaCiclo() {
		return facturacionaCiclo;
	}
	public void setFacturacionaCiclo(boolean facturacionaCiclo) {
		this.facturacionaCiclo = facturacionaCiclo;
	}
	public String getModalidadVenta() {
		return modalidadVenta;
	}
	public void setModalidadVenta(String modalidadVenta) {
		this.modalidadVenta = modalidadVenta;
	}
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

}
