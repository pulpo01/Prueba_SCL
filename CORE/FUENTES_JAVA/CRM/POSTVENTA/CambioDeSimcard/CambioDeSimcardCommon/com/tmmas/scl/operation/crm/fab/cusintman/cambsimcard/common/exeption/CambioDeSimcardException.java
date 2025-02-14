package com.tmmas.scl.operation.crm.fab.cusintman.cambsimcard.common.exeption;

import com.tmmas.cl.framework.exception.GeneralException;

public class CambioDeSimcardException extends GeneralException{
	private static final long serialVersionUID = 1L;
	
	public CambioDeSimcardException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CambioDeSimcardException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public CambioDeSimcardException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public CambioDeSimcardException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public CambioDeSimcardException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public CambioDeSimcardException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public CambioDeSimcardException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}


}
