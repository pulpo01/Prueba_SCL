package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class CausaCamSerieDTO implements Serializable {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String  cod_caucaser;
	private String  des_caucaser;
	private long ind_antiguedad;
	private long ind_cargo;
	private long ind_dev_almacen;
	private long cod_estado_dev;
	private MensajeRetornoDTO mensajeRetorno;
	private int indSeguro;
	protected long numeroVenta;

	
	public long getNumeroVenta() {
		return numeroVenta;
	}
	public void setNumeroVenta(long numeroVenta) {
		this.numeroVenta = numeroVenta;
	}
	public String getCod_caucaser() {
		return cod_caucaser;
	}
	public void setCod_caucaser(String cod_caucaser) {
		this.cod_caucaser = cod_caucaser;
	}
	public long getCod_estado_dev() {
		return cod_estado_dev;
	}
	public void setCod_estado_dev(long cod_estado_dev) {
		this.cod_estado_dev = cod_estado_dev;
	}
	public String getDes_caucaser() {
		return des_caucaser;
	}
	public void setDes_caucaser(String des_caucaser) {
		this.des_caucaser = des_caucaser;
	}
	public long getInd_antiguedad() {
		return ind_antiguedad;
	}
	public void setInd_antiguedad(long ind_antiguedad) {
		this.ind_antiguedad = ind_antiguedad;
	}
	public long getInd_cargo() {
		return ind_cargo;
	}
	public void setInd_cargo(long ind_cargo) {
		this.ind_cargo = ind_cargo;
	}
	public long getInd_dev_almacen() {
		return ind_dev_almacen;
	}
	public void setInd_dev_almacen(long ind_dev_almacen) {
		this.ind_dev_almacen = ind_dev_almacen;
	}
	public MensajeRetornoDTO getMensajeRetorno() {
		return mensajeRetorno;
	}
	public void setMensajeRetorno(MensajeRetornoDTO mensajeRetorno) {
		this.mensajeRetorno = mensajeRetorno;
	}
	public int getIndSeguro() {
		return indSeguro;
	}
	public void setIndSeguro(int indSeguro) {
		this.indSeguro = indSeguro;
	}
	
}
