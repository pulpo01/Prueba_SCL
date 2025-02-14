package com.tmmas.cl.scl.portalventas.web.action;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.actions.DispatchAction;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.AbonadoDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.BusquedaClienteDTO;
import com.tmmas.cl.scl.customerdomain.businessobject.dto.ClienteDTO;
import com.tmmas.cl.scl.portalventas.web.delegate.PortalVentasDelegate;
import com.tmmas.cl.scl.portalventas.web.dto.CustomerOrderSessionDTO;
import com.tmmas.cl.scl.portalventas.web.dto.ResultadoVentaDTO;
import com.tmmas.cl.scl.portalventas.web.dto.VentaAjaxDTO;
import com.tmmas.cl.scl.portalventas.web.form.DistribucionBolsaForm;
import com.tmmas.cl.scl.portalventas.web.helper.Global;
import com.tmmas.cl.scl.productdomain.businessobject.dto.BolsaAbonadoDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.DistribucionBolsaDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.OrdenServicioDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDistDTO;
import com.tmmas.cl.scl.productdomain.businessobject.dto.PlanTarifarioDistListDTO;


public class DistribucionBolsaAction extends DispatchAction {

	PortalVentasDelegate delegate = PortalVentasDelegate.getInstance();	
	private final Logger logger = Logger.getLogger(DistribucionBolsaAction.class);
	private Global global = Global.getInstance();

	public ActionForward inicio(ActionMapping mapping, 
			ActionForm actionForm, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		logger.debug("inicio");
		logger.debug("forma clase[" + actionForm.getClass().getName() + "]");
		DistribucionBolsaForm form = (DistribucionBolsaForm) actionForm;
		return mostrarPlanes(mapping, form, request);
	}

	public ActionForward mostrarPlanes(ActionMapping actionMapping,//mostrarTestOK
			ActionForm form, HttpServletRequest request)throws Exception {

		logger.debug("mostrarPlanes:inicio");
		
		HttpSession session = request.getSession(false);

		ClienteDTO clienteDTO = null;
		PlanTarifarioDTO[] planesDistribuidosTotal = null;
		CustomerOrderSessionDTO sessionData;
		sessionData = new CustomerOrderSessionDTO();//(CustomerOrderSessionDTO)servletRequest.getSession().getAttribute("CustomerOrder");

		VentaAjaxDTO datosVenta = (VentaAjaxDTO)session.getAttribute("ventaSel");
		String codCliente = datosVenta.getCodCliente();
		long numVenta = Long.parseLong(datosVenta.getNroVenta());
		Long numVentaLng = new Long(numVenta);
		logger.debug("codCliente  ["+codCliente+"]");
		logger.debug("numVenta    ["+numVenta+"]");
		//logger.debug("codPlanTarif["+codPlanTarif+"]");
		
		//1.- Se obtienen datos del cliente
		BusquedaClienteDTO busqClienteDTO = new BusquedaClienteDTO();
		busqClienteDTO.setCodCliente(codCliente);
		
		ClienteDTO[] datosCliente = delegate.getDatosCliente(busqClienteDTO);
		BolsaAbonadoDTO[] abonadoList = null;
		if(datosCliente == null || datosCliente.length < 1 || datosCliente[0] == null)
		{
			session.setAttribute("CustomerOrder",sessionData);
			session.setAttribute("involvementsList",abonadoList );
			return actionMapping.findForward("success");
		}
		clienteDTO = datosCliente[0];
		sessionData.setCode(Long.parseLong(codCliente));
		sessionData.setNames(clienteDTO.getNombreCliente());
		
		//2.- Se obtienen datos de los planes tarifarios
		PlanTarifarioDistListDTO planTarifarioList = null;
		PlanTarifarioDTO[] planesDistribuidos        = null;
		PlanTarifarioDTO[] planesDistribuidosAutomc  = null;
		if(session.getAttribute("planes") != null)
		{
			planTarifarioList=(PlanTarifarioDistListDTO) session.getAttribute("planes");	
		}else{
			logger.debug("obtenerPlanesDistribuidos() :antes");
			planesDistribuidos = delegate.obtenerPlanesDistribuidos(numVentaLng);
			planesDistribuidosAutomc = delegate.obtenerPlanesDistribuidosAutomaticos(numVentaLng);
			planesDistribuidosTotal = planesDistribuidos;
			/**/
			//planesDistribuidos = filtrarPlanesVentasAnteriores()
			logger.debug("obtenerPlanesDistribuidos() :despues");
			planTarifarioList=obtenerListaPlanesConversion(planesDistribuidos);
			//planTarifarioListAutomc=obtenerListaPlanesConversion(planesDistribuidosAutomc);
			if(planesDistribuidos.length < 1 )
			{//no debería haber mostrado alert de "Se distri.."
				if(planesDistribuidosAutomc.length>0)
				{//Distribuir de forma automatica
				 //los planes tarifarios se deben distribuir de forma automática con valor 0 y se debe finalizar la distribución
					/*Se guardan los planes tarifarios filtrados(no visibles) de forma automática, estos planes
					 tenían abonados asociados al mismo plan por eso no se muestran (filtrados ini) */
					PlanTarifarioDistDTO[] planTarifarioFiltradoArr = obtenerDistribucionAutomaticaEnCero(planesDistribuidosAutomc,
							numVenta,sessionData);
					guardarDistribucion(planTarifarioFiltradoArr);
				}
				ResultadoVentaDTO resultadoVenta = (ResultadoVentaDTO)session.getAttribute("resultadoVenta");
				request.setAttribute("resultadoVenta",resultadoVenta);
				//Inicio P-CSR-11002 JLGN 08-08-2011
				String codTipcliente = datosVenta.getCodTipoCliente();
				if(codTipcliente.equals("3")){//Si cliente es Prepago no se muestra Boton de Imprimir Contrato
					session.setAttribute("flagBtnContrato","false");
				}else{
					session.setAttribute("flagBtnContrato","true");
				}		
				//Fin P-CSR-11002 JLGN 08-08-2011
				limpiarSesion(session);
				return actionMapping.findForward("aceptarPresupuesto");//acá redirigir a la venta
			}
			/**/
		}
	    
	    planTarifarioList.setNumVenta(numVenta);
		session.removeAttribute("CustomerOrder");
		session.setAttribute("CustomerOrder",sessionData);
		session.setAttribute("planes", planTarifarioList);
		session.setAttribute("planesDistribuidosAutomc", planesDistribuidosAutomc);
		logger.debug("mostrarPlanes:fin");
		session.setAttribute("inicio","inicio");
		return actionMapping.findForward("mostrarPlanes");
	}
	
