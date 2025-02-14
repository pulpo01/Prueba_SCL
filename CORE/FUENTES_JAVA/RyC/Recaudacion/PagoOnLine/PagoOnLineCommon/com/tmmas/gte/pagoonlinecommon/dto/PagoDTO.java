package com.tmmas.gte.pagoonlinecommon.dto;

public class PagoDTO implements java.io.Serializable{
	private static final long serialVersionUID = 1L;
	private String codBanco;
	private String numTelefonoCliente;
	private String Agencia;
	private String cajero;
	private String tipoOperacion;
	private String fecha;
	private String hora;
	private double numFactura;
	private long telefono;
	private int numBoleta;
	private double montoEfectivo;
	private double montoChequeBanco;
	private double montoChequeOtroBanco;
	private int numCheque;
	private double montoTotalOperacion;
	private String numTarjeta;
	private String tipTarjeta;
	private String numAutorizacion;
	private double montoTarjetaCredito;
	private String bancoTarjetaDebito;
	private double montoTarjetaDebito;
	
	public String getAgencia() {
		return Agencia;
	}
	public void setAgencia(String agencia) {
		Agencia = agencia;
	}
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
	public double getMontoChequeBanco() {
		return montoChequeBanco;
	}
	public void setMontoChequeBanco(double montoChequeBanco) {
		this.montoChequeBanco = montoChequeBanco;
	}
	public double getMontoChequeOtroBanco() {
		return montoChequeOtroBanco;
	}
	public void setMontoChequeOtroBanco(double montoChequeOtroBanco) {
		this.montoChequeOtroBanco = montoChequeOtroBanco;
	}
	public double getMontoEfectivo() {
		return montoEfectivo;
	}
	public void setMontoEfectivo(double montoEfectivo) {
		this.montoEfectivo = montoEfectivo;
	}
	public double getMontoTotalOperacion() {
		return montoTotalOperacion;
	}
	public void setMontoTotalOperacion(double montoTotalOperacion) {
		this.montoTotalOperacion = montoTotalOperacion;
	}
	public int getNumBoleta() {
		return numBoleta;
	}
	public void setNumBoleta(int numBoleta) {
		this.numBoleta = numBoleta;
	}
	public int getNumCheque() {
		return numCheque;
	}
	public void setNumCheque(int numCheque) {
		this.numCheque = numCheque;
	}
	public double getNumFactura() {
		return numFactura;
	}
	public void setNumFactura(double numFactura) {
		this.numFactura = numFactura;
	}
	public String getNumTelefonoCliente() {
		return numTelefonoCliente;
	}
	public void setNumTelefonoCliente(String numTelefonoCliente) {
		this.numTelefonoCliente = numTelefonoCliente;
	}
	public long getTelefono() {
		return telefono;
	}
	public void setTelefono(long telefono) {
		this.telefono = telefono;
	}
	public String getTipoOperacion() {
		return tipoOperacion;
	}
	public void setTipoOperacion(String tipoOperacion) {
		this.tipoOperacion = tipoOperacion;
	}
	public String getBancoTarjetaDebito() {
		return bancoTarjetaDebito;
	}
	public void setBancoTarjetaDebito(String bancoTarjetaDebito) {
		this.bancoTarjetaDebito = bancoTarjetaDebito;
	}
	public double getMontoTarjetaCredito() {
		return montoTarjetaCredito;
	}
	public void setMontoTarjetaCredito(double montoTarjetaCredito) {
		this.montoTarjetaCredito = montoTarjetaCredito;
	}
	public double getMontoTarjetaDebito() {
		return montoTarjetaDebito;
	}
	public void setMontoTarjetaDebito(double montoTarjetaDebito) {
		this.montoTarjetaDebito = montoTarjetaDebito;
	}
	public String getNumAutorizacion() {
		return numAutorizacion;
	}
	public void setNumAutorizacion(String numAutorizacion) {
		this.numAutorizacion = numAutorizacion;
	}
	public String getNumTarjeta() {
		return numTarjeta;
	}
	public void setNumTarjeta(String numTarjeta) {
		this.numTarjeta = numTarjeta;
	}
	public String getTipTarjeta() {
		return tipTarjeta;
	}
	public void setTipTarjeta(String tipTarjeta) {
		this.tipTarjeta = tipTarjeta;
	}	
	
}


