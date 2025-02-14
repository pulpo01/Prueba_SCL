package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;
import java.util.Date;
public class ClienteOutDTO implements Serializable {

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
	private String codTipCliente;
	private String tipCliente;
	private String tefCliente1;
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
	public String getCodTipidentapor() {
		return codTipidentapor;
	}
	public void setCodTipidentapor(String codTipidentapor) {
		this.codTipidentapor = codTipidentapor;
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
	public String getDesProfesion() {
		return desProfesion;
	}
	public void setDesProfesion(String desProfesion) {
		this.desProfesion = desProfesion;
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
	public DireccionOutDTO[] getLstDireccion() {
		return lstDireccion;
	}
	public void setLstDireccion(DireccionOutDTO[] lstDireccion) {
		this.lstDireccion = lstDireccion;
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
	public String getNumIdentapor() {
		return numIdentapor;
	}
	public void setNumIdentapor(String numIdentapor) {
		this.numIdentapor = numIdentapor;
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

	
	
	
	
	
	
	
	
}
