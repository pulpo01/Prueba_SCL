package com.tmmas.cl.scl.gestiondeabonados.businessobject.dto;

import java.io.Serializable;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.RetornoDTO;

public class ValidacionServicioSDTO extends RetornoDTO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	SSuplementariosDTO[] trnferenicas;
	SSuplementariosDTO[] incompatible;
	SSuplementariosDTO[] ligadura;
	
	
	public SSuplementariosDTO[] getIncompatible() {
		return incompatible;
	}
	public void setIncompatible(SSuplementariosDTO[] incompatible) {
		this.incompatible = incompatible;
	}
	public SSuplementariosDTO[] getLigadura() {
		return ligadura;
	}
	public void setLigadura(SSuplementariosDTO[] ligadura) {
		this.ligadura = ligadura;
	}
	public SSuplementariosDTO[] getTrnferenicas() {
		return trnferenicas;
	}
	public void setTrnferenicas(SSuplementariosDTO[] trnferenicas) {
		this.trnferenicas = trnferenicas;
	}

	
	
}
