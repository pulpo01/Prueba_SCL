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
 * 14/03/2008 - 13:46:10     Santiago Ventura      			Versión Inicial 
 * 
 *
 * Esta clase se creo para contener todos los atributos requeridos tanto por FiltroDetDocAjusteCReversionCargosDTO
 * como por FiltroDetDocAjusteCExcepcionCargosDTO. Ya que ambas clases manejan los mismos atributos. 
 * 
 * @author Santiago Ventura
 * @version 1.0
 **/
public class FiltroDetDocAjusteCCargosSACDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * C&oacute;digo del tipo de documento.
	 */
	private int codTipDocum;
	/**
	 * C&oacute;digo del vendedor.
	 */	
	private int codVendedor;
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
	private int nroSecuencia;	
	
	/**
	 * Array que contiene el detalle del ajuste realizado al cliente.
	 */
	private DetalleDocumentoSACVO[] arrayDetalleDocumentoVO;
	
	private long nroOOSS;
	private String codError;
	private String desError;
	private String numTransaccion;
	private String nomUsuarioSCL;

	/**
	 * 
	 */
	public FiltroDetDocAjusteCCargosSACDTO() {

	}

	/**
	 * @return DetalleDocumentoVO[] the arrayDetalleDocumentoVO 
	 */
	public DetalleDocumentoSACVO[] getArrayDetalleDocumentoVO() {
		return arrayDetalleDocumentoVO;
	}

	/**
	 * @param arrayDetalleDocumentoVO DetalleDocumentoVO[] the arrayDetalleDocumentoVO to set
	 */
	public void setArrayDetalleDocumentoVO(DetalleDocumentoSACVO[] arrayDetalleDocumentoVO) {
		this.arrayDetalleDocumentoVO = arrayDetalleDocumentoVO;
	}

	/**
	 * @return int the codCentrEmi 
	 */
	public int getCodCentrEmi() {
		return codCentrEmi;
	}

	/**
	 * @param codCentrEmi int the codCentrEmi to set
	 */
	public void setCodCentrEmi(int codCentrEmi) {
		this.codCentrEmi = codCentrEmi;
	}

	/**
	 * @return int the codTipDocum 
	 */
	public int getCodTipDocum() {
		return codTipDocum;
	}

	/**
	 * @param codTipDocum int the codTipDocum to set
	 */
	public void setCodTipDocum(int codTipDocum) {
		this.codTipDocum = codTipDocum;
	}

	/**
	 * @return int the codVendedor 
	 */
	public int getCodVendedor() {
		return codVendedor;
	}

	/**
	 * @param codVendedor int the codVendedor to set
	 */
	public void setCodVendedor(int codVendedor) {
		this.codVendedor = codVendedor;
	}

	/**
	 * @return String the letra 
	 */
	public String getLetra() {
		return letra;
	}

	/**
	 * @param letra String the letra to set
	 */
	public void setLetra(String letra) {
		this.letra = letra;
	}

	/**
	 * @return int the nroSecuencia 
	 */
	public int getNroSecuencia() {
		return nroSecuencia;
	}

	/**
	 * @param nroSecuencia int the nroSecuencia to set
	 */
	public void setNroSecuencia(int nroSecuencia) {
		this.nroSecuencia = nroSecuencia;
	}

	public String getCodError() {
		return codError;
	}

	public void setCodError(String codError) {
		this.codError = codError;
	}

	public String getDesError() {
		return desError;
	}

	public void setDesError(String desError) {
		this.desError = desError;
	}

	public String getNomUsuarioSCL() {
		return nomUsuarioSCL;
	}

	public void setNomUsuarioSCL(String nomUsuarioSCL) {
		this.nomUsuarioSCL = nomUsuarioSCL;
	}

	public long getNroOOSS() {
		return nroOOSS;
	}

	public void setNroOOSS(long nroOOSS) {
		this.nroOOSS = nroOOSS;
	}

	public String getNumTransaccion() {
		return numTransaccion;
	}

	public void setNumTransaccion(String numTransaccion) {
		this.numTransaccion = numTransaccion;
	}		

}
