package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class ParametrosAnulacionVentaDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long codCliente;
	private long numAbonado;
	private String tipAbonado;
	private String claseServ;
	private String codCausaBaja;
	private String codActabo;
	private String usuario;
	private long mnd;
	private long uso;
	
	
	public String getClaseServ() {
		return claseServ;
	}
	public void setClaseServ(String claseServ) {
		this.claseServ = claseServ;
	}
	public String getCodActabo() {
		return codActabo;
	}
	public void setCodActabo(String codActabo) {
		this.codActabo = codActabo;
	}
	public String getCodCausaBaja() {
		return codCausaBaja;
	}
	public void setCodCausaBaja(String codCausaBaja) {
		this.codCausaBaja = codCausaBaja;
	}
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public long getMnd() {
		return mnd;
	}
	public void setMnd(long mnd) {
		this.mnd = mnd;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getTipAbonado() {
		return tipAbonado;
	}
	public void setTipAbonado(String tipAbonado) {
		this.tipAbonado = tipAbonado;
	}
	public long getUso() {
		return uso;
	}
	public void setUso(long uso) {
		this.uso = uso;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	

}
