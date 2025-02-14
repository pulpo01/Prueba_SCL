package com.tmmas.scl.operations.crm.f.s.manpro.web.action;

import java.util.ArrayList;
import java.util.StringTokenizer;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.marketSalesDomain.contactLeadProspectABE.dataTransferObject.VentaDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.AbonadoFrmkDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ClienteFrmkDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.form.BitaForm;
import com.tmmas.scl.operations.crm.f.s.manpro.web.form.ClienteForm;
import com.tmmas.scl.operations.crm.f.s.manpro.web.form.ProductoForm;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.PaqueteWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.ProductoWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.VentaUtils;

public class ClienteAction extends Action 
{  
	private final Logger logger = Logger.getLogger(ClienteAction.class);

	public ActionForward execute(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception 
	{
		logger.debug("execute ini");
		String forward="sucess";
		
		PaqueteWeb productos;
		ClienteForm detalleProductoForm;
		String idAbonado="";
		String idCliente;
		BitaForm navegaForm;
		ProductoForm productoForm;
		
		try
		{
			/**
			 *   Action de pantalla de productos por Abonado o Cliente... 
			 */
			HttpSession session = request.getSession();
			VentaUtils ventaUtils=VentaUtils.getInstance();
			
			if (form instanceof ClienteForm) 
			{
				logger.debug("ClienteForm");
				NavegacionWeb navegacion = (NavegacionWeb) session.getAttribute("navegacion");
				VentaDTO ventaDTO = (VentaDTO) session.getAttribute("VentaDTO");
				ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
				
				//logger.debug("navegacion="+navegacion);
				//logger.debug("ventaDTO="+ventaDTO);		
				
				ClienteFrmkDTO clienteVTA = navegacion.getClienteWeb();
				
				/*Entro a ver el detalle de un Abonado*/
				detalleProductoForm = (ClienteForm) form;	
				
				idAbonado = (detalleProductoForm!=null && detalleProductoForm.getIdAbonado()!=null && !"".equals(detalleProductoForm.getIdAbonado()))?detalleProductoForm.getIdAbonado():"0";
				
				//productos = navegacion.getPaqueteWeb(idAbonado);			
				
				logger.debug("idAbonado="+idAbonado);
				session.setAttribute("idAbonado", idAbonado);
				
				//logger.debug("productos="+productos);
				
				/*if (productos==null)
				{	//esta condicion es equivalente a preguntar, es la primera vez que entra al detalle del abonado	
					logger.debug("entra a ver el detalle del abonado por primera vez");
					productos = new PaqueteWeb(ventaUtils.getAbonado(idAbonado, ventaDTO),navegacion.getCodVendedor(),sessionData);							
					
					// AGREGO ELEMENTO WEB DE PRODUCTO POR ABONADO
					navegacion.AgregarElementoWeb(idAbonado, productos);
				}	*/		
				
				//(+) EV 26/04/2010 filtra los productos disponibles segun los tipos de comportamientos seleccionados
				//ArrayList productosDisponiblesFiltrados = 
				//	filtrarPorTipoComportamiento(productos.getProductosDisponible(),detalleProductoForm.getListaTiposCom()); 
				//(-) EV 26/04/2010
				
				//(+) EV 17/05/2010 Filtra con codigos (solo si se levanta popup con listado de productos)
				AbonadoFrmkDTO abonado = (AbonadoFrmkDTO) session.getAttribute("Abonado");
				logger.debug("abonado"+abonado);
				ArrayList productosDisponiblesFiltrados = abonado.getProductoDisponibles();
				logger.debug("productosDisponiblesFiltrados.size()"+productosDisponiblesFiltrados.size());
				logger.debug("detalleProductoForm.getCadenaProductosSeleccionados()="+detalleProductoForm.getCadenaProductosSeleccionados());
				if (!detalleProductoForm.getCadenaProductosSeleccionados().equals("")){
					productosDisponiblesFiltrados = filtrarPorCodigo(abonado.getProductoDisponibles(),detalleProductoForm.getCadenaProductosSeleccionados());
					abonado.setProductoDisponibles(productosDisponiblesFiltrados);
				}
				
				//(-) EV 17/05/2010 Filtra con codigos (solo si se levanta popup con listado de productos)
				
				//AbonadoFrmkDTO abonado = clienteVTA.getAbonado(Long.parseLong(idAbonado));			
				//abonado.setCodCliente(clienteVTA.getIdCliente());	
				//abonado.setProductoContratados(productos.getProductosContratados());
				//abonado.setProductoDisponibles(productosDisponiblesFiltrados);
				//session.setAttribute("Abonado", abonado);			
				
				//session.setAttribute("ClienteVTA",clienteVTA);	// seteo para mostrar datos en pagina
				//session.setAttribute("navegacion", navegacion);
				
			}
			if (form instanceof BitaForm) 
			{
				logger.debug("BitaForm");
				navegaForm = (BitaForm) form;
				//TODO: rutina que almacena los productos seleccionados
				NavegacionWeb navegacion = (NavegacionWeb) session.getAttribute("navegacion");
				idAbonado = (String)session.getAttribute("idAbonado");
				logger.debug("navegacion="+navegacion);	
				logger.debug("idAbonado="+idAbonado);	
				
				/*if (!request.getParameter("idAbonado").equals("0")) {
					idAbonado = request.getParameter("idAbonado");
				}*/
				
				
				
				navegacion.setPagina(navegaForm.getPagina());
				navegacion.setAccion(navegaForm.getAccion());	
				navegacion.setIdPagina(idAbonado);
				navegacion.setBitacora(navegaForm.getBitacora());
				
				//logger.debug("valor de bitacora "+navegaForm.getBitacora());	
				
				
				String bitacoraDef = request.getParameterValues("bitacoraLcDef")[0];
				
				logger.debug("valor de bitacoraDef "+bitacoraDef);
				
				navegacion.setBitacoraDef(bitacoraDef );
				String[] cantidades = request.getParameterValues("cantidades");
				String[] limConsumoCodigos = request.getParameterValues("combo_lc");
				String[] montoslc   = request.getParameterValues("montoslc");
				/*por defecto*/
				
				String montoslc_D_Str = request.getParameter("montoslc_D_ih");
				StringTokenizer mtosStk = new StringTokenizer(montoslc_D_Str,"|");
				String[] montoslc_D = new String[mtosStk.countTokens()];
				int indMto=0;
				while (mtosStk.hasMoreTokens()) {				
					montoslc_D[indMto++]=mtosStk.nextToken();
				}
				//montoslc_D = montoslc_D_Str.split("|");
				/*por defecto*/
				int numLC = 0;
				
				if(limConsumoCodigos != null){
					numLC = limConsumoCodigos.length;
				}
				
				String[] montoslcTemp =  new String[numLC];
				int indMtlc = 0;
				for(int i=0;i<numLC;i++){
					if("-0".equals(limConsumoCodigos[i])){
						montoslcTemp[i]="0";
					}else{
						montoslcTemp[i]=montoslc[indMtlc++];
					}
				}
				montoslc=montoslcTemp;
				navegacion.Grabar();
				navegacion.setCantidadesPorProductoOfertado(idAbonado,cantidades);
				navegacion.setLCPorProductoOfertado(idAbonado,limConsumoCodigos,montoslc);
				navegacion.setLCPorProductoDefecto(idAbonado,montoslc_D);
				//luego de guardar los cambios .. se asocia a la variable de sesion
				session.setAttribute("navegacion",navegacion);
				forward = navegacion.getSiguiente();
				logger.debug("valor del forward"+ forward);	
				logger.debug("execute fin");
				//"verCargos"	
				//boolean saltarPagPrincipal=session.getAttribute("CORPORATIVO")!=null?true:false;
				//if(!saltarPagPrincipal)
					return mapping.findForward(forward);
				//else
					//return mapping.findForward("verCargos");
			}
		}
		catch(Exception e)
		{
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("log error[" + loge + "]");
			forward="mensajeError";
			request.setAttribute("exception", e.getMessage());
		}	
		logger.debug("execute fin");
		return mapping.findForward(forward);

	}
   
	private ArrayList filtrarPorTipoComportamiento(ArrayList productosDisponibles, String[] listaTiposCom) throws Exception {
		logger.debug("filtrarPorTipoComportamiento():ini");
		
		String seleccion = "";
		ArrayList productosDisponiblesFiltrados = new ArrayList();
		
		for(int i=0;i<listaTiposCom.length;i++){
			seleccion = seleccion + " [" + listaTiposCom[i]+"]";
			
			ArrayList productosDisponiblesAux = new ArrayList();
			
			for (int j=0;j<productosDisponibles.size();j++) {
				ProductoWeb productoX = (ProductoWeb) productosDisponibles.get(j);
				if (productoX.getComportamiento().equals(listaTiposCom[i])){
					productosDisponiblesAux.add(productoX);
				}
			}
			
			productosDisponiblesFiltrados.addAll(productosDisponiblesAux);	
			
		}
		logger.debug("Tipos de comportamientos seleccionados:"+seleccion);
		logger.debug("filtrarPorTipoComportamiento():fin");
		return productosDisponiblesFiltrados;
	}
	
	private ArrayList filtrarPorCodigo(ArrayList productosDisponibles, String cadenaProductos) throws Exception {
		logger.debug("filtrarPorCodigo():ini");
		
		String seleccion = "";
		ArrayList productosDisponiblesFiltrados = new ArrayList();
		String[] listaCodigos = cadenaProductos.split(",");
		ArrayList productosDisponiblesAux = new ArrayList();
		
		for(int i=0;i<listaCodigos.length;i++){
			seleccion = seleccion + " [" + listaCodigos[i]+"]";
			
			productosDisponiblesAux.clear();
			for (int j=0;j<productosDisponibles.size();j++) {
				
				ProductoWeb productoX = (ProductoWeb) productosDisponibles.get(j);
				if (productoX.getCodigo().equals(listaCodigos[i]) && !productoX.getTipoPlanAdic().equals("2")){
					productosDisponiblesAux.add(productoX);
					break;
				}
			}
			
			productosDisponiblesFiltrados.addAll(productosDisponiblesAux);
			
			
			logger.debug("Los productos Disponibles Antes de los O. Obligatorios "+productosDisponiblesFiltrados.size());
			
		}
		
		//VMB INC 155400 22112010 Se agregaron los Opcionales obligatorios
		productosDisponiblesAux.clear();
		for (int j=0;j<productosDisponibles.size();j++) {
			ProductoWeb productoX = (ProductoWeb) productosDisponibles.get(j);
			if(productoX.getTipoPlanAdic().equals("2")){
				productosDisponiblesAux.add(productoX);
			}
		}
		
		productosDisponiblesFiltrados.addAll(productosDisponiblesAux);	
		
		
		logger.debug("Largo PA productosDisponiblesFiltrados Opcionales y O.Obligatorio "+productosDisponiblesFiltrados.size());
		
		logger.debug("Productos seleccionados:"+seleccion);
		logger.debug("filtrarPorCodigo():fin");
		return productosDisponiblesFiltrados;
	}		
}

