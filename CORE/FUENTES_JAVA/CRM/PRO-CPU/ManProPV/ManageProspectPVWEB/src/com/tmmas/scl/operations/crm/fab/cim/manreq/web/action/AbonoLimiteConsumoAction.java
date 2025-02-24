package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.rmi.RemoteException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RestriccionesDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CatalogoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroPlanDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.dao.ParseoXML;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.AbonadoFrmkDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteFrmkDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ControlDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ParametrosCondicionesCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.AboLimiteConsumoForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.JCondicionesComerciales;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.PaqueteWeb;

public class AbonoLimiteConsumoAction extends Action{
	
	private final Logger logger = Logger.getLogger(AbonoLimiteConsumoAction.class);
	private Global global = Global.getInstance();
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private PaqueteWeb productos;
	private String idAbonado;
	private ClienteDTO clienteDTO;
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("execute():start");
		
	    HttpSession session = request.getSession(false);
	    session.removeAttribute("navegacion");
	    session.removeAttribute("productosContratados");
	    session.removeAttribute("listaClientes"); //limpiar la lista de session CAMBIAR ESTO AL NUEVO ACTION QUE CONTROLARA LA LISTA?????????	  
	    ClienteOSSesionDTO sessionData = null;
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");

	    AboLimiteConsumoForm aboLimiteConsumoForm = (AboLimiteConsumoForm)form;
		
	    boolean condicionesCK = aboLimiteConsumoForm.isCondicionesCK();
			
		String ultimaPagina = (session.getAttribute("ultimaPagina")!=null?(String)session.getAttribute("ultimaPagina"):"");
		if (!(ultimaPagina.equalsIgnoreCase("Resumen")) && !(ultimaPagina.equalsIgnoreCase("cargos"))) {
			sessionData.setObtenerCargos("NO");
		} else {
			if (condicionesCK==true){
		        sessionData.setObtenerCargos("NO");
			}else {
				sessionData.setObtenerCargos("SI");			
			}			
		}
		session.setAttribute("AboLimiteConsumoForm",aboLimiteConsumoForm);
		
		
		sessionData.setDefaultPagina(obtenerDefaultPagina());
		ClienteDTO cliente = sessionData.getCliente();
        /************************/
		String canal= "PV";//"VT";
		String nivelApl="A";
		AbonadoDTO abonado = new AbonadoDTO();
        AbonadoListDTO abonadoListaSH = new AbonadoListDTO();
        AbonadoDTO[] abonados=new AbonadoDTO[1];
        
        RetornoDTO retorno = null;

		if(sessionData.getNumAbonado() != 0){
			abonado.setNumAbonado(sessionData.getNumAbonado());
			abonado=delegate.obtenerDatosAbonado(abonado);
			retorno = aplicarRestricciones(sessionData,abonado);
			if (!"OK".equals(retorno.getDescripcion())){
				logger.debug("hubo error al aplicarRestricciones por abonado ["+retorno.getDescripcion()+"]");
				session.setAttribute("error", retorno.getDescripcion());
				return mapping.findForward("noContinuaOS");
			}
		}else{
			retorno = aplicarRestricciones(sessionData,abonado);
			if (!"OK".equals(retorno.getDescripcion())){
				logger.debug("hubo error al aplicarRestricciones por cliente ["+retorno.getDescripcion()+"]");
				session.setAttribute("error", retorno.getDescripcion());
				return mapping.findForward("noContinuaOS");
			}
        	if(sessionData.getCodCliente()!=0){
 	 	    	session.removeAttribute("error");
 	 	    	logger.debug("obtenerListaAbonados:antes");
 	 	    	abonadoListaSH = delegate.obtenerListaAbonados(sessionData.getCliente());
 	 	    	logger.debug("obtenerListaAbonados:despues");
 	 	    	if(abonadoListaSH!=null){
 	 	    		abonado = abonadoListaSH.getAbonados()[0];
 	 	    		abonados[0]=abonado;
 	 		    	//abonados[0].setNumAbonado(0);
 	 		    	//abonadoListaSH.setAbonados(abonados);
 	 		    	sessionData.setAbonados(abonadoListaSH.getAbonados());
 	 		    	abonadoListaSH.setAbonados(null);
 	 	    	}
        	 }
        	 
          //abonado.setNumAbonado(0);
        	 abonado=abonados[0];
          nivelApl="C";
        }
		
		
		
		
        abonados[0]=abonado;
        abonadoListaSH.setAbonados(abonados);
        logger.debug("llena lista de abonados dependiendo de login como cliente o abonado : fin");
		session.setAttribute("AbonadosSeleccionados",abonadoListaSH.getAbonados());
        sessionData.setAbonados(abonadoListaSH.getAbonados());
        cliente.setAbonados(abonadoListaSH);
        sessionData.setCliente(cliente);
        /************************************/
				
