package com.tmmas.scl.doblecuenta.commonapp.dto;

import java.io.Serializable;

public class ClienteDTO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String nomCliente;
	private String codTipIdent;
	private String numIdent;
	private long codCuenta;
	private long codCliente;
	private long codClienteContra;
	private long codClienteAsoc;
	private long codCiclo;
	private String nomApeClien1;
	private String nomApeClien2;
	private long numSecuencialCliente;
	private String tipoValor;
	
	public String getTipoValor() {
		return tipoValor;
	}
	public void setTipoValor(String tipoValor) {
		this.tipoValor = tipoValor;
	}
	public long getNumSecuencialCliente() {
		return numSecuencialCliente;
	}
	public void setNumSecuencialCliente(long numSecuencialCliente) {
		this.numSecuencialCliente = numSecuencialCliente;
	}
	public long getCodCuenta() {
		return codCuenta;
	}
	public void setCodCuenta(long codCuenta) {
		this.codCuenta = codCuenta;
	}
	public String getCodTipIdent() {
		return codTipIdent;
	}
	public void setCodTipIdent(String codTipIdent) {
		this.codTipIdent = codTipIdent;
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
	public void setNomApeClien2(String nomApeclien2) {
		this.nomApeClien2 = nomApeclien2;
	}
	public String getNomCliente() {
		return nomCliente;
	}
	public void setNomCliente(String nomCliente) {
		this.nomCliente = nomCliente;
	}
	
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public String getNumIdent() {
		return numIdent;
	}
	public void setNumIdent(String numIdent) {
		this.numIdent = numIdent;
	}
	public long getCodClienteContra() {
		return codClienteContra;
	}
	public void setCodClienteContra(long codClienteContra) {
		this.codClienteContra = codClienteContra;
	}
	public long getCodClienteAsoc() {
		return codClienteAsoc;
	}
	public void setCodClienteAsoc(long codClienteAsoc) {
		this.codClienteAsoc = codClienteAsoc;
	}
	public long getCodCiclo() {
		return codCiclo;
	}
	public void setCodCiclo(long codCiclo) {
		this.codCiclo = codCiclo;
	}

	
	
	
}