	public ActionForward cargarAbonados(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.debug("cargarAbonados:inicio");
		cargarDatosAbonados(mapping, actionForm, request, response);
		logger.debug("cargarAbonados:fin");
		return mapping.findForward("cargarAbonados");
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
		DistribucionBolsaForm  distBolsaForm = (DistribucionBolsaForm) form;
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
		String forward = "cargarAbonados";
		logger.debug("forward [" + forward + "]");
		logger.debug("aceptarDistribucion:fin");			
		cargarDatosAbonados(mapping, form, request, response);
		return mapping.findForward(forward);
	}
	
	public ActionForward desplegarDistribucion(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		logger.debug("desplegarDistribucion");
		return mapping.findForward("desplegarDistribucion");
	}
	
	public ActionForward guardarDistribucionBolsa(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		logger.debug("guardarDistribucionBolsa:inicio");
		HttpSession session = request.getSession(false);
		CustomerOrderSessionDTO sessionData = (CustomerOrderSessionDTO)session.getAttribute("CustomerOrder");
		PlanTarifarioDistListDTO planTarifarioList=(PlanTarifarioDistListDTO) session.getAttribute("planes");
		PlanTarifarioDistDTO[] planTarifarioVisibleArr  = planTarifarioList.getPlanesTarifarios();
		PlanTarifarioDistDTO[] planTarifarioFiltradoArr = null;
		/*Se guardan los planes tarifarios filtrados(no visibles) de forma automática, estos planes
		 tenían abonados asociados al mismo plan por eso no se muestran (filtrados ini) */
		PlanTarifarioDTO[] planesDistribuidosAutomc = (PlanTarifarioDTO[])session.getAttribute("planesDistribuidosAutomc");
		planTarifarioFiltradoArr = obtenerDistribucionAutomaticaEnCero(planesDistribuidosAutomc,
				                   planTarifarioList.getNumVenta(),sessionData);
		guardarDistribucion(planTarifarioFiltradoArr);
		/*(filtrados fin)*/
		guardarDistribucion(planTarifarioVisibleArr);
		logger.debug("guardarDistribucionBolsa:fin");
		ResultadoVentaDTO resultadoVenta = (ResultadoVentaDTO)session.getAttribute("resultadoVenta");
		request.setAttribute("resultadoVenta",resultadoVenta);
		limpiarSesion(session);
		return mapping.findForward("aceptarPresupuesto");//"desplegarDistribucion");//acá redirigir a la venta
	}


	
	public PlanTarifarioDistDTO[] obtenerDistribucionAutomaticaEnCero(PlanTarifarioDTO[] planTarifarioAutomc,long numVenta, CustomerOrderSessionDTO sessionData) throws Exception
	{
		logger.debug("obtenerDistribucionAutomaticaEnCero:inicio");
		String codPlanTarif = null;
		BolsaAbonadoDTO[] bolsaAboArr = null;
		PlanTarifarioDistDTO planTarif = null;
		DistribucionBolsaDTO distribucionBolsa = null;
		PlanTarifarioDistListDTO planTarifarioFiltradoList = null;
		PlanTarifarioDistDTO[] planTarifarioListAutomcArr = new PlanTarifarioDistDTO[0];
		if(planTarifarioAutomc != null && planTarifarioAutomc.length > 0)
		{
			//planesFiltrados = //obtenerPlanesFiltradosVentasAnteriores(planesDistribuidosTotal,planTarifarioVisibleArr);
			//se convierten los planes a PlanTarifarioDistListDTO
			planTarifarioFiltradoList=obtenerListaPlanesConversion(planTarifarioAutomc);
			planTarifarioFiltradoList.setNumVenta(numVenta);
			//por cada plan se deben cargarDatosAbonados y setDistribucionBolsa
			for(int i=0;i<planTarifarioFiltradoList.getPlanesTarifarios().length;i++)
			{
				planTarif = planTarifarioFiltradoList.getPlanesTarifarios()[i];
				codPlanTarif = planTarif.getCodigoPlanTarifario();
				distribucionBolsa = delegate.obtenerDatosBolsa(codPlanTarif);//se usa:Cod_bolsa y Ind_unidad //Glosa_Parametro Cantidad_bolsa
				//distribucionBolsa.setCod_plan(planSeleccionado);//en la prueba viene nulo
				bolsaAboArr = obtenerBolsasAbonados(numVenta,codPlanTarif);
				//se realiza la distribución a cero (aceptarDistribucion) bolsaAboArr=abonadoList=involvementsList
				distribucionBolsa.setCod_plan(codPlanTarif);
				distribucionBolsa.setCod_cliente(sessionData.getCode());
				distribucionBolsa.setBolsa(obtenerDistribucionEnCero(bolsaAboArr));//<---------setea en 0
				distribucionBolsa.setServiceOrder(crearOrdenServicio(sessionData));
				planTarif.setDistribucionBolsa(distribucionBolsa);
				planTarif.setDistribucionPlanRealizada(true);
			}
			planTarifarioListAutomcArr = planTarifarioFiltradoList.getPlanesTarifarios();
		}
		logger.debug("obtenerDistribucionAutomaticaEnCero:fin");
		return planTarifarioListAutomcArr;
	}
	
