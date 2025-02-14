/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 12/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;

public class FormaPagoListDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private FormaPagoDTO[] formasPago;

	public FormaPagoDTO[] getFormasPago() {
		return formasPago;
	}

	public void setFormasPago(FormaPagoDTO[] formasPago) {
		this.formasPago = formasPago;
	}


}
