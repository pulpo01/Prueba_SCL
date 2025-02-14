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
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CambioPlanPendienteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DescuentoProductoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.helper.NegSalUtils;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.CargoWebDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaAnulaSolicitudForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaProdContratadosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ProductoForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class FlujoAnulaSolicitudAction extends BaseAction {
	
	private final Logger logger = Logger.getLogger(FlujoAnulaSolicitudAction.class);
	private Global global = Global.getInstance();
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();

	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
	
		logger.debug("execute():start");
		String nombreAction = "cargosAnulaSolicitud";
		ListaAnulaSolicitudForm form1 = (ListaAnulaSolicitudForm) form;
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = request.getSession(false);
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	     
	    
		CambioPlanPendienteDTO[] camPlanPendienteDTOarr = (CambioPlanPendienteDTO[])session.getAttribute("camPlanPendienteDTOarr");
		
		/*
		 if(sessionData.getNumOrdenServicio()== 0){
			 obtenerSecuencia(sessionData);
		 }
		*/
	    //AbonadoDTO [] abonados =  delegate.obtenerAbonados(form1.getListaAbonados());
		    
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
					
		session.setAttribute("ClienteOOSS", sessionData);
		String[] listAbo = form1.getListaAbonados();
	    
		logger.debug("codTipoPlanTarif "+sessionData.getCliente().getCodTipoPlanTarif());
				
		
		IOOSSDTO[] ordenServicioArr=null;
		if ("E".equals(sessionData.getCliente().getCodTipoPlanTarif())){
			ordenServicioArr = obtenerSolAnuSel(sessionData,camPlanPendienteDTOarr);
		}else{
			ordenServicioArr = obtenerSolAnuSel(listAbo, camPlanPendienteDTOarr );
		}	
		
		for(int i=0; i<ordenServicioArr.length;i++){
			logger.debug("ordenServicioArr[" + i + "].getCodCliente " + ordenServicioArr[i].getCodCliente());
			logger.debug("ordenServicioArr[" + i + "].getNumAbonado " + ordenServicioArr[i].getNumAbonado());
			logger.debug("ordenServicioArr[" + i + "].getCodPlanTarif " +ordenServicioArr[i].getCodPlanTarif());
			logger.debug("ordenServicioArr[" + i + "].getNumOs " +ordenServicioArr[i].getNumOs());
		}

		CambioPlanPendienteDTO cambioPlanPendienteDTO = null;
		
		for(int i=0;i<camPlanPendienteDTOarr.length;i++)
		{
			cambioPlanPendienteDTO = camPlanPendienteDTOarr[i];
			System.out.println(cambioPlanPendienteDTO.getNumCelular());
			System.out.println(cambioPlanPendienteDTO.getCodCliente());
			System.out.println(sessionData.getCliente().getCodPlanTarif());
		}
		//IOOSSDTO ordenServiRes = delegate.anulaOossPendPlan(ordenServicio);
		session.setAttribute("ordenServicioArr", ordenServicioArr);
		logger.debug("execute():end");
		
		return mapping.findForward(nombreAction);
	}

	private IOOSSDTO[] obtenerSolAnuSel(ClienteOSSesionDTO sessionData,CambioPlanPendienteDTO[] camPlanPendienteDTOarr) {
		IOOSSDTO ordenServicio = null;
		IOOSSDTO ordenServicioArr[] = new IOOSSDTO[camPlanPendienteDTOarr.length];
		for(int i=0;i<camPlanPendienteDTOarr.length;i++)
		{
			ordenServicio = new IOOSSDTO();
			ordenServicio.setCodCliente(camPlanPendienteDTOarr[i].getCodCliente());// long codCliente;
			ordenServicio.setNumAbonado(camPlanPendienteDTOarr[i].getNumAbonado());// long numAbonado;
			ordenServicio.setCodPlanTarif(sessionData.getCliente().getCodPlanTarif());// String codPlanTarif;
			ordenServicio.setNumOs(camPlanPendienteDTOarr[i].getNumOS());//pv 020608
			ordenServicioArr[i]=ordenServicio;
		}
		return ordenServicioArr;
		
	}
	
	private IOOSSDTO[] obtenerSolAnuSel(String[] listAbo, CambioPlanPendienteDTO[] camPlanPendienteDTOarr){
		IOOSSDTO ordenServicio = null;
		IOOSSDTO ordenServicioArr[] = new IOOSSDTO[listAbo.length];
		for(int i=0;i<listAbo.length;i++){
			ordenServicio = new IOOSSDTO();
			AbonadoDTO abonado = new AbonadoDTO();
			abonado.setNumAbonado(Long.parseLong(listAbo[i]));
			
			try{
				AbonadoDTO retorno = delegate.obtenerDatosAbonado(abonado);
				ordenServicio.setCodCliente(retorno.getCodCliente());
				ordenServicio.setNumAbonado(retorno.getNumAbonado());
				ordenServicio.setCodPlanTarif(retorno.getCodPlanTarif());
				for(int j=0; j<camPlanPendienteDTOarr.length;j++){
					if(ordenServicio.getNumAbonado()== camPlanPendienteDTOarr[j].getNumAbonado()){
						ordenServicio.setNumOs(camPlanPendienteDTOarr[j].getNumOS());
						break;
					}
				}
								
				ordenServicioArr[i]=ordenServicio;
			}catch (ManReqException e){
				logger.error(e.getMessage(), e);
			}
		}
		return ordenServicioArr;
	}

	
	private void obtenerSecuencia(ClienteOSSesionDTO sessionData) throws ManReqException {
		SecuenciaDTO secuencia=new SecuenciaDTO();
	    if(sessionData.getNumOrdenServicio()== 0){
			logger.debug("obtenerSecuencia:antes");
			secuencia.setNomSecuencia("CI_SEQ_NUMOS");
			logger.debug("nomSecuencia :"+secuencia.getNomSecuencia());
			secuencia = delegate.obtenerSecuencia(secuencia);
		    sessionData.setNumOrdenServicio(secuencia.getNumSecuencia());
		    logger.debug("obtenerSecuencia:despues");
		}
	}
	
	



}