		AbonadoDTO abonadoS = obtieneAbonado(abonado,canal,nivelApl,sessionData.getCodVendedor());
		NavegacionWeb navegacion = (NavegacionWeb) session.getAttribute("navegacion");
		OrdenServicioDTO ordenServicio = obtieneOrdenServ(cliente);
		//clienteDTOvta = obtenerDatosCtePorVta(ventaId);
		if(navegacion == null)
		{
			navegacion = obtenerNavegacion(request,abonadoS,cliente,ordenServicio);
		}
		idAbonado = ""+abonadoS.getNumAbonado();
		productos = navegacion.getPaqueteWeb(idAbonado);			
		
		if (productos==null)
		{	//esta condicion es equivalente a preguntar, es la primera vez que entra al detalle del abonado				
			//(+) EV 16/02/09
			//productos = new PaqueteWeb(abonadoS,cliente,ordenServicio);//ventaUtils.getAbonado(idAbonado, ventaDTO));}
			productos = new PaqueteWeb(abonadoS,cliente,ordenServicio,sessionData.getNumAbonado(),sessionData);//ventaUtils.getAbonado(idAbonado, ventaDTO));}
			//(-)
			/* AGREGO ELEMENTO WEB DE PRODUCTO POR ABONADO */
			navegacion.AgregarElementoWeb(idAbonado, productos);
		}	
		ClienteFrmkDTO clienteVTA = navegacion.getClienteWeb();
		clienteVTA= new ClienteFrmkDTO(cliente);
		AbonadoFrmkDTO abonadoFrmk = clienteVTA.getAbonado(Long.parseLong(idAbonado));			
		abonadoFrmk.setIdAbonado(Long.parseLong(idAbonado));
		abonadoFrmk.setCodCliente(clienteVTA.getIdCliente());	
		abonadoFrmk.setProductoContratados(productos.getProductoPorDefecto());//productos.getProductosContratados());
		abonadoFrmk.setProductoDisponibles(productos.getProductosDisponible());
		abonadoFrmk.setLimiteConsumoProductos(productos.getLimiteConsumoProductos());
		abonadoFrmk.setHayAutoAfinCont(productos.getHayAutoAfinCont());
		
		if(productos.getProductoPorDefecto().size() == 0 && productos.getProductosDisponible().size() == 0)
		{
			request.setAttribute("hayproductos", "NO");	
		}
		else
		{
			request.setAttribute("hayproductos", "SI");
		}
			
		session.setAttribute("Abonado", abonadoFrmk);
		session.setAttribute("ClienteVTA",clienteVTA);	// seteo para mostrar datos en pagina
		session.setAttribute("navegacion", navegacion);
		session.removeAttribute("controlesList");
		session.setAttribute("controlesList", obtenerControlesList(sessionData));
		session.setAttribute("ClienteOOSS", sessionData);
		//String forward = ForwardOS.forwardOS(sessionData.getForward(), 1);
		String forward = "inicio";
		
