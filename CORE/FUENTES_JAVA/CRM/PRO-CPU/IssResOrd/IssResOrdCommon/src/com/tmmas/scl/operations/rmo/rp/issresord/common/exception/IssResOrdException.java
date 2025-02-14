package com.tmmas.scl.operations.rmo.rp.issresord.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class IssResOrdException extends GeneralException {

	private static final long serialVersionUID = 1L;
	
	public IssResOrdException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public IssResOrdException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public IssResOrdException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public IssResOrdException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public IssResOrdException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public IssResOrdException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public IssResOrdException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
