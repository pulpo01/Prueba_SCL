package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.AnulacionSiniestroBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.ForwardOS;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.SecurityHandler;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;

public class LoginAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(LoginAction.class);
	private Global global = Global.getInstance();
	private AnulacionSiniestroBussinessDelegate delegate = AnulacionSiniestroBussinessDelegate.getInstance();
	private FrmkOOSSBussinessDelegate delegateOOSS = FrmkOOSSBussinessDelegate.getInstance();
	
	protected ActionForward executeAction(ActionMapping mapping,
			ActionForm form, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("executeAction():start");

		logger.debug("--------AnulacionSiniestroWEBEAR.ear CREADO 28/10/2009 13:00 : PV--------");
		
		HttpSession session = request.getSession(false);
		if (session != null) {
            logger.debug("Sesion existente en pagina de login");
            logger.debug("Invalidando sesion existente");
			session.removeAttribute("ClienteOOSS");
			session.invalidate();
		}
		
		SecurityHandler seguridad = new SecurityHandler();
		ClienteOSSesionDTO sessionData = null;
		
		logger.debug("Invocando proceso de validacion de seguridad antes...");
		sessionData = seguridad.validarSeguridad(request, response);
		logger.debug("Invocando proceso de validacion de seguridad despues...");
		
		logger.debug("Creando sesion...");
		session = request.getSession(true);
		session.setAttribute("ClienteOOSS", sessionData);
					
		String forward = ForwardOS.forwardOS(sessionData.getForward(), 1);
	    logger.debug("forward : "+forward); 
		logger.debug("executeAction():end");
		
		// Recupera informacion del usuario para las validaciones
		UsuarioSistemaDTO usuarioSistema = new UsuarioSistemaDTO();
		usuarioSistema.setNom_usuario(sessionData.getUsuario());
		usuarioSistema = delegate.obtenerInformacionUsuario(usuarioSistema);

		// Lo guardo en sesion 
		session.setAttribute("usuarioSistema", usuarioSistema);
		SecuenciaDTO secuencia = new SecuenciaDTO();
		if(sessionData.getNumOrdenServicio()== 0){
			logger.debug("obtenerSecuencia:antes");
			secuencia.setNomSecuencia("CI_SEQ_NUMOS");
			logger.debug("nomSecuencia :"+secuencia.getNomSecuencia());
			secuencia = delegateOOSS.obtenerSecuencia(secuencia);
			sessionData.setNumOrdenServicio(secuencia.getNumSecuencia());
			logger.debug("obtenerSecuencia:despues");
		}
		
		return mapping.findForward(forward);
	}

}
