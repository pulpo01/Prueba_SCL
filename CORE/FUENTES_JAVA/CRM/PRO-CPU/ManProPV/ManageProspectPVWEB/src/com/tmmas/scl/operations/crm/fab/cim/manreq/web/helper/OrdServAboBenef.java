/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 19/10/2007     			 Raúl Lozano              		Versión Inicial
 */
package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoBeneficiarioListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;

public class OrdServAboBenef {
	private final Logger logger = Logger.getLogger(OrdServAboBenef.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	public AbonadoBeneficiarioDTO[] obtieneAbonadosBeneficiariosPorNumCelular(long numCelular) throws GeneralException{
		AbonadoBeneficiarioDTO[] retorno = null;
		AbonadoBeneficiarioListDTO retValue=null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():start");
		
		try {
			AbonadoDTO abonadoDTO=new AbonadoDTO();
			abonadoDTO.setNumCelular(numCelular);
			retValue = delegate.obtieneAbonadosBeneficiariosPorNumCelular(abonadoDTO);

			int numero=retValue!=null?retValue.getAbonadoBeneficiarioList().length:0;
			retorno =new AbonadoBeneficiarioDTO[numero];
			for (int i=0; numero>0&&i<retValue.getAbonadoBeneficiarioList().length;i++){
				retorno[i]=	retValue.getAbonadoBeneficiarioList()[i];
			}
			
		}catch(GeneralException e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}
		
		logger.debug("obtieneAbonadosBeneficiariosPorNumCelular():end");
		return retorno;		
	}
	
	public AbonadoBeneficiarioDTO[] obtieneAboBenPorNumCelularRecarga() throws Exception{
		AbonadoBeneficiarioDTO[] retorno = null;
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);		
		logger.debug("obtieneAboBenPorNumCelularRecarga():start");
		try {
			WebContext ctx = WebContextFactory.get();
			HttpSession session = ctx.getHttpServletRequest().getSession(false);
			if(session.getAttribute("listaAbonadosAgregadosArr") != null)
			{
				retorno = (AbonadoBeneficiarioDTO[])session.getAttribute("listaAbonadosAgregadosArr");
			}else
			{
				retorno = new AbonadoBeneficiarioDTO[0];
			}
			
			logger.debug("AbonadoBeneficiarioDTO[].length"+retorno.length);
		}catch(Exception e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");
			throw e;
		}
		logger.debug("obtieneAboBenPorNumCelularRecarga():end");
		return retorno;		
	}
}
