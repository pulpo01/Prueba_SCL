package com.tmmas.scl.framework.ProductDomain.dto;

import java.io.Serializable;

public class TipoSuspencionDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String Cod_TipoSuspencion;
	private String Des_TipoSuspencion;
	
	public String getCod_TipoSuspencion() {
		return Cod_TipoSuspencion;
	}
	public void setCod_TipoSuspencion(String cod_TipoSuspencion) {
		Cod_TipoSuspencion = cod_TipoSuspencion;
	}
	public String getDes_TipoSuspencion() {
		return Des_TipoSuspencion;
	}
	public void setDes_TipoSuspencion(String des_TipoSuspencion) {
		Des_TipoSuspencion = des_TipoSuspencion;
	}

}
