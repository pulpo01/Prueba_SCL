package com.tmmas.cl.scl.altacliente.presentacion.form;

import javax.servlet.ServletRequest;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.DatosGeneralesDTO;

public class BuscaCuentaForm extends ActionForm {

	private static final long serialVersionUID = -5127672582512639260L;

	private String codTipoCuenta;

	private String seleccionCuenta;

	private DatosGeneralesDTO[] arrayTipoCuenta;

	private String codTipoIdentificacion;

	private String codCriterioBusqueda;

	private IdentificadorCivilComDTO[] arrayIdentificadorCuenta;

	private String codTipoCuentaSel;

	private String codCuentaSel;

	private String numeroDocumento;

	private String telefonoContacto;

	private String nombreResponsable;

	private String nombreCuenta;

	private String largoNumCelular;

	private String codTipoCuentaEmpresa;

	private String txtFiltro;

	private String moduloOrigen;
	
	private String codModuloSolicitudVenta;

	public String getCodTipoCuentaEmpresa() {
		return codTipoCuentaEmpresa;
	}

	public void setCodTipoCuentaEmpresa(String codTipo) {
		this.codTipoCuentaEmpresa = codTipo;
	}

	public String getLargoNumCelular() {
		return largoNumCelular;
	}

	public void setLargoNumCelular(String largoNumCelular) {
		this.largoNumCelular = largoNumCelular;
	}

	public String getNombreCuenta() {
		return nombreCuenta;
	}

	public void setNombreCuenta(String nombre) {
		this.nombreCuenta = nombre;
	}

	public String getNombreResponsable() {
		return nombreResponsable;
	}

	public void setNombreResponsable(String nombres) {
		this.nombreResponsable = nombres;
	}

	public IdentificadorCivilComDTO[] getArrayIdentificadorCuenta() {
		return arrayIdentificadorCuenta;
	}

	public void setArrayIdentificadorCuenta(IdentificadorCivilComDTO[] arrayIdentificadorCliente) {
		this.arrayIdentificadorCuenta = arrayIdentificadorCliente;
	}

	public DatosGeneralesDTO[] getArrayTipoCuenta() {
		return arrayTipoCuenta;
	}

	public void setArrayTipoCuenta(DatosGeneralesDTO[] arrayTipoCuenta) {
		this.arrayTipoCuenta = arrayTipoCuenta;
	}

	public String getCodCriterioBusqueda() {
		return codCriterioBusqueda;
	}

	public void setCodCriterioBusqueda(String codCriterioBusqueda) {
		this.codCriterioBusqueda = codCriterioBusqueda;
	}

	public String getCodTipoCuenta() {
		return codTipoCuenta;
	}

	public void setCodTipoCuenta(String codTipoCliente) {
		this.codTipoCuenta = codTipoCliente;
	}

	public String getCodTipoIdentificacion() {
		return codTipoIdentificacion;
	}

	public void setCodTipoIdentificacion(String codTipoIdentificacion) {
		this.codTipoIdentificacion = codTipoIdentificacion;
	}

	public String getCodCuentaSel() {
		return codCuentaSel;
	}

	public void setCodCuentaSel(String codClienteSel) {
		this.codCuentaSel = codClienteSel;
	}

	public String getCodTipoCuentaSel() {
		return codTipoCuentaSel;
	}

	public void setCodTipoCuentaSel(String codTipoClienteSel) {
		this.codTipoCuentaSel = codTipoClienteSel;
	}

	public String getNumeroDocumento() {
		return numeroDocumento;
	}

	public void setNumeroDocumento(String numeroDocumento) {
		this.numeroDocumento = numeroDocumento;
	}

	public String getTelefonoContacto() {
		return telefonoContacto;
	}

	public void setTelefonoContacto(String telefonoContacto) {
		this.telefonoContacto = telefonoContacto;
	}

	public void reset(ActionMapping arg0, ServletRequest arg1) {
		super.reset(arg0, arg1);
		this.telefonoContacto = null;
		this.codCuentaSel = null;

	}

	public String getTxtFiltro() {
		return txtFiltro;
	}

	public void setTxtFiltro(String txtFiltro) {
		this.txtFiltro = txtFiltro;
	}

	public String getSeleccionCuenta() {
		return seleccionCuenta;
	}

	public void setSeleccionCuenta(String seleccionCuenta) {
		this.seleccionCuenta = seleccionCuenta;
	}

	public String getModuloOrigen() {
		return moduloOrigen;
	}

	public void setModuloOrigen(String moduloOrigen) {
		this.moduloOrigen = moduloOrigen;
	}

	public String getCodModuloSolicitudVenta() {
		return codModuloSolicitudVenta;
	}

	public void setCodModuloSolicitudVenta(String codModuloSolicitudVenta) {
		this.codModuloSolicitudVenta = codModuloSolicitudVenta;
	}

}
