package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

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

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.AbonadoFrmkDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.BitaForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ProductoForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.NavegacionWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.PaqueteWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ProductoWeb;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ProductosContradosFrecUtil;

public class ProductosAboLimiteConsumoAction extends Action{
	
	private final Logger logger = Logger.getLogger(ProductosAboLimiteConsumoAction.class);
	
	  private ProductoForm productoForm;
	  
	  private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	  public ActionForward execute(
		ActionMapping mapping,
		ActionForm form,
		HttpServletRequest request,
		HttpServletResponse response) throws Exception
	  {

		  	productoForm = (ProductoForm) form;
						
			HttpSession session = request.getSession(false);

			AbonadoFrmkDTO abonado = (AbonadoFrmkDTO) session.getAttribute("Abonado");
			NavegacionWeb navegacion = (NavegacionWeb) session.getAttribute("navegacion");
			
		    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");

		    sessionData.setCargosObtenidos(null);//AGREGAR 191208
		    session.setAttribute("CargosForm",null);
			String retornoFW="flujoAboLimiteConsumo";
			//System.out.println("ProductoAction getIdProducto "+productoForm.getIdProducto());
			
			//antes de ir a una opcion de producto guardo los productos que fueron chequeados
			navegacion.setPagina("productos"); //<-- para que guarde los productos
			navegacion.setAccion(BitaForm.ACEPTAR);	
			navegacion.setIdPagina(String.valueOf(abonado.getIdAbonado()));
						
			String[] listaAbonosBita = request.getParameterValues("abono_lc");
			String[] listaAbonosHabilitados = request.getParameterValues("RegistraCambio");
			
			if (listaAbonosBita.length > 0){
				
				
				navegacion.setListaAbonosBita(listaAbonosBita);
				navegacion.setListaAbonosHabilitados(listaAbonosHabilitados);
				navegacion.Grabar();
				
			}else
			{
				navegacion.Grabar();
							
			}
			
			
			return mapping.findForward(retornoFW);
		}



}
