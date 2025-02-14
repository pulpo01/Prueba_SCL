package com.tmmas.cl.scl.activacionmasivacommon.commonapp.exception;
import com.tmmas.cl.framework.exception.GeneralException;

public class ActivacionMasivaException extends GeneralException {
	private static final long serialVersionUID = 1L;

	public ActivacionMasivaException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ActivacionMasivaException(String codigo, long codigoEvento, String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ActivacionMasivaException(String message, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ActivacionMasivaException(String message, Throwable cause, String codigo, long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ActivacionMasivaException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public ActivacionMasivaException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public ActivacionMasivaException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}
}
