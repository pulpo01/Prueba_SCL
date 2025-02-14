package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;
import java.sql.Timestamp;

public class FaMensProcesoDTO implements Serializable {
	
	 /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long numProceso;//NUM_PROCESO     NUMBER(8)                     NOT NULL,
	 private long codFormulario;// COD_FORMULARIO  NUMBER(2)                     NOT NULL,
	 private long codBloque;// COD_BLOQUE      NUMBER(1)                     NOT NULL,
	 private long corrMensaje;// CORR_MENSAJE    NUMBER(6)                     NOT NULL,
	 private long numLineas;// NUM_LINEAS      NUMBER(2)                     NOT NULL,
	 private String codOrigen;// COD_ORIGEN      VARCHAR2(2 BYTE)              NOT NULL,
	 private String descMensaje;// DESC_MENSAJE    VARCHAR2(40 BYTE),
	 private String indFacturado;// IND_FACTURADO   CHAR(1 BYTE),
	 private String nomUsuario;// NOM_USUARIO     VARCHAR2(30 BYTE)             NOT NULL,
	 private Timestamp fecIngreso;//FEC_INGRESO     DATE                          NOT NULL
	 
	public long getCodBloque() {
		return codBloque;
	}
	public void setCodBloque(long codBloque) {
		this.codBloque = codBloque;
	}
	public long getCodFormulario() {
		return codFormulario;
	}
	public void setCodFormulario(long codFormulario) {
		this.codFormulario = codFormulario;
	}
	public String getCodOrigen() {
		return codOrigen;
	}
	public void setCodOrigen(String codOrigen) {
		this.codOrigen = codOrigen;
	}
	public long getCorrMensaje() {
		return corrMensaje;
	}
	public void setCorrMensaje(long corrMensaje) {
		this.corrMensaje = corrMensaje;
	}
	public String getDescMensaje() {
		return descMensaje;
	}
	public void setDescMensaje(String descMensaje) {
		this.descMensaje = descMensaje;
	}
	public Timestamp getFecIngreso() {
		return fecIngreso;
	}
	public void setFecIngreso(Timestamp fecIngreso) {
		this.fecIngreso = fecIngreso;
	}
	public String getIndFacturado() {
		return indFacturado;
	}
	public void setIndFacturado(String indFacturado) {
		this.indFacturado = indFacturado;
	}
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public long getNumLineas() {
		return numLineas;
	}
	public void setNumLineas(long numLineas) {
		this.numLineas = numLineas;
	}
	public long getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(long numProceso) {
		this.numProceso = numProceso;
	}

}
