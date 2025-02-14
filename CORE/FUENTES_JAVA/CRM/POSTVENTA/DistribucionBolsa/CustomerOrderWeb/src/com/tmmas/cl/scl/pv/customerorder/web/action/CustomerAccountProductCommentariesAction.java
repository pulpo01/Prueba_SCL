package com.tmmas.cl.scl.pv.customerorder.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ActualizarSSClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.web.delegate.CustomerOrderDelegate;

import org.apache.commons.configuration.CompositeConfiguration;
import com.tmmas.cl.framework20.util.*;


public class CustomerAccountProductCommentariesAction extends Action {
	private Category logger = Category.getInstance(CustomerAccountProductCommentariesAction.class);
	CustomerOrderDelegate delegate = CustomerOrderDelegate.getInstance();	
	private CompositeConfiguration config;
	
	private void setLog() {
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio CustomerAccountProductCommentariesAction");		
	}
	
	public ActionForward execute(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response) 
		throws Exception 
	{			
		setLog();		
		logger.debug("execute");		
		ActualizarSSClienteDTO sscliente;
		sscliente = (ActualizarSSClienteDTO)request.getSession().getAttribute("sscliente");		
		sscliente.getOoss().setComentario(request.getParameter("comentarios").toString());
		delegate.setServiceBundle(sscliente);			
		logger.debug("guardarDatos:fin");
		return mapping.findForward("exito");
	}

}
