package com.tmmas.cl.scl.portalventas.web.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.scl.commonbusinessentities.dto.NumeroFrecuenteDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.NumeroFrecuenteTipoListDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.form.NumerosFrecuentesForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;

public class NumerosFrecuentesAction extends DispatchAction {
	private final Logger logger = Logger.getLogger(NumerosFrecuentesAction.class);
	private Global global = Global.getInstance();
	
	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();	
	
	public ActionForward inicio(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("inicio, inicio");
		NumerosFrecuentesForm numerosFrecuentesForm = (NumerosFrecuentesForm)form;
		
		int  maximoNumFijos = numerosFrecuentesForm.getMaxNumFijos();
		int  maximoNumMoviles = numerosFrecuentesForm.getMaxNumMoviles();
		int  cantMax = maximoNumFijos + maximoNumMoviles;
		
		//Se crea la lista de tipos de números
		ArrayList arrTipos = new ArrayList();
		arrTipos.add("MOVILES");
		arrTipos.add("RED-FIJA");
		
		//inicializa
		
		ArrayList numerosFrecuentesTipoListDTO = new ArrayList();
	
		NumeroFrecuenteTipoListDTO numeroFrecuenteTipoListDTO = null;
		for (int x = 0; x < 2; x++){				
			numeroFrecuenteTipoListDTO = new NumeroFrecuenteTipoListDTO();
			numeroFrecuenteTipoListDTO.setTipo((String) arrTipos.get(x));
			if (((String)arrTipos.get(x)).equals("MOVILES")) {
				numeroFrecuenteTipoListDTO.setCantidadMaxTipo(maximoNumMoviles);
			} else {
				numeroFrecuenteTipoListDTO.setCantidadMaxTipo(maximoNumFijos);
			}
			
			NumeroFrecuenteDTO[] numFrecuentesIngresadosList = new NumeroFrecuenteDTO[0];
			numeroFrecuenteTipoListDTO.setNumFrecuentesIngresadosList(numFrecuentesIngresadosList);
			numerosFrecuentesTipoListDTO.add(numeroFrecuenteTipoListDTO);
		}										
		
		//Se debe agregar que cargue lo que quedo en sesion
		
		HttpSession session = request.getSession(false);
		
		session.setAttribute("maximoNumFijos", ""+maximoNumFijos);
		session.setAttribute("maximoNumMoviles", ""+maximoNumMoviles);		
		session.setAttribute("cantMaxNrosFrecuentes", String.valueOf(cantMax));
		session.setAttribute("arrTipos", arrTipos);
		session.setAttribute("numerosFrecuentesList", numerosFrecuentesTipoListDTO);		
		
		logger.info("inicio, fin");
		
		return mapping.findForward("inicio");
	}	
	
	public ActionForward aceptar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("aceptar, inicio");
		logger.info("aceptar, fin");
		
		return mapping.findForward("aceptar");
	}
}
