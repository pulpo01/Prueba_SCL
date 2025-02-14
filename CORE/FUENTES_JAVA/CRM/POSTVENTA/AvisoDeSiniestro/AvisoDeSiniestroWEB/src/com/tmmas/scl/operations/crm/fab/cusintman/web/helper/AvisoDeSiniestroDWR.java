package com.tmmas.scl.operations.crm.fab.cusintman.web.helper;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.ProductDomain.dto.TipoSuspencionDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.AvisoSiniestroBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;

public class AvisoDeSiniestroDWR {
	
	private final Logger logger = Logger.getLogger(AvisoDeSiniestroDWR.class);
	private AvisoSiniestroBussinessDelegate delegate = AvisoSiniestroBussinessDelegate.getInstance();
	private Global global = Global.getInstance();
	
	public TipoSuspencionDTO obtenerTipoDeSuspPorCausa (Integer codServicio) throws CusIntManException {
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtenerTipoDeSuspPorCausa():start");
		TipoSuspencionDTO retorno=new TipoSuspencionDTO();
		try{
			retorno = delegate.obtenerTipoDeSuspPorCausa(codServicio);
			logger.debug("obtenerTipoDeSuspPorCausa():end");
			return retorno;
		}
		catch (CusIntManException e)	{
			//throw new CusIntManException("Error");
			throw new CusIntManException("Para esta Causa de siniestro no esta configurado el Tipo de suspension");
		}
		
	}

}
