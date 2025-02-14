package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class ServiciosSuplementariosDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String codServicio;
	private String desServicio;
	private String codServSupl;
	private int codNivel;
	private String n;
	private Integer impTarifa;
	private String desMoneda;
	private Integer codConcepto;
	private Integer impTarifa1;
	private String desMoneda1;
	private Integer codConcepto1;
	private String cadenaSS;
	
	public String getCadenaSS() {
		return cadenaSS;
	}
	public void setCadenaSS(String cadenaSS) {
		this.cadenaSS = cadenaSS;
	}
	/**
	 * @return the codConcepto
	 */
	public Integer getCodConcepto() {
		return codConcepto;
	}
	/**
	 * @param codConcepto the codConcepto to set
	 */
	public void setCodConcepto(Integer codConcepto) {
		this.codConcepto = codConcepto;
	}
	/**
	 * @return the codNivel
	 */
	public int getCodNivel() {
		return codNivel;
	}
	/**
	 * @param codNivel the codNivel to set
	 */
	public void setCodNivel(int codNivel) {
		this.codNivel = codNivel;
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
	 * @return the codServSupl
	 */
	public String getCodServSupl() {
		return codServSupl;
	}
	/**
	 * @param codServSupl the codServSupl to set
	 */
	public void setCodServSupl(String codServSupl) {
		this.codServSupl = codServSupl;
	}
	/**
	 * @return the desMoneda
	 */
	public String getDesMoneda() {
		return desMoneda;
	}
	/**
	 * @param desMoneda the desMoneda to set
	 */
	public void setDesMoneda(String desMoneda) {
		this.desMoneda = desMoneda;
	}
	/**
	 * @return the desMoneda1
	 */
	public String getDesMoneda1() {
		return desMoneda1;
	}
	/**
	 * @param desMoneda1 the desMoneda1 to set
	 */
	public void setDesMoneda1(String desMoneda1) {
		this.desMoneda1 = desMoneda1;
	}
	/**
	 * @return the desServicio
	 */
	public String getDesServicio() {
		return desServicio;
	}
	/**
	 * @param desServicio the desServicio to set
	 */
	public void setDesServicio(String desServicio) {
		this.desServicio = desServicio;
	}
	/**
	 * @return the impTarifa
	 */
	public Integer getImpTarifa() {
		return impTarifa;
	}
	/**
	 * @param impTarifa the impTarifa to set
	 */
	public void setImpTarifa(Integer impTarifa) {
		this.impTarifa = impTarifa;
	}
	/**
	 * @return the impTarifa1
	 */
	public Integer getImpTarifa1() {
		return impTarifa1;
	}
	/**
	 * @param impTarifa1 the impTarifa1 to set
	 */
	public void setImpTarifa1(Integer impTarifa1) {
		this.impTarifa1 = impTarifa1;
	}
	/**
	 * @return the n
	 */
	public String getN() {
		return n;
	}
	/**
	 * @param n the n to set
	 */
	public void setN(String n) {
		this.n = n;
	}
	/**
	 * @return the codConcepto1
	 */
	public Integer getCodConcepto1() {
		return codConcepto1;
	}
	/**
	 * @param codConcepto1 the codConcepto1 to set
	 */
	public void setCodConcepto1(Integer codConcepto1) {
		this.codConcepto1 = codConcepto1;
	}	
}
