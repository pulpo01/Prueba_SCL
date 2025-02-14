package com.tmmas.scl.doblecuenta.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

public class Login extends Action {

	/* forward name="success" path="/pages/welcome.jsp" */
	private final static String SUCCESS = "success";

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		//System.out.println("Login");
		// return mapping.findForward(SUCCESS);
		return mapping.findForward(SUCCESS);
	}

}
