package com.tmmas.scl.operations.crm.fab.cusintman.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.AvisoSiniestroBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.helper.Global;

public class RecalcularAvisSiniesAction extends BaseAction{
	private Global global = Global.getInstance();
	private final Logger logger = Logger.getLogger(RecalcularAvisSiniesAction.class);
	private String textoMensajeRestricciones;
	private AvisoSiniestroBussinessDelegate delegate = AvisoSiniestroBussinessDelegate.getInstance();	
	protected ActionForward executeAction(ActionMapping mapping, ActionForm form, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		HttpSession session = request.getSession(false);
		try{
		ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		sessionData.setCodActAboCargosUso(global.getValor("ACT_AVISOSINIESTRO"));
		sessionData.setTipoPantallaPrevia("2");
		sessionData.setCargosObtenidos(null);//Limpieza de Cargos
		}catch(Exception e){
			
			textoMensajeRestricciones="No existen tarifas para el equipo seleccionado. " +
			"No es posible llevar a cabo la transacción con el módulo de cargos, " +
			"favor verificar que exista la siguiente información: \n" +
			"- Código de Artículo \n" +
			"- Número de Serie \n" +
			"- Código Uso \n" +
			"- Tipo Stock \n" +
			"- Código de Categoría  \n" +
			"- Modalidad de Venta \n" +
			"- Meses de Prorroga \n" +
			"- Código de Promedio Facturado.\n" +
			"Si el problema persiste, favor comunicarse con el administrador de sistema.";
		//e.setMessage(textoMensajeRestricciones);
			session.setAttribute("descripcionError", textoMensajeRestricciones);
			delegate.guardaMensajesError(request, "Error en el Módulo de Cargos", textoMensajeRestricciones);
			return mapping.findForward("error");
		}
		 return mapping.findForward("finalizar");
	}
}
