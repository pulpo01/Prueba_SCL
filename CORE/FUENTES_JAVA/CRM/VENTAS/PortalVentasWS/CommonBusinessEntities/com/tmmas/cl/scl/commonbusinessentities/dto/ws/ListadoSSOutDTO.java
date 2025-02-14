package com.tmmas.cl.scl.commonbusinessentities.dto.ws;

import java.io.Serializable;

public class ListadoSSOutDTO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String codigoServicio;

	private String descripServicio;

	private String indSS;

	private String codigoGrupo;

	private String codigoNivel;

	private String tarifaConexion;

	private String monedaConexion;

	private String tarifaMensual;

	private String monedaMensual;

	private String indIP;

	private String tipoRed;

	private String tipoCobro;

	public String getTipoCobro() {
		return tipoCobro;
	}

	public void setTipoCobro(String tipoCobro) {
		this.tipoCobro = tipoCobro;
	}

	public String getTipoRed() {
		return tipoRed;
	}

	public void setTipoRed(String tipoRed) {
		this.tipoRed = tipoRed;
	}

	public String getCodigoGrupo() {
		return codigoGrupo;
	}

	public void setCodigoGrupo(String codigoGrupo) {
		this.codigoGrupo = codigoGrupo;
	}

	public String getCodigoNivel() {
		return codigoNivel;
	}

	public void setCodigoNivel(String codigoNivel) {
		this.codigoNivel = codigoNivel;
	}

	public String getIndSS() {
		return indSS;
	}

	public void setIndSS(String indSS) {
		this.indSS = indSS;
	}

	public String getCodigoServicio() {
		return codigoServicio;
	}

	public void setCodigoServicio(String codigoServicio) {
		this.codigoServicio = codigoServicio;
	}

	public String getDescripServicio() {
		return descripServicio;
	}

	public void setDescripServicio(String descripServicio) {
		this.descripServicio = descripServicio;
	}

	public String getMonedaConexion() {
		return monedaConexion;
	}

	public void setMonedaConexion(String monedaConexion) {
		this.monedaConexion = monedaConexion;
	}

	public String getMonedaMensual() {
		return monedaMensual;
	}

	public void setMonedaMensual(String monedaMensual) {
		this.monedaMensual = monedaMensual;
	}

	public String getTarifaConexion() {
		return tarifaConexion;
	}

	public void setTarifaConexion(String tarifaConexion) {
		this.tarifaConexion = tarifaConexion;
	}

	public String getTarifaMensual() {
		return tarifaMensual;
	}

	public void setTarifaMensual(String tarifaMensual) {
		this.tarifaMensual = tarifaMensual;
	}

	public String getIndIP() {
		return indIP;
	}

	public void setIndIP(String indIP) {
		this.indIP = indIP;
	}

	/**
	 * Constructs a <code>String</code> with all attributes in name = value format.
	 * 
	 * @return a <code>String</code> representation of this object.
	 */
	public String toString() {
		final String newLine = "\n";
		StringBuffer b = new StringBuffer();
		b.append("ListadoSSOutDTO ( ").append(super.toString()).append(newLine).append("codigoGrupo = ").append(
				this.codigoGrupo).append(newLine).append("codigoNivel = ").append(this.codigoNivel).append(newLine)
				.append("codigoServicio = ").append(this.codigoServicio).append(newLine).append("descripServicio = ")
				.append(this.descripServicio).append(newLine).append("indIP = ").append(this.indIP).append(newLine)
				.append("indSS = ").append(this.indSS).append(newLine).append("monedaConexion = ").append(
						this.monedaConexion).append(newLine).append("monedaMensual = ").append(this.monedaMensual)
				.append(newLine).append("tarifaConexion = ").append(this.tarifaConexion).append(newLine).append(
						"tarifaMensual = ").append(this.tarifaMensual).append(newLine).append("tipoCobro = ").append(
						this.tipoCobro).append(newLine).append("tipoRed = ").append(this.tipoRed).append(newLine)
				.append(" )");
		return b.toString();
	}

}
