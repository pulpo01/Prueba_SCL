package com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto;

import java.io.Serializable;

public class ClienteDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private long	codCliente;
	private long 	codCuenta;
	private int 	codCiclFact;
	
	public int getCodCiclFact() {
		return codCiclFact;
	}
	public void setCodCiclFact(int codCiclFact) {
		this.codCiclFact = codCiclFact;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}	
}
