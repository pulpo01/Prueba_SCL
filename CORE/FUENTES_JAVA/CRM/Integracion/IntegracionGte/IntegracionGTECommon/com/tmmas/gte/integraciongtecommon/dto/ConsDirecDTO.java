package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class ConsDirecDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	private long codCliente;          /*cod_cliente*/
    
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

}