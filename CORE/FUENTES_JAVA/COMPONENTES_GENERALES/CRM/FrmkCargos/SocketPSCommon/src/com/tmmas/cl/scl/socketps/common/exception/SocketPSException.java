package com.tmmas.cl.scl.socketps.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class SocketPSException extends GeneralException {

	private static final long serialVersionUID = 1L;

	public SocketPSException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public SocketPSException(String codigo, long codigoEvento, String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SocketPSException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SocketPSException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public SocketPSException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public SocketPSException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public SocketPSException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

}
