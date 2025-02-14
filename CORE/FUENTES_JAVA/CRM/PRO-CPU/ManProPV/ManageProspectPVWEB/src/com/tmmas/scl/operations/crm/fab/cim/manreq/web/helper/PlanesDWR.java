package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.AbonadoFrmkDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteFrmkDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProductoFrmkDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.RetornoListaAjaxDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;


public class PlanesDWR {
	
	private final Logger logger = Logger.getLogger(PlanesDWR.class);
	private ArrayList listaProductosOblig = new ArrayList();

	/*
	 * Obtiene planes por abonado y por prestacion
	 */
	private String idAbonado;
	public RetornoListaAjaxDTO obtenerPlanesAbonado(String tiposComportamiento) throws Exception
	{
		logger.debug("obtenerPlanesAbonado():inicio");

		WebContext ctx = WebContextFactory.get();
		HttpServletRequest request = ctx.getHttpServletRequest();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);
	    session.removeAttribute("navegacion");
	    session.removeAttribute("productosContratados");
	    session.removeAttribute("listaClientes");
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		ProductoFrmkDTO[] listaProductos =  new ProductoFrmkDTO[0];
		String canal= "PV";
		String nivelApl="A";
		PaqueteWeb productos;
		
        ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
        sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
        ClienteDTO cliente = sessionData.getCliente();
        AbonadoDTO abonado = new AbonadoDTO();
        AbonadoListDTO abonadoListaSH = cliente.getAbonados();
    	abonado = abonadoListaSH.getAbonados()[0];
    	
    	String[] listaTiposCom = tiposComportamiento.split(",");
		logger.debug("tiposComportamientoSel.length["+listaTiposCom.length+"]");
		for(int i=0;i<listaTiposCom.length;i++)
		{
			logger.debug("Tipo Comportamiento Sel["+i+"]["+listaTiposCom[i]+"]");
		}
    	sessionData.setListaTiposCom(listaTiposCom);
    	if(sessionData.getNumAbonado() == 0)
    	{
    		nivelApl="C";
    	}
       
        HashMap parametrosCorreo = VentaUtils.obtenerParametrosCorreo();
        session.setAttribute("parametrosCorreo",parametrosCorreo);
        AbonadoDTO abonadoS = VentaUtils.obtieneAbonado(abonado,canal,nivelApl,sessionData.getCodVendedor());
		NavegacionWeb navegacion = (NavegacionWeb) session.getAttribute("navegacion");
		OrdenServicioDTO ordenServicio = VentaUtils.obtieneOrdenServ(cliente);

		if(navegacion == null)
		{
			logger.debug("RAV():inicio IF  navegacion: ");
			navegacion = obtenerNavegacion(request,abonadoS,cliente,ordenServicio);
		}
		idAbonado = ""+abonadoS.getNumAbonado();
		
		logger.debug("RAV():inicio NUM ABONADO: "+ idAbonado);
		productos = navegacion.getPaqueteWeb(idAbonado);			
		
		logger.debug("productos == NULL antes IF");
		
		if (productos==null)
		{	//esta condicion es equivalente a preguntar, es la primera vez que entra al detalle del abonado				
			//(+) EV 16/02/09
			//productos = new PaqueteWeb(abonadoS,cliente,ordenServicio);//ventaUtils.getAbonado(idAbonado, ventaDTO));}
			logger.debug("Entro como objeto NULL");
			productos = new PaqueteWeb(abonadoS,cliente,ordenServicio,sessionData.getNumAbonado(),sessionData);//ventaUtils.getAbonado(idAbonado, ventaDTO));}
			//(-)
			/* AGREGO ELEMENTO WEB DE PRODUCTO POR ABONADO */
			navegacion.AgregarElementoWeb(idAbonado, productos);
		}				
		
		logger.debug("PASO........");

		//(+) EV 26/04/2010 filtra los productos disponibles segun los tipos de comportamientos seleccionados
		// ArrayList productosDisponiblesFiltrados = productos.getProductosDisponible();//el filtro ya se hizo en paqweb
		// filtrarPorTipoComportamiento(productos.getProductosDisponible(),listaTiposCom); 
		//(-) EV 26/04/2010 
		
