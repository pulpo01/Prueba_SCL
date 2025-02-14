package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;
import java.util.Date;
public class ClientePrepagoDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	private Date sysDate;
	private long numCelular;
	private long codCliente; 
	private String nomCliente;
	private String nomApeClien1; 
	private String nomApeClien2; 
	private String numIdent; 
	private String codTipident;
	private String desNit;
	private String numIdent2; 
	private String codTipident2;
	private String desIdent2;	
	private Date fecNacimien; 
	private String codTecnologia; 
	private String numSerie; 
	private String numImei; 
	private long codArticulo;
	private String desEquipo;
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getCodTecnologia() {
		return codTecnologia;
	}
	public void setCodTecnologia(String codTecnologia) {
		this.codTecnologia = codTecnologia;
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
	public String getDesNit() {
		return desNit;
	}
	public void setDesNit(String desNit) {
		this.desNit = desNit;
	}
	public Date getFecNacimien() {
		return fecNacimien;
	}
	public void setFecNacimien(Date fecNacimien) {
		this.fecNacimien = fecNacimien;
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
	public long getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(long codArticulo) {
		this.codArticulo = codArticulo;
	}
	

	
	
	
	
	
}
