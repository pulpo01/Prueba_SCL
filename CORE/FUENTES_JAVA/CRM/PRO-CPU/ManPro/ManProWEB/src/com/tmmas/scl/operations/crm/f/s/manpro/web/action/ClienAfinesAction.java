package com.tmmas.scl.operations.crm.f.s.manpro.web.action;

import java.util.ArrayList;
import java.util.HashMap;
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
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.AbonadoFrmkDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.delegate.ManageProspectBussinessDelegate;
import com.tmmas.scl.operations.crm.f.s.manpro.web.form.ClienAfinesForm;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.NavegacionWeb;

public class ClienAfinesAction extends Action{
	
	private final Logger logger = Logger.getLogger(ClienAfinesAction.class);
	
	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String forward="sucess";
		boolean parar=false;
		NavegacionWeb navegacion;
		
		try
		{
				HttpSession session = request.getSession();		
				navegacion = (NavegacionWeb) session.getAttribute("navegacion");
		  		AbonadoFrmkDTO abonado = (AbonadoFrmkDTO) session.getAttribute("Abonado");
				String codListaCliente = (String) session.getAttribute("codListaCliente");	
				
				ArrayList todosLosAfines = new ArrayList();
		        HashMap hashMapAfinesOtrosProductos = navegacion.getTodosClienteAfines(String.valueOf(abonado.getIdAbonado()));
		        for (Iterator iteratorAfines = hashMapAfinesOtrosProductos.values().iterator(); iteratorAfines.hasNext();) {
					ArrayList listaAfinesOtrosProductos = (ArrayList) iteratorAfines.next();
					if (listaAfinesOtrosProductos != null) {
						String codigoListaClienteMap = (String) hashMapAfinesOtrosProductos.keySet().iterator().next();
						if (!codigoListaClienteMap.equals(codListaCliente)) {
							for (int i = 0; i < listaAfinesOtrosProductos.size(); i++) {
								todosLosAfines.add(listaAfinesOtrosProductos.get(i));
							}
						}
					}
				}
		        session.setAttribute("todosLosAfines",todosLosAfines); 
				
				ArrayList listaCliente = session.getAttribute("listaCliente")!=null?(ArrayList)session.getAttribute("listaCliente"):new ArrayList();
				String cod_cliente="";
				String cancelarAfines="";
				ClienAfinesForm listAfinesForm = (ClienAfinesForm) form;
				cancelarAfines = listAfinesForm.getCancelarAfines();
		
				if ("cancel".equals(cancelarAfines)){
					listaCliente=(ArrayList)session.getAttribute("listaCliente");
					session.removeAttribute("listaCliente");
					parar=true;
					forward="sucessProduct";
				}		  
				if ("guardar".equals(cancelarAfines) && !parar){
					listaCliente=(ArrayList)session.getAttribute("listaCliente");
					session.removeAttribute("listaCliente");	
					navegacion.setListaClienteAfines(String.valueOf(abonado.getIdAbonado()), codListaCliente, listaCliente);
					session.setAttribute("navegacion",navegacion);
					parar=true;
					forward="sucessProduct";
				}		
				ClienteDTO clienteDTO = null;
				ManageProspectBussinessDelegate delegate = ManageProspectBussinessDelegate.getInstance();
				cod_cliente = listAfinesForm != null ? listAfinesForm.getCodigoCliente() : "";
				if (cod_cliente != null && !parar) {
					clienteDTO = new ClienteDTO();
					VentaDTO venta = new VentaDTO();
					clienteDTO.setCodCliente(Integer.parseInt(cod_cliente));
					//venta.setCliente(clienteDTO);
					clienteDTO = delegate.obtenerDatosCliente(clienteDTO);
					//clienteDTO = delegate.obtenerDatosClienteCuenta(venta);
					listaCliente.add(clienteDTO);
					session.setAttribute("listaCliente", listaCliente);
				}
				else if(!parar) 
				{
					listaCliente = (ArrayList) session.getAttribute("listaCliente");
				}
				if(!parar)
				{
					session.setAttribute("listaCliente", listaCliente);
					cancelarAfines = listAfinesForm != null ? listAfinesForm.getCancelarAfines() : "";
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
