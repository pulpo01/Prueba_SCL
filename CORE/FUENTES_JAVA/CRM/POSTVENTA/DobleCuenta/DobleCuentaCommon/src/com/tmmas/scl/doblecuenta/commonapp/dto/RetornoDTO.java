package com.tmmas.scl.doblecuenta.commonapp.dto;

import java.io.Serializable;

public class RetornoDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String codigo;
	private String descripcion;
	private long numSecEncabezadoFd;
	private long numSecDetalleFd;
	private boolean resultado;
	

	public boolean isResultado() {
		return resultado;
	}
	public void setResultado(boolean resultado) {
		this.resultado = resultado;
	}
	public String getCodigo() {
		return codigo;
	}
	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}
	public String getDescripcion() {
		return descripcion;
	}
	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}
	public long getNumSecEncabezadoFd() {
		return numSecEncabezadoFd;
	}
	public void setNumSecEncabezadoFd(long numSecEncabezadoFd) {
		this.numSecEncabezadoFd = numSecEncabezadoFd;
	}
	public long getNumSecDetalleFd() {
		return numSecDetalleFd;
	}
	public void setNumSecDetalleFd(long numSecDetalleFd) {
		this.numSecDetalleFd = numSecDetalleFd;
	}
	
}

