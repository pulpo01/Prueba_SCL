package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProdContratadoOfertadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaProdContratadosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class ClienElimAfinesAction extends Action{
	
	private final Logger logger = Logger.getLogger(ClienElimAfinesAction.class);
	private Global global = Global.getInstance();
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
	
		HttpSession session = request.getSession(false);
		ArrayList listaCliente = null;
		String [] itemChequeados = null;
	    //System.out.println("entro en ClienElimAfinesAction");	
		
		listaCliente=(ArrayList)session.getAttribute("listaClientes");
		
		request.getParameter("itemChequeados");
		itemChequeados = request.getParameterValues("itemChequeados")!= null ? request.getParameterValues("itemChequeados"):null;
		
		
		ArrayList listaNoMostrados = new ArrayList();
		ArrayList listaMostrados = new ArrayList();
		
		if (listaCliente!=null && itemChequeados!=null && itemChequeados.length>0)
		{
			Iterator mostIt=listaCliente.iterator();
			ClienteDTO dto=null;
			
			while(mostIt.hasNext())
			{
				dto=(ClienteDTO)mostIt.next();
				boolean noMostrada=false;
				
				for(int i=0;(itemChequeados!=null && i<itemChequeados.length);i++)
				{
					if(itemChequeados[i].equals(String.valueOf(dto.getCodCliente())))
					{
						listaNoMostrados.add(dto);
						noMostrada=true;
						break;
					}
					else
					{
						noMostrada=false;
					}
				}	
				if (!noMostrada)
					listaMostrados.add(dto);
			}
			
			listaCliente=new ArrayList();
			listaCliente=listaMostrados;	
			
		}
		
		
		// (+)07-12-07 ------------------------------------------------------------------------------------------------------------------------
				 	
		ListaProdContratadosForm form1 = (ListaProdContratadosForm) session.getAttribute("ListaProdContratadosForm");
		String idProdSelec = form1.getIdProductoContratado();
		List productosContratados = (List)session.getAttribute("productosContratados");
		NumeroListDTO listaNumerosSelec = new NumeroListDTO();
				
		ClienteDTO[] clientesEliminados = (ClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico( listaNoMostrados.toArray(), ClienteDTO.class);
		
		// Convierte la LISTA de listaNoMostrados (tipo clienteDTO), en un ARREGLO de NumeroDTO
		NumeroDTO[] numerosElimandos = new NumeroDTO[clientesEliminados.length];
		for(int x=0; x<clientesEliminados.length; x++){
			NumeroDTO numElim = new NumeroDTO();
			numElim.setNro(String.valueOf(clientesEliminados[x].getCodCliente()));
			numerosElimandos[x]= numElim;
		}
				
       // ---- Recorre objeto de session que contiene TODOS los productos contratados
	    for(int i=0; i<productosContratados.size(); i++){
	    	ProdContratadoOfertadoDTO producto = new ProdContratadoOfertadoDTO();
	    	producto = (ProdContratadoOfertadoDTO) productosContratados.get(i);
	    	
	    	// --- Busca los datos SOLO del producto contratado seleccionado a traves de su identificador
	    	if(idProdSelec.equals(String.valueOf(producto.getIdProdContratado()))) 	{
	    		logger.debug("Encontro para el producto" + idProdSelec+" su lista de numeros asociados");
	    		listaNumerosSelec = producto.getListaNumeros();
	    		NumeroDTO[] numerosEnLista = listaNumerosSelec.getNumerosDTO();
	    			    		
	    		//(+) EV 03/02/09 antes de agregar debe validar si cumple maximo de modificaciones
	    		String retorno="";
	    		if (numerosElimandos.length>0){
		    		HashSet numerosAElimHs = new HashSet();//por si vienen repetidos
		    		
		    		retorno = validaModificaciones(session,idProdSelec,producto.getMaxModificaciones(),producto.getCantModificaciones(),numerosElimandos);
		    		//retorno="OK"; //SOLO PARA PRUEBAS
		    		logger.debug("validaModificaciones retorno="+retorno);
		    		if (retorno.equals("superaMaximo")){
		    			request.setAttribute("ERRORELIMINAR", "superaMaximo");
		    			return mapping.findForward("sucessE");
		    		}else{//se guardan en sesion
			    		//(+) EV 03/02/09
		    			int totalNumerosAElim = 0;
		    			if (numerosElimandos!=null ){
		    				for(int k=0;k<numerosElimandos.length;k++){
		    					numerosAElimHs.add(numerosElimandos[k]);
		    				}
		    				
		    			}
		    			totalNumerosAElim = numerosAElimHs.size();
		    			logger.debug("totalNumerosAElim="+totalNumerosAElim);
		    			if (totalNumerosAElim>0){
				    		List productosContratadosSesion = new ArrayList();
				    		productosContratadosSesion = (List)session.getAttribute("productosContratadosSesion");
				    		long idProdSesion= Long.parseLong(form1.getIdProductoContratado());
				    		logger.debug("idProdSesion="+idProdSesion);
				    		for(int k=0;k<productosContratadosSesion.size();k++){
				    			ProdContratadoOfertadoDTO productoTMP = (ProdContratadoOfertadoDTO) productosContratadosSesion.get(k);
				    	    	if (productoTMP.getIdProdContratado().longValue()== idProdSesion){//actualiza la lista de numeros
				    	    		NumeroListDTO numerosTMP = productoTMP.getListaNumeros();
				    	    		int totalNumeros = 0;
				    	    		if (numerosTMP!=null && numerosTMP.getNumerosDTO()!=null){
				    	    			totalNumeros = numerosTMP.getNumerosDTO().length;
				    	    		}
				    	    		logger.debug("totalNumeros existentes="+totalNumeros);		
				    	    		ArrayList nuevaListaNumeros = new ArrayList();
			    	    			for(int j=0;j<totalNumeros;j++){//traspasar los que ya existen en sesion, solo si no estan en lista para eliminar
			    	    				NumeroDTO numOrig = numerosTMP.getNumerosDTO()[j];
			    	    				boolean encontrado = false;
			    	    				
			    	    				Iterator numerosAElimHsIt=numerosAElimHs.iterator();
			    	    				while(numerosAElimHsIt.hasNext())
			    	    				{
			    	    					NumeroDTO numAElim =(NumeroDTO)numerosAElimHsIt.next();
			    	    					if (numOrig.getNro().equals(numAElim.getNro())){
			    	    						encontrado =true;
			    	    						break;
			    	    					}
			    	    				}//fin while
			    	    				
			    	    				if (!encontrado){
			    	    					nuevaListaNumeros.add(numOrig);
			    	    				}
			    	    				
			    	    			}//fin for j
				    	    		
			    	    			NumeroDTO[] numerosFinal = (NumeroDTO[]) ArrayUtl.copiaArregloTipoEspecifico( nuevaListaNumeros.toArray(), NumeroDTO.class);
			    	    			
			    	    			logger.debug("numerosFinal total="+numerosFinal.length);
				    	    		NumeroListDTO numerosActualizado = new NumeroListDTO();
				    	    		numerosActualizado.setNumerosDTO(numerosFinal);
				    	    		productoTMP.setListaNumeros(numerosActualizado);
				    	    		break;
				    	    	}//fin if
				    		}//fin for
				    		
		    			}//	fin if if (totalNumerosAElim>0		
		    		}//fin if (retorno.equals("superaMaximo")
	    		}//if (numerosElimandos.length>0){		    		
	    		//(-) EV
	    		
	    		ArrayList listaNumerosNuevos = new ArrayList();
	    		
	    		    // compara la lista de numeros eliminados(numerosEliminados) con la lista de numeros del producto seleccionado(numerosEnLista)
	    		    // para generar una lista de numeros nuevos(listaNumerosNuevos)
		    		for(int j=0; j< numerosEnLista.length; j++){
		    			String numBuscar = numerosEnLista[j].getNro();
		    			boolean encontrado = false;
		    			for(int k=0; k<numerosElimandos.length; k++){
		    				if(numBuscar.equals(numerosElimandos[k].getNro())){
		    					encontrado = true;
		    					break;
		    				}
		    			}
		    			
		    			if(!encontrado){
		    				NumeroDTO numeroACargar = new NumeroDTO();
		    				numeroACargar.setNro(numBuscar);
		    				listaNumerosNuevos.add(numeroACargar);
		    				
		    			}
		    			    			
		    		}
		    		
	    		
		    	NumeroDTO[] numerosFinal = (NumeroDTO[]) ArrayUtl.copiaArregloTipoEspecifico( listaNumerosNuevos.toArray(), NumeroDTO.class);
		    	NumeroListDTO numerosNuevos = new NumeroListDTO();
		    	numerosNuevos.setNumerosDTO(numerosFinal);
		    	producto.setListaNumeros(numerosNuevos);
		    	//String maximo=producto.getMaximo();
		    	session.removeAttribute("productosContratados");
	    		session.setAttribute("productosContratados", productosContratados);
	    		break;
	    		
	    	}
	    	
	    }
	    
	    
	    
	    session.removeAttribute("todosLosAfines");
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
	    
		
		// (-) 07-12-2007 ------------------------------------------------------------------------------------------------------------------------
		
				
	    
	    session.setAttribute("listaClientes", listaCliente);
	    session.setAttribute("listaNoMostrados", listaNoMostrados);
		
		 return mapping.findForward("sucessE");
			
			
	}
	
	//(+) EV 03/02/09
	public String validaModificaciones(HttpSession session,String idProductoContratado, int maxModif, int cantModifEnBD, NumeroDTO[] numerosElimandos ){
		logger.debug("ini validaModificaciones");
		String retorno="superaMaximo";

		long idProdContratado= Long.parseLong(idProductoContratado);
		
		int totalModificaciones=cantModifEnBD;
		
		WebContext ctx = WebContextFactory.get();
	    List productosContratados = new ArrayList();
	    List productosContratadosSesion = new ArrayList();//contiene todas las modificaciones realizadas en session para este producto
	    
	    productosContratados = (List)session.getAttribute("productosContratadosOrig");
	    productosContratadosSesion = (List)session.getAttribute("productosContratadosSesion");

	    NumeroListDTO numeroListOriginal = null; 
	    NumeroListDTO numeroListSesion = null;
	    int totalListOriginal = 0;
	    int totalListSesion=0;
	    
	    //Obtiene listas de numeros original y en sesion
	    for(int i=0; i<productosContratados.size();i++){
	    	ProdContratadoOfertadoDTO productoContratado = new ProdContratadoOfertadoDTO();
	    	productoContratado = (ProdContratadoOfertadoDTO) productosContratados.get(i);
	    	
	    	if (productoContratado.getIdProdContratado().longValue()== idProdContratado){
	    		numeroListOriginal = productoContratado.getListaNumeros(); //lista original
	    			
		    	for(int j=0; j<productosContratadosSesion.size();j++){
					ProdContratadoOfertadoDTO productoContratadoSession = new ProdContratadoOfertadoDTO();
					productoContratadoSession = (ProdContratadoOfertadoDTO) productosContratadosSesion.get(i);
					if (productoContratadoSession.getIdProdContratado().longValue()==idProdContratado){
						numeroListSesion = productoContratadoSession.getListaNumeros();//lista en sesion
						break;
					}
		    	}//fin for j
		    	break;
	    	}//fin if
	    	
	    }//fin for i

	    if (numeroListOriginal!=null && numeroListOriginal.getNumerosDTO()!=null) totalListOriginal = numeroListOriginal.getNumerosDTO().length;
	    if (numeroListSesion!=null && numeroListSesion.getNumerosDTO()!=null) totalListSesion = numeroListSesion.getNumerosDTO().length;

	    //para cada numero a eliminar hacer esta validacion
	    
	    for (int l=0; l<numerosElimandos.length;l++){
	    	totalModificaciones=cantModifEnBD;
	    	String numerol = numerosElimandos[l].getNro();
	    	logger.debug("validando numero "+numerol);
	    	
	    	boolean numeroExisteEnBd = false;
		    	
		    //cuenta las modificaciones de los numeros ya ingresados en base de datos
		    if (totalListOriginal>0){
		    	NumeroDTO[] numerosOrig = numeroListOriginal.getNumerosDTO();
		    
			    //busca numero ingresado, en lista original	    	
			    for (int i=0; i<totalListOriginal;i++){
			    	if (numerosOrig[i].getNro().equals(numerol)){
			    		numeroExisteEnBd = true;
			    		break;
			    	}
			    }
			    
		    	if (totalListSesion == 0){//se eliminaron todos los numeros
		    		totalModificaciones = totalModificaciones + totalListOriginal;
		    	}
		    	else{
			    	for(int i=0;i<totalListOriginal;i++){
			    		String numeroOriginal = numerosOrig[i].getNro();
			    		boolean encontrado=false;
			    		//busca si el numero original aun existe en la lista de sesion
		    			NumeroDTO[] numerosSesion = numeroListSesion.getNumerosDTO();
			    		for(int j=0;j<totalListSesion;j++){
			    			String numeroSesion = numerosSesion[j].getNro();
			    			if(numeroOriginal.equals(numeroSesion)){
			    				encontrado = true;
			    				break;
			    			}
			    		}//fin for j
			    		
			    		if (!encontrado) totalModificaciones++; //si no lo encuentra en sesion, fue eliminado
			    	}//fin for i
		    	}//fin if (totalListSesion == 0)
		    }//fin if (totalListOriginal>0){
		    		
		    ///cuenta los nuevos numeros ingresados
		    if (totalListSesion>0){
		    	NumeroDTO[] numerosSesion = numeroListSesion.getNumerosDTO();
		    	
		    	if (totalListOriginal ==0){ //No hay numeros configurados
		    		totalModificaciones = totalModificaciones + totalListSesion;
		    	}
		    	else{
		    		for(int j=0;j<totalListSesion;j++){
		    			String numeroSesion = numerosSesion[j].getNro();
		    			boolean encontrado=false;
		    			//busca si el numero se sesion ya existia en base de datos
		    			NumeroDTO[] numerosOrig = numeroListOriginal.getNumerosDTO();
		    			for(int i=0;i<totalListOriginal;i++){
		    				String numeroOriginal = numerosOrig[i].getNro();
		    				if (numeroSesion.equals(numeroOriginal)){
		    					encontrado=true;
		    					break;
		    				}
		    			}
		    			
		    			if (!encontrado) totalModificaciones++;//si no lo encuentra es sesion, es nuevo
		    		}//fin for j
		    	}//fin if (totalListOriginal ==0)
		    }//fin if (totalListSesion>0)
		    
	    	if (numeroExisteEnBd){
	    		totalModificaciones = totalModificaciones + 1;  
	    	}else{
	    		totalModificaciones = totalModificaciones - 1; //esta eliminando el que agrego durante la sesion
	    	}
	    	
		    if (totalModificaciones <= maxModif){
		    	retorno="OK";
			    //actualizar lista de sesion temporalmente para validar el siguiente numero
		    	ArrayList numerosSesionTMP = new ArrayList();
		    	for(int i=0;i<totalListSesion;i++){
		    		String numeroTMP = numeroListSesion.getNumerosDTO()[i].getNro();
		    		if (!numeroTMP.equals(numerol)){
		    			NumeroDTO numeroDTOTMP = new NumeroDTO();
		    			numeroDTOTMP.setNro(numeroTMP);
		    			numerosSesionTMP.add(numeroDTOTMP);
		    		}
		    	}
		    	NumeroDTO[] numerosFinal = (NumeroDTO[]) ArrayUtl.copiaArregloTipoEspecifico( numerosSesionTMP.toArray(), NumeroDTO.class);
		    	numeroListSesion = new NumeroListDTO();
		    	numeroListSesion.setNumerosDTO(numerosFinal);
		    	totalListSesion = numeroListSesion.getNumerosDTO().length;
		    }else{
		    	 retorno="superaMaximo";
		    	break;
		    }
		    logger.debug("totalModificaciones="+totalModificaciones);

	    }//fin  for l
		
		logger.debug("fin validaModificaciones");		
		
		return retorno;
	}
	//(-)

}
