/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 09/01/2007     Héctor Hermosilla      					Versión Inicial
 */
package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class CausalDescuentoDTO  implements Serializable{
	
	
	private static final long serialVersionUID = 1L;
	private String codigoCausalDescuento;
	private String descripcionCausalDescuento;
	
	private String COD_JUSTIFICACION;
	private String DES_JUSTIFICACION;
	private String COD_CENTCOS;
	private String DES_CENTCOS;
	private String IND_CENTCOS;

	private String COD_CONCEPTO;
	private String COD_CENTREMI;
	private String COD_DOCUMEN;
	private String COD_VENDEDOR;
	private String COLUMNA;
	private String FEC_EMISION;
	private String LETRA;
	private String MODULO;
	private String NUM_PROCESO;
	private String NUM_SECUENCI;
	private String NUM_SECDOCUMMOTIV;
	private String TIP_DOCUMEN;
	private String numVenta;
	
	public String getCOD_JUSTIFICACION() {
		return COD_JUSTIFICACION;
	}
	public void setCOD_JUSTIFICACION(String cod_justificacion) {
		COD_JUSTIFICACION = cod_justificacion;
	}
	public String getDES_JUSTIFICACION() {
		return DES_JUSTIFICACION;
	}
	public void setDES_JUSTIFICACION(String des_justificacion) {
		DES_JUSTIFICACION = des_justificacion;
	}
	public String getCOD_CENTCOS() {
		return COD_CENTCOS;
	}
	public void setCOD_CENTCOS(String cod_centcos) {
		COD_CENTCOS = cod_centcos;
	}
	public String getCOD_CENTREMI() {
		return COD_CENTREMI;
	}
	public void setCOD_CENTREMI(String cod_centremi) {
		COD_CENTREMI = cod_centremi;
	}
	public String getCOD_CONCEPTO() {
		return COD_CONCEPTO;
	}
	public void setCOD_CONCEPTO(String cod_concepto) {
		COD_CONCEPTO = cod_concepto;
	}
	public String getCOD_DOCUMEN() {
		return COD_DOCUMEN;
	}
	public void setCOD_DOCUMEN(String cod_documen) {
		COD_DOCUMEN = cod_documen;
	}
	public String getCOD_VENDEDOR() {
		return COD_VENDEDOR;
	}
	public void setCOD_VENDEDOR(String cod_vendedor) {
		COD_VENDEDOR = cod_vendedor;
	}
	public String getCOLUMNA() {
		return COLUMNA;
	}
	public void setCOLUMNA(String columna) {
		COLUMNA = columna;
	}
	public String getDES_CENTCOS() {
		return DES_CENTCOS;
	}
	public void setDES_CENTCOS(String des_centcos) {
		DES_CENTCOS = des_centcos;
	}
	public String getFEC_EMISION() {
		return FEC_EMISION;
	}
	public void setFEC_EMISION(String fec_emision) {
		FEC_EMISION = fec_emision;
	}
	public String getLETRA() {
		return LETRA;
	}
	public void setLETRA(String letra) {
		LETRA = letra;
	}
	public String getMODULO() {
		return MODULO;
	}
	public void setMODULO(String modulo) {
		MODULO = modulo;
	}
	public String getNUM_PROCESO() {
		return NUM_PROCESO;
	}
	public void setNUM_PROCESO(String num_proceso) {
		NUM_PROCESO = num_proceso;
	}
	public String getNUM_SECDOCUMMOTIV() {
		return NUM_SECDOCUMMOTIV;
	}
	public void setNUM_SECDOCUMMOTIV(String num_secdocummotiv) {
		NUM_SECDOCUMMOTIV = num_secdocummotiv;
	}
	public String getNUM_SECUENCI() {
		return NUM_SECUENCI;
	}
	public void setNUM_SECUENCI(String num_secuenci) {
		NUM_SECUENCI = num_secuenci;
	}
	public String getTIP_DOCUMEN() {
		return TIP_DOCUMEN;
	}
	public void setTIP_DOCUMEN(String tip_documen) {
		TIP_DOCUMEN = tip_documen;
	}
	public String getIND_CENTCOS() {
		return IND_CENTCOS;
	}
	public void setIND_CENTCOS(String ind_centcos) {
		IND_CENTCOS = ind_centcos;
	}
	public String getCodigoCausalDescuento() {
		return codigoCausalDescuento;
	}
	public void setCodigoCausalDescuento(String codigoCausalDescuento) {
		this.codigoCausalDescuento = codigoCausalDescuento;
	}
	public String getDescripcionCausalDescuento() {
		return descripcionCausalDescuento;
	}
	public void setDescripcionCausalDescuento(String descripcionCausalDescuento) {
		this.descripcionCausalDescuento = descripcionCausalDescuento;
	}
	public String getNumVenta() {
		return numVenta;
	}
	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}
		

	
}
