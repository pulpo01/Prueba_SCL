package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CambioPlanPendienteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CambioPlanPendienteListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ValidaOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.EspecProductoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioListaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioListaListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.dao.ParseoXML;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProdContratadoOfertadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaAnulaSolicitudForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.PaqueteWeb;

public class ListAnulaSolicitudAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(ListAnulaSolicitudAction.class);
	private Global global = Global.getInstance();
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private PaqueteWeb productos;
	
	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("execute():start");
		boolean continua = true;
		String nombreAction = "cargarSolicitudes";
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = request.getSession(false);
	    
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    
	    if (sessionData.getNumAbonado() != 0){
	    	continua = false;
	    	nombreAction = "ErrorEnActionDeCarga";
			String osInvalida = global.getValor("osNoAbonado");
			session.setAttribute("error", osInvalida);
	    }
	    if(session.getAttribute("camPlanPendienteDTOarr") != null)
	    {//pv140708
	    	logger.debug("Recarga ListAnulaSolicitudAction sess.camPlanPendienteDTOarr != null");
	    	session.removeAttribute("ultimaPagina");
	    }else if (continua) {
	    	// Lectura de archivo XML de configuracion, parseo y carga en objeto de sesion
		 	DefaultPaginaCPUDTO definicionPagina= new DefaultPaginaCPUDTO();
		 	String dirXML = global.getValor("configAnulaSolicitud.xml");
		 	String dir = global.getPathInstancia() +dirXML;
		 	logger.debug("dir="+dir);
		 	ParseoXML parseo=new ParseoXML();
			logger.debug("leyendo y parseando XML configuración:antes");
			definicionPagina=parseo.cargaXML(dir);
			logger.debug("leyendo y parseando XML configuracion:despues");
			sessionData.setDefaultPagina(definicionPagina);
						
			
			AbonadoListDTO listaAbonados=null;
			String codTipoPlanTarif = null;
		    ClienteDTO cliente =sessionData.getCliente();
		    
		    if (sessionData.getCodCliente() != 0) {
				session.removeAttribute("error");
				logger.debug("obtenerListaAbonados:antes");
				listaAbonados = delegate.obtenerListaAbonados(sessionData.getCliente());
				logger.debug("obtenerListaAbonados:despues");
				if (listaAbonados != null) {
					//isListAbonados = true;
					AbonadoDTO[] abonados = listaAbonados.getAbonados();
					listaAbonados.setAbonados(abonados);
					sessionData.setAbonados(listaAbonados.getAbonados());
				}
			}
		    
		    
		    /*
		    if(sessionData.getNumAbonado() != 0){
		    	abonado.setNumAbonado(sessionData.getNumAbonado());
		    	logger.debug("obtenerDatosAbonado :inicio");
		    	abonado=delegate.obtenerDatosAbonado(abonado);
		    	logger.debug("obtenerDatosAbonado :fin");
		    }else{
		    	abonado.setNumAbonado(0);
		    }

		    abonados[0]=abonado;
	    	abonadoLista.setAbonados(abonados);
	    	sessionData.setAbonados(abonadoLista.getAbonados());
			cliente.setAbonados(abonadoLista);
			sessionData.setCliente(cliente);
			*/
			

			CambioPlanPendienteListDTO cambioPlanPendienteListDTO=delegate.obtenerSolicPendPlan(cliente);
			CambioPlanPendienteDTO[] camPlanPendienteDTOarr = cambioPlanPendienteListDTO.getCambioPlanPendienteList();	
			
			System.out.println("camPlanPendienteDTOarr.length  :" + camPlanPendienteDTOarr.length);
			/*if(camPlanPendienteDTOarr.length < 1)
			{//NO EXISTEN OOSS PENDIENTES DE CAMBIO DE PLAN
				throw new ManReqException();
			}//EXISTEN OOSS PENDIENTES DE CAMBIO DE PLAN ¿Desea Continuar?*/
			if (camPlanPendienteDTOarr.length < 1){
		    	continua = false;
		    	nombreAction = "ErrorEnActionDeCarga";
				String osInvalida = global.getValor("osNoExisteOSS");
				session.setAttribute("error", osInvalida);
		    }
			
			if (continua){
				codTipoPlanTarif = cliente.getCodTipoPlanTarif();
			    ArrayList checksSolicitud=new ArrayList();
			    //Si es Empresa se checkean todos y se deshabilitan
			    String esEmpresa = "false";
			    if("E".equals(codTipoPlanTarif))//(codTipoPlanTarif != null && codTipoPlanTarif.eq("E"))
			    {
			    	esEmpresa = "true";
			    }
		    	for(int i=0;i<camPlanPendienteDTOarr.length;i++)
			    {
		    		checksSolicitud.add(esEmpresa);
		    		//if(i%3==0)
			    	//{
		    		//checksSolicitud.add("false"); 
			    	//}
			    }
				
				session.removeAttribute("controlesList");
				XMLDefault objetoXML	= new XMLDefault();
			    DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
			    SeccionDTO seccion=new SeccionDTO();
			    
			    ArrayList controlesList=new ArrayList();
			    objetoXMLSession = sessionData.getDefaultPagina();
			    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "piePaginaCargosPAG", "CargosCondicionesRegistroSS");
			    controlesList.add(seccion.obtControl("condicionesCK"));
			    
			    session.setAttribute("controlesList", controlesList);		
				session.setAttribute("checksSolicitud", checksSolicitud);
				session.setAttribute("camPlanPendienteDTOarr", camPlanPendienteDTOarr);
				
				ListaAnulaSolicitudForm form1 = (ListaAnulaSolicitudForm) form;
				// cuando carga la pagina por PRIMERA vez por defecto coloca el check marcado 
				if(form1.getCondicH()== null){
			    	form1.setCondicH("SI");
			    }
				
				
				//validar ordenes pendientes plan  PREGUNTAR SI ESTO VA!!!!!!!!!!
				ValidaOOSSDTO validaOS = new ValidaOOSSDTO();
				validaOS.setCodCliente(sessionData.getCliente().getCodCliente());
				validaOS.setCodPlanTarif(sessionData.getCliente().getCodPlanTarif());
				validaOS.setNumAbonado(sessionData.getAbonados()[0].getNumAbonado());
						
				//logger.debug("validaOossPendPlan():inicio");
				//validaOS = delegate.validaOossPendPlan(validaOS);
				//logger.debug("validaOossPendPlan():fin");	
			}	
	    }
		
		logger.debug("execute():end");
		return mapping.findForward(nombreAction);
		
	}

}
