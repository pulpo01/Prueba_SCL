package com.tmmas.scl.operations.crm.f.s.manpro.web.ajax.dwr;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.AbonadoFrmkDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ClienteFrmkDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ProductoFrmkDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.RetornoListaAjaxDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.delegate.ManageProspectBussinessDelegate;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.PaqueteWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.ProductoWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.VentaUtils;
import com.tmmas.scl.operations.crm.f.sel.negsal.helper.NegSalUtils;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.OfertaComercialDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoOcasionalListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import org.apache.commons.lang.SerializationUtils;

public class PlanesDWR {
	
	private final Logger logger = Logger.getLogger(PlanesDWR.class);
	private ArrayList listaProductosOblig = new ArrayList();
	
	ManageProspectBussinessDelegate delegate=ManageProspectBussinessDelegate.getInstance();
	
	/*
	 * Obtiene planes por abonado y por prestacion
	 */
	public RetornoListaAjaxDTO obtenerPlanesAbonado(String numAbonado, String tiposComportamiento)
	{
		logger.debug("obtenerPlanesAbonado():inicio");
		logger.debug("numAbonado="+numAbonado);
		
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);
		
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		ProductoFrmkDTO[] listaProductos =  new ProductoFrmkDTO[0];
		
		PaqueteWeb productos;
		
		//(+) codigo de ClienteAction
		NavegacionWeb navegacion = (NavegacionWeb) session.getAttribute("navegacion");
		VentaDTO venta = (VentaDTO) session.getAttribute("VentaDTO");
		ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		
		logger.debug("navegacion="+navegacion);
		logger.debug("ventaDTO="+venta);		
		
		if (navegacion == null){
			retorno.setCodError("-100");
			retorno.setMsgError("Su sesión ha expirado");
			return retorno;
		}
		
		ClienteFrmkDTO clienteVTA = navegacion.getClienteWeb();
		
		/*Entro a ver el detalle de un Abonado*/
		productos = navegacion.getPaqueteWeb(numAbonado);			
		logger.debug("productos="+productos);
		
		if (productos==null)
		{	//esta condicion es equivalente a preguntar, es la primera vez que entra al detalle del abonado	
			logger.debug("entra a ver el detalle del abonado por primera vez");
			
			AbonadoDTO abonSeleccionado=null;
			for(int i=0;i<venta.getCliente().getAbonados().getAbonados().length;i++)
			{
				AbonadoDTO auxAbon=venta.getCliente().getAbonados().getAbonados()[i];
				if(numAbonado.equalsIgnoreCase(String.valueOf(auxAbon.getNumAbonado())))
				{					
					abonSeleccionado=auxAbon;
					abonSeleccionado.setCodCliente(venta.getCliente().getCodCliente());
				}
			}
			try{
				productos = new PaqueteWeb(abonSeleccionado,navegacion.getCodVendedor(),sessionData);
			}catch(Exception e){}
			
			/* AGREGO ELEMENTO WEB DE PRODUCTO POR ABONADO */
			navegacion.AgregarElementoWeb(numAbonado, productos);
		}			
		
		String[] listaTiposCom = tiposComportamiento.split(",");
		
		//(+) EV 26/04/2010 filtra los productos disponibles segun los tipos de comportamientos seleccionados
		ArrayList productosDisponiblesFiltrados = 
			filtrarPorTipoComportamiento(productos.getProductosDisponible(),listaTiposCom); 
		//(-) EV 26/04/2010 
		
		
		//inicio JMO 22/11/2010 INC 155400
		//Se filtra los productos disponibles excluyendo los planes adicionales obligatorios
		ArrayList productosDisponiblesSinOblig = 
			filtrarPorTipoComportamientoSinOblig(productos.getProductosDisponible(),listaTiposCom);
		//fin JMO 22/11/2010 INC 155400
		
		
		//AGREGAR FILTRO POR PRESTACION
		listaProductos = new ProductoFrmkDTO[productosDisponiblesSinOblig.size()];
		//listaProductos = new ProductoFrmkDTO[productosDisponiblesFiltrados.size()];
		
		for(int i=0; i<productosDisponiblesSinOblig.size();i++) {
			ProductoWeb productoWeb = (ProductoWeb) productosDisponiblesSinOblig.get(i);
			
			ProductoFrmkDTO prod = new ProductoFrmkDTO();			
			prod.setCodigo(productoWeb.getCodigo());				
			prod.setDescripcion(productoWeb.getComportamiento()+" - "+ productoWeb.getCodProducto()+" - "+productoWeb.getNombre());
			listaProductos[i] = prod;				
		}
		
