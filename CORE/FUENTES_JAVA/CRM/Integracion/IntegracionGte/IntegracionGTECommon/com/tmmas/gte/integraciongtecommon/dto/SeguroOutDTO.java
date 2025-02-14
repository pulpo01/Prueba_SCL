package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.Date;

public class SeguroOutDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codSeguro;  
	private String desSeguro;   
	private long  numeroEventos; 
	private double importeEquipo;   
	private Date  fecAlta;   
	private Date fecFinContrato;
	private long numMaxen;
	private long tipCobertura;        
	private String desValor;
	private double deducible;
	private double impSegur;

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getCodSeguro() {
		return codSeguro;
	}
	public void setCodSeguro(String codSeguro) {
		this.codSeguro = codSeguro;
	}
	public double getDeducible() {
		return deducible;
	}
	public void setDeducible(double deducible) {
		this.deducible = deducible;
	}
	public String getDesSeguro() {
		return desSeguro;
	}
	public void setDesSeguro(String desSeguro) {
		this.desSeguro = desSeguro;
	}
	public String getDesValor() {
		return desValor;
	}
	public void setDesValor(String desValor) {
		this.desValor = desValor;
	}
	public Date getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(Date fecAlta) {
		this.fecAlta = fecAlta;
	}
	public Date getFecFinContrato() {
		return fecFinContrato;
	}
	public void setFecFinContrato(Date fecFinContrato) {
		this.fecFinContrato = fecFinContrato;
	}
	public double getImporteEquipo() {
		return importeEquipo;
	}
	public void setImporteEquipo(double importeEquipo) {
		this.importeEquipo = importeEquipo;
	}
	public double getImpSegur() {
		return impSegur;
	}
	public void setImpSegur(double impSegur) {
		this.impSegur = impSegur;
	}
	public long getNumeroEventos() {
		return numeroEventos;
	}
	public void setNumeroEventos(long numeroEventos) {
		this.numeroEventos = numeroEventos;
	}
	public long getNumMaxen() {
		return numMaxen;
	}
	public void setNumMaxen(long numMaxen) {
		this.numMaxen = numMaxen;
	}
	public long getTipCobertura() {
		return tipCobertura;
	}
	public void setTipCobertura(long tipCobertura) {
		this.tipCobertura = tipCobertura;
	}

	
}
