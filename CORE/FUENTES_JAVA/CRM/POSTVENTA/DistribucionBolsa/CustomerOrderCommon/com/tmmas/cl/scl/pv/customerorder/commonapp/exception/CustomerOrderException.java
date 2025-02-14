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
 * 10/07/2006     Jimmy Lopez              					Versión Inicial
 */

/**
 * <p>Title: ServiceLocator </p> 
 * 
 * <p>Description: Clase de excepcion de aplicacion</p> 
 * 
 */
package com.tmmas.cl.scl.pv.customerorder.commonapp.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class CustomerOrderException extends GeneralException {

	private static final long serialVersionUID = 1L;

	public CustomerOrderException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CustomerOrderException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public CustomerOrderException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public CustomerOrderException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public CustomerOrderException(String codigo, long evento, String evento2) {
		super(codigo, evento, evento2);
		// TODO Auto-generated constructor stub
	}

	public CustomerOrderException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public CustomerOrderException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
