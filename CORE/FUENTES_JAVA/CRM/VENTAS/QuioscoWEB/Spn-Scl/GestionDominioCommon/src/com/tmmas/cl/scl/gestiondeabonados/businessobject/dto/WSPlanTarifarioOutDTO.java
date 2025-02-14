package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

public class WSPlanTarifarioOutDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String codigoPlantarif;     
	private String descripcionPlantarif;     
	private String codigoCargoBasico;   
	private String descripcionCargoBasico;   
    private Float  importeCargoBasico;   
    private Float  valorImpuesto;     
    private Float  total;
    private Float  impuesto;
    private String resultadoTransaccion="0";
	private String codError="0";
     
     
     
	public String getCodError() {
		return codError;
	}
	public void setCodError(String codError) {
		this.codError = codError;
	}
	public String getResultadoTransaccion() {
		return resultadoTransaccion;
	}
	public void setResultadoTransaccion(String resultadoTransaccion) {
		this.resultadoTransaccion = resultadoTransaccion;
	}
	public String getCodigoCargoBasico() {
		return codigoCargoBasico;
	}
	public void setCodigoCargoBasico(String codigoCargoBasico) {
		this.codigoCargoBasico = codigoCargoBasico;
	}
	public String getCodigoPlantarif() {
		return codigoPlantarif;
	}
	public void setCodigoPlantarif(String codigoPlantarif) {
		this.codigoPlantarif = codigoPlantarif;
	}
	public String getDescripcionCargoBasico() {
		return descripcionCargoBasico;
	}
	public void setDescripcionCargoBasico(String descripcionCargoBasico) {
		this.descripcionCargoBasico = descripcionCargoBasico;
	}
	public String getDescripcionPlantarif() {
		return descripcionPlantarif;
	}
	public void setDescripcionPlantarif(String descripcionPlantarif) {
		this.descripcionPlantarif = descripcionPlantarif;
	}
	public Float getImporteCargoBasico() {
		return importeCargoBasico;
	}
	public void setImporteCargoBasico(Float importeCargoBasico) {
		this.importeCargoBasico = importeCargoBasico;
	}
	public Float getImpuesto() {
		return impuesto;
	}
	public void setImpuesto(Float impuesto) {
		this.impuesto = impuesto;
	}
	public Float getTotal() {
		return total;
	}
	public void setTotal(Float total) {
		this.total = total;
	}
	public Float getValorImpuesto() {
		return valorImpuesto;
	}
	public void setValorImpuesto(Float valorImpuesto) {
		this.valorImpuesto = valorImpuesto;
	}
	
	
	

}
