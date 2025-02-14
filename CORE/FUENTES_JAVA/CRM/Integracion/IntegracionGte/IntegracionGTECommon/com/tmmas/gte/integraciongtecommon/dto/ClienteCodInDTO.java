package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ClienteCodInDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	private long codCliente;
	
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
}
