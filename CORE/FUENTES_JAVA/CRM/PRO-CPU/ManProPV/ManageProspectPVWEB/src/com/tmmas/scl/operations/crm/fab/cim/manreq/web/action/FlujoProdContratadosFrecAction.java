package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

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
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProductoContratadoFrecDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaProdContratadosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ProductosContradosFrecUtil;

public class FlujoProdContratadosFrecAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(FlujoProdContratadosFrecAction.class);
	private Global global = Global.getInstance();
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
		
	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("execute():start");
		ListaProdContratadosForm form1 = (ListaProdContratadosForm) form;
		
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = request.getSession(false);
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    
	    //(+) EV 16/02/09
	    //List productosContratadosList = (List)session.getAttribute("productosContratadosFrec");
	    List productosContratadosList = (List)session.getAttribute("productosContratadosFrecOrig");
	    //(-)
	    
	    ProductoContratadoFrecDTO [] productosContratadosFrecSess = (ProductoContratadoFrecDTO [])session.getAttribute("productosContratadosFrecSess");
	    
	    NumeroListDTO numeroListAdd = ProductosContradosFrecUtil.obtieneProductosAgregados(productosContratadosFrecSess,productosContratadosList,sessionData.getNumOrdenServicio());
	    NumeroListDTO numeroListDel = ProductosContradosFrecUtil.obtieneProductosEliminados(productosContratadosFrecSess,productosContratadosList,sessionData.getNumOrdenServicio());
	    
	    /**Se agrega 13-10-2009//revisar si se debe setear esto 03-08-09 pv ini*/
	    
	    numeroListAdd.setCodCliente(""+sessionData.getCliente().getCodCliente());
	    numeroListAdd.setNumAbonado(""+sessionData.getNumAbonado());
	    numeroListAdd.setTipoComportamiento("PFRC");
	    logger.debug("numeroListAdd.getCodCliente()["+numeroListAdd.getCodCliente()+"]");
	    logger.debug("numeroListAdd.getNumAbonado()["+numeroListAdd.getNumAbonado()+"]");
	    logger.debug("numeroListAdd.getTipoCompor()["+numeroListAdd.getTipoComportamiento()+"]");
	    /** Se agrega 13-10-2009//revisar si se debe setear esto 030809 fin*/
	    
	    
	    //Objetos de session que contiene los numeros que deberan ser recuperadas en el action de registro de afines 
	    //y setearlas como atributos del objeto que se registrara
	    session.setAttribute("numeroListAdd", numeroListAdd);  
	    session.setAttribute("numeroListDel", numeroListDel);
	    
	    SecuenciaDTO secuencia=new SecuenciaDTO();
	    if(sessionData.getNumOrdenServicio()== 0){
			logger.debug("obtenerSecuencia:antes");
			secuencia.setNomSecuencia("CI_SEQ_NUMOS");
			logger.debug("nomSecuencia :"+secuencia.getNomSecuencia());
			secuencia = delegate.obtenerSecuencia(secuencia);
		    sessionData.setNumOrdenServicio(secuencia.getNumSecuencia());
		    logger.debug("obtenerSecuencia:despues");
		}
	    
	    
	    
	    String[] codAbonado = new String[1];
	    codAbonado[0] = String.valueOf(sessionData.getAbonados()[0].getNumAbonado());
	    
	    ConversionListDTO conversionList=null;
	    ConversionDTO param = new ConversionDTO();
		param.setCodOOSS(sessionData.getCodOrdenServicio());
		param.setCodTipModi("-");
		logger.debug("param.getCodOOSS()    :["+param.getCodOOSS()+"]");
		logger.debug("param.getCodTipModi() :["+param.getCodTipModi()+"]");
		logger.debug("obtenerConversionOOSS():inicio");
		conversionList = delegate.obtenerConversionOOSS(param);
		logger.debug("obtenerConversionOOSS():fin");
		
		sessionData.setCodAbonado(codAbonado);
		sessionData.setSinCondicionesComerciales(form1.getCondicH());
		sessionData.setCodActAbo(conversionList.getRegistros()[0].getCodActuacion());
		sessionData.setTipoPantallaPrevia(String.valueOf(2));  // Se setea valor 2 para que en la query dinamica de obtencion de cargos por uso, no se considerado el codigo de concepto
		sessionData.setObtenerCargos("SI");
		sessionData.setCodActAboCargosUso(conversionList.getRegistros()[0].getCodActuacion());
		
		/*String numProceso = ""+sessionData.getNumOrdenServicio(); pv 270208 por si se necesitara el idProceso
		 * se agregaria a ParamMantencionFrecuentesDTO
		logger.debug("crearProceso con numProceso ["+numProceso+"]");
		ParametroSerializableDTO proceso=delegate.crearProceso(numProceso);
		proceso.setNumProceso(""+sessionData.getNumOrdenServicio());

		session.setAttribute("idProceso", proceso.getIdProceso());*/
		session.setAttribute("ClienteOOSS", sessionData);
	    
	    
		
		logger.debug("execute():end");
		return mapping.findForward("cargosFrecuentes");
		
	}

}
