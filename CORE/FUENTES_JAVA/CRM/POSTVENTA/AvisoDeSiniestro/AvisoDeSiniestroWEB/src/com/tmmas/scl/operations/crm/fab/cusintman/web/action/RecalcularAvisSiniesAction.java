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
			"No es posible llevar a cabo la transacci�n con el m�dulo de cargos, " +
			"favor verificar que exista la siguiente informaci�n: \n" +
			"- C�digo de Art�culo \n" +
			"- N�mero de Serie \n" +
			"- C�digo Uso \n" +
			"- Tipo Stock \n" +
			"- C�digo de Categor�a  \n" +
			"- Modalidad de Venta \n" +
			"- Meses de Prorroga \n" +
			"- C�digo de Promedio Facturado.\n" +
			"Si el problema persiste, favor comunicarse con el administrador de sistema.";
		//e.setMessage(textoMensajeRestricciones);
			session.setAttribute("descripcionError", textoMensajeRestricciones);
			delegate.guardaMensajesError(request, "Error en el M�dulo de Cargos", textoMensajeRestricciones);
			return mapping.findForward("error");
		}
		 return mapping.findForward("finalizar");
	}
}
