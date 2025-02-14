package com.tmmas.scl.doblecuenta.commonapp.dto;

import java.io.Serializable;

public class AbonadoDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private String numCelular;
	private String codCliente;
	private String numAbonado;
	private String codUsuario;
	private String nomUsuario;
	private String nomApellido1;
	private String nomApellido2;

	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodUsuario() {
		return codUsuario;
	}
	public void setCodUsuario(String codUsuario) {
		this.codUsuario = codUsuario;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public String getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(String numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}
	public String getNomApellido1() {
		return nomApellido1;
	}
	public void setNomApellido1(String nomApellido1) {
		this.nomApellido1 = nomApellido1;
	}
	public String getNomApellido2() {
		return nomApellido2;
	}
	public void setNomApellido2(String nomApellido2) {
		this.nomApellido2 = nomApellido2;
	}
	
	
	
	
	
	
	
}
