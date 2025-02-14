package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class AbonadoPospagoDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long numAbonado;
	private long codCliente;
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}



}