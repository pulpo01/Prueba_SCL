package com.tmmas.cl.scl.pv.customerorder.web.action;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.configuration.CompositeConfiguration;
import org.apache.log4j.Category;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework20.util.UtilLog;
import com.tmmas.cl.framework20.util.UtilProperty;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.ClienteDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerAccountDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.CustomerOrderSessionDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.OrdenServicioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.PlanTarifarioDistDTO;
import com.tmmas.cl.scl.pv.customerorder.commonapp.dto.PlanTarifarioDistListDTO;
import com.tmmas.cl.scl.pv.customerorder.web.delegate.CustomerOrderDelegate;
import com.tmmas.cl.scl.pv.customerorder.web.form.RedistribucionBolsaForm;
import com.tmmas.cl.scl.pv.customerorder.web.helper.ForwardOS;
import com.tmmas.cl.scl.pv.customerorder.web.helper.Global;


public class RedistribucionBolsaAction extends Action {

	CustomerOrderDelegate delegate = CustomerOrderDelegate.getInstance();	
	private Category logger = Category.getInstance(RedistribucionBolsaAction.class);	
	private Map actions = null;
	private Global global = Global.getInstance();
	
	private CompositeConfiguration config;
	
	private void RedistribucionBolsaAction() {
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
			actions.put("mostrar", new Integer(1));
			actions.put("modificar", new Integer(2));
			actions.put("mostrarPlanes", new Integer(3));
			actions.put("cargarAbonados", new Integer(4));
			actions.put("aceptarDistribucion", new Integer(5));
			actions.put("ingresarComentarios", new Integer(6));
			actions.put("guardarDistribucionBolsa", new Integer(7));
		}
		return actions;
	}	

	public ActionForward execute(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response) 
		throws Exception 
	{
		logger.debug("execute");
		logger.debug("forma clase[" + actionForm.getClass().getName() + "]");
		RedistribucionBolsaForm form = (RedistribucionBolsaForm) actionForm;

		logger.debug("form.getAccion() :"+form.getAccion());
		switch (((Integer) getMap().get(form.getAccion())).intValue()) {
		case 1:
			logger.debug("1");
			return mostrar(mapping, form, request);
		case 2:
			logger.debug("2");
			return modificarRedistribucion(mapping, form, request);
		case 3:
			logger.debug("3");
			return mostrarPlanes(mapping, form, request);
		case 4:
			logger.debug("4");
			return cargarAbonados(mapping, form, request,response);
		case 5:
			logger.debug("5");
			return aceptarDistribucion(mapping, form, request,response);
		case 6:
			logger.debug("6");
			return ingresarComentarios(mapping, form, request,response);
		case 7:
			logger.debug("7");
			return guardarDistribucionBolsa(mapping, form, request,response);			
		}
		logger.error("NO ENCONTRO UNA ACCION ADECUADA");
		return null;
	}
	
	public ActionForward mostrarPlanes(ActionMapping actionMapping,//mostrarTestOK
			ActionForm form, HttpServletRequest request)throws Exception {

		logger.debug("mostrarPlanes:inicio");
		
		HttpSession session = request.getSession(false);

		ClienteDTO clienteDTO = null;
		//CustomerOrderSessionDTO sessionData;
		//sessionData = new CustomerOrderSessionDTO();//(CustomerOrderSessionDTO)servletRequest.getSession().getAttribute("CustomerOrder");
		//VentaAjaxDTO datosVenta = (VentaAjaxDTO)session.getAttribute("ventaSel");

		CustomerAccountDTO CustomerAccount  = new CustomerAccountDTO();
		CustomerAccountDTO CustomerAccount2 = new CustomerAccountDTO();
		CustomerOrderSessionDTO sessionData;
		BolsaAbonadoDTO[] abonadoList = null;
		
		sessionData = (CustomerOrderSessionDTO)session.getAttribute("CustomerOrder");				
		
		CustomerAccount.setCode(sessionData.getCode());
		CustomerAccount.setCodePlanRate(sessionData.getCodePlanRate());
		CustomerAccount.setDesPlanRate(sessionData.getDesPlanRate());
		CustomerAccount.setNames(sessionData.getNames());
		
		
		String codCliente = ""+sessionData.getCode();//datosVenta.getCodCliente();
		//long numVenta = Long.parseLong(datosVenta.getNroVenta());
		
		logger.debug("codCliente  ["+codCliente+"]");
		//logger.debug("numVenta    ["+numVenta+"]");
		//logger.debug("codPlanTarif["+codPlanTarif+"]");
		
		//1.- Se obtienen datos del cliente
		/*BusquedaClienteDTO busqClienteDTO = new BusquedaClienteDTO();
		busqClienteDTO.setCodCliente(codCliente);
		
		ClienteDTO[] datosCliente = delegate.getDatosCliente(busqClienteDTO);
		BolsaAbonadoDTO[] abonadoList = null;
		if(datosCliente == null || datosCliente.length < 1 || datosCliente[0] == null)
		{
			session.setAttribute("CustomerOrder",sessionData);
			session.setAttribute("involvementsList",abonadoList );
			return actionMapping.findForward("success");
		}*/
		//clienteDTO = datosCliente[0];

		//2.- Se obtienen datos de los planes tarifarios
		PlanTarifarioDistListDTO planTarifarioList = null;
		if(session.getAttribute("planes") != null)
		{
			planTarifarioList=(PlanTarifarioDistListDTO) session.getAttribute("planes");	
		}else{
			logger.debug("obtenerPlanesDistribuidos() :antes");
			PlanTarifarioDTO[] planesDistribuidos = delegate.obtenerPlanesDistribuidos(new Long(codCliente));
			logger.debug("obtenerPlanesDistribuidos() :despues");
			planTarifarioList=obtenerListaPlanesConversion(planesDistribuidos);//obtenerListaPlanesTest();
		}
	    
	   // planTarifarioList.setNumVenta(numVenta);
		//sessionData.setCode(Long.parseLong(codCliente));
		//sessionData.setNames(clienteDTO.getNombreCliente());
		session.removeAttribute("CustomerOrder");
		session.setAttribute("CustomerOrder",sessionData);
		session.setAttribute("planes", planTarifarioList);
		logger.debug("mostrarPlanes:fin");
		session.setAttribute("inicio","inicio");
		//return actionMapping.findForward("mostrarPlanes");
		return actionMapping.findForward("success");
	}
	
	public ActionForward cargarAbonados(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response)
		throws Exception 
	{
		logger.debug("cargarAbonados:inicio");
		cargarDatosAbonados(mapping, actionForm, request, response);
		logger.debug("cargarAbonados:fin");
		return mapping.findForward("success");//"cargarAbonados");
	}
	
	public ActionForward aceptarDistribucion(ActionMapping mapping, ActionForm form, 
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		logger.debug("aceptarDistribucion:inicio");
		HttpSession session = request.getSession(false);
		int minutesToAssign[];
		int count = 0;  
		int i=0;
		float porcentajetotal = 0;
		float dif = 0;
		BolsaAbonadoDTO[] abonadoList = null;
        CustomerOrderSessionDTO sessionData;
        DistribucionBolsaDTO distribucionBolsa = null;
        ArrayList bolsaCliente = new ArrayList();
        BolsaAbonadoDTO bolsaAbonado = null;
        RedistribucionBolsaForm  distBolsaForm = (RedistribucionBolsaForm) form;
		minutesToAssign = distBolsaForm.getMinutesToAssign();
		sessionData = (CustomerOrderSessionDTO)session.getAttribute("CustomerOrder");
		abonadoList = (BolsaAbonadoDTO[])session.getAttribute("involvementsList");
		
		//se actualiza los datos ingresados
		String planSeleccionado = distBolsaForm.getPlanCB();
		logger.debug("planSeleccionado["+planSeleccionado+"]");
		PlanTarifarioDistListDTO planTarifarioList=(PlanTarifarioDistListDTO) session.getAttribute("planes");
		PlanTarifarioDistDTO planTarifarioSelect = obtenerPlanSelect(planTarifarioList,planSeleccionado);
		distribucionBolsa = planTarifarioSelect.getDistribucionBolsa();
		distribucionBolsa.setCod_plan(planTarifarioSelect.getCodigoPlanTarifario());
		distribucionBolsa.setCod_cliente(sessionData.getCode());
		logger.debug("-------------------------------");
		logger.debug("MinutosTotal           ["+sessionData.getFreeUnits()+"]");
		logger.debug("minutesToAssign.length ["+minutesToAssign.length+"]");
		logger.debug("-------------------------------");
		for (i=0; i<abonadoList.length; i++) {
			bolsaAbonado = new BolsaAbonadoDTO();
			bolsaAbonado.setNum_abonado(abonadoList[count].getNum_abonado());	
			bolsaAbonado.setCnt_unidad(minutesToAssign[count]);
			bolsaAbonado.setPrc_unidad((100*minutesToAssign[count])/sessionData.getFreeUnits());
			logger.debug("prc_unidad 1 ["+bolsaAbonado.getPrc_unidad()+"]");
			porcentajetotal = porcentajetotal + bolsaAbonado.getPrc_unidad();
			//if ((porcentajetotal < 100) && (i == abonadoList.length-1)){ // RRG 62582 PAN 20-03-2008 
			if ((porcentajetotal < 100 && porcentajetotal > 0 ) && (i == abonadoList.length-1)){ // RRG
				dif = 100 - porcentajetotal+bolsaAbonado.getPrc_unidad(); 				
				bolsaAbonado.setPrc_unidad(dif);
			}
			bolsaAbonado.setInd_venta(0);//????
			bolsaAbonado.setNum_celular(abonadoList[count].getNum_celular());
			imprimirBolsa(bolsaAbonado);
			bolsaCliente.add(bolsaAbonado);		    		    		    		    		   
		    count = count +1;
		}	 

		distribucionBolsa.setBolsa((BolsaAbonadoDTO[])bolsaCliente.toArray(new BolsaAbonadoDTO[bolsaCliente.size()]));
		distribucionBolsa.setServiceOrder(crearOrdenServicio(sessionData));//revisar si se necesita
		planTarifarioSelect.setDistribucionPlanRealizada(true);//para un plan 
		planTarifarioSelect.setEstilo("border-width: 2px; border-style: solid; font-size:8pt; color: #009900;");
		request.setAttribute("mensaje",planTarifarioSelect.getDescripcionPlanTarifario());
		boolean distribucionCompleta = verificarDistribucionCliente(planTarifarioList);
		planTarifarioList.setDistribucionCompleta(distribucionCompleta);
		Boolean bolsasDistribuidas = new Boolean(distribucionCompleta);
		session.setAttribute("planes", planTarifarioList);
		session.setAttribute("bolsasDistribuidas",bolsasDistribuidas);
		String forward = "success";//"cargarAbonados";
		logger.debug("forward [" + forward + "]");
		logger.debug("aceptarDistribucion:fin");			
		cargarDatosAbonados(mapping, form, request, response);
		return mapping.findForward(forward);
	}
	

	public ActionForward ingresarComentarios(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		logger.debug("ingresarComentarios:inicio");
		HttpSession session = request.getSession(false);
		CustomerOrderSessionDTO sessionData = (CustomerOrderSessionDTO)session.getAttribute("CustomerOrder");
		String forward = ForwardOS.forwardOS(sessionData.getForward(), 2);
		logger.debug("forward [" + forward + "]");
		logger.debug("ingresarComentarios:fin");			
		return mapping.findForward(forward);
	}
	
	public ActionForward guardarDistribucionBolsa(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		logger.debug("guardarDistribucionBolsa:inicio");
		HttpSession session = request.getSession(false);
		PlanTarifarioDistListDTO planTarifarioList=(PlanTarifarioDistListDTO) session.getAttribute("planes");
		PlanTarifarioDistDTO[] planTarifarioArr = planTarifarioList.getPlanesTarifarios();
		PlanTarifarioDistDTO planTarifarioDistDTO = null;
		for(int i=0;i<planTarifarioArr.length;i++)
		{
			planTarifarioDistDTO = planTarifarioArr[i];
			logger.debug("CodigoPlanTarifario ["+planTarifarioDistDTO.getCodigoPlanTarifario()+"]");
			logger.debug("Cantidad de abonados["+planTarifarioDistDTO.getDistribucionBolsa().getBolsa().length+"]");
			logger.debug("guardarDistribucionBolsa:antes");
			//delegate.guardarDistribucionBolsa(planTarifarioDistDTO.getDistribucionBolsa());
			logger.debug("guardarDistribucionBolsa:despues");
		}
		logger.debug("guardarDistribucionBolsa:fin");
		//ResultadoVentaDTO resultadoVenta = (ResultadoVentaDTO)session.getAttribute("resultadoVenta");
		//request.setAttribute("resultadoVenta",resultadoVenta);
		session.removeAttribute("bolsasDistribuidas");
		session.removeAttribute("CustomerOrder");
		session.removeAttribute("inicio");
		session.removeAttribute("involvementsList");
		session.removeAttribute("planes");
		session.removeAttribute("resultadoVenta");
		return mapping.findForward("desplegarDistribucion");//venta "aceptarPresupuesto");
	}

	public void cargarDatosAbonados(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		logger.debug("cargarDatosAbonados:inicio");
		BolsaAbonadoDTO[] bolsaAboArr = null;
		DistribucionBolsaDTO distribucionBolsa = null;
		HttpSession session = request.getSession(false);
		RedistribucionBolsaForm distBolsaForm = (RedistribucionBolsaForm)actionForm;
		String planSeleccionado = distBolsaForm.getPlanCB();
		logger.debug("planSeleccionado["+planSeleccionado+"]");
		
		PlanTarifarioDistListDTO planTarifarioList=(PlanTarifarioDistListDTO) session.getAttribute("planes");
		PlanTarifarioDistDTO planTarifarioSelect = obtenerPlanSelect(planTarifarioList,planSeleccionado);
		CustomerOrderSessionDTO sessionData = (CustomerOrderSessionDTO)session.getAttribute("CustomerOrder");
		if(planTarifarioSelect.isDistribucionPlanRealizada())
		{
			distribucionBolsa = planTarifarioSelect.getDistribucionBolsa();
			bolsaAboArr       = distribucionBolsa.getBolsa();//getBolsaAbonadoArrDTO();
		}else
		{
			CustomerAccountDTO customerAccount  = new CustomerAccountDTO();
			customerAccount.setCode(sessionData.getCode());
			customerAccount.setCodePlanRate(planSeleccionado);//sessionData.getCodePlanRate());
			
			distribucionBolsa = delegate.obtenerDatosBolsa(planSeleccionado);
			planTarifarioSelect.setDistribucionBolsa(distribucionBolsa);
			CustomerAccountDTO customerAccount2 = delegate.getFreeUnitBagId(customerAccount);//test comentar
			bolsaAboArr = delegate.getFreeUnitStock(customerAccount);
		}

		session.setAttribute("planes", planTarifarioList);
		session.removeAttribute("inicio");
		//CustomerOrderSessionDTO sessionData = (CustomerOrderSessionDTO) session.getAttribute("CustomerOrder");//(CustomerOrderSessionDTO)servletRequest.getSession().getAttribute("CustomerOrder");
		sessionData.setFreeUnits(distribucionBolsa.getCantidad_bolsa());//planTarifarioSelect.getFreeUnits());//);		
		session.removeAttribute("CustomerOrder");
		session.setAttribute("CustomerOrder",sessionData);
		
		//abonadoList= crearArregloBolsaAbonado(7);
		//abonadoList = delegate.obtenerDistribucionBolsa(customerAccount);//getFreeUnitStock(CustomerAccount);
		   
		session.removeAttribute("involvementsList");
		session.setAttribute("involvementsList",bolsaAboArr );
		logger.debug("cargarDatosAbonados:fin");
	}
	
	public ActionForward mostrar(ActionMapping actionMapping,ActionForm form, HttpServletRequest servletRequest)
		throws Exception 
	{

		logger.debug("mostrar:inicio");
		
		CustomerAccountDTO CustomerAccount  = new CustomerAccountDTO();
		CustomerAccountDTO CustomerAccount2 = new CustomerAccountDTO();
		CustomerOrderSessionDTO SessionData;
		BolsaAbonadoDTO[] abonadoList = null;
		
		SessionData = (CustomerOrderSessionDTO)servletRequest.getSession().getAttribute("CustomerOrder");				
		
		CustomerAccount.setCode(SessionData.getCode());
		CustomerAccount.setCodePlanRate(SessionData.getCodePlanRate());
		CustomerAccount.setDesPlanRate(SessionData.getDesPlanRate());
		CustomerAccount.setNames(SessionData.getNames());
		
		
		CustomerAccount2 = delegate.getFreeUnitBagId(CustomerAccount);
		
		SessionData.setFreeUnits(CustomerAccount2.getFreeUnits());		
		servletRequest.getSession().removeAttribute("CustomerOrder");
		servletRequest.getSession().setAttribute("CustomerOrder",SessionData);
		
		abonadoList = delegate.getFreeUnitStock(CustomerAccount);
		   
		servletRequest.getSession().removeAttribute("InvolvementsList");
		servletRequest.getSession().setAttribute("InvolvementsList",abonadoList );
		
		logger.debug("mostrar:fin");
		return actionMapping.findForward("success");
	}	
	
	public ActionForward modificarRedistribucion(ActionMapping actionMapping,ActionForm form, HttpServletRequest servletRequest)
		throws Exception 
	{
		
		int minutesToAssign[];
		int count = 0;  
		int i=0;
		float porcentajetotal = 0;
		float dif = 0;
		BolsaAbonadoDTO[] abonadoList = null;
        CustomerOrderSessionDTO SessionData;
        DistribucionBolsaDTO BolsaDistrib = new DistribucionBolsaDTO();
        ArrayList bolsaCliente = new ArrayList();
        BolsaAbonadoDTO bolsaAbonado = null;
        OrdenServicioDTO ordenServicio = new OrdenServicioDTO();
        
		logger.debug("modificarRedistribucion:inicio");
		
		RedistribucionBolsaForm myf = (RedistribucionBolsaForm) form;					
		SessionData = (CustomerOrderSessionDTO)servletRequest.getSession().getAttribute("CustomerOrder");
		minutesToAssign = myf.getMinutesToAssign();
		abonadoList = (BolsaAbonadoDTO[])servletRequest.getSession().getAttribute("InvolvementsList");
		
		ordenServicio.setNumeroOrdenServicio(SessionData.getNumeroOrdenServicio());
		ordenServicio.setOrdenServicio(SessionData.getOrdenServicio());
		ordenServicio.setNumeroAbonado(SessionData.getCode());
		ordenServicio.setTipo(Integer.parseInt(global.getValor("tipo.cliente")));
		ordenServicio.setUserName(SessionData.getUserName());
								
		BolsaDistrib.setCod_cliente(SessionData.getCode());
		logger.debug("minutesToAssign.length ["+minutesToAssign.length+"]");				
		for (i=0; i<abonadoList.length; i++) {
			bolsaAbonado = new BolsaAbonadoDTO();
			logger.debug("myf.getMinutosTotal().toString() ["+SessionData.getFreeUnits()+"]");
			bolsaAbonado.setNum_abonado(abonadoList[count].getNum_abonado());
			logger.debug("Num_abonado ["+bolsaAbonado.getNum_abonado()+"]");		
			bolsaAbonado.setCnt_unidad(minutesToAssign[count]);
			logger.debug("Cnt_unidad ["+bolsaAbonado.getCnt_unidad()+"]");
			logger.debug("Antes prc_unidad ["+bolsaAbonado.getPrc_unidad()+"]");
			logger.debug("Calculo " +  (100*minutesToAssign[count])/SessionData.getFreeUnits()  );
			bolsaAbonado.setPrc_unidad((100*minutesToAssign[count])/SessionData.getFreeUnits());
			logger.debug("prc_unidad 1["+bolsaAbonado.getPrc_unidad()+"]");
			porcentajetotal = porcentajetotal + bolsaAbonado.getPrc_unidad();
			//if ((porcentajetotal < 100) && (i == abonadoList.length-1)){ // RRG 62582 PAN 20-03-2008 
			if ((porcentajetotal < 100 && porcentajetotal > 0 ) && (i == abonadoList.length-1)){ // RRG
				dif = 100 - porcentajetotal+bolsaAbonado.getPrc_unidad(); 				
				bolsaAbonado.setPrc_unidad(dif);
				logger.debug("prc_unidad 2 ["+bolsaAbonado.getPrc_unidad()+"]");
			}
			
			logger.debug("Prc_unidad ["+bolsaAbonado.getPrc_unidad()+"]");			
			bolsaAbonado.setInd_venta(0);
			logger.debug("Ind_venta ["+bolsaAbonado.getInd_venta()+"]");
			bolsaCliente.add(bolsaAbonado);		    		    		    		    		   
		    count = count +1;
		}	 
		
		BolsaDistrib.setBolsa((BolsaAbonadoDTO[])bolsaCliente.toArray(new BolsaAbonadoDTO[bolsaCliente.size()]));
		BolsaDistrib.setServiceOrder(ordenServicio);
		
		
		servletRequest.getSession().removeAttribute("BolsaDistrib");
		servletRequest.getSession().setAttribute("BolsaDistrib",BolsaDistrib);
				
		String forward = ForwardOS.forwardOS(SessionData.getForward(), 2);
		logger.debug("forward [" + forward + "]");
		logger.debug("modificarRedistribucion:fin");			
       
		return actionMapping.findForward(forward);
	}
	
	private PlanTarifarioDistListDTO obtenerListaPlanesConversion(PlanTarifarioDTO[] planesDistribuidos) {
		PlanTarifarioDistListDTO retorno = new PlanTarifarioDistListDTO();
		PlanTarifarioDistDTO[] planes = new PlanTarifarioDistDTO[planesDistribuidos.length];
		for(int i=0;i<planes.length;i++)
		{
			planes[i] = new PlanTarifarioDistDTO();
			planes[i].setCodigoPlanTarifario(planesDistribuidos[i].getCodigoPlanTarifario());
			planes[i].setDescripcionPlanTarifario(planesDistribuidos[i].getDescripcionPlanTarifario());
		}
		retorno.setPlanesTarifarios(planes);
		return retorno;
	}
	
	private boolean verificarDistribucionCliente(PlanTarifarioDistListDTO planTarifarioList) {
		for(int i=0;i<planTarifarioList.getPlanesTarifarios().length;i++){
			/*if(!planTarifarioList.getPlanesTarifarios()[i].isDistribucionPlanRealizada())
				return false;*/
			if(planTarifarioList.getPlanesTarifarios()[i].isDistribucionPlanRealizada())
				return true;
		}
		return false;//true;
	}

	private OrdenServicioDTO crearOrdenServicio(CustomerOrderSessionDTO sessionData) {
		OrdenServicioDTO ordenServicio = new OrdenServicioDTO();
		ordenServicio.setNumeroOrdenServicio(sessionData.getNumeroOrdenServicio());
		ordenServicio.setOrdenServicio(sessionData.getOrdenServicio());
		ordenServicio.setNumeroAbonado(sessionData.getCode());
		ordenServicio.setTipo(Integer.parseInt(global.getValor("tipo.cliente")));
		ordenServicio.setUserName(sessionData.getUserName());
		return ordenServicio;
	}

	public void imprimirBolsa(BolsaAbonadoDTO bolsaAbonado)
	{
		try{
			logger.debug("Num_abonado  ["+bolsaAbonado.getNum_abonado()+"]");
			logger.debug("Num_celular  ["+bolsaAbonado.getNum_celular()+"]");	
			logger.debug("Cnt_unidad   ["+bolsaAbonado.getCnt_unidad()+"]");
			logger.debug("Antes prc_uni["+bolsaAbonado.getPrc_unidad()+"]");
			logger.debug("prc_unidad 2 ["+bolsaAbonado.getPrc_unidad()+"]");	
			logger.debug("Prc_unidad   ["+bolsaAbonado.getPrc_unidad()+"]");
			logger.debug("Ind_venta    ["+bolsaAbonado.getInd_venta()+"]");
			logger.debug("-------------------------------");
		}
		catch(Exception e){logger.debug("Exception imprimirBolsa["+e.getMessage()+"]");	
		}
	}

	private PlanTarifarioDistDTO obtenerPlanSelect(PlanTarifarioDistListDTO planTarifarioList, String planSeleccionado) {
		String codPlan = null;
		PlanTarifarioDistDTO retorno = null;
		for(int i=0;i<planTarifarioList.getPlanesTarifarios().length;i++)
		{
			retorno= planTarifarioList.getPlanesTarifarios()[i];
			codPlan = retorno.getCodigoPlanTarifario();
			if(codPlan.equals(planSeleccionado))
			{
				return retorno;
			}
		}
		return null;
	}
}

