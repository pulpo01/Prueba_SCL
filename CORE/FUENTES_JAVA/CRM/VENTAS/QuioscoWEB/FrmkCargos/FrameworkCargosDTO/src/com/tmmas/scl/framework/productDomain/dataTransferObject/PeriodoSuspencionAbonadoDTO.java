package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class PeriodoSuspencionAbonadoDTO implements Serializable {	
	  /**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long numPeriodoSus;
    private long num_abonado;
    private long cod_cliente;
  	private Date fechaInicio;
	private Date fechaFin;
   	private long diasAcumulados;
   	
   	
	public long getCod_cliente() {
		return cod_cliente;
	}
	public void setCod_cliente(long cod_cliente) {
		this.cod_cliente = cod_cliente;
	}
	public long getDiasAcumulados() {
		return diasAcumulados;
	}
	public void setDiasAcumulados(long diasAcumulados) {
		this.diasAcumulados = diasAcumulados;
	}
	public Date getFechaFin() {
		return fechaFin;
	}
	public void setFechaFin(Date fechaFin) {
		this.fechaFin = fechaFin;
	}
	public Date getFechaInicio() {
		return fechaInicio;
	}
	public void setFechaInicio(Date fechaInicio) {
		this.fechaInicio = fechaInicio;
	}
	public long getNum_abonado() {
		return num_abonado;
	}
	public void setNum_abonado(long num_abonado) {
		this.num_abonado = num_abonado;
	}
	public long getNumPeriodoSus() {
		return numPeriodoSus;
	}
	public void setNumPeriodoSus(long numPeriodoSus) {
		this.numPeriodoSus = numPeriodoSus;
	}
	  
}
