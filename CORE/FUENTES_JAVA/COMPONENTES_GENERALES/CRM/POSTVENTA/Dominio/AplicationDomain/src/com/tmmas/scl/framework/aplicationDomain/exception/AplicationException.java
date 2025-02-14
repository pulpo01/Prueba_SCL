package com.tmmas.scl.framework.aplicationDomain.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class AplicationException  extends GeneralException{

	private static final long serialVersionUID = 1L;
	
	public AplicationException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AplicationException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public AplicationException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public AplicationException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public AplicationException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public AplicationException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public AplicationException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}
}
