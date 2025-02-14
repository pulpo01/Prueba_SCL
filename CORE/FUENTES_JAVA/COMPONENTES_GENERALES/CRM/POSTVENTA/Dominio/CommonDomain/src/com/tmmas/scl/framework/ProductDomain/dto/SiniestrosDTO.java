package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;
import java.util.Date;

public class SiniestrosDTO implements  Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long   num_siniestro;
	private String cod_causa;
	private String des_causa;
	private String cod_estado;
	private String cod_estado_d;
	private String des_estado_d;
	private String num_terminal;
	private String num_serie;
	private Date   fec_siniestro;
	private String cod_servicio;
	private String cod_cargobasico;
	private Date   fec_formaliza;
    private Date   fec_anula;
    private Date   fec_restituc;
	private String num_constpol;
	private String num_solliq;
	private String num_serierep;
	private long   ind_susp;
	private String tip_terminal;
	private String des_terminal;
	private String obs_detalle;
	private long numOoss;
	private String codOoss;
	private String indlistaNegra;
	//Incluido santiago ventura 23-03-2010
	private String numConstaPolAnula;
	//Incluido santiago ventura 26-04-2010	
	private String   srt_fec_anula;
	
	public String getIndlistaNegra() {
		return indlistaNegra;
	}
	public void setIndlistaNegra(String indlistaNegra) {
		this.indlistaNegra = indlistaNegra;
	}
	public String getCod_cargobasico() {
		return cod_cargobasico;
	}
	public void setCod_cargobasico(String cod_cargobasico) {
		this.cod_cargobasico = cod_cargobasico;
	}
	public String getCod_causa() {
		return cod_causa;
	}
	public void setCod_causa(String cod_causa) {
		this.cod_causa = cod_causa;
	}
	public String getCod_estado() {
		return cod_estado;
	}
	public void setCod_estado(String cod_estado) {
		this.cod_estado = cod_estado;
	}
	public String getCod_servicio() {
		return cod_servicio;
	}
	public void setCod_servicio(String cod_servicio) {
		this.cod_servicio = cod_servicio;
	}
	public Date getFec_anula() {
		return fec_anula;
	}
	public void setFec_anula(Date fec_anula) {
		this.fec_anula = fec_anula;
	}
	public Date getFec_formaliza() {
		return fec_formaliza;
	}
	public void setFec_formaliza(Date fec_formaliza) {
		this.fec_formaliza = fec_formaliza;
	}
	public Date getFec_restituc() {
		return fec_restituc;
	}
	public void setFec_restituc(Date fec_restituc) {
		this.fec_restituc = fec_restituc;
	}
	public Date getFec_siniestro() {
		return fec_siniestro;
	}
	public void setFec_siniestro(Date fec_siniestro) {
		this.fec_siniestro = fec_siniestro;
	}
	public long getInd_susp() {
		return ind_susp;
	}
	public void setInd_susp(long ind_susp) {
		this.ind_susp = ind_susp;
	}
	public String getNum_constpol() {
		return num_constpol;
	}
	public void setNum_constpol(String num_constpol) {
		this.num_constpol = num_constpol;
	}
	public String getNum_serie() {
		return num_serie;
	}
	public void setNum_serie(String num_serie) {
		this.num_serie = num_serie;
	}
	public String getNum_serierep() {
		return num_serierep;
	}
	public void setNum_serierep(String num_serierep) {
		this.num_serierep = num_serierep;
	}
	public long getNum_siniestro() {
		return num_siniestro;
	}
	public void setNum_siniestro(long num_siniestro) {
		this.num_siniestro = num_siniestro;
	}
	public String getNum_solliq() {
		return num_solliq;
	}
	public void setNum_solliq(String num_solliq) {
		this.num_solliq = num_solliq;
	}
	public String getNum_terminal() {
		return num_terminal;
	}
	public void setNum_terminal(String num_terminal) {
		this.num_terminal = num_terminal;
	}
	public String getTip_terminal() {
		return tip_terminal;
	}
	public void setTip_terminal(String tip_terminal) {
		this.tip_terminal = tip_terminal;
	}
	public String getCod_estado_d() {
		return cod_estado_d;
	}
	public void setCod_estado_d(String cod_estado_d) {
		this.cod_estado_d = cod_estado_d;
	}
	public String getDes_causa() {
		return des_causa;
	}
	public void setDes_causa(String des_causa) {
		this.des_causa = des_causa;
	}
	public String getDes_estado_d() {
		return des_estado_d;
	}
	public void setDes_estado_d(String des_estado_d) {
		this.des_estado_d = des_estado_d;
	}
	public String getDes_terminal() {
		return des_terminal;
	}
	public void setDes_terminal(String des_terminal) {
		this.des_terminal = des_terminal;
	}
	public String getObs_detalle() {
		return obs_detalle;
	}
	public void setObs_detalle(String obs_detalle) {
		this.obs_detalle = obs_detalle;
	}
	public String getCodOoss() {
		return codOoss;
	}
	public void setCodOoss(String codOoss) {
		this.codOoss = codOoss;
	}
	public long getNumOoss() {
		return numOoss;
	}
	public void setNumOoss(long numOoss) {
		this.numOoss = numOoss;
	}
	public String getNumConstaPolAnula() {
		return numConstaPolAnula;
	}
	public void setNumConstaPolAnula(String numConstaPolAnula) {
		this.numConstaPolAnula = numConstaPolAnula;
	}
	public String getSrt_fec_anula() {
		return srt_fec_anula;
	}
	public void setSrt_fec_anula(String srt_fec_anula) {
		this.srt_fec_anula = srt_fec_anula;
	}

}
