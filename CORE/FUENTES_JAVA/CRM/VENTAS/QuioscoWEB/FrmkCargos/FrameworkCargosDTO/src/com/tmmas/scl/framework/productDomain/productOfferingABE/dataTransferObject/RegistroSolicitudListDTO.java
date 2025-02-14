/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 13/07/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject;

import java.io.Serializable;

public class RegistroSolicitudListDTO implements Serializable {
	private static final long serialVersionUID = 1L;
	
	private RegistroSolicitudDTO[] solicitudes;

	public RegistroSolicitudDTO[] getSolicitudes() {
		return solicitudes;
	}

	public void setSolicitudes(RegistroSolicitudDTO[] solicitudes) {
		this.solicitudes = solicitudes;
	}
	
}
