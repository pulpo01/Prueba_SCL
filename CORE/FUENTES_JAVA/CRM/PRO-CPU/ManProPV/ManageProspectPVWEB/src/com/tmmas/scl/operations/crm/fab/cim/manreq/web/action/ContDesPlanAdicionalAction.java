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

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.dao.ParseoXML;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ParametrosCondicionesCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ConDesPlanForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.JCondicionesComerciales;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.PaqueteWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.VentaUtils;


public class ContDesPlanAdicionalAction extends Action {
	
	private final Logger logger = Logger.getLogger(ContDesPlanAdicionalAction.class);
	private Global global = Global.getInstance();
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private PaqueteWeb productos;
	private String idAbonado;

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		//la funcionalidad de obtención de productos se movió a PlanesDWR
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("execute():start");
		
	    HttpSession session = request.getSession(false);  
	    ClienteOSSesionDTO sessionData = null;
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    String forward = "inicio";

		ConDesPlanForm conDesPlanForm=(ConDesPlanForm)form;
		boolean condicionesCK = conDesPlanForm.isCondicionesCK();

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
		session.setAttribute("ConDesPlanForm",conDesPlanForm);
		sessionData.setDefaultPagina(obtenerDefaultPagina());
		sessionData.setValoresDefecto(VentaUtils.obtenerValoresCorreoDefecto());
		
		//(+)17/05/10 Parametro que indica maximo de productos a desplegar en grilla de productos disponibles
		
		ParametroDTO paramLista = new ParametroDTO();
		paramLista.setCodModulo(global.getValor("codigo.modulo.GA").trim());
		paramLista.setCodProducto(Integer.parseInt(global.getValor("codigo.producto").trim())); 
		paramLista.setNomParametro(global.getValor("parametro.max_lista_producto").trim());
		ParametroDTO paramGral = delegate.obtenerParametroGeneral(paramLista);
		
		sessionData.setMaxListaProductos(Integer.parseInt(paramGral.getValor()));
		//(-)17/05/10 Parametro que indica maximo de productos a desplegar en grilla de productos disponibles

		ClienteDTO cliente = sessionData.getCliente();
        /************************/
		AbonadoDTO abonado = new AbonadoDTO();
        AbonadoListDTO abonadoListaSH = new AbonadoListDTO();
        AbonadoDTO[] abonados=new AbonadoDTO[1];
        
        RetornoDTO retorno = null;//aplicarRestricciones(sessionData,abonado);
        if(cliente.getAbonados() == null)
        {
    		if(sessionData.getNumAbonado() != 0){
    			abonado.setNumAbonado(sessionData.getNumAbonado());
    			abonado=delegate.obtenerDatosAbonado(abonado);
    			retorno = delegate.aplicarRestricciones(sessionData,abonado);//se mueve al delegate
    			if (!"OK".equals(retorno.getDescripcion())){
    				logger.debug("hubo error al aplicarRestricciones por abonado ["+retorno.getDescripcion()+"]");
    				session.setAttribute("error", retorno.getDescripcion());
    				return mapping.findForward("noContinuaOS");
    			}
    		}else{
    			retorno = delegate.aplicarRestricciones(sessionData,abonado);
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
     	 		    	abonados[0].setNumAbonado(0);
     	 		    	//abonadoListaSH.setAbonados(abonados);
     	 		    	sessionData.setAbonados(abonadoListaSH.getAbonados());
     	 		    	abonadoListaSH.setAbonados(null);
     	 	    	}
            	 }
              //abonado.setNumAbonado(0);
            	 abonado=abonados[0];
            }

            abonados[0]=abonado;
            abonadoListaSH.setAbonados(abonados);
            logger.debug("llena lista de abonados dependiendo de login como cliente o abonado : fin");
    		session.setAttribute("AbonadosSeleccionados",abonadoListaSH.getAbonados());
            sessionData.setAbonados(abonadoListaSH.getAbonados());
            cliente.setAbonados(abonadoListaSH);
            sessionData.setCliente(cliente);
    		RetornoDTO retValue=validarCondicionesComerciales(sessionData,abonadoListaSH);
        	if (!("0".equals(retValue.getCodigo()))){
    			//forward="noContinuaOS";
    			forward = "ErrorEnActionDeCarga";
    	    	String osInvalida = retValue.getDescripcion();//global.getValor("valCondComOSS");
    	    	session.setAttribute("error", osInvalida);
    	    	//continua=false;
        	}            
        }else
        {
        	abonadoListaSH = cliente.getAbonados();
        	abonado = abonadoListaSH.getAbonados()[0];
        }
        
		/* Tipo Comportamiento ini*///230410
		if(sessionData.getListaTiposCom() == null)
		{
			forward = "selTipoComp";
			return mapping.findForward(forward);
		}
		/* Tipo Comportamiento fin*/
		
        /************************************/
		NavegacionWeb navegacion = (NavegacionWeb) session.getAttribute("navegacion");
		idAbonado = ""+abonado.getNumAbonado();
		productos = navegacion.getPaqueteWeb(idAbonado);
		if(productos.getProductoPorDefecto().size() == 0 && productos.getProductosDisponible().size() == 0)
		{
			request.setAttribute("hayproductos", "NO");	
		}
		else
		{
			request.setAttribute("hayproductos", "SI");
		}

		session.setAttribute("ultimaPagina","inicio");
		return mapping.findForward(forward);
	}
	
	private RetornoDTO validarCondicionesComerciales(ClienteOSSesionDTO sessionData, AbonadoListDTO abonadoListaSH)
	{
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
		return retValue;
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
    

}
