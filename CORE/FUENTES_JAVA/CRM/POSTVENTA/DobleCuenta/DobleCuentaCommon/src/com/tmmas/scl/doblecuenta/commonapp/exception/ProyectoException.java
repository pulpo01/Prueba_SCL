package com.tmmas.scl.doblecuenta.commonapp.exception;


import com.tmmas.cl.framework.exception.GeneralException;

public class ProyectoException extends GeneralException {

	private static final long serialVersionUID = 1L;

	public ProyectoException() {
		super();
	}

	public ProyectoException(String arg0, long arg1, String arg2) {
		super(arg0, arg1, arg2);
	}

	public ProyectoException(String arg0, String arg1, long arg2, String arg3) {
		super(arg0, arg1, arg2, arg3);
	}

	public ProyectoException(String arg0, Throwable arg1, String arg2, long arg3, String arg4) {
		super(arg0, arg1, arg2, arg3, arg4);
	}

	public ProyectoException(String arg0, Throwable arg1) {
		super(arg0, arg1);
	}

	public ProyectoException(String arg0) {
		super(arg0);
	}

	public ProyectoException(Throwable arg0) {
		super(arg0);
	}

}
