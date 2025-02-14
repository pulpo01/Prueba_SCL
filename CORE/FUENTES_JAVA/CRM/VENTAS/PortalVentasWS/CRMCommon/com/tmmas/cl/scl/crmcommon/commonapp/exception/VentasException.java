package com.tmmas.cl.scl.crmcommon.commonapp.exception;
import com.tmmas.cl.framework.exception.GeneralException;

public class VentasException extends GeneralException {
	private static final long serialVersionUID = 1L;

	public VentasException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public VentasException(String codigo, long codigoEvento, String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public VentasException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public VentasException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public VentasException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public VentasException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public VentasException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}
}

