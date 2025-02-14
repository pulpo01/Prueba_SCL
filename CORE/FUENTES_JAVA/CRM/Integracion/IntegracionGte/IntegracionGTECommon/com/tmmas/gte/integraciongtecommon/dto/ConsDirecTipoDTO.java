package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class ConsDirecTipoDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	private long codCliente;          /*cod_cliente*/
    private String tipDireccion;      /*tip_direccion*/
    
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getTipDireccion() {
		return tipDireccion;
	}
	public void setTipDireccion(String tipDireccion) {
		this.tipDireccion = tipDireccion;
	}

    


}