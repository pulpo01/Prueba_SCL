package com.tmmas.gte.integraciongtecommon.dto;

import java.io.Serializable;

public class DetallePagoVistaClienteDTO implements Serializable {

	private static final long serialVersionUID = 1L;
    private long   numFolio;  
    private double   importeTotDoc; 
    private double	importeTotConcPagados;
    private double   saldoDocumento;
    private String   fechaEfectividad; 
    private String  horaEfectividad;
	private String recaudadora;             
	private String descripcionEmpresa;
	
	public String getDescripcionEmpresa() {
		return descripcionEmpresa;
	}
	public void setDescripcionEmpresa(String descripcionEmpresa) {
		this.descripcionEmpresa = descripcionEmpresa;
	}
	public String getFechaEfectividad() {
		return fechaEfectividad;
	}
	public void setFechaEfectividad(String fechaEfectividad) {
		this.fechaEfectividad = fechaEfectividad;
	}
	public String getHoraEfectividad() {
		return horaEfectividad;
	}
	public void setHoraEfectividad(String horaEfectividad) {
		this.horaEfectividad = horaEfectividad;
	}
	public double getImporteTotDoc() {
		return importeTotDoc;
	}
	public void setImporteTotDoc(double importeTotDoc) {
		this.importeTotDoc = importeTotDoc;
	}
	public long getNumFolio() {
		return numFolio;
	}
	public void setNumFolio(long numFolio) {
		this.numFolio = numFolio;
	}
	public String getRecaudadora() {
		return recaudadora;
	}
	public void setRecaudadora(String recaudadora) {
		this.recaudadora = recaudadora;
	}
	public double getSaldoDocumento() {
		return saldoDocumento;
	}
	public void setSaldoDocumento(double saldoDocumento) {
		this.saldoDocumento = saldoDocumento;
	}
	public double getImporteTotConcPagados() {
		return importeTotConcPagados;
	}
	public void setImporteTotConcPagados(double importeTotConcPagados) {
		this.importeTotConcPagados = importeTotConcPagados;
	}
	
}
