package com.tmmas.scl.operations.crm.f.s.manpro.web.action;

import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;


public class ClienAgregaAfinesAction extends Action{
	 
	
	
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception 
	{
	String forward="sucessAgreC";		
	try
	{
			 HttpSession session = request.getSession(false);
			 String itemRadioChequeados ="";
			 String recibeRespuesta ="";
			 ArrayList listaClientesDTO = session.getAttribute("listaClientesDTO")!=null?(ArrayList)session.getAttribute("listaClientesDTO"):new ArrayList();
			 itemRadioChequeados = request.getParameter("itemRadioChequeados")!= null ? request.getParameter("itemRadioChequeados"):null;
			 String respuesta=""; 
			 ArrayList listaCliente = session.getAttribute("listaCliente")!=null?(ArrayList)session.getAttribute("listaCliente"):new ArrayList();			 
			
			if (listaClientesDTO!=null && itemRadioChequeados!=null)
			{				
				request.setAttribute("clienteBuscado", itemRadioChequeados);				
		    }
			session.setAttribute("listaCliente", listaCliente); 
	}
	catch(Exception e)
	{
		forward="mensajeError";
		request.setAttribute("exception", e.getMessage());
	}
	return mapping.findForward(forward);
   }
	
	public String validaClienAfinRepetido(String codCliente,HttpSession session)
	{	
				
		ArrayList listaCliente=new ArrayList();
		listaCliente=(ArrayList)session.getAttribute("listaCliente");
		String repetido="";
		String codigoCliente="";
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
					repetido="clienRepetido";
				
				 }else{
					 
					 repetido="clienNoRepetido"; 
				 }
				
			}
		}
		
		
		return repetido;
	}	
	
	
public String validaClienRepetEnProduc(String codCliente,HttpSession session)
	{
	ArrayList listaTodosLosAfines=new ArrayList();
	String codigoCliente="";
	String repetido="";
	listaTodosLosAfines=(ArrayList)session.getAttribute("todosLosAfines");
	
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
				repetido="clienRepetidoEnProducto";
			
			 }else{
				 
				 repetido="clienRepetidoNoEnProducto"; 
			 }
			
		}
	}
	
	
	return repetido;
}
	


}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
