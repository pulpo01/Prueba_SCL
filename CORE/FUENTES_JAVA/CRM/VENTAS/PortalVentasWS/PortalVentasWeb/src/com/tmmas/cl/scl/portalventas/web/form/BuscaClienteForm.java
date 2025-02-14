package com.tmmas.cl.scl.portalventas.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;

public class BuscaClienteForm extends ActionForm {
	private static final long serialVersionUID = 1L;

	private String codTipoCliente;

	private DatosGeneralesDTO[] arrayTipoCliente;

	private String codTipoIdentificacion;

	private String codCriterioBusqueda;

	private IdentificadorCivilComDTO[] arrayIdentificadorCliente;

	private String txtFiltro;

	private String codTipoClienteSel;

	private String codClienteSel;

	private String moduloOrigen;

	private String codModuloSolicitudVenta;

	private String numeroDocumento;

	private String telefonoCliente;

	private String nombres;

	private String primerApellido;

	private String segundoApellido;

	private String nombreEmpresa;

	private String largoNumCelular;

	private String codTipoClienteEmpresa;

	public String getCodTipoClienteEmpresa() {
		return codTipoClienteEmpresa;
	}

	public void setCodTipoClienteEmpresa(String codTipoClienteEmpresa) {
		this.codTipoClienteEmpresa = codTipoClienteEmpresa;
	}

	public String getLargoNumCelular() {
		return largoNumCelular;
	}

	public void setLargoNumCelular(String largoNumCelular) {
		this.largoNumCelular = largoNumCelular;
	}

	public String getNombreEmpresa() {
		return nombreEmpresa;
	}

	public void setNombreEmpresa(String nombreEmpresa) {
		this.nombreEmpresa = nombreEmpresa;
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

	public String getNombres() {
		return nombres;
	}

	public void setNombres(String nombres) {
		this.nombres = nombres;
	}

	public String getTelefonoCliente() {
		return telefonoCliente;
	}

	public void setTelefonoCliente(String telefonoCliente) {
		this.telefonoCliente = telefonoCliente;
	}

	public String getModuloOrigen() {
		return moduloOrigen;
	}

	public void setModuloOrigen(String moduloOrigen) {
		this.moduloOrigen = moduloOrigen;
	}

	public IdentificadorCivilComDTO[] getArrayIdentificadorCliente() {
		return arrayIdentificadorCliente;
	}

	public void setArrayIdentificadorCliente(IdentificadorCivilComDTO[] arrayIdentificadorCliente) {
		this.arrayIdentificadorCliente = arrayIdentificadorCliente;
	}

	public DatosGeneralesDTO[] getArrayTipoCliente() {
		return arrayTipoCliente;
	}

	public void setArrayTipoCliente(DatosGeneralesDTO[] arrayTipoCliente) {
		this.arrayTipoCliente = arrayTipoCliente;
	}

	public String getCodCriterioBusqueda() {
		return codCriterioBusqueda;
	}

	public void setCodCriterioBusqueda(String codCriterioBusqueda) {
		this.codCriterioBusqueda = codCriterioBusqueda;
	}

	public String getCodTipoCliente() {
		return codTipoCliente;
	}

	public void setCodTipoCliente(String codTipoCliente) {
		this.codTipoCliente = codTipoCliente;
	}

	public String getTxtFiltro() {
		return txtFiltro;
	}

	public void setTxtFiltro(String txtFiltro) {
		this.txtFiltro = txtFiltro;
	}

	public String getCodTipoIdentificacion() {
		return codTipoIdentificacion;
	}

	public void setCodTipoIdentificacion(String codTipoIdentificacion) {
		this.codTipoIdentificacion = codTipoIdentificacion;
	}

	public String getCodClienteSel() {
		return codClienteSel;
	}

	public void setCodClienteSel(String codClienteSel) {
		this.codClienteSel = codClienteSel;
	}

	public String getCodTipoClienteSel() {
		return codTipoClienteSel;
	}

	public void setCodTipoClienteSel(String codTipoClienteSel) {
		this.codTipoClienteSel = codTipoClienteSel;
	}

	public String getCodModuloSolicitudVenta() {
		return codModuloSolicitudVenta;
	}

	public void setCodModuloSolicitudVenta(String codModuloSolicitudVenta) {
		this.codModuloSolicitudVenta = codModuloSolicitudVenta;
	}

	public String getNumeroDocumento() {
		return numeroDocumento;
	}

	public void setNumeroDocumento(String numeroDocumento) {
		this.numeroDocumento = numeroDocumento;
	}

	private boolean esClienteCarrier;

	public boolean isEsClienteCarrier() {
		return esClienteCarrier;
	}

	public void setEsClienteCarrier(boolean esClienteCarrier) {
		this.esClienteCarrier = esClienteCarrier;
	}

	private String mensajeError;

	public String getMensajeError() {
		return mensajeError;
	}

	public void setMensajeError(String mensajeError) {
		this.mensajeError = mensajeError;
	}

}
