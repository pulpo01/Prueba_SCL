package com.tmmas.scl.operations.frmkooss.web.helper;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.AvisoSiniestroBussinessDelegate;

public class VerificaNumeroDesviadoDWR {
	
	private final Logger logger = Logger.getLogger(VerificaNumeroDesviadoDWR.class);
	private AvisoSiniestroBussinessDelegate delegate = AvisoSiniestroBussinessDelegate.getInstance();
	
	public String verificaNumero( String numero) throws GeneralException{
		
		logger.debug("Inicio verificaNumero()");
		String resultado;
		
		try {
			resultado=delegate.verificaNumeroDesviado(numero);
			logger.debug("El resultado de verificaNumeroDesviado -> "+resultado);
			
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}
		logger.debug("Fin verificaNumero()");
		return resultado;
		
	}

}
