/**
 * Copyright © 2005 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 13/08/2006     Jimmy Lopez              		Versión Inicial
 */
package com.tmmas.cl.scl.pv.customerorder.web.action;

import java.util.Arrays;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
//import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.AbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerOrderSessionDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DesbordeDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.LimiteConsumoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.OrdenServicioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ProductListDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.exception.CustomerOrderException;
import com.tmmas.cl.scl.pv.customerorder.web.delegate.CustomerOrderDelegate;
import com.tmmas.cl.scl.pv.customerorder.web.form.UpdateSSAbonadoForm;
import com.tmmas.cl.scl.pv.customerorder.web.helper.CargarDesborde;
import com.tmmas.cl.scl.pv.customerorder.web.helper.ForwardOS;
import com.tmmas.cl.scl.pv.customerorder.web.helper.Global;

public class UpdateSSAbonadoAction extends BaseAction {
	
	private Category logger = Category.getInstance(UpdateSSAbonadoAction.class);

	CustomerOrderDelegate delegate = CustomerOrderDelegate.getInstance();

	private Global global = Global.getInstance();

	private Map actions = null;
	
	
	private CompositeConfiguration config; // MA
	
	private void UpdateSSAbonadoAction() {
		setLog();
	}
	
	private void setLog() {
		String strRuta = "/com/tmmas/cl/CustomerOrderWeb/web/properties/";
		String srtRutaDeploy = System.getProperty("user.dir");
		String strArchivoProperties= "CustomerOrderWeb.properties";
		String strArchivoLog="CustomerOrderWeb.log";
		String strRutaArchivoExterno = srtRutaDeploy + "/" + strRuta + strArchivoProperties;
	
		config = UtilProperty.getConfiguration(strRutaArchivoExterno, strRutaArchivoExterno);
		
		UtilLog.setLog(strRuta + config.getString(strArchivoLog) );
		logger.debug("Inicio ActionForward");
	}
	

	private Map getMap() {
		if (actions == null) {

			actions = new HashMap();
			actions.put("Mostrar", new Integer(1));
			actions.put("Guardar", new Integer(2));
			actions.put("Editar", new Integer(3));
			actions.put("Actualizar", new Integer(4));
		}
		return actions;
	}

	public ActionForward executeAction(ActionMapping mapping, ActionForm actionForm,HttpServletRequest request, HttpServletResponse response)
		throws Exception 
	{
		// TODO Auto-generated method stub
		logger.debug("executeAction");
		UpdateSSAbonadoForm form = (UpdateSSAbonadoForm) actionForm;

		switch (((Integer) getMap().get(form.getAccion())).intValue()) {
		case 1:
			return mostrar(mapping, form, request);
		case 2:
			return guardar(mapping, form, request);
		case 3:
			return editar(mapping, form, request);
		case 4:
			return actualizar(mapping, form, request);
		}

		logger.error("NO ENCONTRO UNA ACCION ADECUADA");
		return null;
	}

	private ActionForward actualizar(ActionMapping mapping,UpdateSSAbonadoForm form, HttpServletRequest request)
		throws Exception 
	{
		List products = form.getListaProductos();

		Collection listaDesbordes = (Collection) request.getSession()
				.getAttribute("listaDesbordesporAbonado");


		String numero = String.valueOf(form.getEditar()).trim();
		logger.debug("numero Producto()[" + numero + "]");

		// Obtengo el objeto a editar
		ProductDTO dto = (ProductDTO) products.get(form.getEditar());

		// Setea el valor de la prioridad al valor de la forma
		dto.setPriority(form.getPriority());

		// Setea el valor del del desborde al valor de la forma
		dto.setExceedId(form.getExceedId());
		dto.setDescExceedId(CargarDesborde.find(form.getExceedId(),
				listaDesbordes));

		dto.setProfileId(form.getProfileId());
		
		Map map = (HashMap) request.getSession().getAttribute("listaLimiteConsumoMapporAbonado");
		LimiteConsumoDTO[] listaArreglo = (LimiteConsumoDTO[])map.get(numero);
		
		logger.debug("form.getProfileId()[" + form.getProfileId() + "]");
		dto.setDescProfileId(buscaDescripcionLimiteConsumo(form.getProfileId(), listaArreglo));
		form.setEditar(-1);
		return mapping.findForward("success");
	}

