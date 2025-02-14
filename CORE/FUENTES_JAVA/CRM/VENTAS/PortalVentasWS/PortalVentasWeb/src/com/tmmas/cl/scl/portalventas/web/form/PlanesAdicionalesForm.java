package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

public class PlanesAdicionalesForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private String urlPlanesAdicionales;
	private String codTipoCliente;
	private String codTipoClientePrepago;
	private String nombreCliente;
	private String codCliente;
	
	private String codUsuario;
	private String codOperadora;
	private String versionSistema;
	private String tipoEjecucion;
	private String formatoNIT;
	private String codigoIdentificadorNIT;
	private String numeroVenta;
	private String numeroTransaccionVenta;
		
	public String getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}

	public String getNombreCliente() {
		return nombreCliente;
	}

	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}

	public String getCodTipoCliente() {
		return codTipoCliente;
	}

	public void setCodTipoCliente(String codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}

	public String getCodTipoClientePrepago() {
		return codTipoClientePrepago;
	}

	public void setCodTipoClientePrepago(String codTipoClientePrepago) {
		this.codTipoClientePrepago = codTipoClientePrepago;
	}

	public String getUrlPlanesAdicionales() {
		return urlPlanesAdicionales;
	}

	public void setUrlPlanesAdicionales(String urlPlanesAdicionales) {
		this.urlPlanesAdicionales = urlPlanesAdicionales;
	}

	public String getCodigoIdentificadorNIT() {
		return codigoIdentificadorNIT;
	}

	public void setCodigoIdentificadorNIT(String codigoIdentificadorNIT) {
		this.codigoIdentificadorNIT = codigoIdentificadorNIT;
	}

	public String getCodOperadora() {
		return codOperadora;
	}

	public void setCodOperadora(String codOperadora) {
		this.codOperadora = codOperadora;
	}

	public String getCodUsuario() {
		return codUsuario;
	}

	public void setCodUsuario(String codUsuario) {
		this.codUsuario = codUsuario;
	}

	public String getFormatoNIT() {
		return formatoNIT;
	}

	public void setFormatoNIT(String formatoNIT) {
		this.formatoNIT = formatoNIT;
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

	public String getTipoEjecucion() {
		return tipoEjecucion;
	}

	public void setTipoEjecucion(String tipoEjecucion) {
		this.tipoEjecucion = tipoEjecucion;
	}

	public String getVersionSistema() {
		return versionSistema;
	}

	public void setVersionSistema(String versionSistema) {
		this.versionSistema = versionSistema;
	}
}
