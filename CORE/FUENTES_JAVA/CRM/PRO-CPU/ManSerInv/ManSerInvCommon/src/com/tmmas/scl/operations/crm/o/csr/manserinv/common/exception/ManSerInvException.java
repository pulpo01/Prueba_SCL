package com.tmmas.scl.operations.crm.o.csr.manserinv.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class ManSerInvException extends GeneralException {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public ManSerInvException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ManSerInvException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public ManSerInvException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public ManSerInvException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public ManSerInvException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ManSerInvException(String message, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ManSerInvException(String message, Throwable cause,
			String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}
}
