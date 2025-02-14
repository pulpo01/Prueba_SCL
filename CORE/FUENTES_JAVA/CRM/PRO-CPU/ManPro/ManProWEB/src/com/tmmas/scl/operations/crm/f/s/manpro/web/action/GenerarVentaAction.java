package com.tmmas.scl.operations.crm.f.s.manpro.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.VentaUtils;

public class GenerarVentaAction extends Action{

	private final Logger logger = Logger.getLogger(GenerarVentaAction.class);	 

	
	 public ActionForward execute(
				ActionMapping mapping,
				ActionForm form,
				HttpServletRequest request,
				HttpServletResponse response) throws Exception
	{
		  
		 	String forward="DesplegarCargos";
		 	
		 	try
		 	{
		 		
		 		request.getSession().setAttribute("contratarPorDefecto", request.getParameter("contratarPorDefecto")); // INC 155400 18112010
		 		//logger.debug("request.getSession().getAttribute(contratarPorDefecto = " + request.getSession().getAttribute("contratarPorDefecto"));
		 		
			 	VentaDTO venta=(VentaDTO)request.getSession().getAttribute("VentaDTO");
			 	NavegacionWeb navegacion=(NavegacionWeb)request.getSession().getAttribute("navegacion");
			 	VentaUtils utils=VentaUtils.getInstance();		
			 	
			 	logger.debug("Ingreso a generar Venta");
			 	venta=utils.generarVentaDTO(navegacion, venta);	
			 	
			 	//INC 155400 20112010 LO FUERZO para que cambie el estado y escriba			 	
			 	navegacion.setHayPDTporDefecto(venta.isHayPDTporDefecto()); 
			 	request.getSession().setAttribute("navegacion", navegacion);
			 	//FIN
			 	
			 	//ParametroSerializableDTO proceso=delegate.crearProceso(venta);
			 	venta.setOrigenProceso("VT");
			 	//venta.setNumEvento(proceso.getIdProceso());
			 	
			 	request.getSession().setAttribute("VentaDTO", venta);
		 	}
		 	catch(Exception e)
		 	{
		 		forward="mensajeError";
				request.setAttribute("exception", e.getMessage());
		 	}
			return mapping.findForward(forward);
	 }
}