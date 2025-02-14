package com.tmmas.cl.scl.crmcommon.commonapp.exception;
import com.tmmas.cl.framework.exception.GeneralException;

public class CustomerDomainException extends GeneralException {
	private static final long serialVersionUID = 1L;

	public CustomerDomainException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CustomerDomainException(String codigo, long codigoEvento, String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public CustomerDomainException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public CustomerDomainException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public CustomerDomainException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public CustomerDomainException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public CustomerDomainException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}
}
