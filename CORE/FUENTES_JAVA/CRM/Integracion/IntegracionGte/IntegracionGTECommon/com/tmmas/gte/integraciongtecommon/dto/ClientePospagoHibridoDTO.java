package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;
import java.util.Date;
public class ClientePospagoHibridoDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private Date sysDate;
	private long numCelular;
	private long codCliente; 
	private Date fecAlta; 
	private Date fecFincontra; 
	private String nomCliente;
	private String nomApeClien1; 
	private String nomApeClien2; 
	private String numIdent; 
	private String codTipident;
	private String desNit;
	private String numIdent2; 
	private String codTipident2;
	private String desIdent2;	
	private String numIdentapor; 
	private String codTipidentapor; 	
	private String desIdentApor;
	private Date fecNacimien; 
	private long codProfesion; 
	private String desProfesion;
	private String codOcupacion;
	private String desOcupacion;
	private String nomApoderado;
	private String indEstcivil;
	private String nacionalidad;
	private DireccionOutDTO[] lstDireccion;
	private String codTecnologia; 
	private String numSerie; 
	private String numImei; 
	private long codArticulo;
	private String desEquipo;
	private String desPlantarif;
	private String codTipCliente;
	private String tipCliente;
	private String tefCliente1;
	private String limitCredAsocTel;
	private String limitCredParaSms;
	
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodOcupacion() {
		return codOcupacion;
	}
	public void setCodOcupacion(String codOcupacion) {
		this.codOcupacion = codOcupacion;
	}
	public long getCodProfesion() {
		return codProfesion;
	}
	public void setCodProfesion(long codProfesion) {
		this.codProfesion = codProfesion;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
	}
	public String getCodTipCliente() {
		return codTipCliente;
	}
	public void setCodTipCliente(String codTipCliente) {
		this.codTipCliente = codTipCliente;
	}
	public String getCodTipident() {
		return codTipident;
	}
	public void setCodTipident(String codTipident) {
		this.codTipident = codTipident;
	}
	public String getCodTipident2() {
		return codTipident2;
	}
	public void setCodTipident2(String codTipident2) {
		this.codTipident2 = codTipident2;
	}
	public String getCodTipidentapor() {
		return codTipidentapor;
	}
	public void setCodTipidentapor(String codTipidentapor) {
		this.codTipidentapor = codTipidentapor;
	}
	public String getDesEquipo() {
		return desEquipo;
	}
	public void setDesEquipo(String desEquipo) {
		this.desEquipo = desEquipo;
	}
	public String getDesIdent2() {
		return desIdent2;
	}
	public void setDesIdent2(String desIdent2) {
		this.desIdent2 = desIdent2;
	}
	public String getDesIdentApor() {
		return desIdentApor;
	}
	public void setDesIdentApor(String desIdentApor) {
		this.desIdentApor = desIdentApor;
	}
	public String getDesNit() {
		return desNit;
	}
	public void setDesNit(String desNit) {
		this.desNit = desNit;
	}
	public String getDesOcupacion() {
		return desOcupacion;
	}
	public void setDesOcupacion(String desOcupacion) {
		this.desOcupacion = desOcupacion;
	}
	public String getDesPlantarif() {
		return desPlantarif;
	}
	public void setDesPlantarif(String desPlantarif) {
		this.desPlantarif = desPlantarif;
	}
	public String getDesProfesion() {
		return desProfesion;
	}
	public void setDesProfesion(String desProfesion) {
		this.desProfesion = desProfesion;
	}
	public Date getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Date fecAlta) {
		this.fecAlta = fecAlta;
	}
	public Date getFecFincontra() {
		return fecFincontra;
	}
	public void setFecFincontra(Date fecFincontra) {
		this.fecFincontra = fecFincontra;
	}
	public Date getFecNacimien() {
		return fecNacimien;
	}
	public void setFecNacimien(Date fecNacimien) {
		this.fecNacimien = fecNacimien;
	}
	public String getIndEstcivil() {
		return indEstcivil;
	}
	public void setIndEstcivil(String indEstcivil) {
		this.indEstcivil = indEstcivil;
	}
	public String getLimitCredAsocTel() {
		return limitCredAsocTel;
	}
	public void setLimitCredAsocTel(String limitCredAsocTel) {
		this.limitCredAsocTel = limitCredAsocTel;
	}
	public String getLimitCredParaSms() {
		return limitCredParaSms;
	}
	public void setLimitCredParaSms(String limitCredParaSms) {
		this.limitCredParaSms = limitCredParaSms;
	}

	public String getNacionalidad() {
		return nacionalidad;
	}
	public void setNacionalidad(String nacionalidad) {
		this.nacionalidad = nacionalidad;
	}
	public String getNomApeClien1() {
		return nomApeClien1;
	}
	public void setNomApeClien1(String nomApeClien1) {
		this.nomApeClien1 = nomApeClien1;
	}
	public String getNomApeClien2() {
		return nomApeClien2;
	}
	public void setNomApeClien2(String nomApeClien2) {
		this.nomApeClien2 = nomApeClien2;
	}
	public String getNomApoderado() {
		return nomApoderado;
	}
	public void setNomApoderado(String nomApoderado) {
		this.nomApoderado = nomApoderado;
	}
	public String getNomCliente() {
		return nomCliente;
	}
	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public String getNumIdent() {
		return numIdent;
	}
	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}
	public String getNumIdent2() {
		return numIdent2;
	}
	public void setNumIdent2(String numIdent2) {
		this.numIdent2 = numIdent2;
	}
	public String getNumIdentapor() {
		return numIdentapor;
	}
	public void setNumIdentapor(String numIdentapor) {
		this.numIdentapor = numIdentapor;
	}
	public String getNumImei() {
		return numImei;
	}
	public void setNumImei(String numImei) {
		this.numImei = numImei;
	}
	public String getNumSerie() {
		return numSerie;
	}
	public void setNumSerie(String numSerie) {
		this.numSerie = numSerie;
	}
	public Date getSysDate() {
		return sysDate;
	}
	public void setSysDate(Date sysDate) {
		this.sysDate = sysDate;
	}
	public String getTefCliente1() {
		return tefCliente1;
	}
	public void setTefCliente1(String tefCliente1) {
		this.tefCliente1 = tefCliente1;
	}
	public String getTipCliente() {
		return tipCliente;
	}
	public void setTipCliente(String tipCliente) {
		this.tipCliente = tipCliente;
	}
	public DireccionOutDTO[] getLstDireccion() {
		return lstDireccion;
	}
	public void setLstDireccion(DireccionOutDTO[] lstDireccion) {
		this.lstDireccion = lstDireccion;
	}
	public long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}
	
	
	
	
	
	
}
