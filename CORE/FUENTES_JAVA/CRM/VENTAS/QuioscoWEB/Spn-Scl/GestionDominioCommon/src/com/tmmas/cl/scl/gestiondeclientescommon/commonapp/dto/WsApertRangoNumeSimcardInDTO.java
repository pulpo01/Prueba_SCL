package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsApertRangoNumeSimcardInDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long numCelular;
	private long codOficina;
	private long codVendedor;
	private String codUso;
	private long numSimcard;
	private long portID;
	public long getCodOficina() {
		return codOficina;
	}
	public void setCodOficina(long codOficina) {
		this.codOficina = codOficina;
	}
	public String getCodUso() {
		return codUso;
	}
	public void setCodUso(String codUso) {
		this.codUso = codUso;
	}
	public long getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public long getNumSimcard() {
		return numSimcard;
	}
	public void setNumSimcard(long numSimcard) {
		this.numSimcard = numSimcard;
	}
	public long getPortID() {
		return portID;
	}
	public void setPortID(long portID) {
		this.portID = portID;
	}
	
}
