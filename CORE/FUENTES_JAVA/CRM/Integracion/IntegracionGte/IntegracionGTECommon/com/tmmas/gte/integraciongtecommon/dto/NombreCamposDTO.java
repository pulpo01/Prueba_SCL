package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
public class NombreCamposDTO  implements Serializable {

	private static final long serialVersionUID = 1L;
	private String nombreCampo;
	private String ValorCampo;
	public String getValorCampo() {
		return ValorCampo;
	}


	public void setValorCampo(String valorCampo) {
		ValorCampo = valorCampo;
	}


	public static long getSerialVersionUID() {
		return serialVersionUID;
	}


	public String getNombreCampo() {
		return nombreCampo;
	}


	public void setNombreCampo(String nombreCampo) {
		this.nombreCampo = nombreCampo;
	}
	
	

}