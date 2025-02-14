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
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.AbonadoFrmkDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.frmk.dataTransferObject.ClienteFrmkDTO;
import com.tmmas.scl.operations.crm.f.s.manpro.web.form.BitaForm;
import com.tmmas.scl.operations.crm.f.s.manpro.web.form.ProductoForm;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.PaqueteWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.ProductoWeb;
import com.tmmas.scl.operations.crm.f.s.manpro.web.helper.VentaUtils;


public class ProductoAction extends Action
{
	
  private final Logger logger = Logger.getLogger(ProductoAction.class);
	
  public ActionForward execute(
	ActionMapping mapping,
	ActionForm form,
	HttpServletRequest request,
	HttpServletResponse response) throws Exception
  {
	  String retornoFW="inicio";
	  ProductoForm productoForm;
	  
	  try
	  {
	  	productoForm = (ProductoForm) form;
		HttpSession session = request.getSession(false);
  		ClienteFrmkDTO clienteVTA = (ClienteFrmkDTO) session.getAttribute("ClienteVTA");
		AbonadoFrmkDTO abonado = (AbonadoFrmkDTO) session.getAttribute("Abonado");
		NavegacionWeb navegacion = (NavegacionWeb) session.getAttribute("navegacion");		
		
		String descripcionProducto=""; 
		String codigoProducto="";
		String numeroMax="";
		/*if (session != null) {
			session.removeAttribute("ClienteVTA");
			session.removeAttribute("Abonado");
			session.removeAttribute("navegacion");
			//session.invalidate();
		}*/
	
		
		String identificadorProducto = productoForm.getIdProducto();	
		
		logger.debug("identificadorProducto="+identificadorProducto);
		//antes de ir a una opcion de producto guardo los productos que fueron chequeados
		navegacion.setPagina("productos"); //<-- para que guarde los productos
		navegacion.setAccion(BitaForm.ACEPTAR);	
		navegacion.setIdPagina(String.valueOf(abonado.getIdAbonado()));
		String bitacora = (String) request.getParameter("bitacora");
		String[] cantidades=null;
		String[] montoslc  =null;
		String[] limConsumoCodigos =null;
		if (bitacora!=null){
			logger.debug("bitacora != null");
			//si existen productos ofertables chequeados
			navegacion.setBitacora(bitacora);
			cantidades = request.getParameterValues("cantidades");
			montoslc   = request.getParameterValues("montoslc");
			
			//(+)EV 02/01/2010 se guardan valores de pagina  
			limConsumoCodigos = request.getParameterValues("combo_lc");
			
			String bitacoraDef = request.getParameterValues("bitacoraLcDef")[0];
			
			logger.debug("se checkeo un producto "+bitacoraDef);
			
			navegacion.setBitacoraDef(bitacoraDef );
			
			/*por defecto*/
			String montoslc_D_Str = request.getParameter("montoslc_D_ih");
			StringTokenizer mtosStk = new StringTokenizer(montoslc_D_Str,"|");
			String[] montoslc_D = new String[mtosStk.countTokens()];
			int indMto=0;
			while (mtosStk.hasMoreTokens()) {				
				montoslc_D[indMto++]=mtosStk.nextToken();
			}
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
			navegacion.setCantidadesPorProductoOfertado(String.valueOf(abonado.getIdAbonado()),cantidades);
			navegacion.setLCPorProductoOfertado(String.valueOf(abonado.getIdAbonado()),limConsumoCodigos,montoslc);
			navegacion.setLCPorProductoDefecto(String.valueOf(abonado.getIdAbonado()),montoslc_D);
			//luego de guardar los cambios .. se asocia a la variable de sesion
			session.setAttribute("navegacion",navegacion);
			//(-)EV 02/01/2010
		}else
		{
			//esto ocurre cuando no existe ningun producto ofertable checkeado 
			//pero igual se debe "grabar", que nada fue seleccionado
			navegacion.Grabar();			
		}
		//luego de guardar los cambios .. se asocia a la variable de sesion
		//session.setAttribute("navegacion",navegacion);
		
		logger.debug("comportamiento="+productoForm.getComportamiento());
		
		if("PFRC".equalsIgnoreCase(productoForm.getComportamiento()))
		{
//			TODO: setear numero frecuente
			ArrayList listNumFrec = new ArrayList();
			listNumFrec = navegacion.getListaProducNumFreq(String.valueOf(abonado.getIdAbonado()));
			session.setAttribute("ClienteVTA",clienteVTA );
			session.setAttribute("Abonado",abonado );
			session.setAttribute("navegacion",navegacion );
			session.setAttribute("identificadorProducto",  identificadorProducto);
			session.setAttribute("codPadrePaq",  productoForm.getCodPadrePaq());
			session.setAttribute("codNumFre",  productoForm.getCodigo());			
			retornoFW="frecuentes";
		}			
		else if("PAFN".equalsIgnoreCase(productoForm.getComportamiento()))
		{
			codigoProducto = productoForm.getCodigoProducto();
			descripcionProducto =productoForm.getProductoDescripcion();
			numeroMax=productoForm.getNumeroMaximo();		
			
			ArrayList listaClienteAfines = new ArrayList();			
			listaClienteAfines = navegacion.getListaClienteAfines(String.valueOf(abonado.getIdAbonado()),identificadorProducto);
			session.setAttribute("ClienteVTA",clienteVTA );
			session.setAttribute("Abonado",abonado );
			session.setAttribute("navegacion",navegacion );
			
			/*Datos para la cabezera*/
			session.setAttribute("codListaCliente",identificadorProducto);			
			session.setAttribute("listaCliente",listaClienteAfines);
			session.setAttribute("descripcionProducto",descripcionProducto);
			session.setAttribute("codigoProductoTitle",codigoProducto);
			session.setAttribute("numeroMax",numeroMax);
			
			String idAbonado = String.valueOf(abonado.getIdAbonado());
			
			if ( (productoForm.getCodPadrePaq()).equals(idAbonado)){
				session.setAttribute("codPadrePaq",  productoForm.getCodPadrePaq());
			}
			else
			{
				session.setAttribute("codPadrePaq", ".");
			}
			retornoFW="afines";
		}else{
			//(+) si es PA de tipo "correo seven", se invoca a pagina de datos adicionales
			
			logger.debug("productoForm.getIdEspecProvision()="+productoForm.getIdEspecProvision());
			PaqueteWeb paqueteWeb = navegacion.getPaqueteWeb(String.valueOf(abonado.getIdAbonado()));
			boolean esCorreoSeven = VentaUtils.esCorreoSeven(paqueteWeb.getParametrosCorreo(), productoForm.getIdEspecProvision())  ;
			
			if (esCorreoSeven){
				//(+)obtiene producto seleccionado
				ArrayList listaProductosDisponibles = paqueteWeb.getProductosDisponible();
				ProductoWeb productoWeb = new ProductoWeb();
				for(int i=0; i<listaProductosDisponibles.size();i++){
					productoWeb = (ProductoWeb)listaProductosDisponibles.get(i);
					
					if (productoWeb.getIdEspecProvision()!=null
							&& productoWeb.getIdEspecProvision().equals(productoForm.getIdEspecProvision())){
						break;
					}
				}
				//(-)
				
				session.setAttribute("navegacion",navegacion );
				session.setAttribute("paqueteWeb",paqueteWeb );
				session.setAttribute("productoSeleccionado",productoWeb );
				retornoFW = "datosAdicCorreoSeven";
			}
			//(-) si es PA de tipo "correo seven", se invoca a pagina de datos adicionales
		}
		
		
	  }
	  catch(Exception e)
	  {
		  String loge = StackTraceUtl.getStackTrace(e);
		  logger.debug("log error[" + loge + "]");
		  retornoFW="mensajeError";
		  request.setAttribute("exception", e.getMessage()); 
	  }
		return mapping.findForward(retornoFW);
	}
 }


