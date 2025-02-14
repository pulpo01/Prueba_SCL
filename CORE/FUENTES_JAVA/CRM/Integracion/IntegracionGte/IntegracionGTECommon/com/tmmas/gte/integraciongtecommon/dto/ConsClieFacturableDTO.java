package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConsClieFacturableDTO implements Serializable  {
    /**
	 * Autor : Alejandro Lorca
	 */
	private static final long serialVersionUID = 1L;
	private long numAbonado;
	private long codCliente;
	private long codCicloFact;
	public long getCodCicloFact() {
		return codCicloFact;
	}
	public void setCodCicloFact(long codCicloFact) {
		this.codCicloFact = codCicloFact;
	}
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