package com.tmmas.cl.scl.integracionsicsa.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ConsultaDevolucionUsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.UsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocal;
import com.tmmas.cl.scl.integracionsicsa.web.form.BuscaDevolucionForm;
import com.tmmas.cl.scl.integracionsicsa.web.helper.IntegracionSICSAServiceLocator;

public class BuscaDevolucionAction extends Action {
	/**
	 *@author H.O.M
	 */
	private final LoggerHelper logger = LoggerHelper.getInstance();
	private final String nombreClase = this.getClass().getName();
	private IntegracionSICSAServiceLocator integracionSICSAServiceLocator;
	private IntegracionSICSALocal integracionSICSALocal;

	private static final long serialVersionUID = 1L;
	String target = new String();

	public ActionForward execute(ActionMapping mapping, ActionForm p_form,
			HttpServletRequest request, HttpServletResponse response) {
		logger.debug("inicio: BuscaDevolucionAction", nombreClase);
		try {

			BuscaDevolucionForm form = (BuscaDevolucionForm) p_form;
			logger.debug("form.getTxtDevolucion(): " + form.getTxtDevolucion(),
					nombreClase);
			logger.debug("form.getTxtPedido(): " + form.getTxtPedido(),
					nombreClase);
			logger.debug("form.getFec_desde(): " + form.getFec_desde(),
					nombreClase);
			logger.debug("form.getFec_hasta(): " + form.getFec_hasta(),
					nombreClase);

			HttpSession session = request.getSession();
			integracionSICSAServiceLocator = new IntegracionSICSAServiceLocator();

			integracionSICSALocal = integracionSICSAServiceLocator
			.getIntegracionSICSALocal();

			UsuarioDTO usuarioDTO = (UsuarioDTO) session.getAttribute("usuarioDTO");

			

			ConsultaDevolucionUsuarioDTO[] devoluciones =null;
			devoluciones = integracionSICSALocal
			.consultarDevolucionUsuario(usuarioDTO.getCodUsuario(), form
					.getTxtDevolucion().trim()==""?null:form.getTxtDevolucion().trim(), form.getFec_desde().trim()==""?null:form.getFec_desde().trim(),
					form.getFec_hasta().trim()==""?null:form.getFec_hasta().trim());
			
			if(devoluciones.length>0){
				session.setAttribute("devoluciones", devoluciones);
			}else{
				session.removeAttribute("devoluciones");
			}
			

			target = "devoluciones";
		} catch (IntegracionSICSAException e) {
			target = "globalError";
			request.setAttribute("desError", e.getDescripcionEvento());
			logger.error(e, nombreClase);
		} catch (Exception e) {
			target = "globalError";
			request.setAttribute("desError",
			"Se ha producido un error no clasificado.");
			logger.error(e, nombreClase);
		}
		logger.debug("fin: BuscaDevolucionAction", nombreClase);
		return mapping.findForward(target);
	}
}
