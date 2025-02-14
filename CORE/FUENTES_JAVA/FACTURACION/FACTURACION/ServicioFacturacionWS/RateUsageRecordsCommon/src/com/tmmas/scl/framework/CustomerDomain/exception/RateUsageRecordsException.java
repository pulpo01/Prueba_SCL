package com.tmmas.scl.framework.CustomerDomain.exception;

import com.tmmas.cl.framework.exception.GeneralException;



public class RateUsageRecordsException extends GeneralException {

	private static final long serialVersionUID = 1L;

	public RateUsageRecordsException() {
		super();
	}

	public RateUsageRecordsException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public RateUsageRecordsException(String message, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public RateUsageRecordsException(String message, Throwable cause,
			String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public RateUsageRecordsException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public RateUsageRecordsException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public RateUsageRecordsException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}
}
