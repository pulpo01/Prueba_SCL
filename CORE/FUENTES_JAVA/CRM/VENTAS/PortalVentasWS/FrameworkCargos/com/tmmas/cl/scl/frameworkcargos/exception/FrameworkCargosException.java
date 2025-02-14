package com.tmmas.cl.scl.frameworkcargos.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class FrameworkCargosException extends GeneralException{

	private static final long serialVersionUID = 1L;

	public FrameworkCargosException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public FrameworkCargosException(String codigo, long codigoEvento, String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public FrameworkCargosException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public FrameworkCargosException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public FrameworkCargosException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public FrameworkCargosException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public FrameworkCargosException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

}
