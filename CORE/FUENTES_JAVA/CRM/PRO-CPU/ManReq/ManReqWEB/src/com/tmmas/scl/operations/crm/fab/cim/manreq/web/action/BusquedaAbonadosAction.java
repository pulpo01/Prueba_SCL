package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
import java.util.Arrays;
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
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PrestacionListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CausaBajaListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.dao.ParseoXML;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.BusquedaAbonadosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class BusquedaAbonadosAction extends BaseAction {

	private final Logger logger = Logger.getLogger(BusquedaAbonadosAction.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		logger.debug("execute():Ini BusquedaAbonadosAction");
		
		int NUM_MAX_ABONADOS;
		int NUM_MAX_PAGINAS;
		String FLG_DISTINTO_TIPO_PLAN;
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);

		
	    HttpSession session = request.getSession(false);
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    
		session.setAttribute("FlujoNavegacion", "INICIO");
	    
		BusquedaAbonadosForm busquedaAbonadosForm = (BusquedaAbonadosForm)form;
		busquedaAbonadosForm.setCodCliente(sessionData.getCodCliente());
		busquedaAbonadosForm.setNumAbonado("");
		busquedaAbonadosForm.setNumCelular("");
		busquedaAbonadosForm.setRutAbonado("");
		busquedaAbonadosForm.setRadioTipoPlan("2");
		busquedaAbonadosForm.setTipoPlanTarif("2");
		logger.debug("execute():BusquedaAbonadosAction");
		
	    XMLDefault objetoXML	= new XMLDefault();
	    DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
	    SeccionDTO seccion=new SeccionDTO();

	 	DefaultPaginaCPUDTO definicionPagina= new DefaultPaginaCPUDTO();
	 	String dirXML = global.getValor("config.xml");
	 	String dir = System.getProperty("user.dir") +dirXML;
	 	logger.debug("dir="+dir);
	 	ParseoXML parseo=new ParseoXML();
		logger.debug("leyendo y parseando XML configuración:antes");
		definicionPagina=parseo.cargaXML(dir);
		logger.debug("leyendo y parseando XML configuración:despues");
		sessionData.setDefaultPagina(definicionPagina);
		
	    objetoXMLSession = sessionData.getDefaultPagina();
	    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "BusquedaAbonadosPAG", "Constantes");
	    FLG_DISTINTO_TIPO_PLAN = seccion.obtControl("FLG_DISTINTO_TIPO_PLAN").getValorDefecto();
	    
	    logger.debug("FLG_DISTINTO_TIPO_PLAN="+FLG_DISTINTO_TIPO_PLAN);
	    
		ParametroDTO parametro = new ParametroDTO();
		parametro.setNomParametro("NUM_MAX_ABONADOS");
		parametro.setCodModulo("GA");
		parametro.setCodProducto(1);
		parametro = delegate.obtenerParametrosSimples(parametro);
		NUM_MAX_ABONADOS =  Math.round(parametro.getValorNum());
		
		parametro.setNomParametro("NUM_MAX_PAGINAS");
		parametro.setCodModulo("GA");
		parametro.setCodProducto(1);
		parametro = delegate.obtenerParametrosSimples(parametro);
		NUM_MAX_PAGINAS =  Math.round(parametro.getValorNum());
		
		busquedaAbonadosForm.setNumMaxAbonados(NUM_MAX_ABONADOS);
		busquedaAbonadosForm.setNumMaxPaginas(NUM_MAX_PAGINAS);
		busquedaAbonadosForm.setFlgAbonadosDistTipoPlan(FLG_DISTINTO_TIPO_PLAN);
	
		logger.debug("NUM_MAX_ABONADOS=" + NUM_MAX_ABONADOS);
		logger.debug("NUM_MAX_PAGINAS=" + NUM_MAX_PAGINAS);
		logger.debug("FLG_DISTINTO_TIPO_PLAN=" + FLG_DISTINTO_TIPO_PLAN);
		logger.debug("execute():Fin BusquedaAbonadosAction");
		
	    logger.debug("obtenerPrestaciones():antes");
	    PrestacionListDTO prestacionesList = delegate.obtenerPrestaciones();
	    logger.debug("obtenerPrestaciones():despues");
	    List prestaciones = Arrays.asList(prestacionesList.getPrestaciones());
		
		session.setAttribute("prestaciones", prestaciones);
		
		return mapping.findForward("busquedaAbonados");

	}

}