	private ActionForward editar(ActionMapping mapping,UpdateSSAbonadoForm form, HttpServletRequest request)
		throws Exception 
	{
		List products = form.getListaProductos();

		String numero = String.valueOf(form.getEditar()).trim();
		logger.debug("numero Producto()[" + numero + "]");
		
		ProductDTO dto = (ProductDTO) products.get(form.getEditar());


		
		Map map = (HashMap) request.getSession().getAttribute("listaLimiteConsumoMapporAbonado");
		LimiteConsumoDTO[] listaArreglo = (LimiteConsumoDTO[])map.get(numero);
		request.setAttribute("listaLimiteConsumo", Arrays.asList(listaArreglo));

		// setea la forma de la prioridad con el valor del objeto
		form.setPriority(dto.getPriority());

		// setea la forma del desborde con el valor del objeto
		form.setExceedId(dto.getExceedId());

		// setea la forma del limite de consumo con el valor del objeto
		form.setProfileId(dto.getProfileId());

		return mapping.findForward("success");
	}

	private ActionForward guardar(ActionMapping mapping,UpdateSSAbonadoForm form, HttpServletRequest request)
		throws Exception 
	{
		List lista = form.getListaProductos();
		ProductDTO[] newList = new ProductDTO[form.getNumProduct().length];

		// Recupera los elementos

		for (int i = 0; i < form.getNumProduct().length; i++) {
			int num = form.getNumProduct()[i];
			ProductDTO product = (ProductDTO) lista.get(num);
			logger.debug("Id[" + product.getId() + "]");
			logger.debug("Name[" + product.getName() + "]");
			logger.debug("Priority[" + product.getPriority() + "]");
			logger.debug("ExceedId[" + product.getExceedId() + "]");
			logger.debug("ProfileId[" + product.getProfileId() + "]");
			logger.debug("Modificable[" + product.isUpdate() + "]");
			logger.debug("codPlan[" + product.getCodPlan() + "]");
			newList[i] = product;
		}
		
		HttpSession session = request.getSession();
		CustomerOrderSessionDTO SessionData = (CustomerOrderSessionDTO)session.getAttribute("CustomerOrder");
		logger.debug("codigo cliente[" + SessionData.getCode() + "]");
		logger.debug("Plan tarifario cliente[" + SessionData.getCodePlanRate() + "]");
		logger.debug("Orden servicio[" + SessionData.getOrdenServicio() + "]");
		logger.debug("Numero orden servicio[" + SessionData.getNumeroOrdenServicio() + "]");
		
		ProductListDTO productList = new ProductListDTO();
		
		//Setea los productos
		productList.setProducts(newList);
		
		//Crea un objeto de cliente
		CustomerAccountDTO customerAccount = new CustomerAccountDTO();
		customerAccount.setCode(SessionData.getCode());
		customerAccount.setCodePlanRate(SessionData.getCodePlanRate());
		
		//Setea el cliente
		productList.setCustomer(customerAccount);
		
		long numeroAbonado = SessionData.getNumeroAbonado();
		logger.debug("numero Abonado[" + numeroAbonado + "]");
		
		String tipo = global.getValor("tipo.abonado");
		logger.debug("tipo[" + tipo + "]");		
		
		AbonadoDTO abonado = new AbonadoDTO();
		
		//El codigo de abonado se setea a cero
		abonado.setNum_abonado(numeroAbonado);

		
		//Setea el abonado del cliente
		productList.getCustomer().setAbonado(abonado);
		
		//Setea los datos de las ordenes de servicio
		OrdenServicioDTO ordenServicio = new OrdenServicioDTO();
		ordenServicio.setNumeroAbonado(numeroAbonado);
		ordenServicio.setOrdenServicio(SessionData.getOrdenServicio());
		ordenServicio.setNumeroOrdenServicio(SessionData.getNumeroOrdenServicio());
		ordenServicio.setTipo(Integer.parseInt(tipo));
		ordenServicio.setUserName(SessionData.getUserName());
		

		//setea la orden de servicio
		productList.setOrdenServicio(ordenServicio);
		
		session.setAttribute("AtributosSSporAbonado", productList);
		
		
		String forward = ForwardOS.forwardOS(SessionData.getForward(), 2);
		logger.debug("forward [" + forward + "]");
		return mapping.findForward(forward);
	}

