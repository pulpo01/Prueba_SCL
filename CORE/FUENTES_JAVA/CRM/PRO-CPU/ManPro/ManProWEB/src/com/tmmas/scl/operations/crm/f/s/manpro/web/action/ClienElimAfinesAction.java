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

public class ClienElimAfinesAction extends Action{
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
			
		String forward="sucessE";
		
		try
		{
					HttpSession session = request.getSession(false);
					ArrayList listaCliente = null;
					String [] itemChequeados = null;		
					listaCliente=(ArrayList)session.getAttribute("listaCliente");		
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
				session.setAttribute("listaCliente", listaCliente);
				session.setAttribute("listaNoMostrados", listaNoMostrados);
		
		}
		catch(Exception e)
		{
			forward="mensajeError";
			request.setAttribute("exception", e.getMessage());
		}
	    return mapping.findForward(forward);			
	}
}
