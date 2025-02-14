package com.tmmas.scl.operations.crm.f.sel.negsal.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class NegSalException extends GeneralException {

	private static final long serialVersionUID = 1L;
	
	public NegSalException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public NegSalException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public NegSalException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public NegSalException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public NegSalException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public NegSalException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public NegSalException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
