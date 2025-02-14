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

import com.tmmas.scl.operations.crm.f.s.manpro.web.form.ListAfinesDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.form.ListAfinesForm;

public class ListAfinesAction extends Action{
	
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception 
	{
		String forward="sucess";
		
		try
		{
				HttpSession session = request.getSession(false);
				ArrayList listaCliente = null;
				String [] itemChequeados = null;
				String cod_cliente="";
				String accion="";
				
				ListAfinesForm listAfinesForm = (ListAfinesForm)form;
				cod_cliente = listAfinesForm!=null?listAfinesForm.getCodigoCliente():"";
				
				ListAfinesDTO listAfinesDTO = new ListAfinesDTO();
				ListAfinesDTO listAfinesDTO1 = new ListAfinesDTO();
				ListAfinesDTO listAfinesDTO2 = new ListAfinesDTO();
				ListAfinesDTO listAfinesDTO3 = new ListAfinesDTO();
				
				listAfinesDTO.setCodigo_cliente("3203304");
				listAfinesDTO.setNombre_cliente("CARLOS DIAZ ");
				listAfinesDTO1.setCodigo_cliente("3502212");
				listAfinesDTO1.setNombre_cliente("MARISEL LAGOS");
				listAfinesDTO2.setCodigo_cliente("4344189");
				listAfinesDTO2.setNombre_cliente("JUAN PEREZ");
				listAfinesDTO3.setCodigo_cliente("7311000");
				listAfinesDTO3.setNombre_cliente("MANUEL LOPEZ");
				
				
				if ("123".equals(cod_cliente) && session.getAttribute("listaCliente")==null) 
				{
					listaCliente = new ArrayList();
				for(int i=0; i < 2;i++){	
					listaCliente.add(listAfinesDTO);
				    listaCliente.add(listAfinesDTO1);
				    listaCliente.add(listAfinesDTO2);
				    listaCliente.add(listAfinesDTO3);
				  } 
				}
				 else if(session.getAttribute("listaCliente")!=null)
				{
					listaCliente=(ArrayList)session.getAttribute("listaCliente");			
				}
				//System.out.println("listaCliente"+ listaCliente.size());
		       
				
				request.getParameter("itemChequeados");
				itemChequeados = request.getParameterValues("itemChequeados")!= null ? request.getParameterValues("itemChequeados"):null;
				//System.out.println("itemChequeados --------"+ itemChequeados.length);
				
				ArrayList listaNoMostrados = new ArrayList();
				ArrayList listaMostrados = new ArrayList();
				
			if (listaCliente!=null && itemChequeados!=null && itemChequeados.length>0)
			{
				Iterator mostIt=listaCliente.iterator();
				ListAfinesDTO dto=null;
				
				while(mostIt.hasNext())
				{
					dto=(ListAfinesDTO)mostIt.next();
					boolean noMostrada=false;
					
					for(int i=0;(itemChequeados!=null && i<itemChequeados.length);i++)
					{
						if(itemChequeados[i].equalsIgnoreCase(dto.getCodigo_cliente()))
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
				//request.setAttribute("listaCliente", listaCliente);
				accion=request.getParameter("buscar");
				
				 if ("1".equals(accion)){
					 forward="sucessB";
				}
				 if ("E".equals(accion)){
					 forward="sucessE";
				}
		}
		catch(Exception e)
		{
			forward="mensajeError";
			request.setAttribute("exception", e.getMessage());
		}
		return mapping.findForward(forward);
	}
}
