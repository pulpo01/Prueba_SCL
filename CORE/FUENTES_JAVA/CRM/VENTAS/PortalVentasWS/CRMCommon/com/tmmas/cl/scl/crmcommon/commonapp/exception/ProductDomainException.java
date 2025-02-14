package com.tmmas.cl.scl.crmcommon.commonapp.exception;
import com.tmmas.cl.framework.exception.GeneralException;

public class ProductDomainException extends GeneralException {
	private static final long serialVersionUID = 1L;

	public ProductDomainException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProductDomainException(String codigo, long codigoEvento, String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ProductDomainException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ProductDomainException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ProductDomainException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public ProductDomainException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public ProductDomainException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}
}
