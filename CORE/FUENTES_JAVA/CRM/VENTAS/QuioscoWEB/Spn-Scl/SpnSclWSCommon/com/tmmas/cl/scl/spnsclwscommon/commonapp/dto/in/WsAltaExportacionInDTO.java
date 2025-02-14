package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in;

import java.io.Serializable;

public class WsAltaExportacionInDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long numCelular;
	/**
	 * @param perfil
	 * @description 1= Prepago, 2 = Postpago 3 = Hibrido
	 */
	private String perfil; 
	private long opcionMarca;
	
	
	
	public long getNumCelular() {
		return numCelular;
	}
	public void setNumCelular(long numCelular) {
		this.numCelular = numCelular;
	}
	public String getPerfil() {
		return perfil;
	}
	public void setPerfil(String perfil) {
		this.perfil = perfil;
	}
	
	public long getOpcionMarca() {
		return opcionMarca;
	}
	public void setOpcionMarca(long opcionMarca) {
		this.opcionMarca = opcionMarca;
	}
	
	

}
