package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;

public class ModalidadPagoDTO implements Serializable{

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoModalidadPago;
	private String descripcionModalidadPago;
	private int indicadorCuotas;
	private long   cod_modventa;
	private String des_modventa;
	private long   ind_cuotas;
	private long   ind_pagado;
	private long   cod_caupago;
	private long   ind_abono;
	private MensajeRetornoDTO mensajeRetorno;

	public MensajeRetornoDTO getMensajeRetorno() {
		return mensajeRetorno;
	}
	public void setMensajeRetorno(MensajeRetornoDTO mensajeRetorno) {
		this.mensajeRetorno = mensajeRetorno;
	}
	
	public long getCod_caupago() {
		return cod_caupago;
	}
	public void setCod_caupago(long cod_caupago) {
		this.cod_caupago = cod_caupago;
	}
	public long getCod_modventa() {
		return cod_modventa;
	}
	public void setCod_modventa(long cod_modventa) {
		this.cod_modventa = cod_modventa;
	}
	public String getDes_modventa() {
		return des_modventa;
	}
	public void setDes_modventa(String des_modventa) {
		this.des_modventa = des_modventa;
	}
	public long getInd_abono() {
		return ind_abono;
	}
	public void setInd_abono(long ind_abono) {
		this.ind_abono = ind_abono;
	}
	public long getInd_cuotas() {
		return ind_cuotas;
	}
	public void setInd_cuotas(long ind_cuotas) {
		this.ind_cuotas = ind_cuotas;
	}
	public long getInd_pagado() {
		return ind_pagado;
	}
	public void setInd_pagado(long ind_pagado) {
		this.ind_pagado = ind_pagado;
	}
	public String getCodigoModalidadPago() {
		return codigoModalidadPago;
	}
	public void setCodigoModalidadPago(String codigoModalidadPago) {
		this.codigoModalidadPago = codigoModalidadPago;
	}
	public String getDescripcionModalidadPago() {
		return descripcionModalidadPago;
	}
	public void setDescripcionModalidadPago(String descripcionModalidadPago) {
		this.descripcionModalidadPago = descripcionModalidadPago;
	}
	public int getIndicadorCuotas() {
		return indicadorCuotas;
	}
	public void setIndicadorCuotas(int indicadorCuotas) {
		this.indicadorCuotas = indicadorCuotas;
	}
}


