package com.tmmas.cl.scl.pv.customerorder.web.exception;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Category;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.action.ExceptionHandler;
import org.apache.struts.config.ExceptionConfig;

import com.tmmas.cl.framework.util.StackTraceUtl;

public class CustomerOrderExceptionHandler  extends ExceptionHandler {
	private Category cat = Category.getInstance(CustomerOrderExceptionHandler.class);

	public ActionForward execute(Exception e, ExceptionConfig eC, ActionMapping mapping, ActionForm form, HttpServletRequest req, HttpServletResponse resp) throws ServletException {
		cat.debug("execute():start");
		cat.debug("execute():end");
		return super.execute(e, eC, mapping, form, req, resp);
	}

	/**
	 * Loguea la excepcion
	 */
	protected void logException(Exception e) {
		cat.debug("logException():start");
		String log = StackTraceUtl.getStackTrace(e);
		cat.debug("logException[" + log + "]");		
		cat.debug("logException():end");
		super.logException(e);
	}

	protected void storeException(HttpServletRequest req, String property, ActionMessage error, ActionForward forward, String scope) {
		cat.debug("storeException():start");
		cat.debug("storeException():end");
		super.storeException(req, property, error, forward, scope);
	}

}
