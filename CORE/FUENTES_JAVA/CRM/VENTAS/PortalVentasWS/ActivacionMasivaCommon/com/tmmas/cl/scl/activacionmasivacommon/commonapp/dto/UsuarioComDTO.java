package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;

public class UsuarioComDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String usuario;
	private String clave;
	private boolean resultadoValidacion;
	private String mensajeValidacion;
	private String motivoError;
	private int contadorConexionFallida;
	private long codigoVendedor;
	private String codigoOficina;
	private String descripcionOperadora;
	
	public String getDescripcionOperadora() {
		return descripcionOperadora;
	}
	public void setDescripcionOperadora(String descripcionOperadora) {
		this.descripcionOperadora = descripcionOperadora;
	}
	public String getClave() {
		return clave;
	}
	public void setClave(String clave) {
		this.clave = clave;
	}
	public String getUsuario() {
		return usuario;
	}
	public void setUsuario(String usuario) {
		this.usuario = usuario;
	}
	public String getMensajeValidacion() {
		return mensajeValidacion;
	}
	public void setMensajeValidacion(String mensajeValidacion) {
		this.mensajeValidacion = mensajeValidacion;
	}
	public boolean getResultadoValidacion() {
		return resultadoValidacion;
	}
	public void setResultadoValidacion(boolean resultadoValidacion) {
		this.resultadoValidacion = resultadoValidacion;
	}
	public String getMotivoError() {
		return motivoError;
	}
	public void setMotivoError(String motivoError) {
		this.motivoError = motivoError;
	}
	public int getContadorConexionFallida() {
		return contadorConexionFallida;
	}
	public void incrementarContadorConexionFallida() {
		this.contadorConexionFallida++; 
	}
	public long getCodigoVendedor() {
		return codigoVendedor;
	}
	public void setCodigoVendedor(long codigoVendedor) {
		this.codigoVendedor = codigoVendedor;
	}
	public String getCodigoOficina() {
		return codigoOficina;
	}
	public void setCodigoOficina(String codigoOficina) {
		this.codigoOficina = codigoOficina;
	}
	
}

