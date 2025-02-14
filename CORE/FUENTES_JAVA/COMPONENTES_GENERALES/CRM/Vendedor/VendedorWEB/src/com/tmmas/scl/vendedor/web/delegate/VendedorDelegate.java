package com.tmmas.scl.vendedor.web.delegate;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.vendedor.dto.VendedorDTO;
import com.tmmas.scl.vendedor.exception.VendedorException;
import com.tmmas.scl.vendedor.negocio.ejb.session.VendedorFacadeSTL;
import com.tmmas.scl.vendedor.web.helper.FacadeMaker;
import com.tmmas.scl.vendedor.web.helper.Global;

public class VendedorDelegate {
	
	private static VendedorDelegate instance = null;

	private static Logger logger = Logger.getLogger(VendedorDelegate.class);

	private Global global = Global.getInstance();
	private FacadeMaker facadeMaker = FacadeMaker.getInstance();

	
	public static VendedorDelegate getInstance() {
		if (instance == null) {
			instance = new VendedorDelegate();
		}
		return instance;
	}	
	
	public VendedorDTO recuperarInformacionVendedor(VendedorDTO vendedor) throws VendedorException  {
		String log = global.getValor("web.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);
		logger.debug("recuperarInformacionVendedor():start");
		logger.debug("getVendedorFacade:antes");
		VendedorFacadeSTL facade = facadeMaker.getVendedorFacade();
		logger.debug("getVendedorFacade:despues");
		VendedorDTO resultado = null;
		try {
			logger.debug("recuperarInformacionVendedor():antes");
			resultado = facade.recuperarInformacionVendedor(vendedor);
			logger.debug("recuperarInformacionVendedor():despues");
		} catch (Exception e) {
			logger.debug("Exception", e);
			throw new VendedorException(e);			
		}
		logger.debug("recuperarInformacionVendedor():end");
		return resultado;
	}	
}
