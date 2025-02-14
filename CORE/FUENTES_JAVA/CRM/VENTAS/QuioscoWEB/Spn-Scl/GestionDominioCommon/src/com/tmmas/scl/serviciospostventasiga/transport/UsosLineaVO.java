package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class UsosLineaVO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Integer codUso;
	private String desUso;
	private Integer indRestplan;
	/**
	 * @return the codUso
	 */
	public Integer getCodUso() {
		return codUso;
	}
	/**
	 * @param codUso the codUso to set
	 */
	public void setCodUso(Integer codUso) {
		this.codUso = codUso;
	}
	/**
	 * @return the desUso
	 */
	public String getDesUso() {
		return desUso;
	}
	/**
	 * @param desUso the desUso to set
	 */
	public void setDesUso(String desUso) {
		this.desUso = desUso;
	}
	/**
	 * @return the indRestplan
	 */
	public Integer getIndRestplan() {
		return indRestplan;
	}
	/**
	 * @param indRestplan the indRestplan to set
	 */
	public void setIndRestplan(Integer indRestplan) {
		this.indRestplan = indRestplan;
	}
	
	
}
