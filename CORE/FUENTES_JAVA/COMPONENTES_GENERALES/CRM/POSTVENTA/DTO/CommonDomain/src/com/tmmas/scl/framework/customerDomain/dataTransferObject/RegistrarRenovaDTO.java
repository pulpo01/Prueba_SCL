package com.tmmas.scl.framework.customerDomain.dataTransferObject;


// p-mix-09003 ocb
import java.io.Serializable;
import java.util.Date;

public class RegistrarRenovaDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private String codOS;
	private long numOs;
	private String numOsRenova;
	private long numAbonado;
	public String getCodOS() {
		return codOS;
	}
	public void setCodOS(String codOS) {
		this.codOS = codOS;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumOs() {
		return numOs;
	}
	public void setNumOs(long numOs) {
		this.numOs = numOs;
	}
	public String getNumOsRenova() {
		return numOsRenova;
	}
	public void setNumOsRenova(String numOsRenova) {
		this.numOsRenova = numOsRenova;
	}

}
