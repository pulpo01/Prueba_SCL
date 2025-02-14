package com.tmmas.scl.wsseguridad.dto;


import java.io.Serializable;

import com.tmmas.scl.wsfranquicias.common.vo.firma.CausasPagoVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.NotaDebitoVO;
import com.tmmas.scl.wsfranquicias.common.vo.firma.OrigenPagoVO;

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
 * 14/03/2008 - 13:30:39     Santiago Ventura      			Versión Inicial 
 * 
 *
 * 
 * 
 * @author Santiago Ventura
 * @version 1.0
 **/
public class CargaAjusteCReversionCargosSACDTO implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * Número identificador del cliente.
	 */
	private long codCliente;
	
	/**
	 * Password del usuario de sistema SCL
	 */
	private String password;
		
	/**
	 * Nombre completo del cliente.
	 */	
	private String nombreCliente;
	
	/**
	 * Saldo del cliente.
	 */	
	private double saldoCliente;
	
	/**
	 * Array que contiene el listado de folios de facturas asociadas al cliente.
	 */
	private FoliosFacturasSACVO[] arrayFoliosFacturasVO;
	
	/**
	 * Array que contiene el listado de causas de pago.
	 */
	private CausasPagoVO[] arrayCausasPagoVO;
	
	/**
	 * Array que contiene el listado de origenes de pago.
	 */
	private OrigenPagoVO[] arrayOrigenPagoVO;
	
	/**
	 * Array que contiene el listado de tipo de ajuste para la emisi&oacute;n de notas de d&eacute;bito internas.
	 */
	private NotaDebitoVO[] arrayNotaDebitoVO;
	
	private long nroOOSS;
	private String codError;
	private String desError;
	private String numTransaccion;
	private String nomUsuarioSCL;

	/**
	 * 
	 */
	public CargaAjusteCReversionCargosSACDTO() {

	}

	/**
	 * @return CausasPagoVO[] the arrayCausasPagoVO 
	 */
	public CausasPagoVO[] getArrayCausasPagoVO() {
		return arrayCausasPagoVO;
	}

	/**
	 * @param arrayCausasPagoVO CausasPagoVO[] the arrayCausasPagoVO to set
	 */
	public void setArrayCausasPagoVO(CausasPagoVO[] arrayCausasPagoVO) {
		this.arrayCausasPagoVO = arrayCausasPagoVO;
	}

	/**
	 * @return FoliosFacturasVO[] the arrayFoliosFacturasVO 
	 */
	public FoliosFacturasSACVO[] getArrayFoliosFacturasVO() {
		return arrayFoliosFacturasVO;
	}

	/**
	 * @param arrayFoliosFacturasVO FoliosFacturasVO[] the arrayFoliosFacturasVO to set
	 */
	public void setArrayFoliosFacturasVO(FoliosFacturasSACVO[] arrayFoliosFacturasVO) {
		this.arrayFoliosFacturasVO = arrayFoliosFacturasVO;
	}

	/**
	 * @return NotaDebitoVO[] the arrayNotaDebitoVO 
	 */
	public NotaDebitoVO[] getArrayNotaDebitoVO() {
		return arrayNotaDebitoVO;
	}

	/**
	 * @param arrayNotaDebitoVO NotaDebitoVO[] the arrayNotaDebitoVO to set
	 */
	public void setArrayNotaDebitoVO(NotaDebitoVO[] arrayNotaDebitoVOVO) {
		this.arrayNotaDebitoVO = arrayNotaDebitoVOVO;
	}

	/**
	 * @return OrigenPagoVO[] the arrayOrigenPagoVO 
	 */
	public OrigenPagoVO[] getArrayOrigenPagoVO() {
		return arrayOrigenPagoVO;
	}

	/**
	 * @param arrayOrigenPagoVO OrigenPagoVO[] the arrayOrigenPagoVO to set
	 */
	public void setArrayOrigenPagoVO(OrigenPagoVO[] arrayOrigenPagoVO) {
		this.arrayOrigenPagoVO = arrayOrigenPagoVO;
	}

	/**
	 * @return long the codCliente 
	 */
	public long getCodCliente() {
		return codCliente;
	}

	/**
	 * @param codCliente long the codCliente to set
	 */
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	/**
	 * @return String the nombreCliente 
	 */
	public String getNombreCliente() {
		return nombreCliente;
	}

	/**
	 * @param nombreCliente String the nombreCliente to set
	 */
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}

	/**
	 * @return String the password 
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * @param password String the password to set
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * @return double the saldoCliente 
	 */
	public double getSaldoCliente() {
		return saldoCliente;
	}

	/**
	 * @param saldoCliente double the saldoCliente to set
	 */
	public void setSaldoCliente(double saldoCliente) {
		this.saldoCliente = saldoCliente;
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
