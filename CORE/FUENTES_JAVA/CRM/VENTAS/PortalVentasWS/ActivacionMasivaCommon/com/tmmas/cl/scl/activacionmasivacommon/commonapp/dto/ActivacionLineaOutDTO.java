package com.tmmas.cl.scl.activacionmasivacommon.commonapp.dto;

import java.io.Serializable;

public class ActivacionLineaOutDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String numero_transaccion;
	private String codCliente;
	private String numCelular;
	private Long numAbonado;
	private String valorFactura;
	private String numVenta;
	private String codPlanTarif;
	private String imei;
	private String icc;
	private int cod_ciclo;
	
	//P-CSR-11002 JLGN 24-04-2011
	private long numMovimiento;
	
	private Long codError;
	private String msgError;
	private Long codEvento;
	 
	public Long getCodError() {
		return codError;
	}

	public void setCodError(Long codError) {
		this.codError = codError;
	}

	public String getNumero_transaccion() {
		return numero_transaccion;
	}

	public void setNumero_transaccion(String numero_transaccion) {
		this.numero_transaccion = numero_transaccion;
	}

	public Long getCodEvento() {
		return codEvento;
	}

	public void setCodEvento(Long codEvento) {
		this.codEvento = codEvento;
	}

	public String getMsgError() {
		return msgError;
	}

	public void setMsgError(String msgError) {
		this.msgError = msgError;
	}

	public String getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(String codCliente) {
		this.codCliente = codCliente;
	}

	public String getCodPlanTarif() {
		return codPlanTarif;
	}

	public void setCodPlanTarif(String codPlanTarif) {
		this.codPlanTarif = codPlanTarif;
	}

	public String getIcc() {
		return icc;
	}

	public void setIcc(String icc) {
		this.icc = icc;
	}

	public String getImei() {
		return imei;
	}

	public void setImei(String imei) {
		this.imei = imei;
	}

	public Long getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(Long numAbonado) {
		this.numAbonado = numAbonado;
	}

	public String getNumCelular() {
		return numCelular;
	}

	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}

	public String getNumVenta() {
		return numVenta;
	}

	public void setNumVenta(String numVenta) {
		this.numVenta = numVenta;
	}

	public String getValorFactura() {
		return valorFactura;
	}

	public void setValorFactura(String valorFactura) {
		this.valorFactura = valorFactura;
	}

	public int getCod_ciclo() {
		return cod_ciclo;
	}

	public void setCod_ciclo(int cod_ciclo) {
		this.cod_ciclo = cod_ciclo;
	}

	public long getNumMovimiento() {
		return numMovimiento;
	}

	public void setNumMovimiento(long numMovimiento) {
		this.numMovimiento = numMovimiento;
	}	
}
