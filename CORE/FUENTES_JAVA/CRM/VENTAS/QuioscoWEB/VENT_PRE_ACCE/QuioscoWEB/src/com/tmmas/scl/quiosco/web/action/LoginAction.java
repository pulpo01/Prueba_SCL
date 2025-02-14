package com.tmmas.scl.quiosco.web.action;

import java.rmi.RemoteException;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.rpc.ServiceException;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWS;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWSService;
import com.tmmas.cl.scl.spnsclws.pa.SpnSclWSService_Impl;
import com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendasOutDTO;
//import com.tmmas.cl.scl.spnsclws.ws.SpnSclWSProxy;
import com.tmmas.scl.quiosco.web.VO.TiendaVO;
import com.tmmas.scl.quiosco.web.form.LoginForm;
//import dto.businessobject.ventadeaccesorios.scl.cl.tmmas.com.WsTiendasOutDTO;


public class LoginAction extends Action {
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;

	private Logger logger = Logger.getLogger(this.getClass());
	CompositeConfiguration config;

	public LoginAction() throws ServiceException{

		System.out.println("LoginAction:Start");
		config = UtilProperty.getConfigurationfromExternalFile("propiedadesQuioscoWEB.properties");
		UtilLog.setLog(config.getString("QuioscoWEB.log"));
			
	}

	public ActionForward execute(ActionMapping mapping, ActionForm p_form, HttpServletRequest request, HttpServletResponse response) {

		logger.error("ruta.webservice"+config.getString("ruta.webservice"));
		LoginForm form = (LoginForm) p_form;
		String target=new String();
		HttpSession session = request.getSession();

		logger.error("entro al login");
		session.removeAttribute("listaTiendas");
		session.removeAttribute("listaAccesorios");
		session.removeAttribute("totalVO");
		session.removeAttribute("tiendaVendedor");

		ArrayList<TiendaVO> listaTiendas = new ArrayList<TiendaVO>();
		TiendaVO tiendaVO = null;


		WsTiendasOutDTO wsTiendasOutDTO = null;;


		try {
			SpnSclWSService service = new SpnSclWSService_Impl(config.getString("ruta.webservice"));    
			SpnSclWS port = service.getSpnSclWSSoapPort();
			
			com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendasOutDTO getTiendas = new com.tmmas.cl.scl.ventadeaccesorios.businessobject.dto.WsTiendasOutDTO();
			
			
			logger.error("Antes de getTiendas");
			wsTiendasOutDTO = port.getTiendas();
			logger.error("Despues de getTiendas");

			if(wsTiendasOutDTO.getCodError()!=0){
				logger.error("Error : "+ wsTiendasOutDTO.getMsgError());
				request.setAttribute("desError",wsTiendasOutDTO.getMsgError());
				target="globalErrorInesperado";
				return mapping.findForward(target);
			}

			for(int i=0; i<= wsTiendasOutDTO.getTiendaDTOs().length-1;i++){
				tiendaVO = new TiendaVO();
				tiendaVO.setCodTienda(wsTiendasOutDTO.getTiendaDTOs()[i].getCodTienda());
				tiendaVO.setDesTienda(wsTiendasOutDTO.getTiendaDTOs()[i].getDesTienda());
				listaTiendas.add(tiendaVO);
			}

			request.setAttribute("listaTiendas", listaTiendas);
			if("iniciarLogin".equals(form.getAccionLogin())){
				target="login";
			}
			else if("salir".equals(form.getAccionLogin())){
				//Mato todas las sessiones 				
				session.setAttribute("tiendaVendedor", null);
				session.setAttribute("usuarioPrincipal", null);
				session.setAttribute("tienda", null);
				session.setAttribute("cajasDTO", null);
				session.setAttribute("listaLineas", null);
				session.setAttribute("clienteRegistrado", null);
				session.setAttribute("listaStructura", null);
				session.setAttribute("categorias", null);
				session.setAttribute("regiones", null);
				session.setAttribute("tiposIdentificacion",null);
				session.setAttribute("pagoDTO", null);	
				session.setAttribute("totalVO", null);	
				session.setAttribute("listaAccesorios", null);
				session.setAttribute("listaKit", null);
				session.setAttribute("codPrestacion", null);
				target="login";
				
		        
		        request.getSession().invalidate();
		        				
				
			}else if("logout".equals(form.getAccionLogin())){
				
				logger.error("Se elimina Session");
				
				//Mato todas las sessiones
				
				session.removeAttribute("tiendaVendedor");
				
				session.setAttribute("tiendaVendedor", null);
				session.setAttribute("usuarioPrincipal", null);
				session.setAttribute("tienda", null);
				session.setAttribute("cajasDTO", null);
				session.setAttribute("listaLineas", null);
				session.setAttribute("clienteRegistrado", null);
				session.setAttribute("listaStructura", null);
				session.setAttribute("categorias", null);
				session.setAttribute("regiones", null);
				session.setAttribute("tiposIdentificacion",null);
				session.setAttribute("pagoDTO", null);	
				session.setAttribute("totalVO", null);	
				session.setAttribute("listaAccesorios", null);
				session.setAttribute("listaKit", null);
				session.setAttribute("codPrestacion", null);
				target="login";
				
		        
		        request.getSession().invalidate();
		        request = null;
		        
		        logger.error("******************** FIN - Se elimina Session ******************************");
		        				
				
			}else if("subirTienda".equals(form.getAccionLogin())){
				logger.error("subirTienda: "+form.getTienda());
				session.setAttribute("tienda", form.getTienda());
				target="login";
			}
			if(wsTiendasOutDTO.getCodError()!=0){
				request.setAttribute("desError",wsTiendasOutDTO.getMsgError());
				target="globalError";
			}


		} catch (Exception e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("log error[" + log + "]");
			request.setAttribute("desError","Error Inesperado.");
			target="globalErrorInesperado";
			return mapping.findForward(target);
		}catch (Throwable e) {
			String log = StackTraceUtl.getStackTrace(e);
			logger.error("log error[" + log + "]");
			request.setAttribute("desError","Error Inesperado.");
			target="globalErrorInesperado";
			return mapping.findForward(target);
		}

		return mapping.findForward(target);
	}

}
