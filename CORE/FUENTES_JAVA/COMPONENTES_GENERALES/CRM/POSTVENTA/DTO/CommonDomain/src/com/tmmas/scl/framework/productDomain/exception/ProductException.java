/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 30/07/2007     			 Elizabeth Vera              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class ProductException extends GeneralException {
	private static final long serialVersionUID = 1L;

	public ProductException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProductException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public ProductException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public ProductException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public ProductException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ProductException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ProductException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
