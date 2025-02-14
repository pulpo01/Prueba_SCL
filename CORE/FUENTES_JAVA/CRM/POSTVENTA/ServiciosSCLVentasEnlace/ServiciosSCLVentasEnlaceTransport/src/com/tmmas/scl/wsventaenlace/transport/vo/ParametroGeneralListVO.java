package com.tmmas.scl.wsventaenlace.transport.vo;

import java.io.Serializable;


public class ParametroGeneralListVO implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private ParametroGeneralVO parametrosGenerales[];
	public ParametroGeneralVO[] getParametrosGenerales() {
		return parametrosGenerales;
	}
	public void setParametrosGenerales(ParametroGeneralVO[] parametrosGenerales) {
		this.parametrosGenerales = parametrosGenerales;
	}


}
