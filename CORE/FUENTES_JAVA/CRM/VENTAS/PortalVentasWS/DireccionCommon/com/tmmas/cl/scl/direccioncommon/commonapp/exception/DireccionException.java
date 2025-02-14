package com.tmmas.cl.scl.direccioncommon.commonapp.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class DireccionException extends GeneralException {
	private static final long serialVersionUID = 1L;

	public DireccionException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public DireccionException(String codigo, long codigoEvento, String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public DireccionException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public DireccionException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public DireccionException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public DireccionException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public DireccionException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}
}
