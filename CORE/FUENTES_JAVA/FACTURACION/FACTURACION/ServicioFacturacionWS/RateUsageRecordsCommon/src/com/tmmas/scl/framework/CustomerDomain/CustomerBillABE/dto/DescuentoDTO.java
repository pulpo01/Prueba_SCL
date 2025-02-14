package com.tmmas.scl.framework.CustomerDomain.CustomerBillABE.dto;

import java.io.Serializable;

public class DescuentoDTO implements Serializable {
	private String tipoMonto;
	private String codigoConceptoDescuento;
	private String importeDescuento;//cargo
	public String getCodigoConceptoDescuento() {
		return codigoConceptoDescuento;
	}
	public void setCodigoConceptoDescuento(String codigoConceptoDescuento) {
		this.codigoConceptoDescuento = codigoConceptoDescuento;
	}
	public String getImporteDescuento() {
		return importeDescuento;
	}
	public void setImporteDescuento(String importeDescuento) {
		this.importeDescuento = importeDescuento;
	}
	public String getTipoMonto() {
		return tipoMonto;
	}
	public void setTipoMonto(String tipoMonto) {
		this.tipoMonto = tipoMonto;
	}
}
