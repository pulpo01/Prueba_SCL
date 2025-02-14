package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.io.File;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.jasperreports.engine.JREmptyDataSource;
import net.sf.jasperreports.engine.JasperRunManager;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioListOutDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.PlanEvaluacionRiesgoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.AbonadoSecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CantSecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OficinaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ObtencionSecuenciasDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.Carta10020DTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.Carta10022DTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.Carta10033DTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.Carta10034DTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.Carta10233DTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.Carta10508DTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.Carta10530DTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.Carta10539DTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.Carta10541DTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.Carta40009DTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ControlDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.TablaCargosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.PresupuestoForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ResumenForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class ResumenAction extends Action {

	private final Logger logger = Logger.getLogger(ResumenAction.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private final String SIGUIENTE="resumen";
	private final String FACTURA="factura";
	
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {
		
		HttpSession session = request.getSession(false);
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		String vaACargos = "XXX";
		/*
		if(session.getAttribute("paramCargosUsoOOSS")!=null){
			vaACargos =((ParamObtCargOOSSDTO) session.getAttribute("paramCargosUsoOOSS")).getSinCondicionesComerciales();
		}*/
		
		vaACargos = sessionData.getSinCondicionesComerciales();     
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		XMLDefault objetoXML    = new XMLDefault();
		DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
		session.setAttribute("ultimaPagina", "Resumen");
		ResumenForm resumenForm = (ResumenForm)form;
		RegistroPlanDTO registroPlan = (RegistroPlanDTO)session.getAttribute("registroPlan");
		
		AbonadoDTO[] abonadosSel = null;
		abonadosSel = (AbonadoDTO[])session.getAttribute("AbonadosSeleccionados");
						
		// obtener las secuencias y asignarse a cada abonado valido
		ArrayList abonados = new ArrayList();
		SecuenciaDTO[] secuencias = null;
		if (resumenForm.getCargaPagina()== null){
			session.setAttribute("Abonados", null);
			session.setAttribute("AbonadosEmpresa", null);
			
			if (sessionData.getCodOrdenServicio()== 40007){
				//es empresa
				ObtencionSecuenciasDTO param = new ObtencionSecuenciasDTO();
				AbonadoSecuenciaDTO[] abonadosSecuencias=null;
				
				param.setCodCliente(registroPlan.getCliente().getCodCliente());
				param.setNombreSecuencia("CI_SEQ_NUMOS");
				abonadosSecuencias = delegate.obtenerSecuenciasAbonados(param);
				registroPlan.getParamRegistroPlan().setAbonadosEmpresa(abonadosSecuencias);
				
				session.setAttribute("AbonadosEmpresa", abonadosSecuencias);
				
			}else{
				CantSecuenciaDTO cantSec = new CantSecuenciaDTO();
				cantSec.setNomSecuencia("CI_SEQ_NUMOS");
				cantSec.setNumVeces(sessionData.getCodOrdenServicio()!=40009?abonadosSel.length:1); //
				logger.debug("obtenerNumeroDeSecuencias():inicio");
				secuencias = delegate.obtenerNumeroDeSecuencias(cantSec);
				logger.debug("obtenerNumeroDeSecuencias():fin");
				if (secuencias != null){
					if(sessionData.getCodOrdenServicio()!=40009){
						for(int j=0; j<abonadosSel.length; j++){
							abonadosSel[j].setNumeroOS(secuencias[j].getNumSecuencia());
						}
					}
				}
				
				if(abonadosSel!=null){ // existen abonados seleccionados
					for(int i=0; i<abonadosSel.length; i++){
						abonados.add(abonadosSel[i]);
					}
					
				}else{
					// ejecuto OOSS a nivel de cliente para una orden de servicio distinta a CPU
					// se dejan los datos del cliente en un objeto de tipo AbonadoDTO ???
					AbonadoDTO clienteAbo=new AbonadoDTO();
					clienteAbo.setNumAbonado(sessionData.getCliente().getCodCliente());
					clienteAbo.setNumeroOS(secuencias[0].getNumSecuencia());
					clienteAbo.setNombreCompleto(sessionData.getCliente().getNombres());
					session.setAttribute("clienteAbo", clienteAbo);
				}
				session.setAttribute("Abonados", abonados);
			}
			
		}
		
		java.util.Date fechaCiclo=null;
		if(sessionData.getCodOrdenServicio()!=40009){
			Timestamp fecDesdeLlam = registroPlan.getParamRegistroPlan().getFecDesdeLlamTS();
			fechaCiclo = new java.util.Date(fecDesdeLlam.getTime());
		}
						
		String codOSAnt = null;
		String nombreOS = null;
		ConversionListDTO conversionList=null;
		
		if(sessionData.getCodOrdenServicio()==40009){
			codOSAnt = global.getValor("codOS.anula.solicitud");
			nombreOS = global.getValor("nomOS.anula.solicitud");
		}else{
			if(registroPlan != null){
				ConversionDTO param = new ConversionDTO();
				param.setCodOOSS(sessionData.getCodOrdenServicio());
				param.setCodTipModi(registroPlan.getParamRegistroPlan().getCombinatoria());
				logger.debug("obtenerConversionOOSS():inicio");
				conversionList = delegate.obtenerConversionOOSS(param);
				logger.debug("obtenerConversionOOSS():fin");
				logger.debug("CodOSAnt[" + conversionList.getRegistros()[0].getCodOSAnt() + "]");
				logger.debug("NombreOSAnt[" + conversionList.getRegistros()[0].getNombreOSAnt() + "]");
				logger.debug("NombreOS[" + conversionList.getRegistros()[0].getNombreOS() + "]");
				codOSAnt = String.valueOf(conversionList.getRegistros()[0].getCodOSAnt());
				nombreOS = conversionList.getRegistros()[0].getNombreOS() + "-" + conversionList.getRegistros()[0].getNombreOSAnt(); 
				logger.debug("codOSAnt[" + codOSAnt + "]" );
				logger.debug("nombreOS[" + nombreOS + "]");
			}
		}
			
		
		OrdenServicioDTO ordenServicio = null;
		int canReg=0;
		if(codOSAnt !=null){
			ordenServicio = new OrdenServicioDTO();
			ordenServicio.setNumOrdenServicio(codOSAnt);
			logger.debug("validarCarta():inicio");
			canReg = delegate.validarCarta(ordenServicio);
			logger.debug("validarCarta():fin");
		}
		logger.debug("canReg[" + canReg + "]");
		session.setAttribute("canReg", String.valueOf(canReg));
			
		String textoCarta = null;
		
		
		/*
		Object dto = Class.forName("com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.Carta10020DTO").newInstance();
		System.out.println("DTO RECUPERADO :"+dto.getClass().getName());
		if(dto instanceof Carta10508DTO){
			Carta10508DTO cartaTipo = (Carta10508DTO)dto;
			cartaTipo.setCodOOSS(codOSAnt);
			cartaTipo.setCodPlanTarif(registroPlan.getParamRegistroPlan().getCodPlanTarifDestino());
			cartaTipo.setFecCiclo(fechaCiclo);
			textoCarta = obtenerCarta(cartaTipo);
		}
		*/
		
		if (codOSAnt.equalsIgnoreCase("10020")){
			Carta10020DTO carta10020= new Carta10020DTO();
			carta10020.setCodOOSS(codOSAnt);
			carta10020.setCodPlanTarif(registroPlan.getParamRegistroPlan().getCodPlanTarifDestino());
			carta10020.setFecCiclo(fechaCiclo);
		    logger.debug("codOOSS[" + carta10020.getCodOOSS() + "]");
		    logger.debug("codPlanTarif[" + carta10020.getCodPlanTarif() + "]");
		    logger.debug("fecCiclo[" + carta10020.getFecCiclo() + "]");
		    textoCarta = obtenerCarta(carta10020);
		}
		
		if (codOSAnt.equalsIgnoreCase("10022")){
			Carta10022DTO carta10022= new Carta10022DTO();
			carta10022.setCodOOSS(codOSAnt);
			carta10022.setCodPlanTarif(registroPlan.getParamRegistroPlan().getCodPlanTarifDestino());
			carta10022.setFecCiclo(fechaCiclo);
		    logger.debug("codOOSS[" + carta10022.getCodOOSS() + "]");
		    logger.debug("codPlanTarif[" + carta10022.getCodPlanTarif() + "]");
		    logger.debug("fecCiclo[" + carta10022.getFecCiclo() + "]");
		    textoCarta = obtenerCarta(carta10022);
			
		}
		if (codOSAnt.equalsIgnoreCase("10033")){
			Carta10033DTO carta10033= new Carta10033DTO();
			carta10033.setCodOOSS(codOSAnt);
			carta10033.setCodPlanTarif(registroPlan.getParamRegistroPlan().getCodPlanTarifDestino());
			carta10033.setFecCiclo(fechaCiclo);
		    logger.debug("codOOSS[" + carta10033.getCodOOSS() + "]");
		    logger.debug("codPlanTarif[" + carta10033.getCodPlanTarif() + "]");
		    logger.debug("fecCiclo[" + carta10033.getFecCiclo() + "]");
		    textoCarta = obtenerCarta(carta10033);
			
		}
		if (codOSAnt.equalsIgnoreCase("10034")){
			Carta10034DTO carta10034= new Carta10034DTO();
			carta10034.setCodOOSS(codOSAnt);
			carta10034.setCodPlanTarif(registroPlan.getParamRegistroPlan().getCodPlanTarifDestino());
			carta10034.setFecCiclo(fechaCiclo);
		    logger.debug("codOOSS[" + carta10034.getCodOOSS() + "]");
		    logger.debug("codPlanTarif[" + carta10034.getCodPlanTarif() + "]");
		    logger.debug("fecCiclo[" + carta10034.getFecCiclo() + "]");
		    textoCarta = obtenerCarta(carta10034);
			
		}
		if (codOSAnt.equalsIgnoreCase("10508")){
			Carta10508DTO carta10508= new Carta10508DTO();
			carta10508.setCodOOSS(codOSAnt);
			carta10508.setCodPlanTarif(registroPlan.getParamRegistroPlan().getCodPlanTarifDestino());
			carta10508.setFecCiclo(fechaCiclo);
		    logger.debug("codOOSS[" + carta10508.getCodOOSS() + "]");
		    logger.debug("codPlanTarif[" + carta10508.getCodPlanTarif() + "]");
		    logger.debug("fecCiclo[" + carta10508.getFecCiclo() + "]");
		    textoCarta = obtenerCarta(carta10508);
			
		}
		if (codOSAnt.equalsIgnoreCase("10530")){
			Carta10530DTO carta10530= new Carta10530DTO();
			carta10530.setCodOOSS(codOSAnt);
			carta10530.setCodPlanTarif(registroPlan.getParamRegistroPlan().getCodPlanTarifDestino());
			carta10530.setFecCiclo(fechaCiclo);
			carta10530.setCodPlanTarifOrigen(sessionData.getAbonados()[0].getCodPlanTarif());
			carta10530.setNumCelular(String.valueOf(sessionData.getAbonados()[0].getNumCelular()));
			
		    logger.debug("codOOSS[" + carta10530.getCodOOSS() + "]");
		    logger.debug("codPlanTarif[" + carta10530.getCodPlanTarif() + "]");
		    logger.debug("fecCiclo[" + carta10530.getFecCiclo() + "]");
		    logger.debug("codPlanTarifOrigen[" + carta10530.getCodPlanTarifOrigen() + "]");
		    logger.debug("numCelular[" + carta10530.getNumCelular() + "]");
		    
		    textoCarta = obtenerCarta(carta10530);
			
		}
		if (codOSAnt.equalsIgnoreCase("10539")){
			Carta10539DTO carta10539= new Carta10539DTO();
			carta10539.setCodOOSS(codOSAnt);
			carta10539.setCodPlanTarif(registroPlan.getParamRegistroPlan().getCodPlanTarifDestino());
			carta10539.setFecCiclo(fechaCiclo);
			carta10539.setCodPlanTarifOrigen(sessionData.getAbonados()[0].getCodPlanTarif());
			carta10539.setNumCelular(String.valueOf(sessionData.getAbonados()[0].getNumCelular()));
			
		    logger.debug("codOOSS[" + carta10539.getCodOOSS() + "]");
		    logger.debug("codPlanTarif[" + carta10539.getCodPlanTarif() + "]");
		    logger.debug("fecCiclo[" + carta10539.getFecCiclo() + "]");
		    logger.debug("codPlanTarifOrigen[" + carta10539.getCodPlanTarifOrigen() + "]");
		    logger.debug("numCelular[" + carta10539.getNumCelular() + "]");
		    
		    textoCarta = obtenerCarta(carta10539);
			
		}
		if (codOSAnt.equalsIgnoreCase("10541")){
			Carta10541DTO carta10541= new Carta10541DTO();
			carta10541.setCodOOSS(codOSAnt);
			carta10541.setCodPlanTarif(registroPlan.getParamRegistroPlan().getCodPlanTarifDestino());
			carta10541.setFecCiclo(fechaCiclo);
		    logger.debug("codOOSS[" + carta10541.getCodOOSS() + "]");
		    logger.debug("codPlanTarif[" + carta10541.getCodPlanTarif() + "]");
		    logger.debug("fecCiclo[" + carta10541.getFecCiclo() + "]");
		    textoCarta = obtenerCarta(carta10541);
		}
		
		if (codOSAnt.equalsIgnoreCase("40009")){
			IOOSSDTO[] ordenServ = (IOOSSDTO[])session.getAttribute("ordenServicioArr");
			String ordenesDeServicio="";
			if(ordenServ.length==1){
				ordenesDeServicio = String.valueOf(ordenServ[0].getNumOs());
			}else{
				ordenesDeServicio = concatenaNumerosOS(ordenServ);
			}
						
			Carta40009DTO carta40009=new Carta40009DTO();
			carta40009.setCodOOSS(codOSAnt);
			carta40009.setNumOSAnt(ordenesDeServicio);
			logger.debug("CodOOSS[" + carta40009.getCodOOSS() + "]");
			logger.debug("NumOSAnt[" + carta40009.getNumOSAnt() + "]");
			textoCarta = obtenerCarta(carta40009);
		}
		
		if (codOSAnt.equalsIgnoreCase("10233")){
			Carta10233DTO carta10233 = new Carta10233DTO();
			carta10233.setCodOOSS(codOSAnt);
			carta10233.setCodPlanTarif(registroPlan.getParamRegistroPlan().getCodPlanTarifDestino()!=null?registroPlan.getParamRegistroPlan().getCodPlanTarifDestino():null);
			logger.debug("codOOSS[" + carta10233.getCodOOSS() + "]");
			logger.debug("codPlanTarif[" + carta10233.getCodPlanTarif() + "]");
			textoCarta = obtenerCarta(carta10233);
		}

		// REVISAR, todas las ordenes de servicio deberian tener un registroPlan......
		if(sessionData.getCodOrdenServicio()!=40009){
			registroPlan.getParamRegistroPlan().setTextoCarta(textoCarta);
		}
		
	    
		
		//Flujo	
		String botonSeleccionado = null;
		String paginaOrigen = " ";
		if (session.getAttribute("desde")!=null){
			paginaOrigen=(String)session.getAttribute("desde");
		}
		if(form instanceof ResumenForm){
			session.setAttribute("desde","resumen");
			botonSeleccionado = ((ResumenForm)form).getBtnSeleccionado();
			ResumenForm b= (ResumenForm)form;
			b.setBtnSeleccionado(null);
			session.setAttribute("ResumenForm", b);
		}
		
		if (!paginaOrigen.equals("registrar")){
			if(botonSeleccionado!=null&&botonSeleccionado.equalsIgnoreCase("registrarOS")){
				// Cuando se presiona boton finalizar	
				logger.debug("Se presionó finalizar");
				// Actualizar Lineas por plan (si se consultó a los planes de evaluacion de riesgo
				LstPTaPlanTarifarioListOutDTO dataPlanesEval = (LstPTaPlanTarifarioListOutDTO) session.getAttribute("dataPlanesEval");
				if (dataPlanesEval!=null && dataPlanesEval.getNumSol()!=null && !dataPlanesEval.getNumSol().trim().equals("0") ){
					if ( registroPlan.getParamRegistroPlan() !=null){
						PlanEvaluacionRiesgoDTO planEval = new PlanEvaluacionRiesgoDTO();
						planEval.setNumSolEvalRiesgo(Long.parseLong(dataPlanesEval.getNumSol())); 
						planEval.setCodPlanTarif(registroPlan.getParamRegistroPlan().getCodPlanTarifDestino());
						planEval.setNumLineasAct(registroPlan.getParamRegistroPlan().getCantLineasCodPlanTarifDestino());
						logger.debug("actualizarLineasPorPlan:inicio");
						RetornoDTO resultado = delegate.actualizarLineasPorPlan(planEval);
						logger.debug("resultado.getCodError():"+resultado.getCodigo());
						logger.debug("resultado.getCodEvento():"+resultado.getDescripcion());
						logger.debug("actualizarLineasPorPlan:fin");
					}	
				}
				logger.debug("Navegando hacia RegistrarAction");
				return mapping.findForward("registrarOS");
			}
		}
		else if (paginaOrigen.equals("registrar")){
			/*------------------Aceptar presupuesto-----------------*/
			CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
			if(cargosForm!=null && cargosForm.getRbCiclo().equalsIgnoreCase("NO")){
				PresupuestoForm presupuestoForm = new PresupuestoForm();
				if(session.getAttribute("PresupuestoForm")!=null){
					presupuestoForm = (PresupuestoForm)session.getAttribute("PresupuestoForm");
				
					String codTipoDocumento = cargosForm.getCbTipoDocumento();
					String tipoFoliacion = " ";
					
					//busca tipo foliacion:
					List listaTiposDoc = cargosForm.getDocumentosList();
					if (listaTiposDoc!= null){
						Iterator ite = listaTiposDoc.iterator();
					    while (ite.hasNext()) {
					    	DocumentoDTO doc = (DocumentoDTO)ite.next();
				        	if (doc.getCodigo().equals(codTipoDocumento)){
				        		tipoFoliacion = doc.getTipoFoliacion();
				        		break;
				        	}
					    }
					}
					
					PresupuestoDTO presup = new PresupuestoDTO();
					presup.setNumVenta(cargosForm.getNumVenta());
					presup.setNumProceso(presupuestoForm.getNumProceso());
					presup.setTipoFoliacion(tipoFoliacion);
					logger.debug("aceptarPresupuesto:antes");
					delegate.aceptarPresupuesto(presup);
					logger.debug("aceptarPresupuesto:despues");
					session.removeAttribute("PresupuestoForm");
					return mapping.findForward(FACTURA);	
				}
			}//fin rbCiclo = NO
			/*------------------Fin Aceptar presupuesto-----------------*/
		}

		if(botonSeleccionado!=null&&botonSeleccionado.equalsIgnoreCase("anterior")){
			CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
			TablaCargosDTO[] tablaCargos =null;
			if(cargosForm!=null)	tablaCargos = cargosForm.getTablaCargos();
			
			if( (vaACargos!=null&&vaACargos.equalsIgnoreCase("SI"))||(sessionData.getObtenerCargos()!=null&& sessionData.getObtenerCargos().equalsIgnoreCase("NO"))
			   || (tablaCargos == null ||tablaCargos.length == 0) ){
				logger.debug("SIN CARGOS DIRECTO A INICIO");
				return mapping.findForward("inicio");
			}else{
				logger.debug("CON CARGOS A CARGOS");
				return mapping.findForward("cargosAction");
			}		
		}
		
       		
		if(botonSeleccionado!=null&&botonSeleccionado.equals("visualizar")){
			abonados = (ArrayList)session.getAttribute("Abonados");
			String nomVendedor = null;
			String desComuna = null;
			String desOficina = null;
			UsuarioDTO usuario = new UsuarioDTO();
			usuario.setNombre(sessionData.getUsuario());
			logger.debug("obtenerVendedor():antes");
			UsuarioDTO vendedor = delegate.obtenerVendedor(usuario);
			logger.debug("obtenerVendedor():despues");
			nomVendedor = vendedor.getNombre()!=null?vendedor.getNombre():null;
			
			if (vendedor.getCodOficina()!=null) {
				OficinaDTO oficina = new OficinaDTO();
				oficina.setCodOficina(vendedor.getCodOficina());
				logger.debug("obtenerDatosOficina():inicio");
				oficina = delegate.obtenerDatosOficina(oficina);
				logger.debug("obtenerDatosOficina():fin");
				desOficina = oficina.getDesOficina()!=null?oficina.getDesOficina():null;
				desComuna = oficina.getDesComuna()!=null?oficina.getDesComuna():null;
			}
						
			String nivel;
			resumenForm.getAbonadoSel();
			String nombreAbonado=null;
			String codAbonado=null;
			String numSecuencia=null;
			if (sessionData.getCodOrdenServicio()== 40007 || sessionData.getCodOrdenServicio()== 40009){ 
				nivel = "Cliente";
				if(sessionData.getCodOrdenServicio()==40009){ // si es OOSS de Anula Solicitud, se toman los datos del cliente
					AbonadoDTO abo = (AbonadoDTO)session.getAttribute("clienteAbo"); 
					codAbonado = String.valueOf(abo.getNumAbonado());
					nombreAbonado = abo.getNombreCompleto();
					numSecuencia = String.valueOf(abo.getNumeroOS());
				}
				
			}else{
				nivel = "Abonado";
				if (abonados.size()==1){
					AbonadoDTO abo = new AbonadoDTO();
					abo = (AbonadoDTO)abonados.get(0);
					nombreAbonado = abo.getNombreCompleto();
					numSecuencia = String.valueOf(abo.getNumeroOS());
					codAbonado = String.valueOf(abo.getNumAbonado());
				}else{
					codAbonado = resumenForm.getAbonadoSel();
					logger.debug("codAbonado[" + codAbonado + "]");
					AbonadoDTO aboBuscar = new AbonadoDTO();
					aboBuscar.setNumAbonado(Long.parseLong(codAbonado));
					logger.debug("obtenerDatosAbonado():inicio");
					aboBuscar = delegate.obtenerDatosAbonado(aboBuscar);
					logger.debug("obtenerDatosAbonado():fin");
					nombreAbonado = aboBuscar.getNombreCompleto();
					for(int i=0; i<abonadosSel.length;i++){
						if(Long.parseLong(codAbonado)== abonadosSel[i].getNumAbonado()){
							numSecuencia = String.valueOf(abonadosSel[i].getNumeroOS());
						}
					}
					
				} // del else
			} // del else
			
			logger.debug("numSecuencia[" + numSecuencia + "]");
			logger.debug("nivel[" + nivel + "]");
			logger.debug("codAbonado[" + codAbonado + "]");
			logger.debug("nombreAbonado[" + nombreAbonado + "]");
			
			
			
			Map parametros = new HashMap();
			
			parametros.put("Folio", numSecuencia);
			parametros.put("Nivel", nivel);
			parametros.put("Codigo", codAbonado);
			parametros.put("Referencia",nombreOS);
			parametros.put("NomCliente",nombreAbonado);
			parametros.put("TextCarta",textoCarta);
			parametros.put("DesOficina", desOficina);
			parametros.put("DesComuna", desComuna);
			parametros.put("NomVendedor", nomVendedor);

			String rutaReporte = System.getProperty("user.dir") + global.getValor("ruta.reportes")+global.getValor("reporte.carta");
			File reportFile = new File(rutaReporte);
			logger.debug("Estado reporte :Existe="+reportFile.exists()+", Largo="+reportFile.length());
			byte[] bytes =  JasperRunManager.runReportToPdf(reportFile.getPath(), parametros, new JREmptyDataSource());
			logger.debug("bytes="+bytes);
			response.setContentType("application/pdf");
			response.setContentLength(bytes.length);
			//response.setHeader("Content-disposition", "inline; filename=" + "Factura.pdf");
			response.setHeader("Content-disposition", "attachment; filename=" + "Factura.pdf");
			ServletOutputStream ouputStream = response.getOutputStream();
			ouputStream.write(bytes,0,bytes.length);
			ouputStream.flush();
			ouputStream.close();
		}

		TablaCargosDTO[] tablaCargosDTO = null;
		ControlDTO control=new ControlDTO();	    
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");              	    
		objetoXMLSession = sessionData.getDefaultPagina();
		control = objetoXML.obtenerControl(objetoXMLSession, "resumenPAG", "Comentarios", "comentariosTXA");
		sessionData.setComentarioOS(control.getValorDefecto());
		session.removeAttribute("ClienteOOSS");
		session.setAttribute("ClienteOOSS", sessionData);
		CargosForm cargosForm = (CargosForm)session.getAttribute("CargosForm");
		List cargos = new ArrayList();
		if(cargosForm!=null){
			tablaCargosDTO = cargosForm.getTablaCargos();

			if(tablaCargosDTO!=null){
				for(int i = 0;i<tablaCargosDTO.length;i++){
					if(aplicaCargo(tablaCargosDTO[i].getCodConcepto(),cargosForm)){
						cargos.add(tablaCargosDTO[i]);
					}
				}
				TablaCargosDTO [] cargosAprobados= new TablaCargosDTO[cargos.size()];
				for(int a = 0 ; a<cargos.size();a++){
					cargosAprobados[a] = (TablaCargosDTO)cargos.get(a);
				}
				tablaCargosDTO = cargosAprobados;
			}
			if (cargosForm.getTotal()==null || cargosForm.getTotal().trim().equals("")){
				cargosForm.setTotal("0");
			}
			
		}
		session.setAttribute("listCarogos",tablaCargosDTO);
		
		
		logger.debug("execute():end");
		return mapping.findForward(SIGUIENTE);
	}

	public String obtenerCarta(CartaGeneralDTO cartaGeneral) throws ManReqException{
		String retorno=null;
		CartaGeneralDTO retornoDTO;
		retornoDTO = delegate.obtenerTextoCarta(cartaGeneral);
		retorno = retornoDTO.getTexCarta();
		return retorno;
	}

	public boolean aplicaCargo(String codConcepto, CargosForm cargosForm){
		TablaCargosDTO[] tablaCargos = cargosForm.getTablaCargos();
		String checks[] = cargosForm.getSelectedValorCheck();
		if(tablaCargos!=null&&tablaCargos.length>0){
			if(checks!=null&&checks.length>0){
				for(int x = 0;x<checks.length;x++){
					for(int i = 0 ; i<tablaCargos.length; i++){
						if(checks[i].equalsIgnoreCase(tablaCargos[x].getValorCheck())){
							return true;
						}
					}
				}
			}else{
				return false;
			}
		}else{
			return false;
		}
		return false;
	}
	
	public String concatenaNumerosOS(IOOSSDTO[] ordenServ){
		String numerosConcatenados="";
		for(int i=0;i<ordenServ.length;i++){
			numerosConcatenados = numerosConcatenados + String.valueOf(ordenServ[i].getNumOs()) ;
			if(i<ordenServ.length-1){
				numerosConcatenados = numerosConcatenados + ", ";
			}
		}
		return numerosConcatenados;
	}
	
    
	

}