		//if (abonadoListaSH!=null&&abonadoListaSH.getAbonados()!=null&&abonadoListaSH.getAbonados().length>0){
	    	RetornoDTO retValue=new RetornoDTO();
			retValue.setCodigo("0");
	   try{
	    	UsuarioDTO usuario=new UsuarioDTO();//vendedor
	    	
			usuario.setNombre(sessionData.getUsuario());
			usuario= delegate.obtenerVendedor(usuario);

	    	ParametrosCondicionesCPUDTO parametros = new ParametrosCondicionesCPUDTO();
	    	parametros.setCodOOSS(sessionData.getCodOrdenServicio());
	    	parametros.setCombinatoriaGenerada("-");
	    	parametros.setUsuario(String.valueOf(usuario.getCodigo()));
	    	parametros.setCodPlanTarifSelec(sessionData.getCliente().getCodPlanTarif());
	    	parametros.setTipoPlanTarifDestino(sessionData.getCliente().getCodTipoPlan());
	    	
	    	JCondicionesComerciales jCondicionesComerciales =new JCondicionesComerciales();
	    	retValue=jCondicionesComerciales.getCondicionesComercialesOss(abonadoListaSH,parametros);
	   }
	   catch(ManReqException e){
		    e=(ManReqException)e.getCause();
	    	retValue.setCodigo(e.getCodigo());
	    	retValue.setDescripcion(e.getDescripcionEvento());
	    	retValue.setResultado(true);
	   }
			if (!("0".equals(retValue.getCodigo()))){
				//forward="noContinuaOS";
				forward = "ErrorEnActionDeCarga";
		    	String osInvalida = retValue.getDescripcion();//global.getValor("valCondComOSS");
		    	session.setAttribute("error", osInvalida);
		    	//continua=false;
			}
	   // }
			
			
		//(+) evera, 20/11/08 inicializa variable de session comun a CPU y Producto
			RegistroPlanDTO registroPlan=new RegistroPlanDTO();
			ParamRegistroPlanDTO param = new ParamRegistroPlanDTO();	
			
			param.setCombinatoria("");
			param.setNomUsuaOra("");
			param.setFecDesdeLlam("");
			param.setFecDesdeLlamTS(new Timestamp((new Date()).getTime()));
			param.setCodPlanTarifDestino("");
			param.setTipOOSS("");
			
			registroPlan.setParamRegistroPlan(param);
			
