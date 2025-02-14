package com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class CusIntManException extends GeneralException {

	private static final long serialVersionUID = 1L;
	
	public CusIntManException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public CusIntManException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public CusIntManException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public CusIntManException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public CusIntManException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public CusIntManException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}