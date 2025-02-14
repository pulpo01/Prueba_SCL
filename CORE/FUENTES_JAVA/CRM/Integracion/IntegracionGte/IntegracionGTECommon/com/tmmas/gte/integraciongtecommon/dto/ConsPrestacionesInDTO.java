package com.tmmas.gte.integraciongtecommon.dto;
import java.io.Serializable;

public class ConsPrestacionesInDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	private String idTipoPrestacion;
	private String grpPrestacion;
	
	public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	public String getGrpPrestacion() {
		return grpPrestacion;
	}
	public void setGrpPrestacion(String grpPrestacion) {
		this.grpPrestacion = grpPrestacion;
	}
	public String getIdTipoPrestacion() {
		return idTipoPrestacion;
	}
	public void setIdTipoPrestacion(String idTipoPrestacion) {
		this.idTipoPrestacion = idTipoPrestacion;
	}

	


	
}
