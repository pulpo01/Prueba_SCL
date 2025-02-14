package com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class CloCusOrdException extends GeneralException {
	private static final long serialVersionUID = 1L;	

	public CloCusOrdException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CloCusOrdException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public CloCusOrdException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public CloCusOrdException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public CloCusOrdException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public CloCusOrdException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public CloCusOrdException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
