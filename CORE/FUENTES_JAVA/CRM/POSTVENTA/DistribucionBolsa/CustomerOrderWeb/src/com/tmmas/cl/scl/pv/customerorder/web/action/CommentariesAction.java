package com.tmmas.cl.scl.pv.customerorder.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerOrderSessionDTO;
import com.tmmas.cl.scl.pv.customerorder.web.helper.ForwardOS;

import org.apache.commons.configuration.CompositeConfiguration;
import com.tmmas.cl.framework20.util.*;
import org.apache.log4j.Category;


public class CommentariesAction extends Action {
	
	
	private static Category logger = Category.getInstance(CommentariesAction.class);
	private CompositeConfiguration config;

	private void CommentariesAction() {
		setLog();
	}
	
	private void setLog() {
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );			
	}
	
	
	public ActionForward execute(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response) 
		throws Exception
	{		
		logger.debug("execute:inicio");
		CustomerOrderSessionDTO sessionData = null;
		
		sessionData = (CustomerOrderSessionDTO)request.getSession().getAttribute("CustomerOrder");
		
		String forward = ForwardOS.forwardOS(sessionData.getForward(), 3);
		logger.debug("forward [" + forward + "]");
		
		logger.debug("execute:fin");
		return mapping.findForward(forward);
	}
						
}
