package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ConDesPlanForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.SolicitudAutDescuentoForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class ControlNavegacionCargosAction extends BaseAction{

	private final Logger logger = Logger.getLogger(ControlFlujoCPUAction.class);
	private Global global = Global.getInstance();
	private static final String OBTENCION_CARGOS 		= "obtenerCargos";
	private static final String CARGOS 					= "cargosAction";
	private static final String SOLICITUD_DESCUENTO 	= "solicDescuento";
	private static final String RESUMEN 				= "resumenAction";
	private static final String PRESUPUESTO				= "presupuesto";
	private static final String INICIO					= "inicio";
	
	protected ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)throws Exception {
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		HttpSession session = request.getSession(false);
		
		
		
		
		String controlUltPagina = (String)session.getAttribute("ultimaPagina");
		session.setAttribute("ultimaPagina","");
		String recalcular = (String)session.getAttribute("recalcular");
		String solicDesc = (String)session.getAttribute("cumpleDescuento");
		String autDesc = (String) session.getAttribute("accionAutDesc");
		CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");

		ConDesPlanForm conDesPlanForm = (ConDesPlanForm)session.getAttribute("ConDesPlanForm");
		boolean condicionesCK = false;
		if (conDesPlanForm != null){
			condicionesCK = conDesPlanForm.isCondicionesCK();
		}

		//CambiarPlanForm cambiarPlanForm = (CambiarPlanForm)session.getAttribute("CambiarPlanForm");
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		
		//String siguiente=null;
		if(sessionData.getObtenerCargos()!=null&&sessionData.getObtenerCargos().equalsIgnoreCase("NO")){
			return mapping.findForward(RESUMEN);
		}else if(sessionData.getObtenerCargos()!=null&&sessionData.getObtenerCargos()!=null&&sessionData.getObtenerCargos().equalsIgnoreCase("NO")&&controlUltPagina!=null&&controlUltPagina.equalsIgnoreCase("Resumen")){
			return mapping.findForward(INICIO);
		}else if(controlUltPagina==null||controlUltPagina.equalsIgnoreCase("")||controlUltPagina.equalsIgnoreCase("negocio")||controlUltPagina.equalsIgnoreCase("INICIO")){
			//Si viene desde un action externo a cargos
			return mapping.findForward(CARGOS);
			
			//Si la última página es cargos y hay que recalcular cargos -->ActionExterno
		}else if(controlUltPagina.equalsIgnoreCase("cargos")&&recalcular!=null&&recalcular.equalsIgnoreCase("SI")){
			//System.out.println("RECALCULAR CARGOS");

			session.setAttribute("recalcular", "NO");
			return mapping.findForward(OBTENCION_CARGOS);
			
			//Si la última página visitada es cargos y no hay que recalcular-->ResumenAction
		}else if(controlUltPagina.equalsIgnoreCase("cargos")){
			
			if(solicDesc!=null && solicDesc.equalsIgnoreCase("SI")){
				session.setAttribute("cumpleDescuento", "NO");
				
				SolicitudAutDescuentoForm solDesc = (SolicitudAutDescuentoForm)session.getAttribute("SolicitudAutDescuentoForm");
				if(solDesc!=null){
					solDesc.setFlgIniciado(false); 
				}
				return mapping.findForward(SOLICITUD_DESCUENTO);
			}else if(cargosForm.getRbCiclo().equalsIgnoreCase("NO")){
				return mapping.findForward(PRESUPUESTO);
			}
			return mapping.findForward(RESUMEN);
		
		}else if(controlUltPagina.equalsIgnoreCase("SolicDescuento")){
			session.setAttribute("accionAutDesc","");
			if(autDesc!=null&&autDesc.equalsIgnoreCase("Atras")){
				return mapping.findForward(CARGOS);
			}else{
				if(cargosForm!=null&&cargosForm.getRbCiclo()!=null&&cargosForm.getRbCiclo().equalsIgnoreCase("SI")){
					return mapping.findForward(RESUMEN);
				}else{
					
					return mapping.findForward(PRESUPUESTO);
				}
			}
		}else if(controlUltPagina.equalsIgnoreCase("Presupuesto")){
			session.setAttribute("accionAutDesc","");
			if(autDesc!=null){
				if(autDesc.equalsIgnoreCase("Anterior")){
					return mapping.findForward(CARGOS);
				}else{
					return mapping.findForward(RESUMEN);
				}
			}
		}
		
			
	
		
		
		logger.debug("execute():end");
		
		return mapping.findForward("error");
	}
	
}
