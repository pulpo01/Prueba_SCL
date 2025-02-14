package com.tmmas.cl.scl.portalventas.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.altacliente.presentacion.helper.Global;

public class InicioAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(InicioAction.class);
	private Global global = Global.getInstance();
	
	public ActionForward cierre(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("cierre, inicio");
		HttpSession session = request.getSession(false);
		if (session!=null){
			session.removeAttribute("paramGlobal");
			session.invalidate();
		}
		
		//Inicio P-CSR-11002 JLGN 04-04-2011
		String nomOperador = global.getValorExterno("modulo.web.operadora");
		logger.info("nombre operador: "+ nomOperador);
		request.getSession().setAttribute("nomOperador", nomOperador);
		//Fin Inicio P-CSR-11002 JLGN 04-04-2011		
		
		logger.info("cierre, fin");				
		return mapping.findForward("cierre");
	}
}
