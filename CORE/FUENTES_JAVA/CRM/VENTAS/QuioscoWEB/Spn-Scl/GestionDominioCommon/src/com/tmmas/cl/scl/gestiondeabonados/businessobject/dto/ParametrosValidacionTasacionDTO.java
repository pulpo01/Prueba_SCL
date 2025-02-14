package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosValidacionDTO;


public class ParametrosValidacionTasacionDTO extends ParametrosValidacionDTO{
	private static final long serialVersionUID = 1L;
	private double totalImporteCargoBasico;
	
	public double getTotalImporteCargoBasico() {
		return totalImporteCargoBasico;
	}
	public void setTotalImporteCargoBasico(double totalImporteCargoBasico) {
		this.totalImporteCargoBasico = totalImporteCargoBasico;
	}
	
	public ParametrosValidacionTasacionDTO(ParametrosValidacionDTO parametrosValidacion){
		this.setCodigoBodega(parametrosValidacion.getCodigoBodega());
		this.setCodigoCliente(parametrosValidacion.getCodigoCliente());
		this.setCodigoModalidadVenta(parametrosValidacion.getCodigoModalidadVenta());
		this.setCodigoPlanTarifario(parametrosValidacion.getCodigoPlanTarifario());
		this.setCodigoProducto(parametrosValidacion.getCodigoProducto());
		this.setCodigoTecnologia(parametrosValidacion.getCodigoTecnologia());
		this.setCodigoVendedor(parametrosValidacion.getCodigoVendedor());
		this.setNumeroCelular(parametrosValidacion.getNumeroCelular());
		this.setNumeroIdentificador(parametrosValidacion.getNumeroIdentificador());
		this.setNumeroSerie(parametrosValidacion.getNumeroSerie());
		this.setNumeroSerieTerminal(parametrosValidacion.getNumeroSerieTerminal());
		this.setTipoIdentificador(parametrosValidacion.getTipoIdentificador());
		this.setTipoCliente(parametrosValidacion.getTipoCliente());
	}	
	
	public ParametrosValidacionTasacionDTO(){
	}
	


	
}
