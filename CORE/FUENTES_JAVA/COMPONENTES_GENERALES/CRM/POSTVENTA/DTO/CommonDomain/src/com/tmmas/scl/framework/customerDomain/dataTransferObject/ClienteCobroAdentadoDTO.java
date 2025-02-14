package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ClienteCobroAdentadoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	
	private long codCliente;
	private long numAbonado;
	private String codActabo;
	private String codCicloFact;
	
	public String getCodActabo() {
		return codActabo;
	}
	public void setCodActabo(String codActabo) {
		this.codActabo = codActabo;
	}
	public String getCodCicloFact() {
		return codCicloFact;
	}
	public void setCodCicloFact(String codCicloFact) {
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
