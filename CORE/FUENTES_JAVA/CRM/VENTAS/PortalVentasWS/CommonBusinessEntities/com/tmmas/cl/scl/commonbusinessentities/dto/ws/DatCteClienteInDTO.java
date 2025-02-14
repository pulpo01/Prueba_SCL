package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable; 
public class DatCteClienteInDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;

	private String codigoCliente;
	private String tipoIdentificacion;
	private String numeroIdentificacion;
	
	public String getCodigoCliente() {
		return codigoCliente;
	}
	public void setCodigoCliente(String codigoCliente) {
		this.codigoCliente = codigoCliente;
	}
	public String getNumeroIdentificacion() {
		return numeroIdentificacion;
	}
	public void setNumeroIdentificacion(String numeroIdentificacion) {
		this.numeroIdentificacion = numeroIdentificacion;
	}
	public String getTipoIdentificacion() {
		return tipoIdentificacion;
	}
	public void setTipoIdentificacion(String tipoIdentificacion) {
		this.tipoIdentificacion = tipoIdentificacion;
	}
	
	
}//fin class DatCteClienteInDTO