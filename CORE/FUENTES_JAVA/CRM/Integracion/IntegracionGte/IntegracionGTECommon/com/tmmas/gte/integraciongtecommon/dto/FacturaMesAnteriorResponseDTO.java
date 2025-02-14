package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.Date;

public class FacturaMesAnteriorResponseDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private String mesFactura;
	private long saldoEntero;
	private double saldoDecimal;
	private long saldoTotalEntero;
	private double saldoTotalDecimal;
	private Date fechaCorte;
	private Date fechaCancelacion;
	private RespuestaDTO respuesta;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public Date getFechaCorte() {
		return fechaCorte;
	}
	public void setFechaCorte(Date fechaCorte) {
		this.fechaCorte = fechaCorte;
	}
	public String getMesFactura() {
		return mesFactura;
	}
	public void setMesFactura(String mesFactura) {
		this.mesFactura = mesFactura;
	}
	public double getSaldoDecimal() {
		return saldoDecimal;
	}
	public void setSaldoDecimal(double saldoDecimal) {
		this.saldoDecimal = saldoDecimal;
	}
	public long getSaldoEntero() {
		return saldoEntero;
	}
	public void setSaldoEntero(long saldoEntero) {
		this.saldoEntero = saldoEntero;
	}
	public double getSaldoTotalDecimal() {
		return saldoTotalDecimal;
	}
	public void setSaldoTotalDecimal(double saldoTotalDecimal) {
		this.saldoTotalDecimal = saldoTotalDecimal;
	}
	public long getSaldoTotalEntero() {
		return saldoTotalEntero;
	}
	public void setSaldoTotalEntero(long saldoTotalEntero) {
		this.saldoTotalEntero = saldoTotalEntero;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public Date getFechaCancelacion() {
		return fechaCancelacion;
	}
	public void setFechaCancelacion(Date fechaCancelacion) {
		this.fechaCancelacion = fechaCancelacion;
	}

}
