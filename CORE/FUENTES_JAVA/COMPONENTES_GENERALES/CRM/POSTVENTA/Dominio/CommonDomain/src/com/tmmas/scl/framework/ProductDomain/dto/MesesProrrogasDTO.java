package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class MesesProrrogasDTO implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private long num_meses; 
	private String des_prorroga;
	private MensajeRetornoDTO mensajeRetorno;

	public MensajeRetornoDTO getMensajeRetorno() {
		return mensajeRetorno;
	}
	public void setMensajeRetorno(MensajeRetornoDTO mensajeRetorno) {
		this.mensajeRetorno = mensajeRetorno;
	}
		
	public String getDes_prorroga() {
		return des_prorroga;
	}
	public void setDes_prorroga(String des_prorroga) {
		this.des_prorroga = des_prorroga;
	}
	public long getNum_meses() {
		return num_meses;
	}
	public void setNum_meses(long num_meses) {
		this.num_meses = num_meses;
	}
	
}
