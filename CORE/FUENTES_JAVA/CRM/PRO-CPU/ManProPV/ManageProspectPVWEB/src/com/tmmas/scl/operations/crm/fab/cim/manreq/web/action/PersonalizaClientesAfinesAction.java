package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
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
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProdContratadoOfertadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaProdContratadosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class PersonalizaClientesAfinesAction extends BaseAction{

	private final Logger logger = Logger.getLogger(PersonalizaClientesAfinesAction.class);
	private Global global = Global.getInstance();
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("execute():start");
			
		
		String siguiente = "afinesClientes";   
	    List productosContratados =new ArrayList();
	    
	    HttpSession session = request.getSession(false);
	    session.removeAttribute("productoAfinSelec");
	    session.removeAttribute("todosLosAfines");
	    productosContratados = (List)session.getAttribute("productosContratados");
	    // Para remover la lista de clientes encontrados en la pagina de busqueda
	    if(session.getAttribute("listaClientesDTO")!= null){
	    	ArrayList listaClientesDTO = (ArrayList)session.getAttribute("listaClientesDTO");
	    	session.removeAttribute("listaClientesDTO");
	    	listaClientesDTO=null;
	    	session.setAttribute("listaClientesDTO", listaClientesDTO);
	    }
	    	    
	    ListaProdContratadosForm form1 = (ListaProdContratadosForm) form;
	  	    
	    logger.debug("en PersonalizaClientesAfinesAction form1.getEstadoValidacion()   :"+form1.getEstadoValidacion());
	    logger.debug("en PersonalizaClientesAfinesAction form1.getGuardarCancelar()    :"+form1.getGuardarCancelar());
	    logger.debug("en PersonalizaClientesAfinesAction form1.getInicio()             :"+form1.getInicio());
	    
	    logger.debug("form1.getIdProductoContratado()   :"+form1.getIdProductoContratado());
	    logger.debug("form1.getCodigoProducto()         :"+form1.getCodigoProducto());
	    logger.debug("form1.getNombreProducto()         :"+form1.getNombreProducto());
	      
	    String idProdSelec = form1.getIdProductoContratado();
	       
	    	       
	    NumeroListDTO listaNumerosSelec = new NumeroListDTO();
	    String maximo="";
	    int maximoModificaciones = 0; //EV 02/02/09
	    int cantidadModificaciones = 0; //EV 02/02/09
	        
	    	    
	    // ---- recorre objeto de session que contiene TODOS los productos contratados
	    for(int i=0; i<productosContratados.size(); i++){
	    	ProdContratadoOfertadoDTO producto = new ProdContratadoOfertadoDTO();
	    	producto = (ProdContratadoOfertadoDTO) productosContratados.get(i);
	    	
	    	// --- Busca los datos SOLO del producto contratado seleccionado a traves de su identificador
	    	if(idProdSelec.equals(String.valueOf(producto.getIdProdContratado()))) 	{
	    		logger.debug("Encontro para el producto" + idProdSelec+" su lista de numeros asociados");
	    		listaNumerosSelec = producto.getListaNumeros();
	    		maximo=producto.getMaximo();
	    		cantidadModificaciones = producto.getCantModificaciones();//EV 02/02/09
	    		maximoModificaciones = producto.getMaxModificaciones();//EV 02/02/09
	    		break;
	    	}
	    	
	    }
	    
	   
	    
	    
	    // ----Crea una lista con TODOS los numeros afines de TODOS los productos del abonado
	    ArrayList todosLosAfines = new ArrayList();
	    
	    for(int x=0; x<productosContratados.size(); x++){
	    	NumeroListDTO listaNumPorProd = new NumeroListDTO();	
	    	ProdContratadoOfertadoDTO productoObtenido = new ProdContratadoOfertadoDTO();
	    	productoObtenido = (ProdContratadoOfertadoDTO) productosContratados.get(x);
	    	listaNumPorProd = productoObtenido.getListaNumeros();
	    	NumeroDTO[] numPorProdArr = listaNumPorProd.getNumerosDTO();
	    	for(int z=0; z<numPorProdArr.length; z++){
	    		ClienteDTO cliente = new ClienteDTO();
	    		cliente.setCodCliente(Long.parseLong(numPorProdArr[z].getNro()));
	    		todosLosAfines.add(cliente);
	    	}
	    }
	    session.setAttribute("todosLosAfines", todosLosAfines);
	   
	    
	    // ----Mostrar la lista con todos los numeros afines
	    for(int j=0; j<todosLosAfines.size(); j++){
	    	ClienteDTO cliente = new ClienteDTO();
	    	cliente = (ClienteDTO) todosLosAfines.get(j);
	    	logger.debug("cliente.getCodCliente() [" +j+ "]"+cliente.getCodCliente());
	    }
	    
	    // -- Seteando valores del objeto seleccionado, para mostrar en la cabecera de productos afines
	    ProdContratadoOfertadoDTO productoAfinSelec = new ProdContratadoOfertadoDTO();
	    productoAfinSelec.setCodProducto(form1.getCodigoProducto());
	    productoAfinSelec.setNombre(form1.getNombreProducto());
	    productoAfinSelec.setMaximo(maximo);
	    productoAfinSelec.setCantModificaciones(cantidadModificaciones); //EV 02/02/09
	    productoAfinSelec.setMaxModificaciones(maximoModificaciones); //EV 02/02/09
	    productoAfinSelec.setIdProdContratado(Long.valueOf(form1.getIdProductoContratado())); //EV 02/02/09
	    //productoAfinSelec.setListaNumeros(listaNumerosSelec);
	    session.setAttribute("productoAfinSelec", productoAfinSelec);
	    	    
	    NumeroDTO[] numeros = listaNumerosSelec.getNumerosDTO();
	    logger.debug("Largo de la lista de numeros seleccionados :"+numeros.length);
	    
	    
	    
        //	  ArrayList listaClientes = new ArrayList();
	    ArrayList listaClientes = session.getAttribute("listaClientes")!=null?(ArrayList)session.getAttribute("listaClientes"):new ArrayList();
	    
	    // --- si no ha personalizado ningun cliente carga la listaClientes con los numeros existentes para el producto
	    
	    if (form1.getInicio()==null){	    	
	    		logger.debug("La lista de cliente debe crearse y agregar los numeros del producto");
	    		logger.debug("en PersonalizaClientesAfinesAction LISTA NO HA SIDO CARGADA : carga listaClientes con los numeros existentes en producto");
		    	
		    	for(int x=0; x<numeros.length; x++){
			    	ClienteDTO cliente= new ClienteDTO();
			    	cliente.setCodCliente(Long.parseLong(numeros[x].getNro()));
			    	logger.debug("obtenerDatosCliente : inicio");
			    	cliente = delegate.obtenerDatosCliente(cliente);
			    	logger.debug("obtenerDatosCliente : fin");
			    	logger.debug("cliente.getCodCliente()    :"+cliente.getCodCliente());
			    	logger.debug("cliente.getNombres()       :"+cliente.getNombres());
			    	listaClientes.add(cliente);
			    }
		    	
	    	
	    }else{
	    	// -- si la lista ya existe y ademas la validacion del numero de cliente buscado esta CORRECTA se debe tomar la listaClientes 
	    	// -- que ya esta seteada en session y se debe agregar el nuevo cliente a esa lista
	    	if(form1.getEstadoValidacion()!= null && form1.getEstadoValidacion().equals("clienNoRepetido")){
	    		logger.debug("La lista ya fue creada y se debe agregar a esta el nuevo numero");
	    		logger.debug("El numero de cliente a agregar es : "+form1.getNumeroAgregar());
	    		logger.debug("en PersonalizaClientesAfinesAction AGREGAR A listaClientes EL NUEVO CLIENTE YA VALIDADO");
	    		
	    		ClienteDTO clienteAgregar = new ClienteDTO();
	    		clienteAgregar.setCodCliente(Long.parseLong(form1.getNumeroAgregar()));
	    		clienteAgregar = delegate.obtenerDatosCliente(clienteAgregar);
	    		listaClientes.add(clienteAgregar);
	    		session.removeAttribute("listaClientes");
	    		
	    		//(+) EV 03/02/09
	    		List productosContratadosSesion = new ArrayList();
	    		productosContratadosSesion = (List)session.getAttribute("productosContratadosSesion");
	    		long idProdSesion= Long.parseLong(form1.getIdProductoContratado());
	    		logger.debug("idProdSesion="+idProdSesion);
	    		for(int i=0;i<productosContratadosSesion.size();i++){
	    			ProdContratadoOfertadoDTO productoTMP = (ProdContratadoOfertadoDTO) productosContratadosSesion.get(i);
	    	    	if (productoTMP.getIdProdContratado().longValue()== idProdSesion){//actualiza la lista de numeros
	    	    		NumeroListDTO numerosTMP = productoTMP.getListaNumeros();
	    	    		int totalNumeros = 0;
	    	    		if (numerosTMP!=null && numerosTMP.getNumerosDTO()!=null){
	    	    			totalNumeros = numerosTMP.getNumerosDTO().length;
	    	    		}
	    	    		logger.debug("totalNumeros existentes="+totalNumeros);
	    	    		NumeroDTO[] nuevaListaNumeros = new NumeroDTO[totalNumeros+1];
    	    			NumeroDTO numeroTMP= new NumeroDTO();
    	    			numeroTMP.setNro(form1.getNumeroAgregar());

    	    			for(int j=0;j<totalNumeros;j++){//traspasar los que ya existen en sesion
    	    				nuevaListaNumeros[j]=numerosTMP.getNumerosDTO()[j];
    	    			}
	    	    		nuevaListaNumeros[totalNumeros] = numeroTMP; //agrega el nuevo
	    	    		
	    	    		NumeroListDTO numerosActualizado = new NumeroListDTO();
	    	    		numerosActualizado.setNumerosDTO(nuevaListaNumeros);
	    	    		productoTMP.setListaNumeros(numerosActualizado);
	    	    	}
	    		}
	    		//(-) EV
	    		
	    	}
	    }
	    
	    form1.setInicio("enProceso");
	    form1.setEstadoValidacion("");   
	    
	    session.setAttribute("listaClientes", listaClientes);
	    
	    if(form1.getGuardarCancelar()!= null){
	    	if(form1.getGuardarCancelar().equals("guardar")){
	    		siguiente = "irProducto";  
	    	}
	    }
	    	
		logger.debug("execute():end");
		return mapping.findForward(siguiente);
		
	}

}
