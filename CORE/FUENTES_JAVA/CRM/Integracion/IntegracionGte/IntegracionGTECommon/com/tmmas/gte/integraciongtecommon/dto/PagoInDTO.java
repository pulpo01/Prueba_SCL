package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class PagoInDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Mu�oz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	private long codCliente;             

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