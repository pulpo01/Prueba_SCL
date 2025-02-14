package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;


public class ClienAgregaAfinesAction extends Action{
	 
	private final Logger logger = Logger.getLogger(ClienAgregaAfinesAction.class);
	private Global global = Global.getInstance();
	
	
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
	logger.debug("execute ini");

	 HttpSession session = request.getSession(false);
	 String itemRadioChequeados ="";
	 ArrayList listaClientesDTO = session.getAttribute("listaClientesDTO")!=null?(ArrayList)session.getAttribute("listaClientesDTO"):new ArrayList();
	 itemRadioChequeados = request.getParameter("itemRadioChequeados")!= null ? request.getParameter("itemRadioChequeados"):null;
	 ArrayList listaCliente = session.getAttribute("listaClientes")!=null?(ArrayList)session.getAttribute("listaClientes"):new ArrayList();	 
	 
	
	if (listaClientesDTO!=null && itemRadioChequeados!=null)
	{	
		
		request.setAttribute("clienteBuscado", itemRadioChequeados);
		
		
    	session.removeAttribute("listaClientesDTO");
    	listaClientesDTO=null;
    	session.setAttribute("listaClientesDTO", listaClientesDTO);
	
    }	
	
	  session.setAttribute("listaClientes", listaCliente);	
	  
	  logger.debug("execute fin");
	  return mapping.findForward("sucessAgreC");
   }
	
	public String validaClienAfinRepetido(String codCliente,HttpSession session)
	{	
				
		ArrayList listaCliente=new ArrayList();
		listaCliente=(ArrayList)session.getAttribute("listaClientes");
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
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
