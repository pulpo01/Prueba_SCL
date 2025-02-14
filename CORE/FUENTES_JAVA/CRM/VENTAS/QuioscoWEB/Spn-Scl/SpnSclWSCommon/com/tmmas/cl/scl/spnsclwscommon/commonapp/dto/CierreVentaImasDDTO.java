package com.tmmas.cl.scl.spnsclwscommon.commonapp.dto;

import java.io.Serializable;
import java.util.ArrayList;

import com.tmmas.cl.scl.spnsclwscommon.commonapp.dto.in.WsCierreVentaInDTO;

public class CierreVentaImasDDTO extends WsCierreVentaInDTO implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	ArrayList listaErrores;

	public ArrayList getListaErrores() {
		return listaErrores;
	}

	public void setListaErrores(ArrayList listaErrores) {
		this.listaErrores = listaErrores;
	}
	
	
	
	

}
