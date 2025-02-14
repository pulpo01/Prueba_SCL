package com.tmmas.scl.operations.crm.f.oh.comord.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class ComOrdException extends GeneralException {

	private static final long serialVersionUID = 1L;
	
	public ComOrdException() {
		super();
		// TODO Auto-generated constructor stub 
	}

	public ComOrdException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public ComOrdException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public ComOrdException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public ComOrdException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ComOrdException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ComOrdException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
