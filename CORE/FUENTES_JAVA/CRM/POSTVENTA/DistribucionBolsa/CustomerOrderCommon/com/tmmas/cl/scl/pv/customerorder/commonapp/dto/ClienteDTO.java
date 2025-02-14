package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;

public class ClienteDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	
	private long codigoCliente;
	private String nombres;
	private String apellido1  ;
	private String apellido2 ;
	private int unidadesLibres ;
	private String codigoPlanTarifario;
	private String descripcionPalnTarifario;
	private String unidadMedida;
	public String getApellido1() {
		return apellido1;
	}
	public void setApellido1(String apellido1) {
		this.apellido1 = apellido1;
	}
	public String getApellido2() {
		return apellido2;
	}
	public void setApellido2(String apellido2) {
		this.apellido2 = apellido2;
	}
	public long getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(long codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getCodigoPlanTarifario() {
		return codigoPlanTarifario;
	}
	public void setCodigoPlanTarifario(String codigoPlanTarifario) {
		this.codigoPlanTarifario = codigoPlanTarifario;
	}
	public String getDescripcionPalnTarifario() {
		return descripcionPalnTarifario;
	}
	public void setDescripcionPalnTarifario(String descripcionPalnTarifario) {
		this.descripcionPalnTarifario = descripcionPalnTarifario;
	}
	public String getNombres() {
		return nombres;
	}
	public void setNombres(String nombres) {
		this.nombres = nombres;
	}
	public int getUnidadesLibres() {
		return unidadesLibres;
	}
	public void setUnidadesLibres(int unidadesLibres) {
		this.unidadesLibres = unidadesLibres;
	}
	public String getUnidadMedida() {
		return unidadMedida;
	}
	public void setUnidadMedida(String unidadMedida) {
		this.unidadMedida = unidadMedida;
	}
}
