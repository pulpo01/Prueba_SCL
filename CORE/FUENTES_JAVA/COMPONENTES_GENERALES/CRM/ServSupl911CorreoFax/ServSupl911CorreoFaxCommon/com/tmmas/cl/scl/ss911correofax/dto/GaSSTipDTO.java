package com.tmmas.cl.scl.ss911correofax.dto;

import java.io.Serializable;

public class GaSSTipDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	protected String codServicio;
	protected String grupo;
	protected String tipoSS;
	protected long numAbonado ;
	
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public String getGrupo() {
		return grupo;
	}
	public void setGrupo(String grupo) {
		this.grupo = grupo;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getTipoSS() {
		return tipoSS;
	}
	public void setTipoSS(String tipoSS) {
		this.tipoSS = tipoSS;
	}

}
