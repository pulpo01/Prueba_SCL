package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.FlujoNavegacionPag;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class CartaAction extends Action {
	
	private final Logger logger = Logger.getLogger(CartaAction.class);
	private Global global = Global.getInstance();
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);

		logger.debug("execute():start");
		
		String siguiente="carta";
		
		FlujoNavegacionPag flujoNav=new FlujoNavegacionPag();
		HttpSession session = request.getSession(false);
	    flujoNav = (FlujoNavegacionPag)session.getAttribute("flujoNav");
	   	String pagSgte = flujoNav.getPagSgte();
	   
	   	
	   	if(flujoNav.getPagAnte().equals("/CartaAction.do")){
	   		flujoNav.setPagSgte("/CartaAction.do");
	   		flujoNav.setPagAnte("/ComentariosAction.do");
	   	}
	   	
	    if(pagSgte.equals("/ComentariosAction.do")){
	    	flujoNav.setPagSgte("/CartaAction.do");
	    	flujoNav.setPagAnte("/ComentariosAction.do");
	    }
	    
	    
	  
	    session.setAttribute("flujoNav", flujoNav);
		// TODO process request and return an ActionForward instance, for example:
	  	     
		logger.debug("execute():end");
		return mapping.findForward(siguiente);
		
	}

}
