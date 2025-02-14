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
 * 08/02/2007     Jimmy Lopez              					Versión Inicial
 */
package com.tmmas.gte.integraciongtecommon.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class IntegracionGTEException extends GeneralException {

	private static final long serialVersionUID = 1L;

	public IntegracionGTEException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public IntegracionGTEException(String arg0, long arg1, String arg2) {
		super(arg0, arg1, arg2);
		// TODO Auto-generated constructor stub
	}

	public IntegracionGTEException(String arg0, String arg1, long arg2, String arg3) {
		super(arg0, arg1, arg2, arg3);
		// TODO Auto-generated constructor stub
	}

	public IntegracionGTEException(String arg0, Throwable arg1, String arg2, long arg3, String arg4) {
		super(arg0, arg1, arg2, arg3, arg4);
		// TODO Auto-generated constructor stub
	}

	public IntegracionGTEException(String arg0, Throwable arg1) {
		super(arg0, arg1);
		// TODO Auto-generated constructor stub
	}

	public IntegracionGTEException(String arg0) {
		super(arg0);
		// TODO Auto-generated constructor stub
	}

	public IntegracionGTEException(Throwable arg0) {
		super(arg0);
		// TODO Auto-generated constructor stub
	}

}
