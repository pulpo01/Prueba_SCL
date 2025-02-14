package com.tmmas.scl.quiosco.web.form;

import org.apache.struts.action.ActionForm;

public class RegistroClienteForm extends ActionForm{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	//Datos Cliente
	private String numCelular;
	private String tipoIdentificacion;
	private String numeroIdentificacion;
	private String nombreCliente;
	private String primerApellido;
	private String segundoApellido;
	private String categoria;
	private String codCliente;
	private String codCuenta;
	//P-CSR-11002 - (AL) - 2011.07.28
	private String categoriaCambio;
	private String aplicaCategoriaCambio;
	private String codCrediticia;
	
	//Direccion
	private String provincia;
	private String region;
	private String ciudad;
	private String comuna;
	private String nombreCalle;
	private String numeroCalle;
	private String numPiso;
	private String numCasilla;
	private String obsDireccion;
	private String desDirec1;
	private String desDirec2;
	private String codPueblo;
	private String codEstado;
	private String zip;
	private String codTipoCalle;
	
	private String accionRegCliente;
	
	public String getAccionRegCliente() {
		return accionRegCliente;
	}
	public void setAccionRegCliente(String accionRegCliente) {
		this.accionRegCliente = accionRegCliente;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	public String getTipoIdentificacion() {
		return tipoIdentificacion;
	}
	public void setTipoIdentificacion(String tipoIdentificacion) {
		this.tipoIdentificacion = tipoIdentificacion;
	}
	public String getNumeroIdentificacion() {
		return numeroIdentificacion;
	}
	public void setNumeroIdentificacion(String numeroIdentificacion) {
		this.numeroIdentificacion = numeroIdentificacion;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public String getPrimerApellido() {
		return primerApellido;
	}
	public void setPrimerApellido(String primerApellido) {
		this.primerApellido = primerApellido;
	}
	public String getSegundoApellido() {
		return segundoApellido;
	}
	public void setSegundoApellido(String segundoApellido) {
		this.segundoApellido = segundoApellido;
	}
	public String getCategoria() {
		return categoria;
	}
	public void setCategoria(String categoria) {
		this.categoria = categoria;
	}
	public String getRegion() {
		return region;
	}
	public void setRegion(String region) {
		this.region = region;
	}
	public String getProvincia() {
		return provincia;
	}
	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}
	public String getComuna() {
		return comuna;
	}
	public void setComuna(String comuna) {
		this.comuna = comuna;
	}
	public String getCiudad() {
		return ciudad;
	}
	public void setCiudad(String ciudad) {
		this.ciudad = ciudad;
	}
	public String getNombreCalle() {
		return nombreCalle;
	}
	public void setNombreCalle(String nombreCalle) {
		this.nombreCalle = nombreCalle;
	}
	public String getNumeroCalle() {
		return numeroCalle;
	}
	public void setNumeroCalle(String numeroCalle) {
		this.numeroCalle = numeroCalle;
	}
	public String getZip() {
		return zip;
	}
	public void setZip(String zip) {
		this.zip = zip;
	}
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(String codCuenta) {
		this.codCuenta = codCuenta;
	}
	public String getNumPiso() {
		return numPiso;
	}
	public void setNumPiso(String numPiso) {
		this.numPiso = numPiso;
	}
	public String getNumCasilla() {
		return numCasilla;
	}
	public void setNumCasilla(String numCasilla) {
		this.numCasilla = numCasilla;
	}
	public String getObsDireccion() {
		return obsDireccion;
	}
	public void setObsDireccion(String obsDireccion) {
		this.obsDireccion = obsDireccion;
	}
	public String getDesDirec1() {
		return desDirec1;
	}
	public void setDesDirec1(String desDirec1) {
		this.desDirec1 = desDirec1;
	}
	public String getDesDirec2() {
		return desDirec2;
	}
	public void setDesDirec2(String desDirec2) {
		this.desDirec2 = desDirec2;
	}
	public String getCodPueblo() {
		return codPueblo;
	}
	public void setCodPueblo(String codPueblo) {
		this.codPueblo = codPueblo;
	}
	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public String getCodTipoCalle() {
		return codTipoCalle;
	}
	public void setCodTipoCalle(String codTipoCalle) {
		this.codTipoCalle = codTipoCalle;
	}
	public String getCategoriaCambio() {
		return categoriaCambio;
	}
	public void setCategoriaCambio(String categoriaCambio) {
		this.categoriaCambio = categoriaCambio;
	}
	public String getAplicaCategoriaCambio() {
		return aplicaCategoriaCambio;
	}
	public void setAplicaCategoriaCambio(String aplicaCategoriaCambio) {
		this.aplicaCategoriaCambio = aplicaCategoriaCambio;
	}
	public String getCodCrediticia() {
		return codCrediticia;
	}
	public void setCodCrediticia(String codCrediticia) {
		this.codCrediticia = codCrediticia;
	}
	
}
