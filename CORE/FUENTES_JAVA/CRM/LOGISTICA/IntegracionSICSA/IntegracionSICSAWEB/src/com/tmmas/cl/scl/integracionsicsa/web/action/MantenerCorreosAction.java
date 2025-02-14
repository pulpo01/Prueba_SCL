package com.tmmas.cl.scl.integracionsicsa.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.scl.integracionsicsa.common.dto.CorreoDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocal;
import com.tmmas.cl.scl.integracionsicsa.web.form.MantenerCorreosForm;
import com.tmmas.cl.scl.integracionsicsa.web.helper.IntegracionSICSAServiceLocator;

public class MantenerCorreosAction extends Action {
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
		logger.debug("inicio: MantenerCorreosAction", nombreClase);
		try {

			MantenerCorreosForm form = (MantenerCorreosForm) p_form;
			logger.debug("form.getCmbGrupo(): " + form.getCmbGrupo(),
					nombreClase);
			logger.debug("getAccion(): " + form.getAccion(), nombreClase);

			HttpSession session = request.getSession();
			integracionSICSAServiceLocator = new IntegracionSICSAServiceLocator();

			integracionSICSALocal = integracionSICSAServiceLocator
					.getIntegracionSICSALocal();

			if ("buscarCorreos".equals(form.getAccion())) {

				CorreoDTO[] correoDTOs = integracionSICSALocal.getCorreos(form
						.getCmbGrupo());
				session.setAttribute("correoDTOs", correoDTOs);

			} else if ("eliminarCorreo".equals(form.getAccion())) {

				integracionSICSALocal.borrarCorreo(form.getCmbGrupo(), form
						.getAntiCorreo());
				CorreoDTO[] correoDTOs = integracionSICSALocal.getCorreos(form
						.getCmbGrupo());
				session.setAttribute("correoDTOs", correoDTOs);

			} else if ("modificarCorreo".equals(form.getAccion())) {
				boolean modificar = true;
				CorreoDTO[] correoDTOs = (CorreoDTO[]) session
						.getAttribute("correoDTOs");
				// Valido que no exista
				for (int i = 0; i <= correoDTOs.length - 1; i++) {
					if (correoDTOs[i].getMail().equals(form.getNuevoCorreo())) {
						modificar = false;
						break;
					}
				}
				if (modificar) {//Si existe ya el correo no hago nada
					integracionSICSALocal.modificarCorreo(form.getCmbGrupo(),
							form.getAntiCorreo(), form.getNuevoCorreo(), form
									.getNuevoUsuario());
				correoDTOs = integracionSICSALocal.getCorreos(form
						.getCmbGrupo());
				
				session.setAttribute("correoDTOs", correoDTOs);
				}

			} else if ("insertarCorreo".equals(form.getAccion())) {
				CorreoDTO[] correoDTOs = (CorreoDTO[]) session
						.getAttribute("correoDTOs");

				// Valido que no exista
				for (int i = 0; i <= correoDTOs.length - 1; i++) {
					if (correoDTOs[i].getMail().equals(form.getNuevoCorreo())) {
						throw new IntegracionSICSAException("ERR.0023", 0);
					}
				}
				integracionSICSALocal.insertarCorreo(form.getCmbGrupo(), form
						.getNuevoCorreo(), form.getNuevoUsuario());
				correoDTOs = integracionSICSALocal.getCorreos(form
						.getCmbGrupo());
				session.setAttribute("correoDTOs", correoDTOs);

			}

			target = "correos";

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
		logger.debug("fin: MantenerCorreosAction", nombreClase);
		return mapping.findForward(target);
	}

}
