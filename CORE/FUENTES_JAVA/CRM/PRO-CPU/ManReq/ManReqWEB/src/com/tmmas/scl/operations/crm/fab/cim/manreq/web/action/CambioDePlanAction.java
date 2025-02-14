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
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioListOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.SalidaOutDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.SubCuentaListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CicloDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CausaCambioPlanListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CausaExcepcionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CalificacionAbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CausaBajaListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ValidaFiltroAbonadosDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaPlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.BodegaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.BodegaListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ConsultaBodegaDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.dao.ParseoXML;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CambiarPlanForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class CambioDePlanAction extends BaseAction {
 	
	private final Logger logger = Logger.getLogger(CambioDePlanAction.class);
	private Global global = Global.getInstance();
	private final String PUNTUAL = "cambiodeplan";
	private final String EMPRESA = "cambiodeplanempresa";
	private final String REORDENAMIENTO = "cambiodeplanreorden";
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();

	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		log = System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
	    CambiarPlanForm form1 = (CambiarPlanForm) form;
	    
		logger.debug("execute():start CambioDePlanAction");
		int NUM_MAX_ABONADOS_SIN_FILTRO;
	    HttpSession session = request.getSession(false);
	    
		//limpia variables que quedaron en sesion
		session.removeAttribute("ultimaPagina");
		session.removeAttribute("recalcular");
		session.removeAttribute("cumpleDescuento");
		session.removeAttribute("accionAutDesc");
		session.removeAttribute("CargosForm");
		session.removeAttribute("SolicitudAutDescuentoForm");
		session.removeAttribute("PresupuestoForm");
		session.removeAttribute("ResumenForm");
		
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    
		long codOrdenServicio = sessionData.getCodOrdenServicio();
	    logger.debug("codOrdenServicio="+codOrdenServicio);
		
	    AbonadoListDTO abonadoLista=null;
	    AbonadoDTO retornoAbonado=null;
	    
	    form1.setFlgPaginaFiltro("N");
	    int OOSSEmpresa = Integer.parseInt(global.getValor("EMPRESA"));
	    int OOSSReordenamiento= Integer.parseInt(global.getValor("REORDENAMIENTO"));
		
	    if (codOrdenServicio == OOSSEmpresa){//NO SE USA
	    	AbonadoDTO[] abonados = null;
			if(sessionData.getCodCliente() > 0) {
				logger.debug("obtenerAbonadoEmpresa:antes");
				retornoAbonado = delegate.obtenerAbonadoEmpresa(sessionData.getCliente());
				logger.debug("obtenerAbonadoEmpresa:despues");
				if (retornoAbonado!=null){
					abonados = new AbonadoDTO[1];
					abonados[0] = retornoAbonado;
					abonadoLista = new AbonadoListDTO();
					abonadoLista.setAbonados(abonados);
					sessionData.setAbonados(abonadoLista.getAbonados());
					sessionData.getCliente().setNumAbonados(retornoAbonado.getCantAbonados());
				}
			}
			else{
				logger.debug("obtenerDatosAbonado:antes");
				AbonadoDTO buscaAbonado=new AbonadoDTO();
				buscaAbonado.setNumAbonado(sessionData.getNumAbonado());
				retornoAbonado = delegate.obtenerDatosAbonado(buscaAbonado);
				logger.debug("obtenerDatosAbonado:despues");
				if (retornoAbonado!=null){
					abonados = new AbonadoDTO[1];
					abonados[0] = retornoAbonado;
					abonadoLista = new AbonadoListDTO();
					abonadoLista.setAbonados(abonados);
					sessionData.setAbonados(abonadoLista.getAbonados());
					sessionData.getCliente().setNumAbonados(1);
				}
			}
			
			session.setAttribute("AbonadosSeleccionados",abonados);
	    
	    }//fin if (codOrdenServicio == OOSSEmpresa)//NO SE USA
	    else{
	    	
		    //Validar si corresponde o no levantar la página de filtro
		    if (session.getAttribute("AbonadosSeleccionados")!= null){
			    if (session.getAttribute("FlujoNavegacion")!=null && session.getAttribute("FlujoNavegacion").equals("INICIO")){
			    	AbonadoDTO[] lista = (AbonadoDTO[])session.getAttribute("AbonadosSeleccionados");
			    	logger.debug("lista.length"+lista.length);
			    	if (lista.length>0){
			    		sessionData.setAbonados(lista);
			    		sessionData.getCliente().setNumAbonados(lista.length);
			    		sessionData.setNumAbonado(lista[0].getNumAbonado());
			    		session.removeAttribute("ClienteOOSS");
			    		session.setAttribute("ClienteOOSS", sessionData);
			    		form1.setFlgPaginaFiltro("S");
			    	}
			    }
		    }else {
		    	boolean levantarPaginaFiltro = false;
		    	
		    	if(sessionData.getCodCliente()!= 0){
		    		ParametroDTO parametro = new ParametroDTO();
		    		parametro.setNomParametro("MAX_ABON_SIN_FILTRO");
					parametro.setCodModulo("GA");
					parametro.setCodProducto(1);
					parametro = delegate.obtenerParametrosSimples(parametro);
		    		NUM_MAX_ABONADOS_SIN_FILTRO = Math.round(parametro.getValorNum());
		    		
		    		
		    		ValidaFiltroAbonadosDTO valFiltro = new ValidaFiltroAbonadosDTO();
		    		valFiltro.setCodCliente(sessionData.getCliente().getCodCliente()); 
		    		valFiltro.setCodOOSS(String.valueOf(codOrdenServicio));
		    		valFiltro.setNumMaximoAbonados(NUM_MAX_ABONADOS_SIN_FILTRO);
		    		logger.debug("NUM_MAX_ABONADOS_SIN_FILTRO="+NUM_MAX_ABONADOS_SIN_FILTRO);
		    		levantarPaginaFiltro = delegate.validaFiltroAbonados(valFiltro).isResultado();

		    	}
		    	
		    	
			    if (levantarPaginaFiltro){
			    	form1.setFlgPaginaFiltro("S");
			    	return mapping.findForward("busquedaAbonados");
			    }else{
			    	//cargar lista de abonados ***
			    	
				    logger.debug("llena lista de abonados dependiendo de login como cliente o abonado : inicio");
					if(sessionData.getCodCliente()!= 0) {
						logger.debug("obtenerListaAbonados:antes");
						abonadoLista = delegate.obtenerListaAbonados(sessionData.getCliente());
						logger.debug("obtenerListaAbonados:despues");
						if (abonadoLista!=null && abonadoLista.getAbonados()!=null) {
							//(+)EV 02/06/2010 agrega cod_calificacion
							if (sessionData.getAplicaPrecalificacion().equals("S")){
								if (abonadoLista.getAbonados().length >0){
									if (abonadoLista.getAbonados()[0].getCodTipPlan().equals(global.getValor("tipo.producto.prepago"))){
										CalificacionAbonadoDTO calAbo = new CalificacionAbonadoDTO();
										calAbo.setNumAbonado(abonadoLista.getAbonados()[0].getNumAbonado());
										calAbo.setNumCelular(abonadoLista.getAbonados()[0].getNumCelular());
										calAbo = delegate.obtieneCalificacionAbonado(calAbo);
										//como todos los abonados tienen la misma calificacion 
										//se obtiene la calificacion del primero y se setea al resto
										for(int i=0;i<abonadoLista.getAbonados().length;i++)
											 abonadoLista.getAbonados()[i].setCodCalificacion(calAbo.getCodCalificacion());
									}
								}
							}
							//(-)EV 02/06/2010 agrega cod_calificacion
							
							sessionData.setAbonados(abonadoLista.getAbonados());
							sessionData.getCliente().setNumAbonados(abonadoLista.getAbonados().length);
						}else{
							sessionData.getCliente().setNumAbonados(0);
						}
					    		
					}
					else{
						logger.debug("obtenerDatosAbonado:antes");
						AbonadoDTO buscaAbonado=new AbonadoDTO();
						buscaAbonado.setNumAbonado(sessionData.getNumAbonado());
						retornoAbonado = delegate.obtenerDatosAbonado(buscaAbonado);
						logger.debug("obtenerDatosAbonado:despues");
						if (retornoAbonado!=null){
							
							//(+)EV 02/06/2010 agrega cod_calificacion
							if ( sessionData.getAplicaPrecalificacion().equals("S") && 
									retornoAbonado.getCodTipPlan().equals(global.getValor("tipo.producto.prepago"))){
								CalificacionAbonadoDTO calAbo = new CalificacionAbonadoDTO();
								calAbo.setNumAbonado(retornoAbonado.getNumAbonado());
								calAbo.setNumCelular(retornoAbonado.getNumCelular());
								calAbo = delegate.obtieneCalificacionAbonado(calAbo);
								retornoAbonado.setCodCalificacion(calAbo.getCodCalificacion());
							}
							//(-)EV 02/06/2010 agrega cod_calificacion
							
							AbonadoDTO[] abonados = new AbonadoDTO[1];
							abonados[0] = retornoAbonado;
							abonadoLista = new AbonadoListDTO();
							abonadoLista.setAbonados(abonados);
							sessionData.setAbonados(abonadoLista.getAbonados());
							sessionData.getCliente().setNumAbonados(1);
						}
					}
					logger.debug("llena lista de abonados dependiendo de login como cliente o abonado : fin");
					session.setAttribute("AbonadosSeleccionados",abonadoLista.getAbonados());
					
			    }
		    }
	    }//fin else cliente empresa
	    
	    //Indica si aplica modulo de precalificacion
	    if (sessionData.getAplicaPrecalificacion().equals("S") 
	    		&& sessionData.getAbonados()!=null && sessionData.getAbonados().length>0
	    		&& sessionData.getAbonados()[0].getCodTipPlan().equals(global.getValor("tipo.producto.prepago"))){
	    	form1.setAplicaPrecalificacion("S");
	    }
	    
	    
	    session.removeAttribute("FlujoNavegacion");
	    
		if (codOrdenServicio == OOSSEmpresa){
			return mapping.findForward(EMPRESA);
		}else if (codOrdenServicio == OOSSReordenamiento){
			return mapping.findForward(REORDENAMIENTO);
		}
		
	    // Lectura de archivo XML de configuracion, parseo y carga en objeto de sesion
	 	DefaultPaginaCPUDTO definicionPagina= new DefaultPaginaCPUDTO();
	 	String dirXML = global.getValor("config.xml");
	 	String dir = System.getProperty("user.dir") +dirXML;
	 	logger.debug("dir="+dir);
	 	ParseoXML parseo=new ParseoXML();
		logger.debug("leyendo y parseando XML configuración:antes");
		definicionPagina=parseo.cargaXML(dir);
		logger.debug("leyendo y parseando XML configuración:despues");
		sessionData.setDefaultPagina(definicionPagina);
		
	    BusquedaPlanTarifarioDTO plan=new BusquedaPlanTarifarioDTO();
	    ArrayList planTarifPrepago=new ArrayList();
	    ArrayList planTarifPospago=new ArrayList();
	    ArrayList planTarifHibrido=new ArrayList();
	    
	    //ArrayList rango=new ArrayList(); comentado 15/07/08
	    
	    if (sessionData.getCliente().getNumAbonados()>0 && sessionData.getAbonados()!=null && sessionData.getAbonados()[0]!=null ){
	    	plan.setCodPlanTarif(sessionData.getAbonados()[0].getCodPlanTarif());
	    	plan.setTipPlanTarif(sessionData.getAbonados()[0].getCodTipoPlanTarif());
	    	plan.setCodTipoPlan(sessionData.getAbonados()[0].getCodTipPlan());
	    	plan.setCodTecnologia(sessionData.getAbonados()[0].getCodTecnologia());
	    	plan.setNumAbonado(sessionData.getAbonados()[0].getNumAbonado());
	    	plan.setUsuarioOracle(sessionData.getUsuario());
	    	plan.setCambioPlanFamiliar("FALSE");
	    	plan.setCodCalifica(sessionData.getAbonados()[0].getCodCalificacion());
	    
	    	logger.debug("plan.getCodPlanTarif         :"+plan.getCodPlanTarif());
	    	logger.debug("plan.getTipPlanTarif         :"+plan.getTipPlanTarif());
	    	logger.debug("plan.getCodTipoPlan          :"+plan.getCodTipoPlan());
	    	logger.debug("plan.getCodTecnologia        :"+plan.getCodTecnologia());
	    	logger.debug("plan.getNumAbonado           :"+plan.getNumAbonado());
	    	logger.debug("plan.getUsuarioOracle        :"+plan.getUsuarioOracle());
	    	logger.debug("plan.getCambioPlanFamiliar() :"+plan.getCambioPlanFamiliar());
	    	logger.debug("plan.getCodCalifica          :"+plan.getCodCalifica());
	    
	    	logger.debug("plan.obtenerPlanesTarifarios:antes");
	    	PlanTarifarioListDTO listaPlanesTarif=delegate.obtenerPlanesTarifarios(plan);
	    	logger.debug("obtenerPlanesTarifarios:despues");
	    	
	    
	    	logger.debug("recorrer lista de planes tarifarios:antes");
	    	for(int i=0;i<listaPlanesTarif.getPlanesPrepago().length;i++){
	    		PlanTarifarioDTO planAux= listaPlanesTarif.getPlanesPrepago()[i];
	    		planAux.setDesPlanTarif(planAux.getCodPlanTarif()+"-"+planAux.getDesPlanTarif());
	    		planTarifPrepago.add(planAux);
	    	}
	    
	    	for(int i=0;i<listaPlanesTarif.getPlanesPospago().length;i++){
	    		PlanTarifarioDTO planAux= listaPlanesTarif.getPlanesPospago()[i];
	    		planAux.setDesPlanTarif(planAux.getCodPlanTarif()+"-"+planAux.getDesPlanTarif());
	    		planTarifPospago.add(planAux);
	    	}
	    
	    	for(int i=0;i<listaPlanesTarif.getPlanesHibrido().length;i++){
	    		PlanTarifarioDTO planAux= listaPlanesTarif.getPlanesHibrido()[i];
	    		planAux.setDesPlanTarif(planAux.getCodPlanTarif()+"-"+planAux.getDesPlanTarif());
	    		planTarifHibrido.add(planAux);
	    	}
	    	
	    	if(plan.getCodCalifica() != null && (plan.getCodCalifica()).trim() != "")
	    	{
	    		
	    	}
	    	/* comentado 15/07/08
	    	for(int i=0;i<listaPlanesTarif.getPlanesPospagoRango().length;i++){
	    		PlanTarifarioDTO planAux= listaPlanesTarif.getPlanesPospagoRango()[i];
	    		planAux.setDesPlanTarif(planAux.getCodPlanTarif()+"-"+planAux.getDesPlanTarif());
	    		rango.add(planAux);
	    	}
	    	*/
	    	
	    	logger.debug("recorrer lista de planes tarifarios:despues");
	    }//fin sessionData.getCliente().getNumAbonados()>0
	    
	    /*(+) Se cambia implementacion, para agilizar carga de pagina, evera 15/07/08
	    ClienteDTO cliente = sessionData.getCliente();
	    logger.debug("obtenerDatosClienteCuenta:antes");
	    ClienteTipoPlanListDTO listasDeClientes=delegate.obtenerDatosClienteCuenta(cliente);
	    
	    logger.debug("obtenerDatosClienteCuenta:despues");
	    ArrayList clientesPrepago=new ArrayList();
	    ArrayList clientesPospago=new ArrayList();
	    ArrayList clientesHibrido=new ArrayList();
	    
	    ClienteDTO[] clientesDestPrepago = listasDeClientes.getClientesPrepago();
	    ClienteDTO[] clientesDestPospago = listasDeClientes.getClientesPospago();
	    ClienteDTO[] clientesDestHibrido = listasDeClientes.getClientesHibrido();
	    	    
	    //ClienteDTO[] clientesDestPrepago = agregaClienteOrigen(listasDeClientes.getClientesPrepago(), sessionData.getCliente());
	    //ClienteDTO[] clientesDestPospago = agregaClienteOrigen(listasDeClientes.getClientesPospago(), sessionData.getCliente());
	    //ClienteDTO[] clientesDestHibrido = agregaClienteOrigen(listasDeClientes.getClientesHibrido(), sessionData.getCliente());
	    
	    for(int i=0;i<clientesDestPrepago.length;i++){
	    	clientesPrepago.add(clientesDestPrepago[i]);
	    }
	    
	    for(int i=0;i<clientesDestPospago.length;i++){
	    	clientesPospago.add(clientesDestPospago[i]);
	    }
	    
	    for(int i=0;i<clientesDestHibrido.length;i++){
	    	clientesHibrido.add(clientesDestHibrido[i]);
	    }
	    //(-)
	   */
	   
	    logger.debug("obtenerSubCuentas():antes");
	    //(+)para que liste la primera cuenta.  evera 14/07/08
	    ClienteDTO clienteAux = new ClienteDTO();
	    clienteAux.setCodCliente(sessionData.getCliente().getCodCliente());
	    clienteAux.setCodCuenta(sessionData.getCliente().getCodCuenta());
	    clienteAux.setCodValor("1");
	    SubCuentaListDTO listaSubCuentas=delegate.obtenerSubCuentas(clienteAux);
	    //(-)
	    logger.debug("obtenerSubCuentas():despues");
	    
	    ArrayList subCuentas=new ArrayList();
	    for(int i=0;i<listaSubCuentas.getListaSubCuentas().length;i++){
	    	subCuentas.add(listaSubCuentas.getListaSubCuentas()[i]);
	    }
	    
	    logger.debug("obtenerCausaBaja():antes");
	    CausaBajaListDTO causaBajaList=delegate.obtenerCausaBaja();
	    logger.debug("obtenerCausaBaja():despues");
	    List causaBaja = Arrays.asList(causaBajaList.getCausas());
	    
	    
	    logger.debug("obtenerCausaExcepcion():antes");
	    CausaExcepcionListDTO causaExcepList = delegate.obtenerCausaExcepcion();
	    logger.debug("obtenerCausaExcepcion():despues");
	    List causaExcepcion = Arrays.asList(causaExcepList.getListaCausas());
	    
	    /*110809 pv GTSV*/
	    logger.debug("obtenerCausasCambioPlan():antes");
	    CausaCambioPlanListDTO causasCambioPlanList = delegate.obtenerCausasCambioPlan();
	    logger.debug("obtenerCausasCambioPlan():despues");
	    List causasCambioPlan = Arrays.asList(causasCambioPlanList.getCausasCambioPlan());
	    
	    UsuarioDTO usuario = new UsuarioDTO();
	    usuario.setNombre(sessionData.getUsuario());
	    logger.debug("obtenerVendedor():antes");
	    UsuarioDTO vendedor = delegate.obtenerVendedor(usuario);
	    logger.debug("obtenerVendedor():despues");
	    ConsultaBodegaDTO param=new ConsultaBodegaDTO();
	    param.setCodVendedor(vendedor.getCodigo());
	    form1.setCodVendedor(vendedor.getCodigo());
	    logger.debug("obtenerListaBodegas() :antes");
	    BodegaListDTO bodegaList=delegate.obtenerListaBodegas(param);
	    logger.debug("obtenerListaBodegas() :despues");
	    List bodegas = null;
	    if(bodegaList != null){
	    	BodegaDTO[] nuevaBodega = agregaVacio(bodegaList.getBodegas());
	    	bodegas = Arrays.asList(nuevaBodega);
	    }
	    
	    //(+)yosses 29/02/2008
		    //Obtener fecha ciclo (07-02-08 by GS)
	    String fecDesdeLlam ="";
	    String periodoCodCiclFact  = "";
	    try{
		    CicloDTO ciclo = new CicloDTO();
		    ciclo.setCodCiclo(sessionData.getCliente().getCodCiclo());
		    logger.debug("obtenerFechaCiclo():inicio");
		    ciclo = delegate.obtenerFechaCiclo(ciclo);
		    logger.debug("obtenerFechaCiclo():inicio");
		    fecDesdeLlam ="";
		    periodoCodCiclFact  = "";
		    if(ciclo.getFecDesdeLlam()!=null){
		    	logger.debug("ciclo.getFecDesdeLlam()       :"+ciclo.getFecDesdeLlam());
		    	logger.debug("ciclo.getPeriodoCodCiclFact() :"+ciclo.getPeriodoCodCiclFact());
		    	fecDesdeLlam = ciclo.getFecDesdeLlam();
		    	periodoCodCiclFact = String.valueOf(ciclo.getPeriodoCodCiclFact());
		    }
	    }catch(Exception e){
	    	logger.debug("delegate.obtenerFechaCiclo(ciclo)          ["+e.getMessage()+"]");
	    	logger.debug("Error al obtenerFechaCiclo para CodCiclo() ["+sessionData.getCliente().getCodCiclo()+"]");
	    }
		//(-)
		    
	    /*
	    ConsultaPlanDTO consulta = new ConsultaPlanDTO();
	    consulta.setLin(String.valueOf(sessionData.getAbonados()[0].getNumCelular()));
	    consulta.setIcc(sessionData.getAbonados()[0].getNumSerie());
	    logger.debug("consultaPlan():antes");
	    PlanDTO planSK = delegate.consultaPlan(consulta);
	    logger.debug("consultaPlan():despues");
	    if(planSK!=null)logger.debug("planSK.getPlan()"+planSK.getPlan());
	     */     
	    
	    
	    XMLDefault objetoXML	= new XMLDefault();
	    DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
	    SeccionDTO seccion=new SeccionDTO();
	    
	    
    
	    
	    
	    ArrayList controlesList=new ArrayList();
	        
	    objetoXMLSession = sessionData.getDefaultPagina();
	    
	    //Recupera la configuracion del vendedor
	    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "OOSSComisionable", "Configuracion");
	    if (seccion == null) {
	    	logger.debug("Configuracion de vendedor no encontrada en xml por defecto");
	    	session.setAttribute("oossComisionable", null);
	    }
	    else {
	    	logger.debug("Configuracion de vendedor encontrada en xml por defecto");
		    String vendedorConfigurado = seccion.obtControl("ConfigComis").getHabilitado();
		    logger.debug("vendedorConfigurado[" + vendedorConfigurado + "]");
		    session.setAttribute("oossComisionable", vendedorConfigurado);	    	
	    }
	    
	    
	    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "piePaginaCargosPAG", "CargosCondicionesRegistroSS");
	    	    
	    controlesList.add(seccion.obtControl("condicionesCK"));
	    
	    
	    //request.setAttribute("controlesList", controlesList);
	    session.setAttribute("controlesList", controlesList);
	    
	    
	    session.setAttribute("planTarifPrepago", planTarifPrepago);
	    session.setAttribute("planTarifPospago", planTarifPospago);
	    session.setAttribute("planTarifHibrido", planTarifHibrido);
	    imprimiCodPlanes(planTarifPrepago,planTarifPospago,planTarifHibrido);
	    /* comentado 15/07/08	    
	    request.setAttribute("rango", rango);
	    session.setAttribute("clientesPrepago", clientesPrepago);
	    session.setAttribute("clientesPospago", clientesPospago);
	    session.setAttribute("clientesHibrido", clientesHibrido);
	    */
	    //(+) ev 16/07/08
	    if (form1.getClienteDestPre()==null) session.setAttribute("clientesPrepago", new ArrayList());
	    if (form1.getClienteDestPos()==null) session.setAttribute("clientesPospago", new ArrayList());
	    if (form1.getClienteDestHib()==null) session.setAttribute("clientesHibrido", new ArrayList());
	    //(-)
	    
	    
	    //request.setAttribute("subCuentas", subCuentas);
	    //request.setAttribute("causaBaja", causaBaja);
	    session.setAttribute("subCuentas", subCuentas);
	    session.setAttribute("causaBaja", causaBaja);	    
	    request.setAttribute("causaExcepcion", causaExcepcion);
	    //request.setAttribute("bodegas", bodegas);
	    session.setAttribute("bodegas", bodegas);
	    session.setAttribute("fecDesdeLlam", fecDesdeLlam);
	    session.setAttribute("periodoCodCiclFact", periodoCodCiclFact);
	    session.setAttribute("causasCambioPlan", causasCambioPlan);
	    
    	sessionData.setFlujoIndividualEmpresa("I");

		/* comentado 15/07/08
		String codCliente = Long.toString(sessionData.getCliente()!=null?sessionData.getCliente().getCodCliente():0);
	    form1.setClienteDestPre(codCliente);
	    form1.setClienteDestPos(codCliente);
	    form1.setClienteDestHib(codCliente);*/
	    
    	form1.setCambioDePlanRB("aciclo");
    	
	    if(form1.getTipoPlanRB()== null){
	    	form1.setTipoPlanRB("combopre");
	    }
	    if(form1.getCondicH()== null){
	    	form1.setCondicH("SI");
	    }
	    
	   //obtiene información de valores por defecto de controles
		objetoXMLSession = sessionData.getDefaultPagina();
		seccion = objetoXML.obtenerSeccion(objetoXMLSession, "cargosPAG", "CondicionesComercialesSS");
		String cargosACiclo = seccion.obtControl("CargosCicloRB").getValorDefecto();
		String modalidadPago = seccion.obtControl("ModalidadCB").getValorDefecto();
		String tipoDocumento = seccion.obtControl("TipoDocumentoCB").getValorDefecto();

		/*if (sessionData.getCliente().getNumAbonados()>0 && sessionData.getAbonados()!=null && sessionData.getAbonados()[0]!=null){
			//obtener glosa de modalidad de pago
			if (!modalidadPago.trim().equals("")){
				sessionData.setModalidad(modalidadPago);
				
				BusquedaFormasPagoDTO formasPago = new BusquedaFormasPagoDTO();
				formasPago.setCodCliente(sessionData.getCliente().getCodCliente());
				formasPago.setNumVenta(sessionData.getAbonados()[0].getNumVenta());
				FormaPagoDTO[] formasPagoList = delegate.obtenerFromasPago(formasPago).getFormasPago();
				if (formasPagoList!=null){
					for(int i=0; i<formasPagoList.length;i++){
						FormaPagoDTO forma = formasPagoList[i];
						if (forma.getTipoValor().equals(modalidadPago)){
							modalidadPago = forma.getDescripcionTipoValor();
							break;
						}
					}
				}
			}
		}else{
			modalidadPago = " ";
		}*/
		modalidadPago = "Contado";
		sessionData.setModalidad("1");
		
		//obtener glosa de tipo de documento
		if (!tipoDocumento.trim().equals("")){
			BusquedaTiposDocumentoDTO tiposDocumento = new BusquedaTiposDocumentoDTO();
			tiposDocumento.setCodCliente(sessionData.getCliente().getCodCliente());
			DocumentoDTO[] documentosList = delegate.obtenerTiposDocumento(tiposDocumento).getDocumentos();
			
			for(int i=0; i<documentosList.length; i++){
				DocumentoDTO doc = documentosList[i];
				if (doc.getCodigo().equals(tipoDocumento)){
					tipoDocumento = doc.getDescripcion();
				}
			}
		}
		
		//obtener parametro evaluacion crediticia
		ParametroDTO parametro = new ParametroDTO();
		parametro.setNomParametro("APLICA_EVALUACION");
		parametro.setCodModulo("GA");
		parametro.setCodProducto(1);
		parametro = delegate.obtenerParametrosSimples(parametro);
		logger.debug("Aplica Evaluacion Crediticia =" + parametro.getValor());
		form1.setFlgAplicaEvaluacion(parametro.getValor());
		
		//obtener parametro para lista de clientes destino
		parametro = new ParametroDTO();
		parametro.setNomParametro("MAX_LISTA_CLIENTES");
		parametro.setCodModulo("GA");
		parametro.setCodProducto(1);
		parametro = delegate.obtenerParametroGeneral(parametro);
		int numMaxClientesLista =  Integer.parseInt(parametro.getValor());
		form1.setNumMaxClientesLista(numMaxClientesLista);
		//form1.setNumMaxClientesLista(5);// SOLO PARA PRUEBAS ESTA EN DURO
		
	   String detalleControles = " "; 
	   detalleControles = "Cargos a Ciclo: " + cargosACiclo + ", ";
	   detalleControles = detalleControles + "Modalidad de pago: " + modalidadPago + ", ";
	   detalleControles = detalleControles + "Tipo de Documento : " + tipoDocumento + ". ";
	   form1.setDetalleControles(detalleControles);
	   
		// Desbloqueo de solicitud de evualuacion de riesgo antes
		// de enviar a encolar el objeto de orden de servicio
		LstPTaPlanTarifarioListOutDTO dataPlanesEval = (LstPTaPlanTarifarioListOutDTO) session.getAttribute("dataPlanesEval");
		if (dataPlanesEval!=null && dataPlanesEval.getNumSol()!=null && !dataPlanesEval.getNumSol().trim().equals("0") ){
			SalidaOutDTO resultado = delegate.desBloqueaSolicitudEvRiesgo(Long.parseLong(dataPlanesEval.getNumSol()));
			logger.debug("resultado desBloqueaSolicitudEvRiesgo:inicio");
			logger.debug("resultado.getCodError():"+resultado.getCodError());
			logger.debug("resultado.getCodEvento():"+resultado.getCodEvento());
			logger.debug("resultado.getMsgError():"+resultado.getMsgError());
			logger.debug("resultado desBloqueaSolicitudEvRiesgo:fin");
		}

	   
	   logger.debug("execute():end CambioDePlanAction");
	   return mapping.findForward(PUNTUAL);
	}
	
	private void imprimiCodPlanes(ArrayList planTarifPrepago,ArrayList planTarifPospago,ArrayList planTarifHibrido)
	{
		logger.debug("----------------imprimiCodPlanes---ini---------");
		PlanTarifarioDTO plan = null;
		int totalPlanes = 0;
		try{
			logger.debug("--pre--");
			for(int i=0;i<planTarifPrepago.size();i++)
			{
				plan = (PlanTarifarioDTO)planTarifPrepago.get(i);
				totalPlanes++;
				logger.debug(plan.getDesPlanTarif());
			}
			logger.debug("--pos--");
			for(int i=0;i<planTarifPospago.size();i++)
			{
				plan = (PlanTarifarioDTO)planTarifPospago.get(i);
				totalPlanes++;
				logger.debug(plan.getDesPlanTarif());
			}
			logger.debug("--hib--");
			for(int i=0;i<planTarifHibrido.size();i++)
			{
				plan = (PlanTarifarioDTO)planTarifHibrido.get(i);
				totalPlanes++;
				logger.debug(plan.getDesPlanTarif());
			}
		}
		catch(Exception e)
		{
			logger.debug("imprimiCodPlanes["+e.getMessage()+"]");
		}
		logger.debug("totalPlanes["+totalPlanes+"]");
		logger.debug("----------------imprimiCodPlanes---fin---------");
	}
	public BodegaDTO[] agregaVacio(BodegaDTO[] listaBodegas){
		BodegaDTO[] arregloTemporal=null;
		BodegaDTO bodegaVacia=new BodegaDTO();
		bodegaVacia.setCodBodega(-1);
		bodegaVacia.setDesBodega("Seleccionar...");
		arregloTemporal=new BodegaDTO[listaBodegas.length + 1];
		arregloTemporal[0]= bodegaVacia;
		for(int j=0;j<listaBodegas.length;j++){
			arregloTemporal[j+1]=listaBodegas[j];
		}
		return arregloTemporal;
	}
	
	
	/*
	public ClienteDTO[] agregaClienteOrigen(ClienteDTO[] listaClienteDestino, ClienteDTO clienteOrigen){
		ClienteDTO[] arregloTemporal=new ClienteDTO[0];
		ClienteDTO nuevoCliente=new ClienteDTO();
		nuevoCliente.setCodCliente(clienteOrigen.getCodCliente());
		nuevoCliente.setNombreCompleto(clienteOrigen.getNombres());
		nuevoCliente.setCodCiclo(clienteOrigen.getCodCiclo());
		nuevoCliente.setCodCuenta(clienteOrigen.getCodCuenta());
		//si la lista de clientes viene vacia, redimensiona el arreglo y setea el cliente origen
		if (listaClienteDestino.length==0){
			listaClienteDestino = new ClienteDTO[1];
			listaClienteDestino[0]=nuevoCliente;
			return listaClienteDestino;
			
		}else{
			//si en la lista no viene el cliente origen, entonces utiliza un arreglo temporal y vacia el contenido del arreglo original
			if(!buscaClienteOrigen(listaClienteDestino, clienteOrigen)){
				arregloTemporal=new ClienteDTO[listaClienteDestino.length + 1];
				for(int j=0;j<=(listaClienteDestino.length-1);j++){
					arregloTemporal[j]=listaClienteDestino[j];
				}
				arregloTemporal[arregloTemporal.length - 1]=nuevoCliente;
				return arregloTemporal;
			}
			
		}
		return listaClienteDestino;	
	}
	
	public boolean buscaClienteOrigen(ClienteDTO[] listaClienteDestino, ClienteDTO clienteOrigen){
		if(listaClienteDestino.length>0){
			for(int i=0;i<listaClienteDestino.length;i++){
				if(listaClienteDestino[i].getCodCliente()==clienteOrigen.getCodCliente()){
					return true;
				}
			}
		}
		return false;
	}
	*/

}
