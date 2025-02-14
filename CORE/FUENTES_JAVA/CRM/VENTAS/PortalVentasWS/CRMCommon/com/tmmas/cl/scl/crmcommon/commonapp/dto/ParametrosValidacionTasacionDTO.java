package com.tmmas.cl.scl.crmcommon.commonapp.dto;


public class ParametrosValidacionTasacionDTO extends ParametrosValidacionDTO{
	private static final long serialVersionUID = 1L;
	private double totalImporteCargoBasico;
	
	public double getTotalImporteCargoBasico() {
		return totalImporteCargoBasico;
	}
	public void setTotalImporteCargoBasico(double totalImporteCargoBasico) {
		this.totalImporteCargoBasico = totalImporteCargoBasico;
	}
	public ParametrosValidacionTasacionDTO(){
	}
	public ParametrosValidacionTasacionDTO(ParametrosValidacionDTO inicia){
		this.setCodigoBodega(inicia.getCodigoBodega());
		this.setCodigoCliente(inicia.getCodigoCliente());
		this.setCodigoModalidadVenta(inicia.getCodigoModalidadVenta());
		this.setCodigoPlanTarifario(inicia.getCodigoPlanTarifario());
		this.setCodigoProducto(inicia.getCodigoProducto());
		this.setCodigoTecnologia(inicia.getCodigoTecnologia());
		this.setCodigoVendedor(inicia.getCodigoVendedor());
		this.setNumeroCelular(inicia.getNumeroCelular());
		this.setNumeroIdentificador(inicia.getNumeroIdentificador());
		this.setNumeroSerie(inicia.getNumeroSerie());
		this.setNumeroSerieTerminal(inicia.getNumeroSerieTerminal());
		this.setTipoIdentificador(inicia.getTipoIdentificador());
		this.setTipoCliente(inicia.getTipoCliente());
		this.setTipoProducto(inicia.getTipoProducto());
	}

	
}
