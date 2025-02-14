package com.tmmas.cl.scl.altacliente.presentacion.form;

import org.apache.struts.action.ActionForm;

import com.tmmas.cl.scl.altaclientecommon.commonapp.dto.IdentificadorCivilComDTO;

public class ClienteFacturaForm extends ActionForm {
	private static final long serialVersionUID = 1L;
	
	private String nombreClienteFactura; 
	private String apellido1ClienteFactura;
	private String apellido2ClienteFactura;
	private String tipoIdentClienteFactura;
	private IdentificadorCivilComDTO[] arrayIdentificadorCliente;
	private String numeroIdentClienteFactura;
	private String moduloOrigen;
	private String codModuloSolicitudVenta;
	
	public String getCodModuloSolicitudVenta() {
		return codModuloSolicitudVenta;
	}
	public void setCodModuloSolicitudVenta(String codModuloSolicitudVenta) {
		this.codModuloSolicitudVenta = codModuloSolicitudVenta;
	}
	public String getModuloOrigen() {
		return moduloOrigen;
	}
	public void setModuloOrigen(String moduloOrigen) {
		this.moduloOrigen = moduloOrigen;
	}
	public String getApellido1ClienteFactura() {
		return apellido1ClienteFactura;
	}
	public void setApellido1ClienteFactura(String apellido1ClienteFactura) {
		this.apellido1ClienteFactura = apellido1ClienteFactura;
	}
	public String getApellido2ClienteFactura() {
		return apellido2ClienteFactura;
	}
	public void setApellido2ClienteFactura(String apellido2ClienteFactura) {
		this.apellido2ClienteFactura = apellido2ClienteFactura;
	}
	public IdentificadorCivilComDTO[] getArrayIdentificadorCliente() {
		return arrayIdentificadorCliente;
	}
	public void setArrayIdentificadorCliente(
			IdentificadorCivilComDTO[] arrayIdentificadorCliente) {
		this.arrayIdentificadorCliente = arrayIdentificadorCliente;
	}
	public String getNombreClienteFactura() {
		return nombreClienteFactura;
	}
	public void setNombreClienteFactura(String nombreClienteFactura) {
		this.nombreClienteFactura = nombreClienteFactura;
	}
	public String getNumeroIdentClienteFactura() {
		return numeroIdentClienteFactura;
	}
	public void setNumeroIdentClienteFactura(String numeroIdentClienteFactura) {
		this.numeroIdentClienteFactura = numeroIdentClienteFactura;
	}
	public String getTipoIdentClienteFactura() {
		return tipoIdentClienteFactura;
	}
	public void setTipoIdentClienteFactura(String tipoIdentClienteFactura) {
		this.tipoIdentClienteFactura = tipoIdentClienteFactura;
	}
	
}
