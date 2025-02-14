package com.tmmas.scl.operations.crm.fab.cusintman.web.exception;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ExceptionHandler;
import org.apache.struts.config.ExceptionConfig;
import com.tmmas.cl.framework.util.StackTraceUtl;

import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;

public class CusIntManExceptionHandler  extends ExceptionHandler {
	private final Logger logger = Logger.getLogger(CusIntManExceptionHandler.class);

	public ActionForward execute(Exception e, ExceptionConfig eC, ActionMapping mapping, ActionForm form, HttpServletRequest req, HttpServletResponse resp) throws ServletException {
		logger.debug("execute():start");

		try	{
			CusIntManException exc = (CusIntManException) e;
			if (exc.getDescripcionEvento() != null)	{
				req.setAttribute("tituloError", corrigeFormato(exc.getDescripcionEvento() + "<BR>N&uacute;mero de Evento = " + exc.getCodigoEvento()));
				req.setAttribute("descripcionError", corrigeFormato(StackTraceUtl.getStackTrace(exc)));
			}
			else if	(exc.getMessage() != null)	{
				req.setAttribute("tituloError", corrigeFormato(exc.getMessage()));
				req.setAttribute("descripcionError", corrigeFormato(e.getCause().toString()));
			} // if
		} // try
		catch (Exception ex)	{
			if (e.getMessage() != null)	{
				req.setAttribute("tituloError", corrigeFormato(e.getMessage()));
				req.setAttribute("descripcionError", corrigeFormato(StackTraceUtl.getStackTrace(e)));
			} // if
		} // catch
		
		
		logger.debug("execute():end");
		
		return super.execute((Exception)e, eC, mapping, form, req, resp);
	}
	
	// ------------------------------------------------------------------------------------
	
	private String corrigeFormato(String mensaje)	{

		mensaje = mensaje.replaceAll("\n", "<BR>");
		mensaje = mensaje.replaceAll("\t", "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;");

		return mensaje;
		
	}  // corrigeFormato
	
//	 ------------------------------------------------------------------------------------
}
