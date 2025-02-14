package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class UsosVentaDTO implements Serializable{
	
	  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
    private long   cod_uso;
	private String des_uso;
	private long   ind_restplan;
	private long   ind_cargopro;
	private long   ind_usoventa;
	private long   num_dias_hibernacion;
	private MensajeRetornoDTO mensajeRetorno;

	public MensajeRetornoDTO getMensajeRetorno() {
		return mensajeRetorno;
	}
	public void setMensajeRetorno(MensajeRetornoDTO mensajeRetorno) {
		this.mensajeRetorno = mensajeRetorno;
	}
	
	public long getCod_uso() {
		return cod_uso;
	}
	public void setCod_uso(long cod_uso) {
		this.cod_uso = cod_uso;
	}
	public String getDes_uso() {
		return des_uso;
	}
	public void setDes_uso(String des_uso) {
		this.des_uso = des_uso;
	}
	public long getInd_cargopro() {
		return ind_cargopro;
	}
	public void setInd_cargopro(long ind_cargopro) {
		this.ind_cargopro = ind_cargopro;
	}
	public long getInd_restplan() {
		return ind_restplan;
	}
	public void setInd_restplan(long ind_restplan) {
		this.ind_restplan = ind_restplan;
	}
	public long getInd_usoventa() {
		return ind_usoventa;
	}
	public void setInd_usoventa(long ind_usoventa) {
		this.ind_usoventa = ind_usoventa;
	}
	public long getNum_dias_hibernacion() {
		return num_dias_hibernacion;
	}
	public void setNum_dias_hibernacion(long num_dias_hibernacion) {
		this.num_dias_hibernacion = num_dias_hibernacion;
	}        
	  
	  
}
