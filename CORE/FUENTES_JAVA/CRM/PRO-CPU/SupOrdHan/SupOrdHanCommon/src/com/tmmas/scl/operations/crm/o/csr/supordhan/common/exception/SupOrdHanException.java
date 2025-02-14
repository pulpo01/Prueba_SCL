package com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class SupOrdHanException extends GeneralException {

	private static final long serialVersionUID = 1L;
	
	public SupOrdHanException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SupOrdHanException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public SupOrdHanException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public SupOrdHanException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public SupOrdHanException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SupOrdHanException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SupOrdHanException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
