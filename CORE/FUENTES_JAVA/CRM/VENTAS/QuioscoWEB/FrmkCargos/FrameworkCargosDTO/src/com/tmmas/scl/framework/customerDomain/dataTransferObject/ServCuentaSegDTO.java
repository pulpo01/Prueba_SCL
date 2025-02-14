package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;

public class ServCuentaSegDTO implements Serializable{
	private static final long serialVersionUID = 1L;
	private long numAbonado;
	private String codActAbo;
	private String codTecnologia;
	private long numCelular;
	private String codTipoTerminal;
	private int	codCentral;
	private String perfilAbonado;
	private String claseServicio;
	
	public String getClaseServicio() {
		return claseServicio;
	}
	public void setClaseServicio(String claseServicio) {
		this.claseServicio = claseServicio;
	}
	public String getCodActAbo() {
		return codActAbo;
	}
	public void setCodActAbo(String codActAbo) {
		this.codActAbo = codActAbo;
	}
	public int getCodCentral() {
		return codCentral;
	}
	public void setCodCentral(int codCentral) {
		this.codCentral = codCentral;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getCodTipoTerminal() {
		return codTipoTerminal;
	}
	public void setCodTipoTerminal(String codTipoTerminal) {
		this.codTipoTerminal = codTipoTerminal;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public String getPerfilAbonado() {
		return perfilAbonado;
	}
	public void setPerfilAbonado(String perfilAbonado) {
		this.perfilAbonado = perfilAbonado;
	}
	

}
