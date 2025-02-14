package com.tmmas.scl.operations.crm.osr.mancusinv.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class ManCusInvException extends GeneralException {

	private static final long serialVersionUID = 1L;
	
	public ManCusInvException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ManCusInvException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public ManCusInvException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public ManCusInvException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public ManCusInvException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ManCusInvException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ManCusInvException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
