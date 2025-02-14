package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class WsArticuloStockInDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String codArticulo;
	private String codBodega;
	private String codVendedor;
	private String indInterno;
	private String reserva;//1:Reserva, 0: des-reserva
	private String portId;
	public String getCodArticulo() {
		return codArticulo;
	}
	public void setCodArticulo(String codArticulo) {
		this.codArticulo = codArticulo;
	}
	public String getCodBodega() {
		return codBodega;
	}
	public void setCodBodega(String codBodega) {
		this.codBodega = codBodega;
	}
	public String getCodVendedor() {
		return codVendedor;
	}
	public void setCodVendedor(String codVendedor) {
		this.codVendedor = codVendedor;
	}
	public String getIndInterno() {
		return indInterno;
	}
	public void setIndInterno(String indInterno) {
		this.indInterno = indInterno;
	}
	public String getPortId() {
		return portId;
	}
	public void setPortId(String portId) {
		this.portId = portId;
	}
	public String getReserva() {
		return reserva;
	}
	public void setReserva(String reserva) {
		this.reserva = reserva;
	}

}