		AbonadoFrmkDTO abonado = clienteVTA.getAbonado(Long.parseLong(numAbonado));			
		abonado.setCodCliente(clienteVTA.getIdCliente());	
		abonado.setProductoContratados(productos.getProductosContratados());
		abonado.setProductoDisponibles(productosDisponiblesFiltrados);
		
		//(+)EV 30/08/2010	carga planes pre evaluados
		if (navegacion.getOrigen().equals("SCORING")){
			int totalPlanesScoring = 0;
			try{
				abonado.setProductosScoring(delegate.obtenerProductosScoring(new Long(numAbonado)).getProductosScoring());
				totalPlanesScoring = (abonado.getProductosScoring()!=null?abonado.getProductosScoring().length:0);
			}catch(Exception e){}
			 
			logger.debug("totalPlanesScoring="+totalPlanesScoring);
			abonado.setTotalPlanesScoring(totalPlanesScoring);
		}
		//(-)EV 30/08/2010	carga planes pre evaluadosos
		
		session.setAttribute("Abonado", abonado);	
		
		session.setAttribute("ClienteVTA",clienteVTA);	// seteo para mostrar datos en pagina
		session.setAttribute("navegacion", navegacion);
		
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
		
				
		ArrayList productosDisponiblesAux = new ArrayList();
		String seleccion = "";
		ArrayList productosDisponiblesFiltrados = new ArrayList();
		

		
		for(int i=0;i<listaTiposCom.length;i++){
			seleccion = seleccion + " [" + listaTiposCom[i]+"]";
			productosDisponiblesAux.clear();
			for (int j=0;j<productosDisponibles.size();j++) {
				ProductoWeb productoX = (ProductoWeb) productosDisponibles.get(j);
				
				//INC 155400 distinto a los obligatorios
				if (productoX.getComportamiento().equals(listaTiposCom[i]) && !productoX.getTipoPlanAdic().equals("2")){
					productosDisponiblesAux.add(productoX);
				} 
			}
			
			productosDisponiblesFiltrados.addAll(productosDisponiblesAux);	
			
		}
		
        //	VMB INC 155400 para los obligatorios
		//divido en dos objetos los obligatorios con los opcionales
		//productosDisponiblesAux.clear();+
		listaProductosOblig.clear();
		for (int j=0;j<productosDisponibles.size();j++) {
			ProductoWeb productoX = (ProductoWeb) productosDisponibles.get(j);
			if (productoX.getTipoPlanAdic().equals("2")) {
				listaProductosOblig.add(productoX);
			}
		}
		
		productosDisponiblesFiltrados.addAll(listaProductosOblig);	
		//FIN
		
