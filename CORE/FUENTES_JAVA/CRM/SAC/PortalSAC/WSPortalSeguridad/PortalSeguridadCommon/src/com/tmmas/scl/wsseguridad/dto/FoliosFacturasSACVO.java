package com.tmmas.scl.wsseguridad.dto;


import java.io.Serializable;

/**
 * Copyright © 2008 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 12/03/2008 - 16:30:45     Santiago Ventura      			Versión Inicial 
 * 
 *
 * Representa el folio de facturas asociadas al cliente.
 * 
 * @author Santiago Ventura
 * @version 1.0
 **/
public class FoliosFacturasSACVO implements Serializable {

	private static final long serialVersionUID = 1L;
	/**
	 * Descripci&oacute;n abreviada del tipo de documento.
	 */
	private String desAbreviada;
	
	/**
	 * Número de folio del documento.
	 */
	private long nroFolio;
	
	/**
	 * Fecha de efectividad del documento.
	 */
	private String fecEfectividad;
	
	/**
	 * Fecha de vencimiento del documento.
	 */
	private String fecVencimiento;
	
	/**
	 * Número de la venta.
	 */
	private long numVenta;
	
	/**
	 * Indica si el documento es 0 - Recurrente 1 - Contado
	 */
	private int indContado;
	
	/**
	 * Prefijo de la plaza del documento.
	 */
	private String prefPlaza;

	
	private int codTipDocum;
	/**
	 * C&oacute;digo del vendedor.
	 */	
	private long codVendedor;
	/**
	 * Letra de un documento.
	 */
	private String letra;
	/**
	 * C&oacute;digo del centro emisor.
	 */
	private int codCentrEmi;
	/**
	 * N&uacute;mero de secuencia del siguiente documento.
	 */
	private long nroSecuencia;
	
	private double monto;

	
	/**
	 * 
	 */
	public FoliosFacturasSACVO() {

	}

	/**
	 * @return String the desAbreviada 
	 */
	public String getDesAbreviada() {
		return desAbreviada;
	}

	/**
	 * @param desAbreviada String the desAbreviada to set
	 */
	public void setDesAbreviada(String desAbreviada) {
		this.desAbreviada = desAbreviada;
	}

	/**
	 * @return String the fecEfectividad 
	 */
	public String getFecEfectividad() {
		return fecEfectividad;
	}

	/**
	 * @param fecEfectividad String the fecEfectividad to set
	 */
	public void setFecEfectividad(String fecEfectividad) {
		this.fecEfectividad = fecEfectividad;
	}

	/**
	 * @return String the fecVencimiento 
	 */
	public String getFecVencimiento() {
		return fecVencimiento;
	}

	/**
	 * @param fecVencimiento String the fecVencimiento to set
	 */
	public void setFecVencimiento(String fecVencimiento) {
		this.fecVencimiento = fecVencimiento;
	}

	/**
	 * @return int the indContado 
	 */
	public int getIndContado() {
		return indContado;
	}

	/**
	 * @param indContado int the indContado to set
	 */
	public void setIndContado(int indContado) {
		this.indContado = indContado;
	}

	/**
	 * @return long the nroFolio 
	 */
	public long getNroFolio() {
		return nroFolio;
	}

	/**
	 * @param nroFolio long the nroFolio to set
	 */
	public void setNroFolio(long nroFolio) {
		this.nroFolio = nroFolio;
	}

	/**
	 * @return long the numVenta 
	 */
	public long getNumVenta() {
		return numVenta;
	}

	/**
	 * @param numVenta long the numVenta to set
	 */
	public void setNumVenta(long numVenta) {
		this.numVenta = numVenta;
	}

	/**
	 * @return String the prefPlaza 
	 */
	public String getPrefPlaza() {
		return prefPlaza;
	}

	/**
	 * @param prefPlaza String the prefPlaza to set
	 */
	public void setPrefPlaza(String prefPlaza) {
		this.prefPlaza = prefPlaza;
	}

	public int getCodCentrEmi() {
		return codCentrEmi;
	}

	public void setCodCentrEmi(int codCentrEmi) {
		this.codCentrEmi = codCentrEmi;
	}

	public int getCodTipDocum() {
		return codTipDocum;
	}

	public void setCodTipDocum(int codTipDocum) {
		this.codTipDocum = codTipDocum;
	}

	public long getCodVendedor() {
		return codVendedor;
	}

	public void setCodVendedor(long codVendedor) {
		this.codVendedor = codVendedor;
	}

	public String getLetra() {
		return letra;
	}

	public void setLetra(String letra) {
		this.letra = letra;
	}

	public double getMonto() {
		return monto;
	}

	public void setMonto(double monto) {
		this.monto = monto;
	}

	public long getNroSecuencia() {
		return nroSecuencia;
	}

	public void setNroSecuencia(long nroSecuencia) {
		this.nroSecuencia = nroSecuencia;
	}	
}
