package com.tmmas.scl.framework.commonDoman.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class FrmkCargosException extends GeneralException {

	public FrmkCargosException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FrmkCargosException(String codigo, long codigoEvento, String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public FrmkCargosException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public FrmkCargosException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public FrmkCargosException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public FrmkCargosException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public FrmkCargosException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	private static final long serialVersionUID = 1L;

}
