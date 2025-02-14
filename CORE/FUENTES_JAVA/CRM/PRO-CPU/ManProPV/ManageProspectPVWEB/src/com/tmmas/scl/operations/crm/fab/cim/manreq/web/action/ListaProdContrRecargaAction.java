package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProdContratadoOfertadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaProdContratadosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class ListaProdContrRecargaAction extends BaseAction{

	private final Logger logger = Logger.getLogger(ListaProdContrRecargaAction.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		log=global.getPathInstancia()+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("execute():start");
		logger.debug("RECARGANDO LAS LISTAS........................");
		
	    List productosContratados =new ArrayList();
	    List productosContratadosOriginal = new ArrayList();
	    HttpSession session = request.getSession(false);
	    productosContratados = (List)session.getAttribute("productosContratados"); // lista que se creo para cargar todos los productos y sus listas de numeros
	    productosContratadosOriginal = (List)session.getAttribute("productosContratadosListOriginal");
	    ArrayList listaCliente=(ArrayList)session.getAttribute("listaClientes");
	    
	    //ArrayList listaClientesAgregados = session.getAttribute("listaClientesAgregados")!=null?(ArrayList)session.getAttribute("listaClientesAgregados"):new ArrayList();
	    //ArrayList listaClientesEliminados = session.getAttribute("listaClientesEliminados")!=null?(ArrayList)session.getAttribute("listaClientesEliminados"):new ArrayList();
	        
	    ListaProdContratadosForm form1 = (ListaProdContratadosForm) form;
	    String idProdSelec = form1.getIdProductoContratado();
	    
	    
	    //Recorre el ArrayList listaClientes de session y lo copia en un arreglo de clientes (clienteEnProducto)
	    ClienteDTO[] clientesEnProducto = new ClienteDTO[listaCliente.size()];
	    for(int j=0; j<listaCliente.size();j++){
	    	ClienteDTO cliente = (ClienteDTO)listaCliente.get(j);
	    	clientesEnProducto[j] = cliente;
	    }
	     
	    	    
	    // ---- Recorre objeto de session productosContratados que contiene TODOS los productos contratados 
	    // ---- y obtiene el producto SELECCIONADO con su lista de numeros
        // NumeroListDTO listaNumCargados = new NumeroListDTO();
	    // NumeroDTO[] numerosSesion = null;
	    for(int i=0; i<productosContratados.size(); i++){
	    	ProdContratadoOfertadoDTO producto = new ProdContratadoOfertadoDTO();
	    	producto = (ProdContratadoOfertadoDTO) productosContratados.get(i);
	    	
	    	// --- Busca los datos SOLO del producto contratado seleccionado a traves de su identificador
	    	if(idProdSelec.equals(String.valueOf(producto.getIdProdContratado()))) 	{
	    		//listaNumCargados = producto.getListaNumeros();  // ????????????????'
	    		//numerosSesion = listaNumCargados.getNumerosDTO(); //rescatar la lista de numeros para posteriormente comparar NO SE UTILIZA  // ?????????'
	    		
	    		// --- para volver a setear la lista de session listaProductosContratados en su atributo listaNumeros, con la listaClientes (lista de numeros)
	    		NumeroListDTO listaNumNuevos = new NumeroListDTO();
	    		NumeroDTO[] numNuevos = new NumeroDTO[listaCliente.size()];
	    		if(clientesEnProducto.length>0){
	    			for(int x=0; x<clientesEnProducto.length;x++){
		    			NumeroDTO num = new NumeroDTO();
		    			num.setNro(String.valueOf(clientesEnProducto[x].getCodCliente()));
		    			numNuevos[x] = num;
		    		}
	    		}
	    		
	    		listaNumNuevos.setNumerosDTO(numNuevos);
	    		producto.setListaNumeros(listaNumNuevos);  // guardar en el objeto que quedara en session
	    		//productosContratados.set(i, producto);  // REVISAR!!! esto seria lo correcto, pero sin esta linea funciona bien
	    		producto.setPermitidos(listaNumNuevos.getNumerosDTO().length);
	    		session.removeAttribute("listaClientes");
	    		session.removeAttribute("productosContratados");   
	    		session.setAttribute("productosContratados", productosContratados);
	    		break;
	    	}
	    }
	    
	    
	    
	    /*
	    
	    ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    
		if(sessionData.getNumOrdenServicio()== 0){ 
			SecuenciaDTO secuencia=new SecuenciaDTO();
			logger.debug("obtenerSecuencia:antes");
			secuencia.setNomSecuencia("CI_SEQ_NUMOS");
			secuencia = delegate.obtenerSecuencia(secuencia);
		    sessionData.setNumOrdenServicio(secuencia.getNumSecuencia());
		    logger.debug("obtenerSecuencia:despues");
		}
	    
		
		
		
		//  Recorre objeto de session productosContratadosOriginal que contiene TODOS los productos contratados
        //  y obtiene el producto SELECCIONADO con su lista de numeros
	    NumeroDTO[] numerosOriginal = null;
	    for(int i=0; i<productosContratadosOriginal.size(); i++){
	    	ProdContratadoOfertadoDTO productoOriginal = new ProdContratadoOfertadoDTO();
	    	productoOriginal = (ProdContratadoOfertadoDTO) productosContratadosOriginal.get(i);
	    	
	    	if(idProdSelec.equals(String.valueOf(productoOriginal.getIdProdContratado()))){
	    		NumeroListDTO numerosProducto= productoOriginal.getListaNumeros();
	    		numerosOriginal = numerosProducto.getNumerosDTO(); // numerosOriginal se utilizara para hacer la comparacion 
	    	}
	    	
	    }
			
	    
	    // ---- Revisa si los numeros de la listaClientes manipulada en la pagina de personalizacion 
	    // ---- se encuentran dentro de la lista de numeros ORIGINAL para AGREGAR en la listaClientesAgregados
	    if(numerosOriginal!=null && clientesEnProducto != null){
	    	for(int x=0; x<clientesEnProducto.length; x++){
	    		long numeroABuscar = clientesEnProducto[x].getCodCliente();
	    		boolean encontrado = false;
	    		for(int y=0; y<numerosOriginal.length; y++){
	    			if(numeroABuscar== Long.parseLong(numerosOriginal[y].getNro())){
	    				encontrado = true;
	    				break;
	    			}
	    			
	    		}
	    		// si el numero a buscar no ha sido encontrado dentro de la lista de session
	    		if(!encontrado){
	    			NumeroDTO numeroAgregar = new NumeroDTO();
	    			numeroAgregar.setNro(String.valueOf(numeroABuscar));
	    			numeroAgregar.setIdProductoContratado(idProdSelec);
	    			numeroAgregar.setNumProceso(String.valueOf(sessionData.getNumOrdenServicio()));
	    			numeroAgregar.setOrigenProceso("PV");
	    			Date fecha = new Date();
	    		    Timestamp fechaActual = new Timestamp(fecha.getTime());
	    			numeroAgregar.setFecInicioVigencia(fechaActual);
	    			numeroAgregar.setFecProceso(fechaActual);
	    				    			
	    			Calendar calendario = Calendar.getInstance();
	    			calendario.set(3000, 11, 30);
	    			Date fechaFinal = new Date(calendario.getTimeInMillis());
	    			
	    			numeroAgregar.setFecTerminoVigencia(fechaFinal);
	    			numeroAgregar.setCodCategoriaDest(null);
	    			listaClientesAgregados.add(numeroAgregar);
	    			form1.setPersonalizados(true);
	    			
	    		}
	    		
	    	}
	    	
	    }
	    
	    // ---- Revisa si los numeros de listaClientes manipulada en la pagina de personalizacion
	    // ---- NO se encuentran dentro de la lista de numeros ORIGINAL para colocarlos dentro de la lista de numeros eliminados 
	    if(numerosOriginal!=null && clientesEnProducto != null){
	    	for(int i=0; i<numerosOriginal.length; i++){
	    		String numeroABuscar = numerosOriginal[i].getNro();
	    		boolean encontrado = false;
	    		for(int j=0; j<clientesEnProducto.length; j++){
	    			if (Long.parseLong(numeroABuscar) == clientesEnProducto[j].getCodCliente()){
	    				encontrado = true;
	    				break;
	    			}
	    			
	    		}
	    		
	    		if(!encontrado){
	    			
	    			NumeroDTO numeroEliminar = new NumeroDTO();
	    			numeroEliminar.setNro(numeroABuscar);
	    			numeroEliminar.setIdProductoContratado(idProdSelec);
	    			numeroEliminar.setNumProcesoDescontrata(String.valueOf(sessionData.getNumOrdenServicio()));
	    			numeroEliminar.setOrigenProcDescontrata("PV");
	    			numeroEliminar.setFecTerminoVigencia(new Date());
	    			listaClientesEliminados.add(numeroEliminar);
	    			form1.setPersonalizados(true);
	    		}
	    		
	    	}
	    	
	    }
	    */
	    
	    
	    
	    
	    form1.setPersonalizados(true);  // REVISAR SI ESTE VALOR CORRESPONDE SETEAR SI NO HA AGREADO O ELIMINADO DATOS Y VERIFICAR DONDE SE USA
	    
	    //session.setAttribute("listaClientesAgregados", listaClientesAgregados);
	    //session.setAttribute("listaClientesEliminados", listaClientesEliminados);
	    
	    form1.setInicio(null);
	    form1.setGuardarCancelar(null);
	    form1.setEstadoValidacion(null);
	    	
		logger.debug("execute():end");
		return mapping.findForward("cargarProductos");
		
	}

}
