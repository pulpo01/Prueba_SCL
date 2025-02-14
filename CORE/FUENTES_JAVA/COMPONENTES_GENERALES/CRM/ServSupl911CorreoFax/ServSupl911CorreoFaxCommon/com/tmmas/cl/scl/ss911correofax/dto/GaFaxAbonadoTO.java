package com.tmmas.cl.scl.ss911correofax.dto;

import java.io.Serializable;
import java.sql.Timestamp;

public class GaFaxAbonadoTO extends GaSSTipDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	protected String codServicio;//	varchar2(3)
	protected long numFax;//	number(15)
	protected Timestamp fecModificacion;//	date
	protected String nomUsuarora;//	varchar2(30)
	
	public String getCodServicio() {
		return codServicio;
	}
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	public Timestamp getFecModificacion() {
		return fecModificacion;
	}
	public void setFecModificacion(Timestamp fecModificacion) {
		this.fecModificacion = fecModificacion;
	}
	public String getNomUsuarora() {
		return nomUsuarora;
	}
	public void setNomUsuarora(String nomUsuarora) {
		this.nomUsuarora = nomUsuarora;
	}
	
	public long getNumFax() {
		return numFax;
	}
	public void setNumFax(long numFax) {
		this.numFax = numFax;
	}


}
