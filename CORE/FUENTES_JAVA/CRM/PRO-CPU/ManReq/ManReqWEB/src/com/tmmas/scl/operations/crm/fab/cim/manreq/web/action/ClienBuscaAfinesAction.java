package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.TipIdentListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ClienAfinesForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaProdContratadosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class ClienBuscaAfinesAction extends Action{
	
	private final Logger logger = Logger.getLogger(ClienBuscaAfinesAction.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		HttpSession session = request.getSession(false);
		String siguiente = "irBuscar";
		String volver ="";
		String valorCombo="";
		String numeroIdent="";
		String vieneCel="";
		ArrayList listaClientesDTO = session.getAttribute("listaClientesDTO")!=null?(ArrayList)session.getAttribute("listaClientesDTO"):new ArrayList();
		
		ClienAfinesForm clienAfinesForm = (ClienAfinesForm)form;
	    TipIdentListDTO  tipIdentListDTO = null;
	    ClienteListDTO  clienteListDTO = null;
	    logger.debug("obtenerTiposIdentidad : inicio");
	    
	    tipIdentListDTO=delegate.obtenerTiposDeIdentidad();
	    
	    logger.debug("obtenerTiposIdentidad : fin");
	    ArrayList listaIdentidad = new ArrayList();
	    
	    
	    for(int i=0; i < tipIdentListDTO.tipIdentListList().length;i++){
	    		listaIdentidad.add(tipIdentListDTO.tipIdentListList()[i]);
	    } 
	    
	    request.setAttribute("listaIdentidad", listaIdentidad);
	    /*    
	    if (listaIdentidad!= null){
	    	session.removeAttribute("listaIdentidad");
	    	request.setAttribute("listaIdentidad", listaIdentidad);	
	    }else{
	    	
	    	listaIdentidad=(ArrayList)request.getAttribute("listaIdentidad");
	    	
	    }
	    */
	    
	    numeroIdent = clienAfinesForm!=null?clienAfinesForm.getNumeroCelular():"";
	    valorCombo = clienAfinesForm!=null?clienAfinesForm.getSelect2():"";
	    vieneCel = clienAfinesForm!=null?clienAfinesForm.getVieneCelular():"";
	    
	 if(numeroIdent !=null && valorCombo!=null && "id".equals(vieneCel)){
		ClienteDTO  clienteDTO = new ClienteDTO();
	    clienteDTO.setCodigoTipoIdentificacion(valorCombo);
	    clienteDTO.setNumeroIdentificacion(numeroIdent);
	    
	    clienteListDTO = delegate.buscarCliente(clienteDTO);
	    
	     
	    
       for(int i=0; i < clienteListDTO.getClienteList().length;i++){
	    	
    	   clienteDTO = (clienteListDTO.getClienteList()[i]);
    	   listaClientesDTO.add(clienteDTO);
	    } 
	    
	    if (listaClientesDTO!= null){
	    	session.removeAttribute("listaClientesDTO");
	    	session.setAttribute("listaClientesDTO", listaClientesDTO);	
	    }else{
	    	
	    	listaClientesDTO=(ArrayList)session.getAttribute("listaClientesDTO");
	    	
	    }
	  }
	    
	  
	 
	  if ("cel".equals(vieneCel) && numeroIdent !=null){
		  
		  NumeroDTO numeroDTO = new NumeroDTO();
		  ClienteListDTO clienteList = new ClienteListDTO();
		  ClienteDTO  clienteDTO = new ClienteDTO();
		  numeroDTO.setNro(numeroIdent); 
		  
		  clienteList = delegate.buscarCliente(numeroDTO);
		  
		  for(int i=0; i < clienteList.getClienteList().length;i++){
		    	
	   	   clienteDTO = (clienteList.getClienteList()[i]);
	   	   listaClientesDTO.add(clienteDTO);
		    } 
		    
		    if (listaClientesDTO!= null){
		    	session.removeAttribute("listaClientesDTO");
		    	session.setAttribute("listaClientesDTO", listaClientesDTO);	
		    }else{
		    	
		    	listaClientesDTO=(ArrayList)session.getAttribute("listaClientesDTO");
		    	
		    }
	  } 
	   
	  
	  volver = clienAfinesForm!=null?clienAfinesForm.getVolverAlistado():"";  
	    
	  if ("vol".equals(volver)){
		  listaClientesDTO=(ArrayList)session.getAttribute("listaClientesDTO");
		  session.removeAttribute("listaClientesDTO");
		 // return mapping.findForward("irListado");
		  
		  ListaProdContratadosForm formLista = (ListaProdContratadosForm) session.getAttribute("ListaProdContratadosForm");
		  formLista.setEstadoValidacion(""); // para que NO agrege el cliente en la listaClientes en la clase PersonalizaAfines
		  siguiente = "irListado";
	  }
	  
	    
		//return mapping.findForward("irBuscar");
	  return mapping.findForward(siguiente);
	
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
}
