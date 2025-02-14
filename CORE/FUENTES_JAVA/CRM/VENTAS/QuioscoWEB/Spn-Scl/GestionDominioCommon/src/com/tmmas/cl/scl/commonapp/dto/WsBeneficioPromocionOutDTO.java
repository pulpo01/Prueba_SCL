package com.tmmas.cl.scl.commonapp.dto;

import java.io.Serializable;

public class WsBeneficioPromocionOutDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String codigoCampana; 
	private String ddescripcionCampana; 
	private String codigoTiplan; 
	private String indicadorDefault;
	
	
	public String getCodigoCampana() {
		return codigoCampana;
	}
	public void setCodigoCampana(String codigoCampana) {
		this.codigoCampana = codigoCampana;
	}
	public String getCodigoTiplan() {
		return codigoTiplan;
	}
	public void setCodigoTiplan(String codigoTiplan) {
		this.codigoTiplan = codigoTiplan;
	}
	public String getDdescripcionCampana() {
		return ddescripcionCampana;
	}
	public void setDdescripcionCampana(String ddescripcionCampana) {
		this.ddescripcionCampana = ddescripcionCampana;
	}
	public String getIndicadorDefault() {
		return indicadorDefault;
	}
	public void setIndicadorDefault(String indicadorDefault) {
		this.indicadorDefault = indicadorDefault;
	}	

}
