package com.tmmas.cl.scl.pv.customerorder.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.web.delegate.CustomerOrderDelegate;

public class LimiteConsumoTemporalClienteCommentariesAction extends Action{
	private Category logger = Category.getInstance(LimiteConsumoTemporalCommentariesAction.class);
	CustomerOrderDelegate delegate = CustomerOrderDelegate.getInstance();
	
	private CompositeConfiguration config; // MA
	
	private void setLog() {
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio ActionForward");
	}
	
	public ActionForward execute(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response) 
		throws Exception 
	{
		
		setLog();		
		logger.debug("executeAction():start");
		
		LimiteClienteDTO limitecliente;
		limitecliente = (LimiteClienteDTO)request.getSession().getAttribute("limitecliente");
		
		logger.debug("Plan Grabar SS 43563 " + limitecliente.getCod_plan());
		
		limitecliente.getOoss().setComentario(request.getParameter("comentarios").toString()); 
		
		
		logger.debug("Antes de Delegate");
		delegate.setServiceLimitTemporally(limitecliente);
		logger.debug("Despues de Delegate");
		
		logger.debug("executeAction():end");
		return mapping.findForward("exito");							
	}
}
