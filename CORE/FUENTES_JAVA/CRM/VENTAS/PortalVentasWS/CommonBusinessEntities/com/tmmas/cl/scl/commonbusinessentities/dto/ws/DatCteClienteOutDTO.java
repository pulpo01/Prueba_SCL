package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable; 
public class DatCteClienteOutDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String codigoCliente;
	private String nombreCliente;
	private String nombreApellido1;
	private String nombreApellido2;
	private String codigoTipoIdentificacion;
	private String numeroIdentificacion;
    private String numeroTelefono1;
    private String direccionEMail;
	private String fechaNacimiento;
	
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getDireccionEMail() {
		return direccionEMail;
	}
	public void setDireccionEMail(String direccionEMail) {
		this.direccionEMail = direccionEMail;
	}
	public String getFechaNacimiento() {
		return fechaNacimiento;
	}
	public void setFechaNacimiento(String fechaNacimiento) {
		this.fechaNacimiento = fechaNacimiento;
	}
	public String getNombreApellido1() {
		return nombreApellido1;
	}
	public void setNombreApellido1(String nombreApellido1) {
		this.nombreApellido1 = nombreApellido1;
	}
	public String getNombreApellido2() {
		return nombreApellido2;
	}
	public void setNombreApellido2(String nombreApellido2) {
		this.nombreApellido2 = nombreApellido2;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public String getNumeroIdentificacion() {
		return numeroIdentificacion;
	}
	public void setNumeroIdentificacion(String numeroIdentificacion) {
		this.numeroIdentificacion = numeroIdentificacion;
	}
	public String getNumeroTelefono1() {
		return numeroTelefono1;
	}
	public void setNumeroTelefono1(String numeroTelefono1) {
		this.numeroTelefono1 = numeroTelefono1;
	}
	public String getCodigoTipoIdentificacion() {
		return codigoTipoIdentificacion;
	}
	public void setCodigoTipoIdentificacion(String codigoTipoIdentificacion) {
		this.codigoTipoIdentificacion = codigoTipoIdentificacion;
	}
	
}//fin class DatCteClienteOutDTO


