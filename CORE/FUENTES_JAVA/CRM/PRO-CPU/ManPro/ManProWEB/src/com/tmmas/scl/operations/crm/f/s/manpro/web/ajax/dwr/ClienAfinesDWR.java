package com.tmmas.scl.operations.crm.f.s.manpro.web.ajax.dwr;

import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpSession;

import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ClienteFrmkDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.exception.ManProException;
import com.tmmas.scl.operations.crm.f.s.manpro.web.delegate.ManageProspectBussinessDelegate;

public class ClienAfinesDWR 
{	
	public String validaClienAfinRepetido(String codCliente)
	{
		
		HttpSession session = WebContextFactory.get().getSession();;		
		ArrayList listaCliente=new ArrayList();
		ArrayList listaTodosLosAfines=new ArrayList();
		
		ClienteFrmkDTO clienteVTA = (ClienteFrmkDTO) session.getAttribute("ClienteVTA");
		
		String codigoClienteSession=String.valueOf(clienteVTA.getIdCliente());
		listaCliente=(ArrayList)session.getAttribute("listaCliente");
		listaTodosLosAfines=(ArrayList)session.getAttribute("todosLosAfines");
		String retorno="clienNoRepetido";
		String codigoCliente="";
		ManageProspectBussinessDelegate delegate=ManageProspectBussinessDelegate.getInstance();
		
		
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
		catch (ManProException e) 
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
