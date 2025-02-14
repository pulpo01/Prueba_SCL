package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class ServiciosSuplementariosVtaDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	  private Long numAbonado;
	  private String codServicio;
	  private String numTerminal;
	  private Long codServSuplabo;
	  private Long codConcepto;
	  private Long codNivel;
	  private String usuario;
	  private String codActabo;
	  
	  
	public String getCodActabo() {
		return codActabo;
	}
	public void setCodActabo(String codActabo) {
		this.codActabo = codActabo;
	}
	/**
	 * @return the codConcepto
	 */
	public Long getCodConcepto() {
		return codConcepto;
	}
	/**
	 * @param codConcepto the codConcepto to set
	 */
	public void setCodConcepto(Long codConcepto) {
		this.codConcepto = codConcepto;
	}
	/**
	 * @return the codServicio
	 */
	public String getCodServicio() {
		return codServicio;
	}
	/**
	 * @param codServicio the codServicio to set
	 */
	public void setCodServicio(String codServicio) {
		this.codServicio = codServicio;
	}
	/**
	 * @return the codServSuplabo
	 */
	public Long getCodServSuplabo() {
		return codServSuplabo;
	}
	/**
	 * @param codServSuplabo the codServSuplabo to set
	 */
	public void setCodServSuplabo(Long codServSuplabo) {
		this.codServSuplabo = codServSuplabo;
	}
	/**
	 * @return the numAbonado
	 */
	public Long getNumAbonado() {
		return numAbonado;
	}
	/**
	 * @param numAbonado the numAbonado to set
	 */
	public void setNumAbonado(Long numAbonado) {
		this.numAbonado = numAbonado;
	}
	/**
	 * @return the numTerminal
	 */
	public String getNumTerminal() {
		return numTerminal;
	}
	/**
	 * @param numTerminal the numTerminal to set
	 */
	public void setNumTerminal(String numTerminal) {
		this.numTerminal = numTerminal;
	}
	/**
	 * @return the usuario
	 */
	public String getUsuario() {
		return usuario;
	}
	/**
	 * @param usuario the usuario to set
	 */
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public Long getCodNivel() {
		return codNivel;
	}
	public void setCodNivel(Long codNivel) {
		this.codNivel = codNivel;
	}
	  
}
