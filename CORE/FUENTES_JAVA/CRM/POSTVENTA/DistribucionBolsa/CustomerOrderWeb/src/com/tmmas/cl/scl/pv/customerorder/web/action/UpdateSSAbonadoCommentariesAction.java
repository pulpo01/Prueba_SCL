package com.tmmas.cl.scl.pv.customerorder.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
//import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.web.delegate.CustomerOrderDelegate;

public class UpdateSSAbonadoCommentariesAction extends BaseAction{
	private Category logger = Category.getInstance(UpdateSSAbonadoCommentariesAction.class);
	private CustomerOrderDelegate delegate = CustomerOrderDelegate.getInstance();
	
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
	
	protected ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response)
		throws Exception 
	{
		
		setLog();		
		logger.debug("executeAction:start");
		String comentario = request.getParameter("comentarios");
		logger.debug("Comentario[" + comentario + "]");
		
		HttpSession session = request.getSession();
		ProductListDTO productList = (ProductListDTO)session.getAttribute("AtributosSSporAbonado");
		productList.getOrdenServicio().setComentario(comentario);
		session.setAttribute("AtributosSSporAbonado", productList);
		
		logger.debug("setInvolvementProductBundleAttributes:antes");
		delegate.setInvolvementProductBundleAttributes(productList);
		logger.debug("setInvolvementProductBundleAttributes:despues");
		
		logger.debug("executeAction:end");
		return mapping.findForward("exito");
	}

}
