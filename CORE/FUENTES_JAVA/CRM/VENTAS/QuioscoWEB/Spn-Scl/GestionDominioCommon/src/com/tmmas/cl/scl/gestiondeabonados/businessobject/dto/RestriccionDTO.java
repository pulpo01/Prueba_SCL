package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class RestriccionDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String secuencia;
	private String modulo;
	private String producto;
	private String actuacion;
	private String evento;
	private String param_entrada;
	
	
	public String getActuacion() {
		return actuacion;
	}
	public void setActuacion(String actuacion) {
		this.actuacion = actuacion;
	}
	public String getEvento() {
		return evento;
	}
	public void setEvento(String evento) {
		this.evento = evento;
	}
	public String getModulo() {
		return modulo;
	}
	public void setModulo(String modulo) {
		this.modulo = modulo;
	}
	public String getParam_entrada() {
		return param_entrada;
	}
	public void setParam_entrada(String param_entrada) {
		this.param_entrada = param_entrada;
	}
	public String getProducto() {
		return producto;
	}
	public void setProducto(String producto) {
		this.producto = producto;
	}
	public String getSecuencia() {
		return secuencia;
	}
	public void setSecuencia(String secuencia) {
		this.secuencia = secuencia;
	}		

}
