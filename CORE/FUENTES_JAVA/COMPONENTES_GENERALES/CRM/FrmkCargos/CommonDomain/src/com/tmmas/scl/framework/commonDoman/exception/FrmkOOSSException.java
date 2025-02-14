package com.tmmas.scl.framework.commonDoman.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class FrmkOOSSException extends GeneralException {

	public FrmkOOSSException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FrmkOOSSException(String codigo, long codigoEvento, String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public FrmkOOSSException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public FrmkOOSSException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public FrmkOOSSException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public FrmkOOSSException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public FrmkOOSSException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	private static final long serialVersionUID = 1L;

}
