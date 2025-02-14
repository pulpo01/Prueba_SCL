package com.tmmas.cl.scl.productdomain.businessobject.dto;
import java.io.Serializable;

public class NumeroPilotoDTO implements Serializable
{
	private static final long serialVersionUID = 1L;
	
	private long numeroPiloto;
	private String nomUsuarOra;
	private long numDesde;

	public long getNumDesde() {
		return numDesde;
	}

	public void setNumDesde(long numDesde) {
		this.numDesde = numDesde;
	}

	public String getNomUsuarOra() {
		return nomUsuarOra;
	}

	public void setNomUsuarOra(String nomUsuarOra) {
		this.nomUsuarOra = nomUsuarOra;
	}

	public long getNumeroPiloto() {
		return numeroPiloto;
	}

	public void setNumeroPiloto(long numeroPiloto) {
		this.numeroPiloto = numeroPiloto;
	}

	
}

