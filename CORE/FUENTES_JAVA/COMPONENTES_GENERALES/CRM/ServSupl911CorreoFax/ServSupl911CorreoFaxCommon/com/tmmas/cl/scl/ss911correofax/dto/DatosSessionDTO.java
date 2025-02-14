package com.tmmas.cl.scl.ss911correofax.dto;

import java.io.Serializable;

public class DatosSessionDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected String nomUsuario="MKDIAZSA";
	protected String codCliente="2345712";
	protected String nomCliente="Pablo Pedro Pino Puentes";
	protected String nomOperadora="Telefónica Móviles - El Salvador";
	
	
	public DatosSessionDTO(){
		/*this.setNomUsuario(nomUsuario);
		this.setCodCliente(codCliente);
		this.setNomCliente(nomCliente);
		this.setNomOperadora(nomOperadora);*/
	}
	
	public String getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}
	public String getNomCliente() {
		return nomCliente;
	}
	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}
	public String getNomOperadora() {
		return nomOperadora;
	}
	public void setNomOperadora(String nomOperadora) {
		this.nomOperadora = nomOperadora;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}

}