		logger.debug("Cantidad PA filtrados con opc. obligatorios: "+productosDisponiblesFiltrados.size());
		logger.debug("Tipos de comportamientos seleccionados:"+seleccion);
		logger.debug("filtrarPorTipoComportamiento():fin");
		return productosDisponiblesFiltrados;
	}	
	
	
	public String contrataOpcionalesObligatorios(){
		String mensajeSalida="";			
		String mensajeSalidaSinPDT = "No existen planes adicionales a contratar";
		logger.debug("ENTRO contrataOpcionalesObligatorios ");
		
		try
		{
			/* Inicio Primera Pagina GenerarVentaAction.java */
			HttpSession session = WebContextFactory.get().getSession();
			
			VentaDTO venta=(VentaDTO)session.getAttribute("VentaDTO");
			NavegacionWeb navegacion=(NavegacionWeb)session.getAttribute("navegacion");
			
			VentaUtils utils=VentaUtils.getInstance();		 	
			venta=utils.generarVentaDTO(navegacion, venta);
			venta.setOrigenProceso("VT");
			/* Termino Primera Pagina GenerarVentaAction.java */
			/**************************************************/
			/* Inicio Pagina AplicarCargosAction.java */
			NegSalUtils utilsNegSal=NegSalUtils.getInstance();		
			OfertaComercialDTO ofertaComercial=utilsNegSal.generarOfertaComercial(venta);				
			CargoOcasionalListDTO cargosOcasionales=ofertaComercial.getCargoOcasionalList();
				
			/*for(int aux=0; aux<ofertaComercial.getProductoList().getProductosContratadosDTO().length; aux++){
				ofertaComercial.getProductoList().getProductosContratadosDTO()[aux].setIndCondicionContratacion("B");
			}*/
			
			for(int indexCargos=0;indexCargos<cargosOcasionales.getCargoOcasional().length;indexCargos++)
			{				  
				    cargosOcasionales.getCargoOcasional()[indexCargos].setTipDescuento("M");
				    cargosOcasionales.getCargoOcasional()[indexCargos].setValDescuento(String.valueOf("0.0"));
				    cargosOcasionales.getCargoOcasional()[indexCargos].setCodPlanCom("1");
			} 	
			/**
			 * Agrupacion de cargos ocacionales por cliente - abonado - concepto
			 */
			cargosOcasionales=utilsNegSal.agruparCargosOcasionales(cargosOcasionales);					
			ofertaComercial.setCargoOcasionalList(cargosOcasionales);	
			session.setAttribute("OfertaComercial", ofertaComercial);			
			/* Termino Pagina AplicarCargosAction.java */
			
			
			/* INICIO Pagina GenerarOfertaComercialAction.java */
			
			ManageProspectBussinessDelegate delegate=ManageProspectBussinessDelegate.getInstance();
			
			if(!navegacion.hayPDTporDefecto() && !utils.hayProductosCheckeados(navegacion, venta)){
				mensajeSalida=mensajeSalidaSinPDT;
			//(+) EV 06/02/09
				ParametroSerializableDTO param=new ParametroSerializableDTO();
				param.setEstadoProceso("PROCESADO");
				param.setNumProceso(ofertaComercial.getNumProceso());
				param.setIdProceso(ofertaComercial.getNumEvento());
				param.setOrigenProceso("VT");
				param.setObjetoSerializado((byte[])SerializationUtils.serialize(ofertaComercial));	
				logger.debug("No existen planes adicionales a contratar, no ejecuta activarOfertaComercialJms");
				delegate.inscribeProceso(param);
				
			}
			
			/*
			
			else{
				logger.debug("--------llama a activarOfertaComercialJms--------------------");
			    /* (+) EV 08/04/09 GRABA TODA LA INFORMACION DEL PROCESO POR SI OCURRE ALGUN ERROR
				ofertaComercial.setCodCliente(venta.getCliente().getCodCliente());
			    ProcesoProductoDTO param = new ProcesoProductoDTO();
				param.setEstadoProceso("INSCRITO");
				param.setNumProceso(ofertaComercial.getNumProceso());
				param.setIdProceso(ofertaComercial.getNumEvento());
				param.setOrigenProceso("VT");
				param.setObjetoSerializado((byte[])SerializationUtils.serialize(ofertaComercial));
				param.setNumEvento(0);
				param.setCodOs("VTWEB");
				param.setCodCliente(ofertaComercial.getCodCliente());
				param.setNumAbonado(0);/*De donde se obtiene este codigo?

				delegate.actualizaProceso(param);
				/* (-) EV 08/04/09 
				delegate.activarOfertaComercialJms(ofertaComercial);
				delegate.inscribeProceso(ofertaComercial);
				mensajeSalida="Enviado a contratar productos por defecto";
					
			}
		
		*/
		
			
			/* TERMINO Pagina GenerarOfertaComercialAction.java */
			
		}catch(Exception e){
			mensajeSalida = "Se ha generado un error en la contratacion de planes Obligatorios";
		}
		logger.debug(mensajeSalida);
		return mensajeSalida;
	}
	
	
	/**
	 * Filtra listado de productos disponibles segun comportamiento
	 * Se excluye planes adicionales obligatorios
	 **/
	private ArrayList filtrarPorTipoComportamientoSinOblig(ArrayList productosDisponibles, String[] listaTiposCom)  {
		logger.debug("filtrarPorTipoComportamientoSinOblig():ini");
		
		String seleccion = "";
		ArrayList productosDisponiblesFiltrados = new ArrayList();
		
		for(int i=0;i<listaTiposCom.length;i++){
			seleccion = seleccion + " [" + listaTiposCom[i]+"]";
			
			ArrayList productosDisponiblesAux = new ArrayList();
			
			for (int j=0;j<productosDisponibles.size();j++) {
				ProductoWeb productoX = (ProductoWeb) productosDisponibles.get(j);
				if (productoX.getComportamiento().equals(listaTiposCom[i]) && !(productoX.getTipoPlanAdic().equals("2"))){
					productosDisponiblesAux.add(productoX);
				}
			}
			
			productosDisponiblesFiltrados.addAll(productosDisponiblesAux);	
			
		}
		logger.debug("Cantidad de PA filtrados sin PA oblig.: "+productosDisponiblesFiltrados.size());
		logger.debug("Tipos de comportamientos seleccionados:"+seleccion);
		logger.debug("filtrarPorTipoComportamientoSinOblig():fin");
		return productosDisponiblesFiltrados;
	}
	
		

	
}
