package com.tmmas.scl.framework.productDomain.dataTransferObject;

import java.io.Serializable;
import java.util.Date;

public class FechasSuspensionDTO implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private Date fechaSuspencion;
	
	public Date getFechaSuspencion() {
		return fechaSuspencion;
	}
	public void setFechaSuspencion(Date fechaSuspencion) {
		this.fechaSuspencion = fechaSuspencion;
	} 
	
}
