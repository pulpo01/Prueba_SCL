package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProdContratadoOfertadoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ProductoContratadoFrecDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.ListaProdContratadosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.ProductosContradosFrecUtil;

public class ListaProdContrFrecRecargaAction extends BaseAction{

	private final Logger logger = Logger.getLogger(ListaProdContrFrecRecargaAction.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("execute():start");
		//System.out.println("RECARGANDO LAS LISTAS........................");
		
	    ProductoContratadoFrecDTO [] productosContratadosFrecSess = null;
	    HttpSession session = request.getSession(false);
	    List productosContratados = (List)session.getAttribute("productosContratadosFrec"); // lista que se creo para cargar todos los productos y sus listas de numeros
	    productosContratadosFrecSess = (ProductoContratadoFrecDTO []) session.getAttribute("productosContratadosFrecSess");
 
	    ListaProdContratadosForm form1 = (ListaProdContratadosForm) form;
	    String idProdSelec = form1.getIdProductoContratado();
	    idProdSelec = (String)session.getAttribute("identificadorProducto");
	    ProductoContratadoFrecDTO productoConFrecSel = null;
	    for(int i=0; i<productosContratadosFrecSess.length; i++){
	    	productoConFrecSel = productosContratadosFrecSess[i];
	    	if(idProdSelec.equals(""+productoConFrecSel.getIdProductoContratado()))
	    	{
	    		break;
	    	}	
	    }
	    ClienteOSSesionDTO sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    
	    // ---- Recorre objeto de session productosContratados que contiene TODOS los productos contratados 
	    // ---- y obtiene el producto SELECCIONADO con su lista de numeros
        // NumeroListDTO listaNumCargados = new NumeroListDTO();
	    // NumeroDTO[] numerosSesion = null;
	    for(int i=0; i<productosContratados.size(); i++){
	    	ProdContratadoOfertadoDTO producto = new ProdContratadoOfertadoDTO();
	    	producto = (ProdContratadoOfertadoDTO) productosContratados.get(i);
	    	
	    	// --- Busca los datos SOLO del producto contratado seleccionado a traves de su identificador
	    	if(idProdSelec.equals(String.valueOf(producto.getIdProdContratado()))) 	{
	    		NumeroListDTO listaNumNuevos = ProductosContradosFrecUtil.obtieneListaNumerosSimple(productoConFrecSel);
	    		producto.setListaNumeros(listaNumNuevos);
	    		producto.setPermitidos(listaNumNuevos.getNumerosDTO().length);
	    		session.removeAttribute("listaClientes");
	    		session.removeAttribute("productosContratadosFrec");   
	    		session.setAttribute("productosContratadosFrec", productosContratados);
	    		break;
	    	}
	    }
	    
		if(sessionData.getNumOrdenServicio()== 0){
			SecuenciaDTO secuencia=new SecuenciaDTO();
			logger.debug("obtenerSecuencia:antes");
			secuencia.setNomSecuencia("CI_SEQ_NUMOS");
			secuencia = delegate.obtenerSecuencia(secuencia);
		    sessionData.setNumOrdenServicio(secuencia.getNumSecuencia());
		    logger.debug("obtenerSecuencia:despues");
		}

	    form1.setInicio(null);
	    form1.setGuardarCancelar(null);
	    form1.setEstadoValidacion(null);
	    	
		logger.debug("execute():end");
		return mapping.findForward("cargarProductos");
		
	}

}
