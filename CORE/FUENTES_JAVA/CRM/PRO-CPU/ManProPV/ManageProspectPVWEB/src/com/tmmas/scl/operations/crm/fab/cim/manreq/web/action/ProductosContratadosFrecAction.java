 package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.dao.ParseoXML;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;


public class ProductosContratadosFrecAction extends Action {
	
	private final Logger logger = Logger.getLogger(ProductosContratadosFrecAction.class);
	private Global global = Global.getInstance();

	String  CLASS_NAME = "ProductosContratadosFrecAction";
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String METHOD_NAME = "execute";
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug(CLASS_NAME+" "+METHOD_NAME+"----------------------------ini------------------------------------>");
		logger.debug("execute():start");
		
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = request.getSession(false);
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    
	    // Lectura de archivo XML de configuracion, parseo y carga en objeto de sesion
	 	DefaultPaginaCPUDTO def= new DefaultPaginaCPUDTO();
		ParseoXML parseo=new ParseoXML();
		logger.debug("leyendo  y parseando XML configuración:antes");
		//def=parseo.cargaXML();
		logger.debug("leyendo  y parseando XML configuración:despues");
		sessionData.setDefaultPagina(def);

	    XMLDefault objetoXML	= new XMLDefault();
	    DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
	    SeccionDTO seccion=new SeccionDTO();
	    objetoXMLSession = sessionData.getDefaultPagina();
	    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "piePaginaCargosPAG", "CargosCondicionesRegistroSS");

	    String individualOEmpresa = sessionData.getCliente().getCodTipoPlanTarif();
	    logger.debug("flujo individual o Empresa :"+ individualOEmpresa);
	    //String NumerosFrecuentes ="NumerosFrecuentes";
	    String productosContratadosFrec ="ProductosContratadosFrec";
	   
		//logger.debug("execute():end");
		logger.debug(CLASS_NAME+" "+METHOD_NAME+"----------------------------fin------------------------------------>");
		return mapping.findForward(productosContratadosFrec);
		
	}
	

}
