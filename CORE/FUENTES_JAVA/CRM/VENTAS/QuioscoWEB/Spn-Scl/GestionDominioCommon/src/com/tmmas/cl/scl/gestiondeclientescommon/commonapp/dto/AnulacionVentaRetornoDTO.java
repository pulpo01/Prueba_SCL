package com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto;

import java.io.Serializable;
import java.util.ArrayList;

public class AnulacionVentaRetornoDTO extends AnulacionVentaDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	ArrayList listaerrores;

	public ArrayList getListaerrores() {
		return listaerrores;
	}

	public void setListaerrores(ArrayList listaerrores) {
		this.listaerrores = listaerrores;
	}
	
	
}
