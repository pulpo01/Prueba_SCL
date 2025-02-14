package com.tmmas.scl.framework.customerDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class PenalizacionDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private long numAbonado;
	private Date fecFinContrato;
	private int modalidadPago;
	private String tipoIndemizacion;
	private long codPenalizacion;
	private String afectoIndemiza;
	
	public String getAfectoIndemiza() {
		return afectoIndemiza;
	}
	public void setAfectoIndemiza(String afectoIndemiza) {
		this.afectoIndemiza = afectoIndemiza;
	}
	public long getCodPenalizacion() {
		return codPenalizacion;
	}
	public void setCodPenalizacion(long codPenalizacion) {
		this.codPenalizacion = codPenalizacion;
	}
	public Date getFecFinContrato() {
		return fecFinContrato;
	}
	public void setFecFinContrato(Date fecFinContrato) {
		this.fecFinContrato = fecFinContrato;
	}
	public int getModalidadPago() {
		return modalidadPago;
	}
	public void setModalidadPago(int modalidadPago) {
		this.modalidadPago = modalidadPago;
	}
	public long getNumAbonado() {
		return numAbonado;
	}
	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}
	public String getTipoIndemizacion() {
		return tipoIndemizacion;
	}
	public void setTipoIndemizacion(String tipoIndemizacion) {
		this.tipoIndemizacion = tipoIndemizacion;
	}
	
	
	

}
