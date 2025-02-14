package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;

import uk.ltd.getahead.dwr.ExecutionContext;
import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProdContratadoOfertadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;

public class ClienAfinesDWR 
{	
	private final Logger logger = Logger.getLogger(ClienAfinesDWR.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	public String validaClienAfinRepetido(String codCliente)
	{
		logger.debug("ini validaClienAfinRepetido");
		logger.debug("codCliente="+codCliente);
		HttpSession session = ExecutionContext.get().getHttpServletRequest().getSession();		
		ArrayList listaCliente=new ArrayList();
		ArrayList listaTodosLosAfines=new ArrayList();
		
		//ClienteFrmkDTO clienteVTA = (ClienteFrmkDTO) session.getAttribute("ClienteVTA");
		//String codigoClienteSession=String.valueOf(clienteVTA.getIdCliente());
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		String codigoClienteSession= String.valueOf(sessionData.getCliente().getCodCliente());
			
		listaCliente=(ArrayList)session.getAttribute("listaClientes");
		listaTodosLosAfines=(ArrayList)session.getAttribute("todosLosAfines");
		session.getAttribute("");
		String retorno="clienNoRepetido";
		String codigoCliente="";
			
		
		boolean repetidoLista1=false;
		boolean repetidoLista2=false;
		boolean existeCliente=false;
		boolean clienteSession=false;
		
		ClienteDTO clienteAgregar=new ClienteDTO();
		clienteAgregar.setCodCliente(Long.parseLong(codCliente));
		try 
		{
			clienteAgregar=delegate.obtenerDatosCliente(clienteAgregar);
			if(clienteAgregar.getNombres()!=null && !"".equalsIgnoreCase(clienteAgregar.getNombres()))
					existeCliente=true;			
		}
		catch (ManReqException e) 
		{
			existeCliente=false;
		}
					
		if(codCliente.equals(codigoClienteSession))
		{
			clienteSession=true;
		}	
		
		if(listaCliente!=null)
		{
			Iterator it=listaCliente.iterator();
			ClienteDTO clienteDTO = new ClienteDTO();			
			while(it.hasNext())
			{
			    clienteDTO=(ClienteDTO)it.next();
				codigoCliente=String.valueOf(clienteDTO.getCodCliente());	
				
				if(codCliente.equals(codigoCliente))
				{
					//repetido="clienRepetido";
					repetidoLista1=true;
				}								
			 }
		}		
		if(listaTodosLosAfines!=null)
		{
			Iterator it=listaTodosLosAfines.iterator();
			ClienteDTO clienteDTO = new ClienteDTO();			
			 while(it.hasNext())
			 {
				    clienteDTO=(ClienteDTO)it.next();
					codigoCliente=String.valueOf(clienteDTO.getCodCliente());	
					
					if(codCliente.equals(codigoCliente))
					 {
						repetidoLista2=true;										
					 }				
			}
		}
		
			
		if(!existeCliente)		
			retorno="clienNoExiste";		
		else if(clienteSession)	
			retorno="clienteSession";
		else if(repetidoLista1)
			retorno="clienRepetido";
		else if(repetidoLista2)	
			retorno="clienRepetidoEnProducto";
		
		logger.debug("fin validaClienAfinRepetido");
		
		return retorno;
	}
	
	//(+) Evera 02/02/2009
	/*
	 * Por cada ingreso o modificación en la lista de numeros, se debe validar que no supere el maximo de modificaciones permitidas
	 */
	public String validaModificaciones(long idProductoContratado, int maxModif, int cantModifEnBD, String accion, String numero)
	{
		logger.debug("ini validaModificaciones");
		logger.debug("idProductoContratado,maxModif,cantModifEnBD,accion,numero="+idProductoContratado+","+ maxModif+","+ cantModifEnBD+","+accion+","+numero);
		String retorno="superaMaximo";
		int totalModificaciones=cantModifEnBD;
		
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);
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
	    	
	    	if (productoContratado.getIdProdContratado().longValue()== idProductoContratado){
	    		numeroListOriginal = productoContratado.getListaNumeros(); //lista original
	    			
		    	for(int j=0; j<productosContratadosSesion.size();j++){
					ProdContratadoOfertadoDTO productoContratadoSession = new ProdContratadoOfertadoDTO();
					productoContratadoSession = (ProdContratadoOfertadoDTO) productosContratadosSesion.get(i);
					if (productoContratadoSession.getIdProdContratado().longValue()==idProductoContratado){
						numeroListSesion = productoContratadoSession.getListaNumeros();//lista en sesion
						break;
					}
		    	}//fin for j
		    	break;
	    	}//fin if
	    	
	    }//fin for i

	    if (numeroListOriginal!=null && numeroListOriginal.getNumerosDTO()!=null) totalListOriginal = numeroListOriginal.getNumerosDTO().length;
	    if (numeroListSesion!=null && numeroListSesion.getNumerosDTO()!=null) totalListSesion = numeroListSesion.getNumerosDTO().length;


	    boolean numeroExisteEnBd = false;
	    	
	    //cuenta las modificaciones de los numeros ya ingresados en base de datos
	    if (totalListOriginal>0){
	    	NumeroDTO[] numerosOrig = numeroListOriginal.getNumerosDTO();
	    
		    //busca numero ingresado, en lista original	    	
		    for (int i=0; i<totalListOriginal;i++){
		    	if (numerosOrig[i].getNro().equals(numero)){
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
	    
	    if (accion.equals("I")){//numero nuevo
	    	if (numeroExisteEnBd){
	    		totalModificaciones = totalModificaciones - 1; //queda igual, se anula modificacion
	    	}else{
	    		totalModificaciones = totalModificaciones + 1;
	    	}
	    }else if(accion.equals("E")){//eliminacion
	    	if (numeroExisteEnBd){
	    		totalModificaciones = totalModificaciones + 1;  
	    	}else{
	    		totalModificaciones = totalModificaciones - 1; //esta eliminando el que agrego durante la sesion
	    	}
	    }
	    
	    if (totalModificaciones <= maxModif) retorno="OK";
	    logger.debug("totalModificaciones="+totalModificaciones);
	    
	    logger.debug("fin validaModificaciones");
	    return retorno;
	    
	}
	//(-) Evera 02/02/2009
	
	

}
