package com.tmmas.scl.operation.crm.fab.cusintman.avisinie.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class AvisoDeSiniestroException extends GeneralException{

	private static final long serialVersionUID = 1L;
	
	public AvisoDeSiniestroException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AvisoDeSiniestroException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public AvisoDeSiniestroException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public AvisoDeSiniestroException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public AvisoDeSiniestroException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public AvisoDeSiniestroException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public AvisoDeSiniestroException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}


}
