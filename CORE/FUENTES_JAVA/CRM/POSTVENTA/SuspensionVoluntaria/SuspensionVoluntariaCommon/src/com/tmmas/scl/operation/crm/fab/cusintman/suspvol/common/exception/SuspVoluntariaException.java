package com.tmmas.scl.operation.crm.fab.cusintman.suspvol.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class SuspVoluntariaException extends GeneralException {
private static final long serialVersionUID = 1L;
	
	public SuspVoluntariaException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SuspVoluntariaException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public SuspVoluntariaException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public SuspVoluntariaException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public SuspVoluntariaException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SuspVoluntariaException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SuspVoluntariaException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
