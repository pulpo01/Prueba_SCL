package com.tmmas.scl.operations.crm.fab.cim.manreq.web.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.commonbusinessentities.dto.FormularioDireccionDTO;

public class DatosCorreoClienteForm extends ActionForm{
	
	private static final long serialVersionUID = 1L;
	
	private String nombreContacto;
	private String correoElectronicoEmpresa;
	private String correoElectronicoPersonal;
	private String telefono;
	private String nombreProducto;
	private String direccionInstalacion;
	private String tipoCorreo; //"PER:personal","EMP:empresarial", "PEREMP:personal y empresarial"
	private String largoNumCelular;
	
	public String getLargoNumCelular() {
		return largoNumCelular;
	}
	public void setLargoNumCelular(String largoNumCelular) {
		this.largoNumCelular = largoNumCelular;
	}
	public String getTipoCorreo() {
		return tipoCorreo;
	}
	public void setTipoCorreo(String tipoCorreo) {
		this.tipoCorreo = tipoCorreo;
	}
	public String getDireccionInstalacion() {
		return direccionInstalacion;
	}
	public void setDireccionInstalacion(String direccionInstalacion) {
		this.direccionInstalacion = direccionInstalacion;
	}
	public String getCorreoElectronicoEmpresa() {
		return correoElectronicoEmpresa;
	}
	public void setCorreoElectronicoEmpresa(String correoElectronicoEmpresa) {
		this.correoElectronicoEmpresa = correoElectronicoEmpresa;
	}
	public String getCorreoElectronicoPersonal() {
		return correoElectronicoPersonal;
	}
	public void setCorreoElectronicoPersonal(String correoElectronicoPersonal) {
		this.correoElectronicoPersonal = correoElectronicoPersonal;
	}
	public String getNombreContacto() {
		return nombreContacto;
	}
	public void setNombreContacto(String nombreContacto) {
		this.nombreContacto = nombreContacto;
	}
	public String getTelefono() {
		return telefono;
	}
	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}
	public String getNombreProducto() {
		return nombreProducto;
	}
	public void setNombreProducto(String nombreProducto) {
		this.nombreProducto = nombreProducto;
	}
}
