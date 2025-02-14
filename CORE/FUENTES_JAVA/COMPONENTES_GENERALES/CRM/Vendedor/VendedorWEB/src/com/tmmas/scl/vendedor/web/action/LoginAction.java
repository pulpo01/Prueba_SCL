package com.tmmas.scl.vendedor.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.vendedor.web.delegate.VendedorDelegate;
import com.tmmas.scl.vendedor.web.helper.Global;

public class LoginAction extends Action {

	private final Logger logger = Logger.getLogger(LoginAction.class);

	private Global global = Global.getInstance();

	private final static String SUCCESS = "success";

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {


		String log = global.getValor("web.log");
		log = System.getProperty("user.dir") + log;
		PropertyConfigurator.configure(log);

		logger.debug("execute():start");

     	logger.debug("execute():end");
		return mapping.findForward(SUCCESS);
	}
}
