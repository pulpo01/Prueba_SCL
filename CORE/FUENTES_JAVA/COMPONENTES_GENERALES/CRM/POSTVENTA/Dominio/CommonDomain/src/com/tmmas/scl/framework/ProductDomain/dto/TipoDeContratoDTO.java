package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;
import java.util.Date;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class TipoDeContratoDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String cod_tipcontrato;
	private String des_tipcontrato;
	private Date   fec_desde = new Date();
	private Date   fec_hasta = new Date();
	private String ind_contseg;
	private String ind_contcel;
	private long   ind_comodato;
	private long   canal_vta;
	private long   meses_minimo;
	private String ind_procequi;
	private String ind_preciolista;
	private String ind_gmc;
	private String num_meses;
	private MensajeRetornoDTO mensajeRetorno;

	public MensajeRetornoDTO getMensajeRetorno() {
		return mensajeRetorno;
	}
	public void setMensajeRetorno(MensajeRetornoDTO mensajeRetorno) {
		this.mensajeRetorno = mensajeRetorno;
	}
	
	public TipoDeContratoDTO() {
	}
		
	public long getCanal_vta() {
		return canal_vta;
	}
	public void setCanal_vta(long canal_vta) {
		this.canal_vta = canal_vta;
	}
	public String getCod_tipcontrato() {
		return cod_tipcontrato;
	}
	public void setCod_tipcontrato(String cod_tipcontrato) {
		this.cod_tipcontrato = cod_tipcontrato;
	}
	public String getDes_tipcontrato() {
		return des_tipcontrato;
	}
	public void setDes_tipcontrato(String des_tipcontrato) {
		this.des_tipcontrato = des_tipcontrato;
	}
	public Date getFec_desde() {
		return fec_desde;
	}
	public void setFec_desde(Date fec_desde) {
		this.fec_desde = fec_desde;
	}
	public Date getFec_hasta() {
		return fec_hasta;
	}
	public void setFec_hasta(Date fec_hasta) {
		this.fec_hasta = fec_hasta;
	}
	public long getInd_comodato() {
		return ind_comodato;
	}
	public void setInd_comodato(long ind_comodato) {
		this.ind_comodato = ind_comodato;
	}
	public String getInd_contcel() {
		return ind_contcel;
	}
	public void setInd_contcel(String ind_contcel) {
		this.ind_contcel = ind_contcel;
	}
	public String getInd_contseg() {
		return ind_contseg;
	}
	public void setInd_contseg(String ind_contseg) {
		this.ind_contseg = ind_contseg;
	}
	public String getInd_gmc() {
		return ind_gmc;
	}
	public void setInd_gmc(String ind_gmc) {
		this.ind_gmc = ind_gmc;
	}
	public String getInd_preciolista() {
		return ind_preciolista;
	}
	public void setInd_preciolista(String ind_preciolista) {
		this.ind_preciolista = ind_preciolista;
	}
	public String getInd_procequi() {
		return ind_procequi;
	}
	public void setInd_procequi(String ind_procequi) {
		this.ind_procequi = ind_procequi;
	}
	public long getMeses_minimo() {
		return meses_minimo;
	}
	public void setMeses_minimo(long meses_minimo) {
		this.meses_minimo = meses_minimo;
	}
	public String getNum_meses() {
		return num_meses;
	}
	public void setNum_meses(String num_meses) {
		this.num_meses = num_meses;
	}
	
}
