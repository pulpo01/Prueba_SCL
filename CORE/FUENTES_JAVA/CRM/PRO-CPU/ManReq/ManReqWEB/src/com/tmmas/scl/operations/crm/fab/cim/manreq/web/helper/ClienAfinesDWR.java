package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpSession;

import uk.ltd.getahead.dwr.ExecutionContext;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;

public class ClienAfinesDWR 
{	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	public String validaClienAfinRepetido(String codCliente)
	{
		
		System.out.println("CODIGO CLIENTE : "+codCliente);
		
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
		return retorno;
	}
	
	
	

}
