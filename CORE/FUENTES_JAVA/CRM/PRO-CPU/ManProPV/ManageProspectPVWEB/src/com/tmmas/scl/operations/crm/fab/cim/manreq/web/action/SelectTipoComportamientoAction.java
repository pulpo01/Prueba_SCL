package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.TipoComportamientoListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.AbonadoFrmkDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.SelectTipoComportamientoForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ProductoWeb;

public class SelectTipoComportamientoAction extends DispatchAction {
	
	private final Logger logger = Logger.getLogger(SelectTipoComportamientoAction.class);
	ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	public ActionForward inicio(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("inicio, inicio");
		HttpSession session = request.getSession(false);
		TipoComportamientoListDTO tiposCompList = (TipoComportamientoListDTO)session.getAttribute("tiposCompList");
		if(tiposCompList == null)
		{
			tiposCompList = delegate.obtenerTiposComportamiento();
			if(tiposCompList != null && tiposCompList.getTipoComportamientoList() != null)
			{
				logger.debug("Tipo Comportamiento de BD ini");
				logger.debug("--------------------------------------------");
				for(int i=0;i<tiposCompList.getTipoComportamientoList().length;i++)
				{
					logger.debug("Tipo["+i+"]["+tiposCompList.getTipoComportamientoList()[i].getTipoComportamiento()+"]");
					logger.debug("Desc["+i+"]["+tiposCompList.getTipoComportamientoList()[i].getDescComportamiento()+"]");
					logger.debug("--------------------------------------------");
				}
				logger.debug("Tipo Comportamiento de BD fin");
			}else
			{
				logger.debug("Tipo Comportamiento tiposCompList ==> null");
			}
		}
		session.setAttribute("tiposCompList", tiposCompList);
		logger.info("inicio, fin");
		return mapping.findForward("inicio");
	}

	public ActionForward grabar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.info("grabar, inicio");
		HttpSession session = request.getSession(false);
		SelectTipoComportamientoForm selTipoCompForm = (SelectTipoComportamientoForm) form;
		
		//session = setListaTiposComSel(session,selTipoCompForm);
		
		//(+) EV 17/05/2010 Filtra con codigos (solo si se levanta popup con listado de productos)
		AbonadoFrmkDTO abonadoFrmk = (AbonadoFrmkDTO) session.getAttribute("Abonado");
		logger.debug("abonadoFrmk["+abonadoFrmk+"]");
		ArrayList productosDisponiblesFiltrados = abonadoFrmk.getProductoDisponibles();
		logger.debug("productosDisponiblesFiltrados.size()"+productosDisponiblesFiltrados.size());
		logger.debug("selTipoCompForm.getCadenaProductosSeleccionados()="+selTipoCompForm.getCadenaProductosSeleccionados());
		if (!selTipoCompForm.getCadenaProductosSeleccionados().equals("")){
			productosDisponiblesFiltrados = filtrarPorCodigo(abonadoFrmk.getProductoDisponibles(),selTipoCompForm.getCadenaProductosSeleccionados());
			abonadoFrmk.setProductoDisponibles(productosDisponiblesFiltrados);
		}
		//(-) EV 17/05/2010 Filtra con codigos (solo si se levanta popup con listado de productos)
		
		return mapping.findForward("volver");
	}
	
	private ArrayList filtrarPorCodigo(ArrayList productosDisponibles, String cadenaProductos) throws Exception {
		logger.debug("filtrarPorCodigo():ini");
		
		String seleccion = "";
		ArrayList productosDisponiblesFiltrados = new ArrayList();
		String[] listaCodigos = cadenaProductos.split(",");
		for(int i=0;i<listaCodigos.length;i++){
			seleccion = seleccion + " [" + listaCodigos[i]+"]";
			
			ArrayList productosDisponiblesAux = new ArrayList();
			for (int j=0;j<productosDisponibles.size();j++) {
				ProductoWeb productoX = (ProductoWeb) productosDisponibles.get(j);
				if (productoX.getCodigo().equals(listaCodigos[i])){
					productosDisponiblesAux.add(productoX);
					break;
				}
			}
			
			productosDisponiblesFiltrados.addAll(productosDisponiblesAux);	
			
		}
		
		logger.debug("Productos seleccionados:"+seleccion);
		logger.debug("filtrarPorCodigo():fin");
		return productosDisponiblesFiltrados;
	}
	
	private HttpSession setListaTiposComSel(HttpSession session, SelectTipoComportamientoForm selTipoCompForm) {
		//la lista ahora se obtiene por PlanesDWR
		ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO) session.getAttribute("ClienteOOSS");
		logger.debug("selTipoCompForm.getListaTiposCom["+selTipoCompForm.getListaTiposCom()+"]");
		
		String[] listaTiposCom = selTipoCompForm.getListaTiposCom();
		if(listaTiposCom == null)  listaTiposCom = new String[0];
		
		logger.debug("selTipoCompForm.getListaTiposCom["+listaTiposCom.length+"]");
		for(int i=0;i<listaTiposCom.length;i++)
		{
			logger.debug("Tipo Comportamiento Sel["+i+"]["+listaTiposCom[i]+"]");
		}
		sessionData.setListaTiposCom(listaTiposCom);
		return session;
	}
}
