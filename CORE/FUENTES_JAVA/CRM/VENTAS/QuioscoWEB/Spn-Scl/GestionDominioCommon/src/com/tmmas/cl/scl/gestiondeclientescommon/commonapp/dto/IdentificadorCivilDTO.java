package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;

public class IdentificadorCivilDTO implements Serializable {
	private static final long serialVersionUID = 1L;

	private String codigoTipIdentif;
	private String descripcionTipIdentif;
	private String indicadorPertrib; 
	private int    indicadorSalefact;
	
	public String getCodigoTipIdentif() {
		return codigoTipIdentif;
	}
	public void setCodigoTipIdentif(String codigoTipIdentif) {
		this.codigoTipIdentif = codigoTipIdentif;
	}
	public String getDescripcionTipIdentif() {
		return descripcionTipIdentif;
	}
	public void setDescripcionTipIdentif(String descripcionTipIdentif) {
		this.descripcionTipIdentif = descripcionTipIdentif;
	}
	public String getIndicadorPertrib() {
		return indicadorPertrib;
	}
	public void setIndicadorPertrib(String indicadorPertrib) {
		this.indicadorPertrib = indicadorPertrib;
	}
	public int getIndicadorSalefact() {
		return indicadorSalefact;
	}
	public void setIndicadorSalefact(int indicadorSalefact) {
		this.indicadorSalefact = indicadorSalefact;
	}

}//fin class IdentificadorCivilDTO
