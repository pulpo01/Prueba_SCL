package com.tmmas.scl.framework.commonDoman.helper;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;

public class ParsearGeneralException {
	private Exception e;

	private final Logger logger = Logger
			.getLogger(ParsearGeneralException.class);

	private Global global = Global.getInstance();

	public ParsearGeneralException(Exception e) {
		super();
		this.e = e;
	}

	public GeneralException getGeneralExceptionAttributesNested() {
		String log = global.getValor("common.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		logger.debug("getGeneralExceptionAttributesNested():start");
		if (e.getCause() != null) {
			logger.debug("Causa error[" + e.getCause().getClass().getName()	+ "]");
			if (e instanceof GeneralException) {
				GeneralException ex = (GeneralException) e.getCause();
				logger.debug("Instancia de GeneralException");
				logger.debug("getCodigo[" + ex.getCodigo());
				logger.debug("getCodigoEvento[" + ex.getCodigoEvento());
				logger.debug("getDescripcionEvento[" + ex.getDescripcionEvento());				
				logger.debug("getMessageUser[" + ex.getMessageUser());
				return ex;

			} else {
				logger.debug("No es instancia de GeneralException. devolviendo nulo");
			}
		}
		logger.debug("getGeneralExceptionAttributesNested():end");
		return null;
	}

}
