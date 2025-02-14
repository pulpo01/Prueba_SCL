package com.tmmas.cl.scl.integracionsicsa.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import com.tmmas.cl.scl.integracionsicsa.common.dto.GrupoCorreosDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.UsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocal;
import com.tmmas.cl.scl.integracionsicsa.web.helper.IntegracionSICSAServiceLocator;

public class LoginAction extends Action {
	/**
	 *@author H.O.M
	 */
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private final String nombreClase = this.getClass().getName();
	private IntegracionSICSAServiceLocator integracionSICSAServiceLocator;
	private IntegracionSICSALocal integracionSICSALocal;
	private static final long serialVersionUID = 1L;

	public ActionForward execute(ActionMapping mapping, ActionForm p_form,
			HttpServletRequest request, HttpServletResponse response) {
		logger.debug("inicio: LoginAction", nombreClase);
		String target = new String();
		try {
			HttpSession session = request.getSession();

			String menu = request.getParameter("menu");
			
			if(null==menu||"".equals(menu.trim())){
				throw new IntegracionSICSAException("ERR.0022",0);
			}

			integracionSICSAServiceLocator = new IntegracionSICSAServiceLocator();
			integracionSICSALocal = integracionSICSAServiceLocator
			.getIntegracionSICSALocal();
			
			if("BUSCARPEDIDOS".equals(menu.trim().toUpperCase())){
			//Consulta de pedidos
	
			String codUsuario = request.getParameter("strCodigoUsuCre");
			

			UsuarioDTO usuarioDTO = integracionSICSALocal
					.getDatosUsuario(codUsuario);

			session.setAttribute("usuarioDTO", usuarioDTO);

			target = "buscarPedidos";
			
			}else if("MANTENERCORREOS".equals(menu.trim().toUpperCase())){
				//Mantenedor de correos
				
				
				//Traer grupos de correos para llenar el comboBox
				GrupoCorreosDTO[] grupoCorreosDTOs = integracionSICSALocal.getGruposCorreos();
				session.setAttribute("grupoCorreosDTOs", grupoCorreosDTOs);			
				
				target="mantenedorCorreos";
				
			}else if("BUSCARDEVOLUCIONES".equals(menu.trim().toUpperCase())){
				//Consulta de pedidos
				
				String codUsuario = request.getParameter("strCodigoUsuCre");
				

				UsuarioDTO usuarioDTO = integracionSICSALocal
						.getDatosUsuario(codUsuario);

				session.setAttribute("usuarioDTO", usuarioDTO);

				target = "buscarDevoluciones";
				
			}else{
				throw new IntegracionSICSAException("ERR.0022",0);
			}

		} catch (IntegracionSICSAException e) {
			target="globalError";
			request.setAttribute("desError", e.getDescripcionEvento());
			logger.error(e, nombreClase);
		} catch (Exception e) {
			target="globalError";
			request.setAttribute("desError", "Se ha producido un error no clasificado.");
			logger.error(e, nombreClase);
		}
		logger.debug("fin: LoginAction", nombreClase);
		return mapping.findForward(target);
	}

}