			session.removeAttribute("registroPlan");	    
			session.setAttribute("registroPlan", registroPlan);	
		//(-)
		session.setAttribute("ultimaPagina","inicio");
		return mapping.findForward(forward);
	}

	private RetornoDTO aplicarRestricciones(ClienteOSSesionDTO sessionData, AbonadoDTO abonado) throws GeneralException {
		/***
		 * @author rlozano
		 * @description Se invoca método para validación y verificación de datos :  PL de Restricciones
		 * @date 24-12-2008
		 */
		RetornoDTO retorno = new RetornoDTO();
		
		SecuenciaDTO secuencia = new SecuenciaDTO();
		secuencia.setNomSecuencia("CI_SEQ_NUMOS");
		secuencia = delegate.obtenerSecuencia(secuencia);
		long numOOSS =  secuencia.getNumSecuencia();
		
		
		//(+) EV 12/01/09
		SecuenciaDTO secuenciaTransacabo = new SecuenciaDTO();
		secuenciaTransacabo.setNomSecuencia("GA_SEQ_TRANSACABO");
		secuenciaTransacabo = delegate.obtenerSecuencia(secuenciaTransacabo);
		long numSeqTransacabo =  secuenciaTransacabo.getNumSecuencia();
		//(-) EV 12/01/09
		
		String usuarioOra ="";
		
		//obtiene usuario
		UsuarioDTO usuario = new UsuarioDTO();
		usuario.setNombre(sessionData.getUsuario());
		usuario = this.delegate.obtenerVendedor(usuario);
		
		ClienteDTO cliente = sessionData.getCliente();
		
		long numAbonado;
		long codCliente;
		long numVenta;
		int codUso;
		long codCuentaOrigen;
		long codCuentaDestino;
		String tipoPlan;
		long numCiclo;
		int codCentral;
		long idSecuencia = numOOSS;
		String codActuacion;
		String codOOS = ""+sessionData.getCodOrdenServicio();
		String codVendedor = ""+usuario.getCodigo();
		String planDestino = ""; //EV 30/04/09 inc 87696
		
		if(sessionData.getNumAbonado() != 0){
			numAbonado = abonado.getNumAbonado();
			codCliente = abonado.getCodCliente();
			numVenta   = abonado.getNumVenta();
			codUso     = Integer.parseInt(abonado.getCodUso());
			codCuentaOrigen  = abonado.getCodCuenta();
			codCuentaDestino = abonado.getCodCuenta();
			tipoPlan = abonado.getCodTipoPlanTarif();
			numCiclo = abonado.getCodCiclo();
			codCentral = abonado.getCodCentral();
			codActuacion = global.getValor("cod.act.ooss.abo");
			planDestino = abonado.getCodPlanTarif(); //EV 30/04/09 inc 87696
		}
		else
		{
			//cliente = sessionData.getCliente();
			numAbonado = 0;
			codCliente = cliente.getCodCliente();
			numVenta   = idSecuencia;//abonado.getNumVenta();
			codUso     = -1;
			codCuentaOrigen  = cliente.getCodCuenta();
			codCuentaDestino = cliente.getCodCuenta();
			tipoPlan = cliente.getCodTipoPlanTarif();
			numCiclo = cliente.getCodCiclo();
			codCentral = -1;
			codActuacion = global.getValor("cod.act.ooss.cli");
		}

		RestriccionesDTO restriccionesDTO = new RestriccionesDTO();
		restriccionesDTO.setNumAbonado(numAbonado);
		restriccionesDTO.setCodCliente(codCliente);
		restriccionesDTO.setNumVenta(numVenta);
		restriccionesDTO.setCodUso(codUso);
		restriccionesDTO.setCodCuentaOrigen(codCuentaOrigen);
		restriccionesDTO.setCodCuentaDestino(codCuentaDestino);
		restriccionesDTO.setTipoPlan(tipoPlan);
		restriccionesDTO.setNumCiclo(numCiclo);
		restriccionesDTO.setCodCentral(codCentral);
		//restriccionesDTO.setIdSecuencia(idSecuencia);    //EV
		restriccionesDTO.setIdSecuencia(numSeqTransacabo); //EV
		restriccionesDTO.setCodActuacion(codActuacion);
		restriccionesDTO.setCodOOSS(codOOS);
		restriccionesDTO.setCodVendedor(codVendedor);
		restriccionesDTO.setPlanDestino(planDestino); //EV 30/04/09 inc 87696
		retorno = delegate.aplicaPLRestricciones(restriccionesDTO);
		return retorno;
	}

	private DefaultPaginaCPUDTO obtenerDefaultPagina() {
		DefaultPaginaCPUDTO def= new DefaultPaginaCPUDTO();
	 	String dirXML = global.getValor("configActualizar.xml");//"config.xml");
	 	String dir = global.getPathInstancia() +dirXML;
	 	logger.debug("dir="+dir);
	 	ParseoXML parseo=new ParseoXML();
		logger.debug("leyendo  y parseando XML configuración:antes");
		def=parseo.cargaXML(dir);
		logger.debug("leyendo  y parseando XML configuración:despues");
		return def;
	}
    
	private ArrayList obtenerControlesList(ClienteOSSesionDTO sessionData) {
		XMLDefault objetoXML	= new XMLDefault();
	    DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
	    SeccionDTO seccion=new SeccionDTO();
	    ArrayList controlesList = new ArrayList();
	    objetoXMLSession = sessionData.getDefaultPagina();
	    seccion = objetoXML.obtenerSeccion(objetoXMLSession, "piePaginaCargosPAG", "CargosCondicionesRegistroSS");    
	    controlesList.add(seccion.obtControl("condicionesCK"));
	    ControlDTO control = seccion.obtControl("condicionesCK");
	    
	   
	    return controlesList;
	}

	private OrdenServicioDTO obtieneOrdenServ(ClienteDTO cliente) throws ManReqException {
		OrdenServicioDTO ordenServicio = new OrdenServicioDTO();
		ordenServicio.setIdOrdenServicio(1);
		ordenServicio.setNumOrdenServicio("13");
		ordenServicio.setCliente(cliente);
		ordenServicio.setTipoComportamiento(null);
		return ordenServicio;
	}
	private AbonadoDTO obtieneAbonado(AbonadoDTO abonado,String canal, String  nivelApl,String codVendedor) throws ManReqException {

		abonado.setCatalogo(obtenerCatalogo(canal,nivelApl,codVendedor));
		abonado.setPlanTarifario(new PlanTarifarioDTO());
		abonado.getPlanTarifario().setPaqueteDefault(new PaqueteDTO());
		abonado.getPlanTarifario().getPaqueteDefault().setCodProdPadre("13");//TODO REVISAR QUE NO AFECTE LA W
		return abonado;
	}
	private CatalogoDTO obtenerCatalogo(String canal, String nivelApl,String codVendedor) {
		CatalogoDTO catalogo = new CatalogoDTO();
		Calendar cal= Calendar.getInstance();			
		cal.set(3000,11,31);			
		catalogo.setCodCanal(canal);//"PV"
		catalogo.setFecInicioVigencia(new Date());
		catalogo.setFecTerminoVigencia(new Date(cal.getTimeInMillis()));
		catalogo.setIndNivelAplica(nivelApl);//C
		catalogo.setCodVendedor(codVendedor);
		return catalogo;
	}
	private ClienteDTO obtenerDatosCtePorVta(String ventaId) throws ManConException, ManReqException {
		VentaDTO venta = new VentaDTO();
		ClienteDTO clienteVta = new ClienteDTO();//clienteDTO.setCodCliente(frmCodCliente);
		venta.setIdVenta(ventaId);//venta.setIdVenta(frmNumVenta);	
		venta.setCliente(clienteVta);
		clienteVta=delegate.obtenerDatosCliente(venta);//obtenerDatosClienteCuenta(venta);
		return clienteVta;
	}
	private NavegacionWeb obtenerNavegacion(HttpServletRequest request,AbonadoDTO abonado,ClienteDTO clienteVtaPar,OrdenServicioDTO ordenServicio) throws Exception
	{
		NavegacionWeb navegacion = new NavegacionWeb();
		//String numVenta = ventaId;//request.getParameter("num_venta")!=null?request.getParameter("num_venta"):ingresoVentaForm.getNumVenta();
		String numTransaccion = request.getParameter("num_transaccion")!=null?request.getParameter("num_transaccion"):"111";
		String numEvento = request.getParameter("num_evento")!=null?request.getParameter("num_evento"):"111";
		String codVendedor = request.getParameter("cod_vendedor")!=null?request.getParameter("cod_vendedor"):"111";
		
		navegacion.setNumEvento(numEvento);
		navegacion.setNumTransaccion(numTransaccion);
		navegacion.setCodVendedor(codVendedor);
		
		//(+) EV 16/02/09
	    ClienteOSSesionDTO sessionData = null;
	    HttpSession session = request.getSession(false);
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    //(-)
	    
		navegacion.creaLimiteConsuProductoPorAbonado(abonado,clienteVtaPar,ordenServicio,sessionData.getNumAbonado(),sessionData);//EV
		return navegacion;
	}

	

}
