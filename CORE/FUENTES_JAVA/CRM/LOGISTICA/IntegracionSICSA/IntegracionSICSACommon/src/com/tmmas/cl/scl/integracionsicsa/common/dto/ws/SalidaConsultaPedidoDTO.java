package com.tmmas.cl.scl.integracionsicsa.common.dto.ws;

import java.io.Serializable;

import com.tmmas.cl.scl.integracionsicsa.common.dto.SerieErrorDTO;

public class SalidaConsultaPedidoDTO extends SalidaIntegracionSICSADTO implements Serializable{
	/**
     * 
     */
	private static final long serialVersionUID = 1L;
	
	private String codPedido;
	private String codEstado;
	private String desEstado;
	private String validacionOk;
	private SerieErrorDTO[] seriesError;
	
	public String getValidacionOk() {
		return validacionOk;
	}
	public void setValidacionOk(String validacionOk) {
		this.validacionOk = validacionOk;
	}
	public SerieErrorDTO[] getSeriesError() {
		return seriesError;
	}
	public void setSeriesError(SerieErrorDTO[] seriesError) {
		this.seriesError = seriesError;
	}
	public String getCodPedido() {
		return codPedido;
	}
	public void setCodPedido(String codPedido) {
		this.codPedido = codPedido;
	}
	public String getCodEstado() {
		return codEstado;
	}
	public void setCodEstado(String codEstado) {
		this.codEstado = codEstado;
	}
	public String getDesEstado() {
		return desEstado;
	}
	public void setDesEstado(String desEstado) {
		this.desEstado = desEstado;
	}	
}