	public void guardarDistribucion(PlanTarifarioDistDTO[] planTarifarioArr) throws Exception
	{
		logger.debug("guardarDistribucion:inicio");
		PlanTarifarioDistDTO planTarifarioDistDTO = null;
		logger.debug("planTarifarioArr.length["+planTarifarioArr.length+"]");
		for(int i=0;i<planTarifarioArr.length;i++)
		{
			planTarifarioDistDTO = planTarifarioArr[i];
			logger.debug("CodigoPlanTarifario ["+planTarifarioDistDTO.getCodigoPlanTarifario()+"]");
			logger.debug("Cantidad de abonados["+planTarifarioDistDTO.getDistribucionBolsa().getBolsa().length+"]");
			logger.debug("guardarDistribucionBolsa:antes");
			delegate.guardarDistribucionBolsa(planTarifarioDistDTO.getDistribucionBolsa());
			logger.debug("guardarDistribucionBolsa:despues");
		}
		logger.debug("guardarDistribucion:fin");
	}
	
	public void limpiarSesion(HttpSession session)
	{
		session.removeAttribute("bolsasDistribuidas");
		session.removeAttribute("CustomerOrder");
		session.removeAttribute("inicio");
		session.removeAttribute("involvementsList");
		session.removeAttribute("planes");
		session.removeAttribute("planesDistribuidosAutomc");
		session.removeAttribute("resultadoVenta");
	}
	
