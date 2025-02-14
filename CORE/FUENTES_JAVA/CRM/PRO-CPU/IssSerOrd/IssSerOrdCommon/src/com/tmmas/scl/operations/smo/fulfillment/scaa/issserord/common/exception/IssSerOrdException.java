package com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class IssSerOrdException extends GeneralException {

	private static final long serialVersionUID = 1L;
	
	public IssSerOrdException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public IssSerOrdException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public IssSerOrdException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public IssSerOrdException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public IssSerOrdException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public IssSerOrdException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public IssSerOrdException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
