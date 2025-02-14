// P-CSR-11002 JLGN 04-04-2011 JLGN

package com.tmmas.cl.scl.portalventas.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.scl.altacliente.presentacion.helper.Global;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;

public class CargarLogin extends Action {
	private final Logger logger = Logger.getLogger(CargarLogin.class);
	private Global global = Global.getInstance();
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("execute, inicio");
		HttpSession session = request.getSession(false);
		if (session!=null){
			session.removeAttribute("paramGlobal");
			session.invalidate();
		}
		ParametrosGlobalesDTO sessionData = new ParametrosGlobalesDTO();
		
		request.getSession(true).setAttribute("paramGlobal", sessionData );
		
		String nomOperador = global.getValorExterno("modulo.web.operadora");
		request.getSession().setAttribute("nomOperador", nomOperador);
		
		logger.info("execute, fin");				
		return mapping.findForward("success");
	}

}
