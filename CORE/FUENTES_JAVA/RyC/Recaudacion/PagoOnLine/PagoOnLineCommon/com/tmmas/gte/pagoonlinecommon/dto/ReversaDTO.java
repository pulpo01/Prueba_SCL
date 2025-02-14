package com.tmmas.gte.pagoonlinecommon.dto;

public class ReversaDTO implements java.io.Serializable{
	private static final long serialVersionUID = 1L;	
	private String numTelefonoCliente;
	private String tipoOperacion;
	private String fecha;
	private String hora;
	private String codBanco;
	private double montoTotalOperacion;
	private String cajero;	
	private int numTransaccion;
	
	public String getCajero() {
		return cajero;
	}
	public void setCajero(String cajero) {
		this.cajero = cajero;
	}
	public String getCodBanco() {
		return codBanco;
	}
	public void setCodBanco(String codBanco) {
		this.codBanco = codBanco;
	}
	public String getFecha() {
		return fecha;
	}
	public void setFecha(String fecha) {
		this.fecha = fecha;
	}
	public String getHora() {
		return hora;
	}
	public void setHora(String hora) {
		this.hora = hora;
	}
	public double getMontoTotalOperacion() {
		return montoTotalOperacion;
	}
	public void setMontoTotalOperacion(double montoTotalOperacion) {
		this.montoTotalOperacion = montoTotalOperacion;
	}
	public String getNumTelefonoCliente() {
		return numTelefonoCliente;
	}
	public void setNumTelefonoCliente(String numTelefonoCliente) {
		this.numTelefonoCliente = numTelefonoCliente;
	}
	public int getNumTransaccion() {
		return numTransaccion;
	}
	public void setNumTransaccion(int numTransaccion) {
		this.numTransaccion = numTransaccion;
	}
	public String getTipoOperacion() {
		return tipoOperacion;
	}
	public void setTipoOperacion(String tipoOperacion) {
		this.tipoOperacion = tipoOperacion;
	}
}
