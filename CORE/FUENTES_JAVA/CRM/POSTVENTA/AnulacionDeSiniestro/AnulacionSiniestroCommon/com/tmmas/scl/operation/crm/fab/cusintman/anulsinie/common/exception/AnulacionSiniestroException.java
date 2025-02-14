package com.tmmas.scl.operation.crm.fab.cusintman.anulsinie.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class AnulacionSiniestroException extends GeneralException{

	private static final long serialVersionUID = 1L;
	
	public AnulacionSiniestroException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AnulacionSiniestroException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public AnulacionSiniestroException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public AnulacionSiniestroException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public AnulacionSiniestroException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public AnulacionSiniestroException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public AnulacionSiniestroException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}


}
