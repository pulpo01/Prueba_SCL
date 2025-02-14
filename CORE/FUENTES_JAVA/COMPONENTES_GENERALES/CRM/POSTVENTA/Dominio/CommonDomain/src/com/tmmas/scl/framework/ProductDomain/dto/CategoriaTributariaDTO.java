package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class CategoriaTributariaDTO implements Serializable {
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long cod_tipdocum;  
	private String des_tipdocum; 
	private String tip_foliacion; 
	private String cod_catribut;
	private MensajeRetornoDTO mensajeRetorno;
	
	public String getCod_catribut() {
		return cod_catribut;
	}
	public void setCod_catribut(String cod_catribut) {
		this.cod_catribut = cod_catribut;
	}
	public long getCod_tipdocum() {
		return cod_tipdocum;
	}
	public void setCod_tipdocum(long cod_tipdocum) {
		this.cod_tipdocum = cod_tipdocum;
	}
	public String getDes_tipdocum() {
		return des_tipdocum;
	}
	public void setDes_tipdocum(String des_tipdocum) {
		this.des_tipdocum = des_tipdocum;
	}
	public String getTip_foliacion() {
		return tip_foliacion;
	}
	public void setTip_foliacion(String tip_foliacion) {
		this.tip_foliacion = tip_foliacion;
	}
	public MensajeRetornoDTO getMensajeRetorno() {
		return mensajeRetorno;
	}
	public void setMensajeRetorno(MensajeRetornoDTO mensajeRetorno) {
		this.mensajeRetorno = mensajeRetorno;
	}

}
