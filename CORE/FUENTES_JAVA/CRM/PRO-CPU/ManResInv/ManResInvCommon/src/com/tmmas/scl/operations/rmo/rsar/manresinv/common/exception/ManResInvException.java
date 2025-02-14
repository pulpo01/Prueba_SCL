package com.tmmas.scl.operations.rmo.rsar.manresinv.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class ManResInvException extends GeneralException {

	private static final long serialVersionUID = 1L;
	
	public ManResInvException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ManResInvException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public ManResInvException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public ManResInvException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public ManResInvException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ManResInvException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ManResInvException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