		//(+) EV 26/04/2010 filtra los productos disponibles segun los tipos de comportamientos seleccionados

		for (int j=0;j<(productos.getProductosDisponible()).size();j++) {

				ProductoWeb productoX = (ProductoWeb) (productos.getProductosDisponible()).get(j);			
				logger.debug(" * * * * * * * * * * * * * * * * * * * * * * * ");
				logger.debug("productoX.getComportamiento(): [" + productoX.getComportamiento() + "]");
				logger.debug("productoX.getTipoPlanAdic()  : [" + productoX.getTipoPlanAdic()    + "]");
				logger.debug(" * * * * * * * * * * * * * * * * * * * * * * * ");		
		}	
		
		//Prueba FDL
		for (int j=0;j<(productos.getProductoList().length).size();j++) {

				ProductoOfertadoDTO productoX = productosOfertables.getProductoList()[p];
			
				ProductoWeb productoX = (ProductoWeb) (productos.getProductosDisponible()).get(j);			
				logger.debug(" * * * * * * Prueba FDL * * * * * * * * * ");
				logger.debug("productoX.getTipoPlanAdic()  : [" + productoX.getTipoPlanAdic()    + "]");
				logger.debug(" * * * * * * Prueba FDL * * * * * * * * * * * ");		
		}	
		//Prueba FDL
		
		
		
		ArrayList productosDisponiblesFiltrados = filtrarPorTipoComportamiento(productos.getProductosDisponible(),listaTiposCom);
		//(-) EV 26/04/2010
		
		//inicio JMO 22/11/2010 INC 155400
		//Se filtra los productos disponibles excluyendo los planes adicionales obligatorios
		ArrayList productosDisponiblesSinOblig = filtrarPorTipoComportamientoSinOblig(productos.getProductosDisponible(),listaTiposCom);
		//fin JMO 22/11/2010 INC 155400
		
		listaProductos = new ProductoFrmkDTO[productosDisponiblesFiltrados.size()];
		for(int i=0; i<productosDisponiblesFiltrados.size();i++){
			ProductoWeb productoWeb = (ProductoWeb) productosDisponiblesFiltrados.get(i);
			
			ProductoFrmkDTO prod = new ProductoFrmkDTO();
			prod.setCodigo(productoWeb.getCodigo());
			prod.setDescripcion(productoWeb.getComportamiento()+" - "+ productoWeb.getCodProducto()+" - "+productoWeb.getNombre());
			
			listaProductos[i] = prod;
		}
		
		ClienteFrmkDTO clienteVTA = navegacion.getClienteWeb();
		clienteVTA= new ClienteFrmkDTO(cliente);
		AbonadoFrmkDTO abonadoFrmk = clienteVTA.getAbonado(Long.parseLong(idAbonado));			
		abonadoFrmk.setIdAbonado(Long.parseLong(idAbonado));
		abonadoFrmk.setCodCliente(clienteVTA.getIdCliente());	
		abonadoFrmk.setProductoContratados(productos.getProductoPorDefecto());//productos.getProductosContratados());
		abonadoFrmk.setProductoDisponibles(productosDisponiblesFiltrados);//productos.getProductosDisponible());
		abonadoFrmk.setHayAutoAfinCont(productos.getHayAutoAfinCont());

		session.setAttribute("Abonado", abonadoFrmk);
		session.setAttribute("ClienteVTA",clienteVTA);	// seteo para mostrar datos en pagina
		session.setAttribute("navegacion", navegacion);
		session.removeAttribute("controlesList");
		session.setAttribute("controlesList", VentaUtils.obtenerControlesList(sessionData));
		session.setAttribute("ClienteOOSS", sessionData);
		
		//(+) evera, 20/11/08 inicializa variable de session comun a CPU y Producto
		RegistroPlanDTO registroPlan=VentaUtils.obtenerRegistroPlan();
		session.removeAttribute("registroPlan");	    
		session.setAttribute("registroPlan", registroPlan);	
		//(-)
		
		//indica si se debe abrir popup para filtrar productos antes de pasar a la siguiente pagina
		session.removeAttribute("listaProductos");
		
