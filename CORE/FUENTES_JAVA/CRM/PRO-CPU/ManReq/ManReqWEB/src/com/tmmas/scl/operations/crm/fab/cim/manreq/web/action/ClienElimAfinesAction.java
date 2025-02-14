package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
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

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProdContratadoOfertadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaProdContratadosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class ClienElimAfinesAction extends Action{
	
	private final Logger logger = Logger.getLogger(PersonalizaClientesAfinesAction.class);
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
	
	

}
