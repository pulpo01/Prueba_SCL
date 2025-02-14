package com.tmmas.cl.scl.crmcommon.commonapp.dto;

import java.io.Serializable;

public class AgenteVenta implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 
	 */
	
	private String canal;
    private String codigo;
    
    
	
    public AgenteVenta(String canal, String codigo) {
		super();
		this.canal = canal;
		this.codigo = codigo;
	}
    
	public String getCanal() {
		return canal;
	}
	public void setCanal(String canal) {
		this.canal = canal;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
}
