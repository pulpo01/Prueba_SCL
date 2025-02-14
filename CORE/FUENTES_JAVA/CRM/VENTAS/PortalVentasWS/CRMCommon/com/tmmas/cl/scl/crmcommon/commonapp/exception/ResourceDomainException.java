package com.tmmas.cl.scl.crmcommon.commonapp.exception;
import com.tmmas.cl.framework.exception.GeneralException;

public class ResourceDomainException extends GeneralException {
	private static final long serialVersionUID = 1L;

	public ResourceDomainException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ResourceDomainException(String codigo, long codigoEvento, String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ResourceDomainException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ResourceDomainException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ResourceDomainException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public ResourceDomainException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public ResourceDomainException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}
}

