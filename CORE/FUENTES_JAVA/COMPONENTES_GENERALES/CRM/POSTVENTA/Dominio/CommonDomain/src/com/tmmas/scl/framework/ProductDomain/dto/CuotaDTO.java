package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class CuotaDTO implements Serializable{


	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String cod_cuota;
	private String des_cuota;
	private long   num_cuota;
	private long   por_interes;
	private long   num_dias;
	private long   ind_forminteres;
	private MensajeRetornoDTO mensajeRetorno;

	public MensajeRetornoDTO getMensajeRetorno() {
		return mensajeRetorno;
	}
	public void setMensajeRetorno(MensajeRetornoDTO mensajeRetorno) {
		this.mensajeRetorno = mensajeRetorno;
	}                   

	public String getCod_cuota() {
		return cod_cuota;
	}
	public void setCod_cuota(String cod_cuota) {
		this.cod_cuota = cod_cuota;
	}
	public String getDes_cuota() {
		return des_cuota;
	}
	public void setDes_cuota(String des_cuota) {
		this.des_cuota = des_cuota;
	}
	public long getInd_forminteres() {
		return ind_forminteres;
	}
	public void setInd_forminteres(long ind_forminteres) {
		this.ind_forminteres = ind_forminteres;
	}
	public long getNum_cuota() {
		return num_cuota;
	}
	public void setNum_cuota(long num_cuota) {
		this.num_cuota = num_cuota;
	}
	public long getNum_dias() {
		return num_dias;
	}
	public void setNum_dias(long num_dias) {
		this.num_dias = num_dias;
	}
	public long getPor_interes() {
		return por_interes;
	}
	public void setPor_interes(long por_interes) {
		this.por_interes = por_interes;
	}
}
