package com.tmmas.scl.operations.smo.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class SerManOpeWSException extends GeneralException {
	private static final long serialVersionUID = 1L;

	public SerManOpeWSException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SerManOpeWSException(String codigo, long codigoEvento, String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SerManOpeWSException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SerManOpeWSException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SerManOpeWSException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public SerManOpeWSException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public SerManOpeWSException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}
}
