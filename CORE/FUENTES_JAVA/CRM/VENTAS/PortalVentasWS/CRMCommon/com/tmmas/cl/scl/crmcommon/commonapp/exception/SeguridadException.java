package com.tmmas.cl.scl.crmcommon.commonapp.exception;
import com.tmmas.cl.framework.exception.GeneralException;

public class SeguridadException extends GeneralException {
	private static final long serialVersionUID = 1L;
	
	public SeguridadException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SeguridadException(String codigo, long codigoEvento, String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SeguridadException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SeguridadException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SeguridadException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public SeguridadException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public SeguridadException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

}
