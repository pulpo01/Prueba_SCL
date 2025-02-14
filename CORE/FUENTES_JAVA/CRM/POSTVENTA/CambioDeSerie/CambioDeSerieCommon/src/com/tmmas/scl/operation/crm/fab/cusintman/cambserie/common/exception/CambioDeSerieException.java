package com.tmmas.scl.operation.crm.fab.cusintman.cambserie.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class CambioDeSerieException extends GeneralException{
	private static final long serialVersionUID = 1L;
	
	public CambioDeSerieException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CambioDeSerieException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public CambioDeSerieException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public CambioDeSerieException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public CambioDeSerieException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public CambioDeSerieException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public CambioDeSerieException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}


}
