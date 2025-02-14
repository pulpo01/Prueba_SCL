package com.tmmas.scl.serviciospostventasiga.transport;

import java.io.Serializable;

public class EquipoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Long numCelular;
	private String equipo;
	private String fabricante;
	private String modelo;
	private String codError;
	private String desError;
	private Integer codArticulo;
	private Integer codTipStock; 
	
	
	public Integer getCodTipStock() {
		return codTipStock;
	}
	public void setCodTipStock(Integer codTipStock) {
		this.codTipStock = codTipStock;
	}
	public Integer getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(Integer codArticulo) {
		this.codArticulo = codArticulo;
	}
	/**
	 * @return the codError
	 */
	public String getCodError() {
		return codError;
	}
	/**
	 * @param codError the codError to set
	 */
	public void setCodError(String codError) {
		this.codError = codError;
	}
	/**
	 * @return the desError
	 */
	public String getDesError() {
		return desError;
	}
	/**
	 * @param desError the desError to set
	 */
	public void setDesError(String desError) {
		this.desError = desError;
	}
	/**
	 * @return the equipo
	 */
	public String getEquipo() {
		return equipo;
	}
	/**
	 * @param equipo the equipo to set
	 */
	public void setEquipo(String equipo) {
		this.equipo = equipo;
	}
	/**
	 * @return the fabricante
	 */
	public String getFabricante() {
		return fabricante;
	}
	/**
	 * @param fabricante the fabricante to set
	 */
	public void setFabricante(String fabricante) {
		this.fabricante = fabricante;
	}
	/**
	 * @return the modelo
	 */
	public String getModelo() {
		return modelo;
	}
	/**
	 * @param modelo the modelo to set
	 */
	public void setModelo(String modelo) {
		this.modelo = modelo;
	}
	/**
	 * @return the numCelular
	 */
	public Long getNumCelular() {
		return numCelular;
	}
	/**
	 * @param numCelular the numCelular to set
	 */
	public void setNumCelular(Long numCelular) {
		this.numCelular = numCelular;
	}
	
	
}
