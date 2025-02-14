package com.tmmas.scl.operation.crm.fab.cusintman.servsup.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class ServSuplemException extends GeneralException {
private static final long serialVersionUID = 1L;
	
	public ServSuplemException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ServSuplemException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public ServSuplemException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public ServSuplemException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public ServSuplemException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ServSuplemException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ServSuplemException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
