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
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteTipoPlanListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.SubCuentaListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DocumentoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CausaExcepcionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CausaBajaListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaPlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.FormaPagoDTO;
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

public class CambioDePlanEmpresaAction extends BaseAction {

	private final Logger logger = Logger.getLogger(CambioDePlanEmpresaAction.class);
	private Global global = Global.getInstance();
	private final String EMPRESA = "cambiodeplanempresa";
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();

	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("execute():start CambioDePlanEmpresaAction");
		
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = request.getSession(false);
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    
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
		
	    /*AbonadoListDTO abonadoLista=null;
		if(sessionData.getCodCliente()> 0) {
		    logger.debug("obtenerListaAbonados:antes");
		    abonadoLista = delegate.obtenerListaAbonados(sessionData.getCliente());
		    logger.debug("obtenerListaAbonados:despues");
		    if (abonadoLista!=null && abonadoLista.getAbonados()!=null) {
		    	sessionData.setAbonados(abonadoLista.getAbonados());
		    	sessionData.getCliente().setNumAbonados(abonadoLista.getAbonados().length);
		    }else{
	    		sessionData.getCliente().setNumAbonados(0);
	    	}
		}else{
			logger.debug("Error, empresa siempre debe ingresar por cliente");
			//ERROR, EMPRESA SIEMPRE DEBE INGRESAR POR CLIENTE
		}*/
   
	    BusquedaPlanTarifarioDTO plan=new BusquedaPlanTarifarioDTO();
	    ArrayList planTarifPrepago=new ArrayList();
	    ArrayList planTarifPospago=new ArrayList();
	    ArrayList planTarifHibrido=new ArrayList();
	    ArrayList rango=new ArrayList();
	    
	    if (sessionData.getCliente().getNumAbonados()>0 && sessionData.getAbonados()!=null && sessionData.getAbonados()[0]!=null ){
	    	plan.setCodPlanTarif(sessionData.getAbonados()[0].getCodPlanTarif());
	    	plan.setTipPlanTarif(sessionData.getAbonados()[0].getCodTipoPlanTarif());
	    	plan.setCodTipoPlan(sessionData.getAbonados()[0].getCodTipPlan());
	    	plan.setCodTecnologia(sessionData.getAbonados()[0].getCodTecnologia());
	    	plan.setNumAbonado(sessionData.getAbonados()[0].getNumAbonado());
	    	plan.setUsuarioOracle(sessionData.getUsuario());
	    	plan.setCambioPlanFamiliar("FALSE");
	    
	    	logger.debug("plan.getCodPlanTarif         :"+plan.getCodPlanTarif());
	    	logger.debug("plan.getTipPlanTarif         :"+plan.getTipPlanTarif());
	    	logger.debug("plan.getCodTipoPlan          :"+plan.getCodTipoPlan());
	    	logger.debug("plan.getCodTecnologia        :"+plan.getCodTecnologia());
	    	logger.debug("plan.getNumAbonado           :"+plan.getNumAbonado());
	    	logger.debug("plan.getUsuarioOracle        :"+plan.getUsuarioOracle());
	    	logger.debug("plan.getCambioPlanFamiliar() :"+plan.getCambioPlanFamiliar());
	    
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
	    
	    	for(int i=0;i<listaPlanesTarif.getPlanesPospagoRango().length;i++){
	    		PlanTarifarioDTO planAux= listaPlanesTarif.getPlanesPospagoRango()[i];
	    		planAux.setDesPlanTarif(planAux.getCodPlanTarif()+"-"+planAux.getDesPlanTarif());
	    		rango.add(planAux);
	    	}
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
	    
	    CambiarPlanForm form1 = (CambiarPlanForm) form;
	    
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
	    
	    XMLDefault objetoXML	= new XMLDefault();
	    DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
	    SeccionDTO seccion=new SeccionDTO();
	    
	    
	    ArrayList controlesList=new ArrayList();
	        
	    objetoXMLSession = sessionData.getDefaultPagina();
	    
	    //Recupera la configuracion del vendedor
	    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "OOSSComisionableEmpresa", "Configuracion");
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
	    
	    
	    session.setAttribute("controlesList", controlesList);
	    
	    
	    
	    session.setAttribute("planTarifPrepago", planTarifPrepago);
	    session.setAttribute("planTarifPospago", planTarifPospago);
	    session.setAttribute("planTarifHibrido", planTarifHibrido);
	    session.setAttribute("rango", rango);
	    
	    //request.setAttribute("rango", rango);
	    //(+) ev 16/07/08
	    /*session.setAttribute("clientesPrepago", clientesPrepago);
	    session.setAttribute("clientesPospago", clientesPospago);
	    session.setAttribute("clientesHibrido", clientesHibrido);
	    */
	    session.setAttribute("clientesPrepago", new ArrayList());
	    session.setAttribute("clientesPospago", new ArrayList());
	    session.setAttribute("clientesHibrido", new ArrayList());
	    //(-)
	    
	    request.setAttribute("subCuentas", subCuentas);
	    request.setAttribute("causaBaja", causaBaja);
	    request.setAttribute("causaExcepcion", causaExcepcion);
	    //request.setAttribute("causaExcepcion", null);
	    request.setAttribute("bodegas", bodegas);
	    
	    
	    String codPlanTarif = sessionData.getCliente().getCodTipoPlanTarif();
	    long codOrdenServicio = sessionData.getCodOrdenServicio();
	    logger.debug("codPlanTarif="+codPlanTarif);
	    logger.debug("codOrdenServicio="+codOrdenServicio);
	    String individualOEmpresa = "E";
    	logger.debug("flujo individual o Empresa :"+individualOEmpresa);
    	sessionData.setFlujoIndividualEmpresa(individualOEmpresa);

		String codCliente = Long.toString(sessionData.getCliente()!=null?sessionData.getCliente().getCodCliente():0);
	    form1.setClienteDestPre(codCliente);
	    form1.setClienteDestPos(codCliente);
	    form1.setClienteDestHib(codCliente);
	    
	    if(form1.getTipoPlanRB()== null){
	    	form1.setTipoPlanRB("combopre");
	    }
	    if(form1.getCondicH()== null){
	    	form1.setCondicH("SI");
	    }
	    if (individualOEmpresa.equalsIgnoreCase("E")){
	    	if (form1.getRadioPlanORango() == null) form1.setRadioPlanORango("radioPlan");
	    	form1.setOpcionPlanORango("PLAN");
	    	form1.setTipoPlanRB("combopos");
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
	   
	   logger.debug("execute():end CambioDePlanEmpresaAction");
	   return mapping.findForward(EMPRESA);
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
