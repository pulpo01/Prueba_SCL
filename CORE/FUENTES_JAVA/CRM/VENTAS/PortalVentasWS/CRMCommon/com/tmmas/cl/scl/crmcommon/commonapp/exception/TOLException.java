package com.tmmas.cl.scl.crmcommon.commonapp.exception;
import com.tmmas.cl.framework.exception.GeneralException;

public class TOLException extends GeneralException{
	private static final long serialVersionUID = 1L;

	public TOLException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}
	
	public TOLException(String codigo, long evento, String evento2) {
		super(codigo, evento, evento2);
		// TODO Auto-generated constructor stub
	}

	public TOLException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public TOLException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public TOLException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public TOLException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public TOLException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}
	
}
