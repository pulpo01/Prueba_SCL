package com.tmmas.gte.integraciongtecommon.dto;
 
import java.io.Serializable;

public class RespTipoClienteDTO implements Serializable{
	/**
	 * Autor : Leonardo Muñoz R.
	 * Modificado: Juan Daniel Muñoz Queupul.
	 */
	private static final long serialVersionUID = 1L;
	private long codCliente;
	private String codTipo;
	private String tipCliente;
	private RespuestaDTO respuesta;
	
	public long getCodCliente() {
		return codCliente;
	}
	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public String getTipCliente() {
		return tipCliente;
	}
	public void setTipCliente(String tipCliente) {
		this.tipCliente = tipCliente;
	}
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getCodTipo() {
		return codTipo;
	}
	public void setCodTipo(String codTipo) {
		this.codTipo = codTipo;
	}
	
	

}