	private ActionForward mostrar(ActionMapping mapping,UpdateSSAbonadoForm form, HttpServletRequest request)
		throws Exception 
	{
		// Data del listbox de desborde
		CargarDesborde cargaDesborde = new CargarDesborde();
		Collection listaDesbordes = cargaDesborde.cargarConfiguracionDesborde();
		Iterator it = listaDesbordes.iterator();
		while (it.hasNext()) {
			DesbordeDTO product = (DesbordeDTO) it.next();
			logger.debug("Codigo Desborde[" + product.getCodigoDesborde() + "]");
			logger.debug("Descripcion Desborde["
					+ product.getDescripcionDesborde() + "]");
		}
		request.getSession().setAttribute("listaDesbordesporAbonado", listaDesbordes);

		// Manejo de session
		HttpSession session = request.getSession();

		// Obtencion de informacion del cliente de session
		CustomerOrderSessionDTO sessionData = (CustomerOrderSessionDTO)session.getAttribute("CustomerOrder");
		logger.debug("Numero de cliente[" + sessionData.getCode() + "]");
		logger.debug("Numero de abonado[" + sessionData.getNumeroAbonado() + "]");
		
		CustomerAccountDTO cust = new CustomerAccountDTO();
		cust.setCode(sessionData.getCode());		

		AbonadoDTO abonado = new AbonadoDTO();
		abonado.setNum_abonado(sessionData.getNumeroAbonado());
		
		// Ejecutando carga de servicios suplementarios
		ProductListDTO productsList = null;
		try {
			logger.debug("getInstalledInvolvementProductBundle:start");
			productsList = (ProductListDTO) delegate
					.getInstalledInvolvementProductBundle(abonado);
			logger.debug("getInstalledInvolvementProductBundle:end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException", e);
		}

		// Procesando resultados
		 ProductDTO[] products = (ProductDTO[]) productsList.getProducts();
		 
		//ProductDTO[] products = (ProductDTO[]) getProductList();
		 logger.debug("Elementos[" + products.length + "]");


		LimiteConsumoDTO[] listaLimiteConsumoServer = null;
		Map listaLimiteConsumoMap = new HashMap();

		for (int i = 0; i < products.length; i++) {
			ProductDTO prod = products[i];
			prod.setDescExceedId(CargarDesborde.find(prod.getExceedId(),
					listaDesbordes));
			
			String key = String.valueOf(i).trim();
			logger.debug("key[" + key + "]");
			logger.debug("prod.getCodPlan() = [" + prod.getCodPlan() + "]");

			// Obtiene la lista de limites de consumo
			listaLimiteConsumoServer = delegate.getServiceLimitProfiles(prod);			
			listaLimiteConsumoMap.put(key, listaLimiteConsumoServer);			
			
			//Seteo la descripcion
			prod.setDescProfileId(buscaDescripcionLimiteConsumo(prod.getProfileId(), listaLimiteConsumoServer));
			
			logger.debug("Id[" + prod.getId() + "]");
			logger.debug("Name[" + prod.getName() + "]");
			logger.debug("ExceedId[" + prod.getExceedId() + "]");
			logger.debug("Priority[" + prod.getPriority() + "]");
			logger.debug("ProfileId[" + prod.getProfileId() + "]");
			logger.debug("Modificable[" + prod.isUpdate() + "]");
			logger.debug("Desc ExceedId[" + prod.getDescExceedId() + "]");
			logger.debug("Desc ProfileId[" + prod.getDescProfileId() + "]");
			logger.debug("codPlan[" + prod.getCodPlan() + "]");			

		}

		form.setListaProductos(Arrays.asList(products));
		
		request.getSession().setAttribute("listaLimiteConsumoMapporAbonado",
				listaLimiteConsumoMap);		
		return mapping.findForward("success");
	}
	
	
	/**
	 * Busca la descripcion del limite de consumo dado un codigo
	 * @param cod_plan
	 * @param lista
	 * @return
	 */
	private String buscaDescripcionLimiteConsumo (String profileId, LimiteConsumoDTO[] lista) 
	{
		logger.debug("buscaDescripcionLimiteConsumo():start");
		logger.debug("profileId[" + profileId + "]");
		logger.debug("size[" + lista.length + "]");
		String resultado = "";
		for (int i = 0; i < lista.length; i++) {
			LimiteConsumoDTO dto = lista[i];
			String key = dto.getProfileId();
			String desc = dto.getDescProfileId();
			logger.debug("elemento[" + key + "]");
			if (key.equalsIgnoreCase(profileId)){
				logger.debug("Elemento[" + profileId + "] encontrada descripcion[" + desc + "]");
				resultado = desc;
				break;
			}
		}
		logger.debug("buscaDescripcionLimiteConsumo():end");
		return resultado;
	}
}
