package com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.common.exception;

import com.tmmas.cl.framework.exception.GeneralException;

public class AllSpeSerParException extends GeneralException
{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public AllSpeSerParException() {
		super();
		// TODO Auto-generated constructor stub
	}

	public AllSpeSerParException(String message) {
		super(message);
		// TODO Auto-generated constructor stub
	}

	public AllSpeSerParException(Throwable cause) {
		super(cause);
		// TODO Auto-generated constructor stub
	}

	public AllSpeSerParException(String message, Throwable cause) {
		super(message, cause);
		// TODO Auto-generated constructor stub
	}

	public AllSpeSerParException(String codigo, long codigoEvento,
			String descripcionEvento) {
		super(codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public AllSpeSerParException(String message, String codigo, long codigoEvento,
			String descripcionEvento) {
		super(message, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}

	public AllSpeSerParException(String message, Throwable cause, String codigo,
			long codigoEvento, String descripcionEvento) {
		super(message, cause, codigo, codigoEvento, descripcionEvento);
		// TODO Auto-generated constructor stub
	}
	

}
