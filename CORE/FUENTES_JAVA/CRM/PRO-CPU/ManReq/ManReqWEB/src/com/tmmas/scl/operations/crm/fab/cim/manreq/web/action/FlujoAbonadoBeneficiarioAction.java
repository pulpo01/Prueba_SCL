package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DescuentoProductoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.CargoWebDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ManAboBeneForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class FlujoAbonadoBeneficiarioAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(FlujoAbonadoBeneficiarioAction.class);
	private Global global = Global.getInstance();
	ArrayList listaCargosAMostrar=new ArrayList();
	ArrayList listaCargosRecurrentes=new ArrayList();	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
		
	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		String nombreFordward="inicioOrdenServicio";
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		ManAboBeneForm form1 = (ManAboBeneForm) form;
		AbonadoDTO[] abonadoDTO=new AbonadoDTO[1];
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = request.getSession(false);
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    String[] codAbonado = new String[1];
	    codAbonado[0] = String.valueOf(sessionData.getNumAbonado());
	    AbonadoDTO abonadoSession=new AbonadoDTO();
	    abonadoSession.setNumAbonado(Long.parseLong(codAbonado[0]));
	    abonadoDTO[0] =delegate.obtenerDatosAbonado(abonadoSession);
	    sessionData.setAbonados(abonadoDTO);
	    ConversionListDTO conversionList=null;
	    ConversionDTO param = new ConversionDTO();
		param.setCodOOSS(sessionData.getCodOrdenServicio());
		param.setCodTipModi("-");
		logger.debug("param.getCodOOSS()    :["+param.getCodOOSS()+"]");
		logger.debug("param.getCodTipModi() :["+param.getCodTipModi()+"]");
		logger.debug("obtenerConversionOOSS():inicio");
		conversionList = delegate.obtenerConversionOOSS(param);
		logger.debug("obtenerConversionOOSS():fin");
		
		 SecuenciaDTO secuencia=new SecuenciaDTO();
		    if(sessionData.getNumOrdenServicio()== 0){
				logger.debug("obtenerSecuencia:antes");
				secuencia.setNomSecuencia("CI_SEQ_NUMOS");
				logger.debug("nomSecuencia :"+secuencia.getNomSecuencia());
				secuencia = delegate.obtenerSecuencia(secuencia);
			    sessionData.setNumOrdenServicio(secuencia.getNumSecuencia());
			    logger.debug("obtenerSecuencia:despues");
			}
		
		
		sessionData.setCodAbonado(codAbonado);
		sessionData.setSinCondicionesComerciales(form1.getCondicH());
		sessionData.setCodActAbo(conversionList.getRegistros()[0].getCodActuacion());
		sessionData.setCodActAboCargosUso(conversionList.getRegistros()[0].getCodActuacion());
		sessionData.setTipoPantallaPrevia(String.valueOf(2));  // Se setea valor 2 para que en la query dinamica de obtencion de cargos por uso, no se considerado el codigo de concepto
		boolean isExisteAbonados=(form1.getListaEncolar()!=null&&form1.getListaEncolar().length>0)?true:false;		
		session.setAttribute("ClienteOOSS", sessionData);
		
		//generarCargosWeb(sessionData.getCliente());
		//VentaDTO venta = obtieneVentaDto(sessionData);
		
		session.removeAttribute("listaCargosAMostrar");
		session.removeAttribute("listaCargosRecurrentes");
		session.setAttribute("listaCargosAMostrar", listaCargosAMostrar);
		session.setAttribute("listaCargosRecurrentes", listaCargosRecurrentes);
		session.setAttribute("ClienteOOSS", sessionData);
		//session.setAttribute("venta", venta);
		logger.debug("execute():end");
	    
		String next=form1.getBtnSiguiente();
		next=next==null?"":next.trim().toUpperCase();
		 if (isExisteAbonados&&next.equals("SIGUIENTE")){
			 nombreFordward="controlNavegacion"; 
		}
		 form1.setBtnSiguiente(null);
		logger.debug("execute():end");
		return mapping.findForward(nombreFordward);
	}
}
