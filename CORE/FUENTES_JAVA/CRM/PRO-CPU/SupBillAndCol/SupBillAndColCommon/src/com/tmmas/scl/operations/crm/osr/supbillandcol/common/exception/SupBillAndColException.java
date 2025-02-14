package com.tmmas.scl.operations.crm.osr.supbillandcol.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class SupBillAndColException extends GeneralException
{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public SupBillAndColException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SupBillAndColException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public SupBillAndColException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public SupBillAndColException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public SupBillAndColException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SupBillAndColException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SupBillAndColException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
