package com.tmmas.cl.scl.altaclientecommon.commonapp.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class AltaClienteException extends GeneralException {
	private static final long serialVersionUID = 1L;

	public AltaClienteException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AltaClienteException(String codigo, long codigoEvento, String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public AltaClienteException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public AltaClienteException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public AltaClienteException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public AltaClienteException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public AltaClienteException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}
}
