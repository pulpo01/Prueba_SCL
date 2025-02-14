package com.tmmas.cl.scl.socketps.common.dto;

import java.io.Serializable;

public class HeaderPSDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	//Indicador del sistema de cliente. Ejemplo FEFacon
	private String sis;
	
	//Usuario del sistema. Ejemplo testr
	private String usuario;
	
	//Identificador del sistema del cliente. Ejemplo 1002
	private String os;
	
	//Prioridad. Ejemplo 9
	private String prioridad;
	
	//Tiempo en segundos por la espera de una respuesta. Ejemplo 10
	private String ttl;
	
	//Orden a ejecutar. ppga_plan_q
	private String orden;
	
	//Parametros de la orden. parametro=valor separados por "separador"
	private String[] parametrosNombre;

	private String[] parametrosValor;
	
	private String separador;
	
	private boolean parametrodelCliente = false;
	
	public boolean isParametrodelCliente() {
		return parametrodelCliente;
	}

	public void setParametrodelCliente(boolean parametrodelCliente) {
		this.parametrodelCliente = parametrodelCliente;
	}

	public String getSeparador() {
		return separador;
	}

	public void setSeparador(String separador) {
		this.separador = separador;
	}

	public String getOrden() {
		return orden;
	}

	public void setOrden(String orden) {
		this.orden = orden;
	}

	public String getOs() {
		return os;
	}

	public void setOs(String os) {
		this.os = os;
	}

	public String getPrioridad() {
		return prioridad;
	}

	public void setPrioridad(String prioridad) {
		this.prioridad = prioridad;
	}

	public String getSis() {
		return sis;
	}

	public void setSis(String sis) {
		this.sis = sis;
	}

	public String getTtl() {
		return ttl;
	}

	public void setTtl(String ttl) {
		this.ttl = ttl;
	}

	public String getUsuario() {
		return usuario;
	}

	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}

	public String[] getParametrosNombre() {
		return parametrosNombre;
	}

	public void setParametrosNombre(String[] parametrosNombre) {
		this.parametrosNombre = parametrosNombre;
	}

	public String[] getParametrosValor() {
		return parametrosValor;
	}

	public void setParametrosValor(String[] parametrosValor) {
		this.parametrosValor = parametrosValor;
	}

	
}
