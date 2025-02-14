package com.tmmas.scl.operations.crm.f.oh.detcusordfea.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class DetCusOrdFeaException extends GeneralException {
	
	private static final long serialVersionUID = 1L;

	public DetCusOrdFeaException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public DetCusOrdFeaException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public DetCusOrdFeaException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public DetCusOrdFeaException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public DetCusOrdFeaException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public DetCusOrdFeaException(String message, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public DetCusOrdFeaException(String message, Throwable cause,
			String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
