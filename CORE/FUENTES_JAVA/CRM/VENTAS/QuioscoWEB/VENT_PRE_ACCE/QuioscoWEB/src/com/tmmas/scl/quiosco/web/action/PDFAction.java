package com.tmmas.scl.quiosco.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.scl.quiosco.web.form.PDFForm;


public class PDFAction extends Action {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private Logger logger = Logger.getLogger(this.getClass());
	
	public ActionForward execute(ActionMapping mapping, ActionForm p_form, HttpServletRequest request, HttpServletResponse response){
		
		CompositeConfiguration config;
		config = UtilProperty.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
		UtilLog.setLog(config.getString("QuioscoWEB.log"));

		PDFForm form = (PDFForm) p_form;
		String target=new String();
		HttpSession session = request.getSession();
		logger.error("inicio:ActionForward()");
		try {
		
			//GENERAR PDF
			logger.error("Antes de if genera PDF");
			if("generarPDF".equals(form.getAccionPDF())){
			logger.error("Despues de IF");	
			byte[] pdf = (byte[])session.getAttribute("pdf");
			logger.error("Despues de PDF session");
			request.setAttribute("download-bytes", pdf);
			request.setAttribute("download-contentType","application/pdf");
	        request.setAttribute("download-filename","Factura.pdf");
	        target="generarPDF";
			}
		
		}catch(Exception e){
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("Error Inesperado: [" + log + "]");						
			request.setAttribute("desError","Error Al intentar generar PDF");
			target="globalErrorInesperado";			
			return mapping.findForward(target);
		}
		logger.error("inicio:ActionForward()");
		return mapping.findForward(target);
	
	}	
}