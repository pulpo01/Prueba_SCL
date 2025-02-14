package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class ConsultarTipoAbonadoResponseDTO implements Serializable{
	/**
	 * Autor : Leonardo Muñoz R.
	 */
	private static final long serialVersionUID = 1L;
	private String tipAbonado;
	private String codPrestacion;
	private String desPrestacion;
	private String tipProducto;
	private RespuestaDTO respuesta;
	
	public String getTipAbonado() {
		return tipAbonado;
	}
	public void setTipAbonado(String tipAbonado) {
		this.tipAbonado = tipAbonado;
	}
	public String getCodPrestacion() {
		return codPrestacion;
	}
	public void setCodPrestacion(String codPrestacion) {
		this.codPrestacion = codPrestacion;
	}
	public String getDesPrestacion() {
		return desPrestacion;
	}
	public void setDesPrestacion(String desPrestacion) {
		this.desPrestacion = desPrestacion;
	}
	public String getTipProducto() {
		return tipProducto;
	}
	public void setTipProducto(String tipProducto) {
		this.tipProducto = tipProducto;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
}
