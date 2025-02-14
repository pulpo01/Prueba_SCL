package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;
import java.util.Date;

public class WsClienteIdentOutDTO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private long codCliente;
	private long codCuenta;
	private String nomCliente;
	private String nomApeClien1;
	private String nomApeClien2;
	private String fecAlta;
	private String usoCliente;
	private String codPlanTarif;
	private int codCategoria;
	
	
	private String indDebito;	
	private String indTipcuenta;
	private String codBanco;
    private String desBanco;
    private String numCtaCte;
    private String codTipotarjeta;
    private String desTipoTarjeta;
    private String numeroTarjeta;
    private Date fechaVencimientoTarjeta;
	
	
	
	
	
	
	
	
	public String getCodBanco() {
		return codBanco;
	}
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}
	public String getCodTipotarjeta() {
		return codTipotarjeta;
	}
	public void setCodTipotarjeta(String codTipotarjeta) {
		this.codTipotarjeta = codTipotarjeta;
	}
	public String getDesBanco() {
		return desBanco;
	}
	public void setDesBanco(String desBanco) {
		this.desBanco = desBanco;
	}
	public String getDesTipoTarjeta() {
		return desTipoTarjeta;
	}
	public void setDesTipoTarjeta(String desTipoTarjeta) {
		this.desTipoTarjeta = desTipoTarjeta;
	}
	public Date getFechaVencimientoTarjeta() {
		return fechaVencimientoTarjeta;
	}
	public void setFechaVencimientoTarjeta(Date fechaVencimientoTarjeta) {
		this.fechaVencimientoTarjeta = fechaVencimientoTarjeta;
	}
	public String getIndDebito() {
		return indDebito;
	}
	public void setIndDebito(String indDebito) {
		this.indDebito = indDebito;
	}
	public String getIndTipcuenta() {
		return indTipcuenta;
	}
	public void setIndTipcuenta(String indTipcuenta) {
		this.indTipcuenta = indTipcuenta;
	}
	public String getNumCtaCte() {
		return numCtaCte;
	}
	public void setNumCtaCte(String numCtaCte) {
		this.numCtaCte = numCtaCte;
	}
	public String getNumeroTarjeta() {
		return numeroTarjeta;
	}
	public void setNumeroTarjeta(String numeroTarjeta) {
		this.numeroTarjeta = numeroTarjeta;
	}
	public int getCodCategoria() {
		return codCategoria;
	}
	public void setCodCategoria(int codCategoria) {
		this.codCategoria = codCategoria;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}
	public String getCodPlanTarif() {
		return codPlanTarif;
	}
	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}
	public String getFecAlta() {
		return fecAlta;
	}
	public void setFecAlta(String fecAlta) {
		this.fecAlta = fecAlta;
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
	public String getUsoCliente() {
		return usoCliente;
	}
	public void setUsoCliente(String usoCliente) {
		this.usoCliente = usoCliente;
	}
}
