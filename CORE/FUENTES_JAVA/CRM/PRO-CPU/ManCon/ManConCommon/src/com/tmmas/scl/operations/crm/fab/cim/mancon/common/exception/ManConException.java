package com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class ManConException extends GeneralException {

	private static final long serialVersionUID = 1L;
	
	public ManConException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ManConException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public ManConException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public ManConException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public ManConException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ManConException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ManConException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