	public BolsaAbonadoDTO[] obtenerDistribucionEnCero(BolsaAbonadoDTO[] abonadoList)
	{
		int count = 0;		
		BolsaAbonadoDTO bolsaAbonado = null;
		BolsaAbonadoDTO[] bolsaClienteArr = null;
		ArrayList bolsaCliente = new ArrayList();
		for (int i=0; i<abonadoList.length; i++) {
			bolsaAbonado = new BolsaAbonadoDTO();
			bolsaAbonado.setNum_abonado(abonadoList[count].getNum_abonado());	
			bolsaAbonado.setCnt_unidad(0);
			bolsaAbonado.setPrc_unidad(0);
			bolsaAbonado.setInd_venta(0);
			bolsaAbonado.setNum_celular(abonadoList[count].getNum_celular());
			imprimirBolsa(bolsaAbonado);
			bolsaCliente.add(bolsaAbonado);		    		    		    		    		   
		    count = count +1;
		}
		bolsaClienteArr = (BolsaAbonadoDTO[])bolsaCliente.toArray(new BolsaAbonadoDTO[bolsaCliente.size()]);
		return bolsaClienteArr;
	}
	
	public BolsaAbonadoDTO[] obtenerBolsasAbonados(long numVenta, String plan) throws Exception
	{
		BolsaAbonadoDTO[] bolsaAboArr = null;
		AbonadoDTO abonado = new AbonadoDTO();
		abonado.setNumVenta(numVenta);//Long.parseLong(planSeleccionado));
		abonado.setCodPlanTarif(plan);
		AbonadoDTO[] abonadosDistribuidos = delegate.obtenerAbonadosDistribuidos(abonado);
		bolsaAboArr = obtenerBolsas(abonadosDistribuidos);
		return bolsaAboArr;
	}

	public void cargarDatosAbonados(ActionMapping mapping, ActionForm actionForm, HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		logger.debug("cargarDatosAbonados:inicio");
		BolsaAbonadoDTO[] bolsaAboArr = null;
		DistribucionBolsaDTO distribucionBolsa = null;
		HttpSession session = request.getSession(false);
		DistribucionBolsaForm distBolsaForm = (DistribucionBolsaForm)actionForm;
		String planSeleccionado = distBolsaForm.getPlanCB();
		logger.debug("planSeleccionado["+planSeleccionado+"]");
		
		PlanTarifarioDistListDTO planTarifarioList=(PlanTarifarioDistListDTO) session.getAttribute("planes");
		PlanTarifarioDistDTO planTarifarioSelect = obtenerPlanSelect(planTarifarioList,planSeleccionado);
		
		if(planTarifarioSelect.isDistribucionPlanRealizada())
		{
			distribucionBolsa = planTarifarioSelect.getDistribucionBolsa();
			bolsaAboArr       = distribucionBolsa.getBolsa();//getBolsaAbonadoArrDTO();
		}else
		{
			distribucionBolsa = delegate.obtenerDatosBolsa(planSeleccionado);
			//distribucionBolsa.setCod_plan(planSeleccionado);//en la prueba viene nulo
			bolsaAboArr = obtenerBolsasAbonados(planTarifarioList.getNumVenta(),planSeleccionado);
			planTarifarioSelect.setDistribucionBolsa(distribucionBolsa);
		}

		session.setAttribute("planes", planTarifarioList);
		session.removeAttribute("inicio");
		CustomerOrderSessionDTO sessionData = (CustomerOrderSessionDTO) session.getAttribute("CustomerOrder");//(CustomerOrderSessionDTO)servletRequest.getSession().getAttribute("CustomerOrder");
		sessionData.setFreeUnits(distribucionBolsa.getCantidad_bolsa());//planTarifarioSelect.getFreeUnits());//);		
		session.removeAttribute("CustomerOrder");
		session.setAttribute("CustomerOrder",sessionData);
		
		//abonadoList= crearArregloBolsaAbonado(7);
		//abonadoList = delegate.obtenerDistribucionBolsa(customerAccount);//getFreeUnitStock(CustomerAccount);
		   
		session.removeAttribute("involvementsList");
		session.setAttribute("involvementsList",bolsaAboArr );
		logger.debug("cargarDatosAbonados:fin");
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
			if(!planTarifarioList.getPlanesTarifarios()[i].isDistribucionPlanRealizada())
				return false;
		}
		return true;
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
	