		if (listaProductos!=null){
			session.setAttribute("listaProductos", listaProductos);//carga lista en popup
			
			logger.debug("Todos productos por abonado :"+listaProductos.length);
			if (listaProductos.length > sessionData.getMaxListaProductos())	retorno.setAbrirPopupFiltro("S");
			else															retorno.setAbrirPopupFiltro("N");
		}

		logger.debug("obtenerPlanesAbonado():fin");
		return retorno;
		
	}
	
	private ArrayList filtrarPorTipoComportamiento(ArrayList productosDisponibles, String[] listaTiposCom)  {
		logger.debug("filtrarPorTipoComportamiento():ini");
		
		String seleccion = "";
		ArrayList productosDisponiblesFiltrados = new ArrayList();
		
		for(int i=0;i<listaTiposCom.length;i++){
			logger.debug("RAV() ENTRA FOR 1");
			
			seleccion = seleccion + " [" + listaTiposCom[i]+"]";
			
			ArrayList productosDisponiblesAux = new ArrayList();
			
			for (int j=0;j<productosDisponibles.size();j++) {
				logger.debug("RAV() ENTRA FOR 2");
				ProductoWeb productoX = (ProductoWeb) productosDisponibles.get(j);
				
				logger.debug(" * * * * * * * * * * * * * * * * * * * * * * * ");
				logger.debug("productoX.getComportamiento(): [" + productoX.getComportamiento() + "]");
				logger.debug("productoX.getTipoPlanAdic()  : [" + productoX.getTipoPlanAdic()    + "]");
				logger.debug(" * * * * * * * * * * * * * * * * * * * * * * * ");
				
				if (productoX.getComportamiento().equals(listaTiposCom[i]) && !(productoX.getTipoPlanAdic().equals("2")) ){
					logger.debug("RAV() ENTRA IF");
					productosDisponiblesAux.add(productoX);
				}
			}
			
			productosDisponiblesFiltrados.addAll(productosDisponiblesAux);	
			
		}
		logger.debug("RAV() SALIO FOR 1");
		
		logger.debug("Cantidad de PA filtrados sin PA oblig.: "+productosDisponiblesFiltrados.size());
		logger.debug("Tipos de comportamientos seleccionados:"+seleccion);
		logger.debug("filtrarPorTipoComportamiento():fin");
		return productosDisponiblesFiltrados;
	}

	private NavegacionWeb obtenerNavegacion(HttpServletRequest request,AbonadoDTO abonado,ClienteDTO clienteVtaPar,OrdenServicioDTO ordenServicio) throws Exception
	{
		
		logger.debug("RAV NavegacionWeb 4 INICIO");
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
		logger.debug("RAV navegacion.creaProductoPorAbonado 4 ABONADO: "+ abonado.getNumAbonado());
		navegacion.creaProductoPorAbonado(abonado,clienteVtaPar,ordenServicio,sessionData.getNumAbonado(),sessionData);//EV
		logger.debug("RAV NavegacionWeb 4 FIN");
		return navegacion;
	}
		
	/**
	* filtra listado de productos disponibles segun comportamiento
	* se excluye planes adicionales obligatorios
	**/
	private ArrayList filtrarPorTipoComportamientoSinOblig(ArrayList productosdisponibles, String[] listatiposcom) {
		
		logger.debug("filtrarportipocomportamientosinoblig():ini");

		String seleccion = "";
		ArrayList productosDisponiblesFiltrados = new ArrayList();

		for (int i = 0; i < listatiposcom.length; i++) {
			seleccion = seleccion + " [" + listatiposcom[i] + "]";

			ArrayList productosDisponiblesAux = new ArrayList();

			for (int j = 0; j < productosdisponibles.size(); j++) {
				ProductoWeb productox = (ProductoWeb)productosdisponibles.get(j);
				
				if (productox.getComportamiento().equals(listatiposcom[i]) && !(productox.getTipoPlanAdic().equals("2"))) {
					productosDisponiblesAux.add(productox);
				}
			}

			productosDisponiblesFiltrados.addAll(productosDisponiblesAux);

		}
		logger.debug("cantidad de pa filtrados sin pa oblig.: "
				+ productosDisponiblesFiltrados.size());
		logger.debug("tipos de comportamientos seleccionados:" + seleccion);
		logger.debug("filtrarportipocomportamientosinoblig():fin");
		return productosDisponiblesFiltrados;
	}

}
