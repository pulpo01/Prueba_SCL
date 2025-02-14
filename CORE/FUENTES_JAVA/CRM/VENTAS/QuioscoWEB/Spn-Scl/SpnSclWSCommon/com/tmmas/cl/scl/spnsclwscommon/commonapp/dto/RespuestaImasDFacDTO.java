package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto;

import java.io.Serializable;
import java.util.ArrayList;

import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.ParametrosFactVentaDTO;

public class RespuestaImasDFacDTO extends ParametrosFactVentaDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String numProceso; 
	private ArrayList listaErrores;
	
	public ArrayList getListaErrores() {
		return listaErrores;
	}
	public void setListaErrores(ArrayList listaErrores) {
		this.listaErrores = listaErrores;
	}
	public String getNumProceso() {
		return numProceso;
	}
	public void setNumProceso(String numProceso) {
		this.numProceso = numProceso;
	}

}
