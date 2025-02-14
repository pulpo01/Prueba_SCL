package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class ConsumoOutDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String fechaCorteCiclo;
	private long  cantidadMensaje;
	private String tipoAbonado;
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getFechaCorteCiclo() {
		return fechaCorteCiclo;
	}
	public void setFechaCorteCiclo(String fechaCorteCiclo) {
		this.fechaCorteCiclo = fechaCorteCiclo;
	}
	public String getTipoAbonado() {
		return tipoAbonado;
	}
	public void setTipoAbonado(String tipoAbonado) {
		this.tipoAbonado = tipoAbonado;
	}
	public long getCantidadMensaje() {
		return cantidadMensaje;
	}
	public void setCantidadMensaje(long cantidadMensaje) {
		this.cantidadMensaje = cantidadMensaje;
	}

}
