package com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class ManProOffInvException extends GeneralException {
	
	private static final long serialVersionUID = 1L;	

	public ManProOffInvException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ManProOffInvException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public ManProOffInvException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public ManProOffInvException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public ManProOffInvException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ManProOffInvException(String message, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ManProOffInvException(String message, Throwable cause,
			String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
