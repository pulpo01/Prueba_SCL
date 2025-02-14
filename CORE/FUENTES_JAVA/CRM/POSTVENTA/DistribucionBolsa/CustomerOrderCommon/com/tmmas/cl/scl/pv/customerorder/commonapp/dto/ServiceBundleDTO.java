package com.tmmas.cl.scl.pv.customerorder.commonapp.dto;

import java.io.Serializable;

public class ServiceBundleDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String COD_CLIENTE;
	private String COD_SERVICIO;
	
	
	public String getCOD_CLIENTE() {
		return COD_CLIENTE;
	}
	public void setCOD_CLIENTE(String cod_cliente) {
		COD_CLIENTE = cod_cliente;
	}
	public String getCOD_SERVICIO() {
		return COD_SERVICIO;
	}
	public void setCOD_SERVICIO(String cod_servicio) {
		COD_SERVICIO = cod_servicio;
	}
	
	


}
