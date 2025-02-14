package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class FaMensajesDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	 private long corrMensaje;// CORR_MENSAJE    NUMBER(8)                     NOT NULL,
	 private String numLinea;// NUM_LINEA       VARCHAR2(2 BYTE)              NOT NULL,
	 private String descMensaje;// DESC_MENSAJE    VARCHAR2(40 BYTE)             NOT NULL,
	 private String descMesLin;// DESC_MENSLIN    VARCHAR2(200 BYTE)            NOT NULL,
	 private String codIdioma;//COD_IDIOMA      VARCHAR2(5 BYTE)              DEFAULT NULL                  NOT NULL,
	 private long cantLineasMen;// CANT_LINEASMEN  NUMBER(2)                     DEFAULT 0                     NOT NULL,
	 private long cantCaractLin;// CANT_CARACTLIN  NUMBER(4)                     DEFAULT 0                     NOT NULL
	 private String nomUsuario;
	 
	public String getNomUsuario() {
		return nomUsuario;
	}
	public void setNomUsuario(String nomUsuario) {
		this.nomUsuario = nomUsuario;
	}
	public long getCantCaractLin() {
		return cantCaractLin;
	}
	public void setCantCaractLin(long cantCaractLin) {
		this.cantCaractLin = cantCaractLin;
	}
	public long getCantLineasMen() {
		return cantLineasMen;
	}
	public void setCantLineasMen(long cantLineasMen) {
		this.cantLineasMen = cantLineasMen;
	}
	public String getCodIdioma() {
		return codIdioma;
	}
	public void setCodIdioma(String codIdioma) {
		this.codIdioma = codIdioma;
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
	public String getDescMesLin() {
		return descMesLin;
	}
	public void setDescMesLin(String descMesLin) {
		this.descMesLin = descMesLin;
	}
	public String getNumLinea() {
		return numLinea;
	}
	public void setNumLinea(String numLinea) {
		this.numLinea = numLinea;
	}

}
