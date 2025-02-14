package com.tmmas.scl.doblecuenta.commonapp.dto;

import java.io.Serializable;

public class ClientesAsociadosDTO implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private ClienteDTO cliente;
	private AbonadoDTO abonado;
	private ConceptoDTO concepto;
	private FacturaDTO factura;
	
	public FacturaDTO getFactura() {
		return factura;
	}
	public void setFactura(FacturaDTO factura) {
		this.factura = factura;
	}
	public AbonadoDTO getAbonado() {
		return abonado;
	}
	public void setAbonado(AbonadoDTO abonado) {
		this.abonado = abonado;
	}
	public ClienteDTO getCliente() {
		return cliente;
	}
	public void setCliente(ClienteDTO cliente) {
		this.cliente = cliente;
	}
	public ConceptoDTO getConcepto() {
		return concepto;
	}
	public void setConcepto(ConceptoDTO concepto) {
		this.concepto = concepto;
	}
	
	
}
