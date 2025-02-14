package com.tmmas.gte.pagoonlinecommon.dto;

public class RespuestaPagoDTO implements java.io.Serializable{
	private static final long serialVersionUID = 1L;	
	private String tipoOperacion;
	private String status;
	private long numTelefonoCliente;
	private String nombreCliente;
	private String apellidosCliente;
	private double mtoSaldo;
	private int numTransaccion;
	
	private RespuestaDTO respuesta;
	
	public String getApellidosCliente() {
		return apellidosCliente;
	}
	public void setApellidosCliente(String apellidosCliente) {
		this.apellidosCliente = apellidosCliente;
	}
	public double getMtoSaldo() {
		return mtoSaldo;
	}
	public void setMtoSaldo(double mtoSaldo) {
		this.mtoSaldo = mtoSaldo;
	}
	public String getNombreCliente() {
		return nombreCliente;
	}
	public void setNombreCliente(String nombreCliente) {
		this.nombreCliente = nombreCliente;
	}
	public long getNumTelefonoCliente() {
		return numTelefonoCliente;
	}
	public void setNumTelefonoCliente(long numTelefonoCliente) {
		this.numTelefonoCliente = numTelefonoCliente;
	}
	public RespuestaDTO getRespuesta() {
		return respuesta;
	}
	public void setRespuesta(RespuestaDTO respuesta) {
		this.respuesta = respuesta;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getTipoOperacion() {
		return tipoOperacion;
	}
	public void setTipoOperacion(String tipoOperacion) {
		this.tipoOperacion = tipoOperacion;
	}	
	public int getNumTransaccion() {
		return numTransaccion;
	}
	public void setnumTransaccion(int numTransaccion) {
		this.numTransaccion = numTransaccion;
	}	
	
}