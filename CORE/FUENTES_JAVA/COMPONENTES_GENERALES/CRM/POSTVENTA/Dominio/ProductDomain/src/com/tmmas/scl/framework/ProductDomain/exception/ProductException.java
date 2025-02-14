package com.tmmas.scl.framework.ProductDomain.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class ProductException extends GeneralException{

	private static final long serialVersionUID = 1L;
	
	public ProductException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public ProductException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public ProductException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public ProductException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public ProductException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ProductException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public ProductException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

}
