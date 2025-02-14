package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.rmi.RemoteException;
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
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CatalogoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PaqueteDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
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
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ConDesPlanForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ForwardOS;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.JCondicionesComerciales;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.PaqueteWeb;


public class ContDesPlanAdicionalRecargaAction extends Action {
	
	private final Logger logger = Logger.getLogger(ContDesPlanAdicionalRecargaAction.class);
	private Global global = Global.getInstance();
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private PaqueteWeb productos;
	private String idAbonado;
	private ClienteDTO clienteDTO;
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		/*
		ConDesPlanForm conDesPlanForm=(ConDesPlanForm)form;
		String condicH=conDesPlanForm.getCondicH();
		condicH=condicH==null||condicH.equals("")?"":condicH;
		if ("".equals(condicH)){
			conDesPlanForm.setCondicH("SI");
		}
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("execute():start");
		*/
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = request.getSession(false);
	    //session.removeAttribute("navegacion");
	    //session.removeAttribute("productosContratados");
	    //session.removeAttribute("listaClientes"); //limpiar la lista de session CAMBIAR ESTO AL NUEVO ACTION QUE CONTROLARA LA LISTA?????????
	    
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	   
		sessionData.setDefaultPagina(obtenerDefaultPagina());
		ClienteDTO cliente = sessionData.getCliente();
        /************************/
		
		String canal= "PV";//"VT";
		String nivelApl="A";
		AbonadoDTO abonado = sessionData.getCliente().getAbonados().getAbonados()[0];//new AbonadoDTO();
        if(sessionData.getNumAbonado() == 0){nivelApl="C";}
		/*AbonadoListDTO abonadoListaSH = new AbonadoListDTO();
        AbonadoDTO[] abonados=new AbonadoDTO[1];
        if(sessionData.getNumAbonado() != 0){
          abonado.setNumAbonado(sessionData.getNumAbonado());
          abonado=delegate.obtenerDatosAbonado(abonado);
        }else{
        	 if(sessionData.getCodCliente()!=0){
 	 	    	session.removeAttribute("error");
 	 	    	logger.debug("obtenerListaAbonados:antes");
 	 	    	abonadoListaSH = delegate.obtenerListaAbonados(sessionData.getCliente());
 	 	    	logger.debug("obtenerListaAbonados:despues");
 	 	    	if(abonadoListaSH!=null){
 	 	    		abonados = abonadoListaSH.getAbonados();
 	 		    	abonados[0].setNumAbonado(0);
 	 		    	abonadoListaSH.setAbonados(abonados);
 	 		    	sessionData.setAbonados(abonadoListaSH.getAbonados());
 	 	    	}
        	 }
          abonado.setNumAbonado(0);
          nivelApl="C";
        }
        abonados[0]=abonado;
        abonadoListaSH.setAbonados(abonados);
        sessionData.setAbonados(abonadoListaSH.getAbonados());
        cliente.setAbonados(abonadoListaSH);
        sessionData.setCliente(cliente);*/
        /************************************/

		AbonadoDTO abonadoS = obtieneAbonado(abonado,canal,nivelApl,sessionData.getCodVendedor());
		NavegacionWeb navegacion = (NavegacionWeb) session.getAttribute("navegacion");
		OrdenServicioDTO ordenServicio = obtieneOrdenServ(cliente);
		//clienteDTOvta = obtenerDatosCtePorVta(ventaId);
		if(navegacion == null)
		{
			//navegacion = obtenerNavegacion(request,abonadoS,cliente,ordenServicio);
		}
		idAbonado = ""+abonadoS.getNumAbonado();
		productos = navegacion.getPaqueteWeb(idAbonado);			

		ClienteFrmkDTO clienteVTA = navegacion.getClienteWeb();
		clienteVTA= new ClienteFrmkDTO(cliente);
		AbonadoFrmkDTO abonadoFrmk1 = (AbonadoFrmkDTO)session.getAttribute("Abonado");
		AbonadoFrmkDTO abonadoFrmk = clienteVTA.getAbonado(Long.parseLong(idAbonado));			
		abonadoFrmk.setIdAbonado(Long.parseLong(idAbonado));
		abonadoFrmk.setCodCliente(clienteVTA.getIdCliente());	
		abonadoFrmk.setProductoContratados(productos.getProductoPorDefecto());//productos.getProductosContratados());
		abonadoFrmk.setProductoDisponibles(productos.getProductosDisponible());
		abonadoFrmk.setHayAutoAfinCont(productos.getHayAutoAfinCont());
		eliminaAtrSess(session);
		session.setAttribute("Abonado", abonadoFrmk);
		session.setAttribute("ClienteVTA",clienteVTA);	// seteo para mostrar datos en pagina
		session.setAttribute("navegacion", navegacion);
		//session.removeAttribute("controlesList");
		session.setAttribute("controlesList", obtenerControlesList(sessionData));
		session.setAttribute("ClienteOOSS", sessionData);
		String forward = ForwardOS.forwardOS(sessionData.getForward(), 1);
		
		//if (abonadoListaSH!=null&&abonadoListaSH.getAbonados()!=null&&abonadoListaSH.getAbonados().length>0){
	    	//RetornoDTO retValue=new RetornoDTO();
			//retValue.setCodigo("0");
	  /*
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
				forward="noContinuaOS";
		    	String osInvalida = retValue.getDescripcion();//global.getValor("valCondComOSS");
		    	session.setAttribute("error", osInvalida);
		    	//continua=false;
			}
	   // }
		*/	
		session.setAttribute("ultimaPagina","inicio");
		return mapping.findForward(forward);
	}

	private void eliminaAtrSess(HttpSession session) {
		session.removeAttribute("Abonado");
		session.removeAttribute("ClienteVTA");	// seteo para mostrar datos en pagina
		//session.removeAttribute("navegacion");
		session.removeAttribute("controlesList");
		//session.removeAttribute("ClienteOOSS");	
	}

	private DefaultPaginaCPUDTO obtenerDefaultPagina() {
		DefaultPaginaCPUDTO def= new DefaultPaginaCPUDTO();
	 	String dirXML = global.getValor("configActualizar.xml");//"config.xml");
	 	String dir = System.getProperty("user.dir") +dirXML;
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
	private NavegacionWeb obtenerNavegacion(HttpServletRequest request,AbonadoDTO abonado,ClienteDTO clienteVtaPar,OrdenServicioDTO ordenServicio) throws RemoteException, GeneralException
	{
		NavegacionWeb navegacion = new NavegacionWeb();
		//String numVenta = ventaId;//request.getParameter("num_venta")!=null?request.getParameter("num_venta"):ingresoVentaForm.getNumVenta();
		String numTransaccion = request.getParameter("num_transaccion")!=null?request.getParameter("num_transaccion"):"111";
		String numEvento = request.getParameter("num_evento")!=null?request.getParameter("num_evento"):"111";
		String codVendedor = request.getParameter("cod_vendedor")!=null?request.getParameter("cod_vendedor"):"111";
		
		navegacion.setNumEvento(numEvento);
		navegacion.setNumTransaccion(numTransaccion);
		navegacion.setCodVendedor(codVendedor);
		navegacion.creaProductoPorAbonado(abonado,clienteVtaPar,ordenServicio);
		return navegacion;
	}
}
