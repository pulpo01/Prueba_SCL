package com.tmmas.scl.operations.crm.f.s.manpro.web.action;

import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.TipIdentListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.delegate.ManageProspectBussinessDelegate;
import com.tmmas.scl.operations.crm.f.s.manpro.web.form.ClienAfinesForm;

public class ClienBuscaAfinesAction extends Action{

	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String forward="sucessB";
		
		try
		{
				HttpSession session = request.getSession(false);
				String volver ="";
				String valorCombo="";
				String numeroIdent="";
				String vieneCel="";
				String boton="";
				session.removeAttribute("listaClientesDTO");
				session.removeAttribute("idBoton");
				ArrayList listaIdentidad = request.getAttribute("listaIdentidad")!=null?(ArrayList)request.getAttribute("listaIdentidad"):new ArrayList();
				ArrayList listaClientesDTO = session.getAttribute("listaClientesDTO")!=null?(ArrayList)session.getAttribute("listaClientesDTO"):new ArrayList();
				ClienAfinesForm clienAfinesForm = (ClienAfinesForm)form;
			    TipIdentListDTO  tipIdentListDTO = null;
			    ClienteListDTO  clienteListDTO = null;
			    ManageProspectBussinessDelegate delegate=ManageProspectBussinessDelegate.getInstance();
			    tipIdentListDTO =delegate.obtenerTiposDeIdentidad();
			    for(int i=0; i < tipIdentListDTO.tipIdentListList().length;i++){
			    	
			    	listaIdentidad.add(tipIdentListDTO.tipIdentListList()[i]);
			    }			    
			    if (listaIdentidad!= null){
			    	session.removeAttribute("listaIdentidad");
			    	request.setAttribute("listaIdentidad", listaIdentidad);	
			    }else{
			    	
			    	listaIdentidad=(ArrayList)request.getAttribute("listaIdentidad");
			    	
			    }			    
			    numeroIdent = clienAfinesForm!=null?clienAfinesForm.getNumeroCelular():"";
			    numeroIdent=numeroIdent==null?"":numeroIdent;
			    numeroIdent="".equals(numeroIdent)?numeroIdent:numeroIdent.toUpperCase();
			    valorCombo = clienAfinesForm!=null?clienAfinesForm.getSelect2():"";
			    valorCombo=valorCombo==null?"":valorCombo;
			   // valorCombo="".equals(valorCombo)?valorCombo:valorCombo.toUpperCase();
			    vieneCel = clienAfinesForm!=null?clienAfinesForm.getVieneCelular():"";
			    vieneCel=vieneCel==null?"":vieneCel;
			    //vieneCel="".equals(vieneCel)?vieneCel:vieneCel.toUpperCase();
			    
				 if(numeroIdent !=null && valorCombo!=null && "id".equals(vieneCel)){
					 
					 
					ClienteDTO  clienteDTO = new ClienteDTO();
				    clienteDTO.setCodigoTipoIdentificacion(valorCombo);
				    clienteDTO.setNumeroIdentificacion(numeroIdent);
				    clienteListDTO = delegate.buscarCliente(clienteDTO); 
			    
					//(+) EV  03/02/10
				    if (clienteListDTO!=null && clienteListDTO.getClienteList()!=null && clienteListDTO.getClienteList().length>0){ 
						  //Si encontro datos, validar repetidos
						  boolean repetido =false;

						  for(int i=0; i < clienteListDTO.getClienteList().length;i++){
						   	   clienteDTO = (clienteListDTO.getClienteList()[i]);
						   	   for(int j=0; j<listaClientesDTO.size();j++){
						   		   ClienteDTO clienteEnLista = (ClienteDTO)listaClientesDTO.get(j);
						   		   if (clienteDTO.getCodCliente()==clienteEnLista.getCodCliente()){
						   			   repetido =true;
						   			   break;
						   		   }
						   	   }
						   	   if (repetido) break;
						  }
						  
						  if (!repetido){
							  for(int i=0; i < clienteListDTO.getClienteList().length;i++){
							   	   clienteDTO = (clienteListDTO.getClienteList()[i]);
							   	   listaClientesDTO.add(clienteDTO);
							  }
						  }else{
							  request.setAttribute("ERRORBUSCAR", "clienRepetido");
						  }

				    }else{
			  			request.setAttribute("ERRORBUSCAR", "clienNoExiste");
				    }
				    //(-) EV  03/02/10

				    
				    if (listaClientesDTO!= null){
				    	session.removeAttribute("listaClientesDTO");
				    	session.setAttribute("listaClientesDTO", listaClientesDTO);	
				    	if (listaClientesDTO.size()==0)boton="BUSCAR";
				    }else{			   
				    	boton="BUSCAR";
				    	listaClientesDTO=(ArrayList)session.getAttribute("listaClientesDTO");			    	
				    }
			  }			 
			  if ("cel".equals(vieneCel) && numeroIdent !=null){
				  
					  NumeroDTO numeroDTO = new NumeroDTO();
					  ClienteListDTO clienteList = new ClienteListDTO();
					  ClienteDTO  clienteDTO = new ClienteDTO();
					  numeroDTO.setNro(numeroIdent); 
					  clienteList = delegate.buscarCliente(numeroDTO);  
					  
					  //(+) EV  03/02/10
					  if (clienteList!=null && clienteList.getClienteList()!=null && clienteList.getClienteList().length>0){
						  
						  //Si encontro datos, validar repetidos
						  boolean repetido =false;

						  for(int i=0; i < clienteList.getClienteList().length;i++){
						   	   clienteDTO = (clienteList.getClienteList()[i]);
						   	   for(int j=0; j<listaClientesDTO.size();j++){
						   		   ClienteDTO clienteEnLista = (ClienteDTO)listaClientesDTO.get(j);
						   		   if (clienteDTO.getCodCliente()==clienteEnLista.getCodCliente()){
						   			   repetido =true;
						   			   break;
						   		   }
						   	   }
						   	   if (repetido) break;
						  }
						  
						  if (!repetido){
							  for(int i=0; i < clienteList.getClienteList().length;i++){
							   	   clienteDTO = (clienteList.getClienteList()[i]);
							   	   listaClientesDTO.add(clienteDTO);
							  }
						  }else{
							  request.setAttribute("ERRORBUSCAR", "clienRepetido");
						  }
						  
					  }else{
				  			request.setAttribute("ERRORBUSCAR", "clienNoExiste");
					  }
					  //(-) EV  03/02/10
					  
					  
					    if (listaClientesDTO!= null){
					    	if (listaClientesDTO.size()==0)boton="BUSCAR";
					    	session.removeAttribute("listaClientesDTO");
					    	session.setAttribute("listaClientesDTO", listaClientesDTO);
					    	
					    }else{
					    	boton="BUSCAR";
					    	listaClientesDTO=(ArrayList)session.getAttribute("listaClientesDTO");
					    	
					    }
			  }
			  if (!boton.equals(""))session.setAttribute("idBoton","BUSCAR");
			  volver = clienAfinesForm!=null?clienAfinesForm.getVolverAlistado():"";			    
			  if ("vol".equals(volver)){
				  listaClientesDTO=(ArrayList)session.getAttribute("listaClientesDTO");
				  session.removeAttribute("listaClientesDTO");
				  return mapping.findForward("sucessListC");
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
