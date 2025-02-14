package com.tmmas.scl.operations.crm.o.csr.supcusintman.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class SupCusIntManException extends GeneralException {

	private static final long serialVersionUID = 1L;
	
	public SupCusIntManException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SupCusIntManException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public SupCusIntManException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public SupCusIntManException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public SupCusIntManException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SupCusIntManException(String message, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SupCusIntManException(String message, Throwable cause,
			String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