	private BolsaAbonadoDTO[] obtenerBolsas(AbonadoDTO[] abonadosDistribuidos) {
		BolsaAbonadoDTO[] bolsas = new BolsaAbonadoDTO[abonadosDistribuidos.length];
		for(int i=0;i<bolsas.length;i++)
		{
			bolsas[i] = new BolsaAbonadoDTO();
			bolsas[i].setNum_abonado(Integer.parseInt(""+abonadosDistribuidos[i].getNumAbonado()));//revisar el campo, deberia dejarse en long, pv
			bolsas[i].setNum_celular(""+abonadosDistribuidos[i].getNumCelular());
			//bolsas[i].setInd_venta(ind_venta)
		}
		return bolsas;
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



	public ActionForward cancelar(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.debug("cancelar, inicio");
		String  forward = "cancelarConsulta";
		DistribucionBolsaForm fuscaClienteForm = (DistribucionBolsaForm) form;
		logger.debug("cancelar, fin");
		
		return mapping.findForward(forward);
	}
	
	public ActionForward irAMenu(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {

		logger.debug("irAMenu, inicio");
		logger.debug("irAMenu, fin");
		
		return mapping.findForward("irAMenu");
	}
	
	private ArrayList obtenerValores(PlanTarifarioDistListDTO planesTarifarios)
	{
		//String valor="";
		PlanTarifarioDistDTO[] planTarifarioArr = planesTarifarios.getPlanesTarifarios();
		String  plan = "";
		String[] valores = new String[planTarifarioArr.length];
		ArrayList valoresAL = new ArrayList();
		String desPlan = "";
		String codPlan = "";
		for(int i=0;i<planTarifarioArr.length;i++)
		{
			desPlan = planTarifarioArr[i].getDescripcionPlanTarifario();
			codPlan = planTarifarioArr[i].getCodigoPlanTarifario();
			plan = "<tr bgcolor=\"yellow\"><td>codPlan</td><td>"+codPlan+"</td><td>desPlan</td><td>"+desPlan+"</td></tr>";
			valores = obtenerValores(planTarifarioArr[i].getDistribucionBolsa().getBolsa(),plan,valoresAL);
		}
		return valoresAL;
	}
	
	private String[] obtenerValores(BolsaAbonadoDTO[] bolsaCliente, String plan, ArrayList valoresAL)
	{
		String valor="";
		String e = "&nbsp;";
		String esp = e+e+e+e+e+e;
		String [] valores = new String[bolsaCliente.length];
		BolsaAbonadoDTO bolsaAbo = null;
		for(int i=0;i<bolsaCliente.length;i++)
		{
			valores[i] = "";
			if(i==0) valores[i] = plan;
			bolsaAbo = bolsaCliente[i];
			valor = ""+bolsaAbo.getCnt_unidad();
			if(valor.equals("") || valor.equals("0")) valor="-";
				
			//valor = valor.equals("")?"-":valor;
			valores[i]+="<tr><td>"+i+"</td><td>"+esp+bolsaAbo.getNum_abonado() +esp+"</td><td>"+esp+ valor;
			valor = ""+(bolsaAbo).getPrc_unidad();
			if(valor.equals("") || valor.equals("0")) valor="-";
			valores[i]+=esp+"</td><td>"+esp+ valor+"</td></tr>";
			valoresAL.add(valores[i]);
			logger.info("valores Unidad["+i+"]["+valores[i]+"]");
		}
		return valores;
	}
}

