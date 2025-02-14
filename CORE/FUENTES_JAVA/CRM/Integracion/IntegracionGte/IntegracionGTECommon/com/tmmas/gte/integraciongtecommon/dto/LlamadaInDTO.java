package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class LlamadaInDTO  implements Serializable {
	/*
	 * Autor: Juan Daniel Muñoz Queupul
	 * */
	
	private static final long serialVersionUID = 1L;
	private long codCliente;   
	private long numAbonado;   
	private String numCelular; 
	private long codCiclo;     
	private String fecTasa;    
	private String fecDesde;   
	private String fecHasta;   
	private double impuesto;   

	
	public double getImpuesto() {
		return impuesto;
	}

	public void setImpuesto(double impuesto) {
		this.impuesto = impuesto;
	}

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public long getCodCiclo() {
		return codCiclo;
	}

	public void setCodCiclo(long codCiclo) {
		this.codCiclo = codCiclo;
	}

	public long getCodCliente() {
		return codCliente;
	}

	public void setCodCliente(long codCliente) {
		this.codCliente = codCliente;
	}

	public String getFecDesde() {
		return fecDesde;
	}

	public void setFecDesde(String fecDesde) {
		this.fecDesde = fecDesde;
	}

	public String getFecHasta() {
		return fecHasta;
	}

	public void setFecHasta(String fecHasta) {
		this.fecHasta = fecHasta;
	}

	public String getFecTasa() {
		return fecTasa;
	}

	public void setFecTasa(String fecTasa) {
		this.fecTasa = fecTasa;
	}

	public long getNumAbonado() {
		return numAbonado;
	}

	public void setNumAbonado(long numAbonado) {
		this.numAbonado = numAbonado;
	}

	public String getNumCelular() {
		return numCelular;
	}

	public void setNumCelular(String numCelular) {
		this.numCelular = numCelular;
	}



}