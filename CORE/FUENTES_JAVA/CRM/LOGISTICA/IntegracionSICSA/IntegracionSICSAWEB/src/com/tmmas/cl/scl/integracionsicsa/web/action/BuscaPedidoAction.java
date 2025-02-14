package com.tmmas.cl.scl.integracionsicsa.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import com.tmmas.cl.scl.integracionsicsa.common.dto.ConsultaPedidoUsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.dto.UsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.common.helper.LoggerHelper;
import com.tmmas.cl.scl.integracionsicsa.negocio.session.IntegracionSICSALocal;
import com.tmmas.cl.scl.integracionsicsa.web.form.BuscaPedidoForm;
import com.tmmas.cl.scl.integracionsicsa.web.helper.IntegracionSICSAServiceLocator;

public class BuscaPedidoAction extends Action {
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
		logger.debug("inicio: BuscaPedidoAction", nombreClase);
		try {

			BuscaPedidoForm form = (BuscaPedidoForm) p_form;
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

			ConsultaPedidoUsuarioDTO[] pedidos =null;
			pedidos = integracionSICSALocal
			.consultarPedidosUsuario(usuarioDTO.getCodUsuario(), form
					.getTxtPedido().trim()==""?null:form.getTxtPedido().trim(), form.getFec_desde().trim()==""?null:form.getFec_desde().trim(),
					form.getFec_hasta().trim()==""?null:form.getFec_hasta().trim());
			
			if(pedidos.length>0){
				session.setAttribute("pedidos", pedidos);
			}else{
				session.removeAttribute("pedidos");
			}
			

			target = "pedidos";
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
		logger.debug("fin: BuscaPedidoAction", nombreClase);
		return mapping.findForward(target);
	}
	
}
