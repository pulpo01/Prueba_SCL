package com.tmmas.cl.scl.portalventas.web.helper;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.scl.commonbusinessentities.dto.GaContactoAbonadoToDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ParametrosGlobalesDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.ListadoSSOutDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;


public class ServSuplAJAX {
	private final Logger logger = Logger.getLogger(ServSuplAJAX.class);
	private Global global = Global.getInstance();
	
	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();
	
	public void actualizarListasSesion(String tipoListaTraspaso, String codServicio){
		
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		
		if (!validarSesion(sesion)){
			//retorno.setCodError("-100");
			//retorno.setMsgError("Su sesión ha expirado");
			return;	
		}
		
		ArrayList listaServiciosAct = (ArrayList)sesion.getAttribute("listaServiciosAct");
		ArrayList listaServiciosDisp = (ArrayList)sesion.getAttribute("listaServiciosDisp");
		
		if (listaServiciosAct == null)   listaServiciosAct  = new ArrayList();
		if (listaServiciosDisp == null)  listaServiciosDisp = new ArrayList();
		
		
		//se carga el servicio en lista de disponibles y se elimina de lista a activar
		if (tipoListaTraspaso.equals("DISP")){
			ArrayList listaServiciosActAux = new ArrayList();//nueva lista a activar

			for(int i=0;i<listaServiciosAct.size();i++){
				ListadoSSOutDTO ssSel = (ListadoSSOutDTO)listaServiciosAct.get(i);
				
				if (ssSel.getCodigoServicio().equals(codServicio))	listaServiciosDisp.add(ssSel);
				else										listaServiciosActAux.add(ssSel);
			}//fin for
			
			listaServiciosAct = listaServiciosActAux;
		}
		else if (tipoListaTraspaso.equals("ACT")){//carga servicio en lista a activar y lo elimina de disponibles
			ArrayList listaServiciosDispAux = new ArrayList();//nueva lista ss disponibles

			for(int i=0;i<listaServiciosDisp.size();i++){
				ListadoSSOutDTO ssSel = (ListadoSSOutDTO)listaServiciosDisp.get(i);
				
				if (ssSel.getCodigoServicio().equals(codServicio))	listaServiciosAct.add(ssSel);
				else										listaServiciosDispAux.add(ssSel);
			}//fin for
			
			listaServiciosDisp = listaServiciosDispAux;
		}
		
		sesion.setAttribute("listaServiciosAct", listaServiciosAct);
		sesion.setAttribute("listaServiciosDisp", listaServiciosDisp);
		
	}
	
	public void cargaContactos(GaContactoAbonadoToDTO contacto){
		
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
	    logger.debug("cargaContactos!!!!");
	    logger.debug("contacto.apellido:" + contacto.getApellido1Contacto());
	    logger.debug("contacto.apellido2:" + contacto.getApellido2Contacto());
	    
	    ArrayList listaContactos = (ArrayList)sesion.getAttribute("listaContactos");
	    if (listaContactos == null)   listaContactos  = new ArrayList();
	    listaContactos.add(contacto);
	    
        sesion.setAttribute("listaContactos", listaContactos);
	}	
	
	private boolean validarSesion(HttpSession sesion){

		if (sesion == null)	return false;
			
		ParametrosGlobalesDTO sessionData = (ParametrosGlobalesDTO)sesion.getAttribute("paramGlobal"); 
		if (sessionData == null) return false;
		
		return true;
	}	
}
