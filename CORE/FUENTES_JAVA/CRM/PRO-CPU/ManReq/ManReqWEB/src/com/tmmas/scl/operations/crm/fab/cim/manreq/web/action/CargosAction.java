package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.dozer.util.mapping.DozerBeanMapper;
import net.sf.dozer.util.mapping.MapperIF;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GedCodigosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GedCodigosListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.FormaPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ParamCargosAbonadoCeroDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.SeccionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.TablaCargosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.TiposDescuentoDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CambiarPlanForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class CargosAction extends BaseAction {
	private final Logger logger = Logger.getLogger(CargosAction.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private final String SIGUIENTE = "cargos";
	private final String RESUMEN = "resumen";
	private final String CONTROL_NAVEGACION = "controlNavegacion";
	private final String INICIO = "inicio";

	protected ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		CargosForm cargosForm = (CargosForm)form;
		RegistroPlanDTO registroPlan=new RegistroPlanDTO();
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		//FlujoNavegacionPag flujoNav=new FlujoNavegacionPag();
		HttpSession session = request.getSession(false);
		session.setAttribute("ultimaPagina","cargos");
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		
		registroPlan=(RegistroPlanDTO)session.getAttribute("registroPlan");	
		String botonSeleccionado = ((CargosForm)form).getBotonSeleccionado(); 

		if(botonSeleccionado!=null && botonSeleccionado.equals("siguiente")){
			CargosForm a= (CargosForm)form;

			//obtener secuencia de venta
			/*
			if(a.getNumVenta()==0  && (a.getRbCiclo().equalsIgnoreCase("NO"))){
				//OBTENER SECUENCIA DE VENTA
				SecuenciaDTO secuencia = new SecuenciaDTO();
				secuencia.setNomSecuencia("GA_SEQ_VENTA");
				
				//REGISTRO DE VENTA
				IngresoVentaDTO venta = new IngresoVentaDTO();
				venta.setNumVenta(delegate.obtenerSecuencia(secuencia).getNumSecuencia());
				venta.setCodCliente(sessionData.getCliente().getCodCliente());
				venta.setNomUsuarioVenta(sessionData.getUsuario());
				venta.setCodModVenta(Integer.parseInt(((CargosForm)form).getCbModPago().trim()));
				venta.setCodCuota(((CargosForm)form).getCbNumCuotas());
				venta.setCodTipDocumento(Integer.parseInt(((CargosForm)form).getCbNumCuotas().trim()));
				a.setNumVenta(venta.getNumVenta());
				delegate.registrarVenta(venta);
			}*/
			

			//Filtrar los seleccionados //CAMBIAR : Validar que los cargos no sean nulos
			//CargosDTO[] cargos = sessionData.getCargosObtenidos().getOcacionales().getCargos();
			//CargosDTO[] cargos = sessionData.getCargosObtenidos().getOcacionales().getCargos()==null?null:sessionData.getCargosObtenidos().getOcacionales().getCargos();
			CargosDTO[] cargos = cargosForm.getCargosMerge()==null?null:cargosForm.getCargosMerge().getCargos();

			 
			
			/*
			List cargosList = new ArrayList();
			for(int i = 0;i<(cargos==null?0:cargos.length);i++){
				if(aplicaCargo(cargos[i].getPrecio().getCodigoConcepto(),cargosForm)){
					cargos[i].setCantidad(1);
					cargosList.add(cargos[i]);
				}
			}
			*/
			
			// Para generar el cargosList compara el codigoConcepto (identificador del registro de cargos) y el valor seleccionado
			List cargosList = new ArrayList();
			String codConcepto=null;
			String codConceptoTabla=null;
			for(int i = 0;i<(cargos==null?0:cargos.length);i++){
				codConcepto=cargos[i].getPrecio().getCodigoConcepto();
				codConcepto=codConcepto==null?"":codConcepto;
				for (int j=0;(cargosForm.getSelectedValorCheck()!=null&&j<cargosForm.getSelectedValorCheck().length);j++){
					codConceptoTabla=cargosForm.getSelectedValorCheck()[j];
					if (codConcepto.equals(codConceptoTabla)){
						cargosList.add(cargos[i]);
					}
				}
			}
			
			
			
			CargosDTO [] cargosAprobados= new CargosDTO[cargosList.size()];
			for(int cont = 0 ; cont<cargosList.size();cont++){
				cargosAprobados[cont] = (CargosDTO)cargosList.get(cont);
			}
			ObtencionCargosDTO obtCargosDTO =new ObtencionCargosDTO();
			obtCargosDTO.setCargos(cargosAprobados);
			//cargosForm.getCargosSeleccionados().setCargos(cargosAprobados);
			cargosForm.setCargosSeleccionados(obtCargosDTO);
			cargosForm.setCbModPago("1"); //contado

			//AplicarDescuentos
			if(cargosForm.getCargosSeleccionados()!=null&&cargosForm.getCargosSeleccionados().getCargos()!=null){
				for(int i = 0 ; i<cargosForm.getCargosSeleccionados().getCargos().length;i++){
					cargosForm.getCargosSeleccionados().getCargos()[i].setDescuento(obtenerDescuentos(cargosForm.getCargosSeleccionados().getCargos()[i].getPrecio().getCodigoConcepto(), cargosForm.getTablaCargos(), cargosForm.getCargosSeleccionados().getCargos()[i].getDescuento()));
				}
			}


			a.setBotonSeleccionado(null);
			session.setAttribute("CargosForm", a);
			CargosForm f = new CargosForm();
			f = a;
			f.setBotonSeleccionado("retrocedio");
			session.setAttribute("CargosForm", f);


			if(a.getCumpleDescuento()!=null&&"SI".equalsIgnoreCase(a.getCumpleDescuento())){
				a.setCumpleDescuento("NO");
				session.setAttribute("cumpleDescuento", "SI");
				
				return mapping.findForward(CONTROL_NAVEGACION);
			}

			if(a.getRbCiclo().equalsIgnoreCase("NO")){
				
				return mapping.findForward(CONTROL_NAVEGACION);
			}
			
			return mapping.findForward(CONTROL_NAVEGACION);
		}
		cargosForm.setCargosSeleccionados(null);
		if(botonSeleccionado!=null && botonSeleccionado.equals("recalcular")&&session.getAttribute("recalculado")!=null&&((String)session.getAttribute("recalculado")).equalsIgnoreCase("NO")){
			session.removeAttribute("CargosForm");
			((CargosForm)form).setBotonSeleccionado("");
			session.setAttribute("CargosForm", form);
			logger.debug("RECALCULAR CARGOS");
			session.setAttribute("recalcular", "SI");
			session.setAttribute("recalculado", "SI");
			
			return mapping.findForward(CONTROL_NAVEGACION);
		}

		if(botonSeleccionado!=null && botonSeleccionado.equals("anterior")){
			CargosForm a= (CargosForm)form;
			a.setBotonSeleccionado(null);
			session.setAttribute("CargosForm", a);	
			logger.debug("DESDE CARGOS AL ANTERIOR");
						
			return mapping.findForward(INICIO);
		}


		UsuarioDTO usuario = new UsuarioDTO();
		usuario.setNombre(sessionData.getUsuario());
		logger.debug("obtenerVendedor():antes");
		UsuarioDTO vendedor = delegate.obtenerVendedor(usuario);
		logger.debug("obtenerVendedor():despues");

		DescuentoVendedorDTO descVend = new DescuentoVendedorDTO();
		descVend.setCodVendedor(vendedor.getCodigo());
		descVend = delegate.obtenerDescuentoVendedor(descVend);
		request.setAttribute("indCreaDesc",String.valueOf(descVend.getIndCreaDescuento()));
		request.setAttribute("rangoInf",String.valueOf(descVend.getRangoInfPorcDescuento()));
		request.setAttribute("rangoSup", String.valueOf(descVend.getRangoSupPorcDescuento())); 
		
		
        //Obtiene cantidad de decimales usados en facturación
		ParametroDTO paramGral = null;
		ParametroDTO param = new ParametroDTO();
		param.setNomParametro(global.getValor("parametro.decimal.facturacion").trim());
		param.setCodModulo(global.getValor("codigo.modulo.GE").trim());
		param.setCodProducto(Integer.parseInt(global.getValor("codigo.producto").trim())); 
		paramGral = delegate.obtenerParametroGeneral(param);
		request.setAttribute("numDecimalesFormulario",paramGral.getValor());
		
		

		//Parámetros para creación de dto para obtención de cargos
		// ParamObtCargOOSSDTO param = (ParamObtCargOOSSDTO) session.getAttribute("paramCargosUsoOOSS");  (--)GS
		//Llamada al obtenerTiposDocumentos
		DocumentoListDTO documentosList;
		BusquedaTiposDocumentoDTO tiposDocumento = new BusquedaTiposDocumentoDTO();
		tiposDocumento.setCodCliente(sessionData.getCliente().getCodCliente());
		documentosList = delegate.obtenerTiposDocumento(tiposDocumento);
		request.setAttribute("documentosList", Arrays.asList(documentosList.getDocumentos()));	    
		((CargosForm)form).setDocumentosList(Arrays.asList(documentosList.getDocumentos()));

		//Llamada al obtenerFormasPago
		BusquedaFormasPagoDTO formasPago = new BusquedaFormasPagoDTO();
		formasPago.setCodCliente(sessionData.getCliente().getCodCliente());
		formasPago.setNumVenta(sessionData.getAbonados()[0].getNumVenta());
		FormaPagoListDTO formaPagoList;
		//formaPagoList = delegate.obtenerFromasPago(formasPago);
		formaPagoList= new FormaPagoListDTO();
		FormaPagoDTO[] formas = new FormaPagoDTO[1];
		FormaPagoDTO formaPago = new FormaPagoDTO();
		formaPago.setTipoValor("1");
		if (registroPlan!=null){
			if (registroPlan.getParamRegistroPlan().getCombinatoria().equalsIgnoreCase("PREPAGOPREPAGO")){
				formaPago.setDescripcionTipoValor("Descuento Saldo");
			}else{
				formaPago.setDescripcionTipoValor("Contado");
			}
		}
		formas[0] = formaPago;
		formaPagoList.setFormasPago(formas);
				
		request.setAttribute("formaPagoList", Arrays.asList(formaPagoList.getFormasPago()));
		((CargosForm)form).setFormaPagoList( Arrays.asList(formaPagoList.getFormasPago()));

		//Obtener tiposDescuento
		request.setAttribute("tipDescuentosList", obtenerTiposDescuentos());
		((CargosForm)form).setTipDescuentosList(obtenerTiposDescuentos());
		//Llamada al obtenerCuotas
		CuotasProductoDTO[] cuotasProducto = null;
		cuotasProducto = delegate.obtenerCuotasProducto();//cuotasProducto[0] = null;
		List lcta = Arrays.asList(cuotasProducto);
		ArrayList cuotasProductoArrList = new ArrayList();
		ordenarCuotas(lcta,cuotasProductoArrList);//pvargas 220708
		
		request.setAttribute("cuotasList", cuotasProductoArrList);//Arrays.asList(cuotasProducto));
		((CargosForm)form).setCuotasList(Arrays.asList(cuotasProducto));

		XMLDefault objetoXML    = new XMLDefault();
		DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
		SeccionDTO seccion=new SeccionDTO();
		objetoXMLSession = sessionData.getDefaultPagina();
		seccion = objetoXML.obtenerSeccion(objetoXMLSession, "cargosPAG", "CondicionesComercialesSS");
		// ---------------------------------------------------------------------------
		// Seteo de controles de formulario
		// ---------------------------------------------------------------------------		
		
		// seteo control habilitado
		if (seccion.obtControl("CargosCicloRB").getHabilitado().equals("SI"))
			request.setAttribute("Hab_CargosCicloRB", "false");
		else
			request.setAttribute("Hab_CargosCicloRB", "true");
		
		// seteo control visible 
		request.setAttribute("Vis_CargosCicloRB", String.valueOf(seccion.obtControl("CargosCicloRB").getVisible()));
		// ---------------------------------------------------------------------------

		String rbCiclo = "";
		if(((CargosForm)form).getRbCiclo()==null){
			rbCiclo = seccion.obtControl("CargosCicloRB").getValorDefecto();
			((CargosForm)form).setRbCiclo(rbCiclo);
		}
		
		if ("SI".equalsIgnoreCase(rbCiclo))//valor defecto es SI, entonces el radio "NO" queda deshabilitado
			request.setAttribute("Hab_CargosCicloRBNO", "true");
		else
			request.setAttribute("Hab_CargosCicloRBNO", "false");
		
		if ("Contado".equalsIgnoreCase(formaPago.getDescripcionTipoValor()))//si formaPago es contado, se oculta select cuotas
			request.setAttribute("Vis_CuotasSO", "NO");//"hidden" <div style="visibility:<%=request.getAttribute("Vis_CuotasSO")%>">
		else
		    request.setAttribute("Vis_CuotasSO", "SI");
			//request.setAttribute("Hab_CuotasSO", "false");
		
			
		
		if (!sessionData.isExistVendUsuario()){
			((CargosForm)form).setRbCiclo("NO");
		}

		
		float total=0;

		
		
		
		ParametrosObtencionCargosDTO paramObtCargos = new ParametrosObtencionCargosDTO();
		paramObtCargos.setTipoPantalla("0");
		
		CambiarPlanForm cambiarPlanForm = (CambiarPlanForm)session.getAttribute("CambiarPlanForm"); 
		paramObtCargos.setAbonados(cambiarPlanForm==null?sessionData.getCodAbonado():sessionData.getCodAbonadosAplicarCargos()==null||sessionData.getCodAbonadosAplicarCargos().length==0?sessionData.getCodAbonado():sessionData.getCodAbonadosAplicarCargos());  // GS
		paramObtCargos.setCodigoClienteOrigen(String.valueOf(sessionData.getCliente().getCodCliente()));
		
		if (sessionData.getCodOrdenServicio()==40008) {
			paramObtCargos.setCodigoClienteDestino(cambiarPlanForm.getCodClienteDestSelec());
		}else{
			paramObtCargos.setCodigoClienteDestino(String.valueOf(sessionData.getCliente().getCodCliente()));
		}
		
		//	ini-Proyecto p-mix-09003 OCB; 	
		paramObtCargos.setNumOsRenova(sessionData.getParamRenova());
		//	fin-Proyecto p-mix-09003 OCB; 
			
		paramObtCargos.setCodigoPlanTarifDestino(cambiarPlanForm!=null?cambiarPlanForm.getCodPlanTarifSelec():null); 
		
		paramObtCargos.setCodigoPlanTarifOrigen(sessionData.getAbonados()[0].getCodPlanTarif());
		paramObtCargos.setCodActabo(sessionData.getCodActAboCargosUso());
		//paramObtCargos.setCodActabo(sessionData.getCodActAbo());
		paramObtCargos.setTipoPantallaPrevio(sessionData.getTipoPantallaPrevia());   //GS
		paramObtCargos.setOrdenServicio(String.valueOf(sessionData.getCodOrdenServicio()));
		paramObtCargos.setCodPlanServ(sessionData.getAbonados()[0].getCodPlanServ());
		paramObtCargos.setCodigoTecnologia(sessionData.getAbonados()[0].getCodTecnologia());
		/*paramObtCargos.setTipoSegOrigen(sessionData.getAbonados()[0].getCodTipPlan());
		paramObtCargos.setTipoSegDestino(cambiarPlanForm.getTipoPlanTarifDestino());*/
		
		
		CambiarPlanForm formCambiarPlan = (CambiarPlanForm)session.getAttribute("CambiarPlanForm");
		if(formCambiarPlan!=null){
			String fecVig = formCambiarPlan.getFecDesdeLlam();
	    	logger.debug("fecVig[" + fecVig + "]");
	    	SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
			try{
				
				Date fechaVigencia = format.parse(fecVig);
				java.sql.Date fechaVigenciaFinal = new java.sql.Date(fechaVigencia.getTime());
				paramObtCargos.setFechaVigenciaAbonadoCero(fechaVigenciaFinal);
			}catch(Exception e){}
		}
				
		ObtencionCargosDTO obtencionCargos = new ObtencionCargosDTO();

		session.setAttribute("recalculado", "NO");
		if(botonSeleccionado!=null && botonSeleccionado.equals("retrocedio")||(session.getAttribute("recalculado")!=null&&((String)session.getAttribute("recalculado")).equalsIgnoreCase("SI"))){
			CargosForm a= (CargosForm)form;
			a.setBotonSeleccionado(null);
			session.setAttribute("CargosForm", a);	
			logger.debug("DESDE ANTERIOR A CARGOS");
			obtencionCargos = sessionData.getCargosObtenidos().getOcacionales()==null?null:sessionData.getCargosObtenidos().getOcacionales(); //GS
			//obtencionCargos = mergeCargos(obtencionCargos, sessionData.getCargosObtenidos()==null?null:sessionData.getCargosObtenidos().getOcacionales());
			session.setAttribute("recalculado", "NO");
			return mapping.findForward(SIGUIENTE);
		}else{
			logger.debug("-------------Datos enviados al obtener cargos---------------");
			logger.debug("Tipo pantalla			:"+paramObtCargos.getTipoPantalla());
			logger.debug("Cliente origen		:"+paramObtCargos.getCodigoClienteOrigen());
			logger.debug("Cliente destino		:"+paramObtCargos.getCodigoClienteDestino());
			logger.debug("Plan tarif destino	:"+paramObtCargos.getCodigoPlanTarifDestino());
			logger.debug("Plan tarif origen		:"+paramObtCargos.getCodigoPlanTarifOrigen());
			logger.debug("Cod actuacion			:"+paramObtCargos.getCodActabo());
			logger.debug("Tipo pantalla previo	:"+paramObtCargos.getTipoPantallaPrevio());
			logger.debug("Orden de Servicio		:"+paramObtCargos.getOrdenServicio());
			logger.debug("Cod plan serv			:"+paramObtCargos.getCodPlanServ());
			logger.debug("Cod tecnologia		:"+paramObtCargos.getCodigoTecnologia());
			logger.debug("Fecha vigencia		:"+paramObtCargos.getFechaVigenciaAbonadoCero());
			logger.debug("Abonados				:");
			
            //INI 72181; COLOMBIA; AVC; 17-12-2008
			
			if (sessionData.getCodOrdenServicio()== 40008) {
				RegistroPlanDTO registroPlanAux = (RegistroPlanDTO)session.getAttribute("registroPlan");
				String tipPlanTarifEmpresa = global.getValor("parametro.tipo.plan.tarifario.empresa");
				
				if (registroPlanAux.getParamRegistroPlan().getTipPlanTarifDestino().equals(tipPlanTarifEmpresa)){
					ParamCargosAbonadoCeroDTO paramCargos = new ParamCargosAbonadoCeroDTO();
					paramCargos.setCodCliente(registroPlanAux.getParamRegistroPlan().getCodClienteDestino());
					boolean isAplicaAbonadoCero = delegate.getValidacionAbonadoCero(paramCargos).isResultado();
					logger.debug("isAplicaAbonadoCero="+isAplicaAbonadoCero);
					if (isAplicaAbonadoCero){//solo envia un abonado a frmcargos
						if (paramObtCargos.getAbonados().length>1){
							String[] abonadosCero = new String[1];
							abonadosCero[0] = paramObtCargos.getAbonados()[0];
							paramObtCargos.setAbonados(abonadosCero);
						}
					}
				}
			}
			
			// FIN 72181; COLOMBIA; AVC; 17-12-2008
			
			for(int i=0; i<paramObtCargos.getAbonados().length;i++)	logger.debug(i+".-"+paramObtCargos.getAbonados()[i]);
			
			//(+)evera 02/08/08
			try{
				logger.debug("-------------------------------------------------------------");			
				obtencionCargos=delegate.obtencionCargos(paramObtCargos);
				logger.debug("-------------Retorno cargos----------------");
				CargosDTO[] cargos = obtencionCargos.getCargos();
				if (cargos==null || cargos.length==0){
					logger.debug("-No se encontraron cargos-");
				}else{
					for(int i=0;i<cargos.length;i++){
						CargosDTO cargo = cargos[i];
						DescuentoDTO[] descuentos = cargo.getDescuento();
						PrecioDTO precio= cargo.getPrecio();
						AtributosCargoDTO atributo=cargo.getAtributo();
						logger.debug("-Cargo "+i+"-");
						logger.debug("idProducto="+cargo.getIdProducto());
						logger.debug("cantidad="+cargo.getCantidad());
						logger.debug("-Precio-");
						logger.debug("monto="+precio.getMonto());
						logger.debug("codigoConcepto="+precio.getCodigoConcepto());
						logger.debug("descripcionConcepto="+precio.getDescripcionConcepto());
						logger.debug("fechaAplicacion="+precio.getFechaAplicacion());
						logger.debug("valorMaximo="+precio.getValorMaximo());
						logger.debug("valorMinimo="+precio.getValorMinimo());
						logger.debug("indicadorAutMan="+precio.getIndicadorAutMan());
						
						if (descuentos==null||descuentos.length==0){
							logger.debug("-No tiene Descuentos-");
						}else{
							for(int j=0;j<descuentos.length;j++){
								DescuentoDTO descuento = descuentos[j];
								logger.debug("-Descuento "+j+"-");
								logger.debug(" monto				:"+descuento.getMonto());
								logger.debug(" tipo					:"+descuento.getTipo());
								logger.debug(" codigoConceptoCargo	:"+descuento.getCodigoConceptoCargo());
								logger.debug(" codigoConcepto		:"+descuento.getCodigoConcepto());
								logger.debug(" descripcionConcepto	:"+descuento.getDescripcionConcepto());
								logger.debug(" minDescuento			:"+descuento.getMinDescuento());
								logger.debug(" maxDescuento			:"+descuento.getMaxDescuento());
								logger.debug(" aprobacion			:"+descuento.isAprobacion());
								logger.debug(" tipoAplicacion		:"+descuento.getTipoAplicacion());
								logger.debug(" montoCalculado		:"+descuento.getMontoCalculado());
								logger.debug(" codigoMoneda			:"+descuento.getCodigoMoneda());
								logger.debug(" numTransaccion		:"+descuento.getNumTransaccion());
								
							}//fin for descuentos
						}
						logger.debug("-Atributos Cargo-");
						logger.debug("recurrente="+atributo.isRecurrente());
						logger.debug("obligatorio="+atributo.isObligatorio());
						logger.debug("cuotas="+atributo.getCuotas());
						logger.debug("fechaAplicacion="+atributo.getFechaAplicacion());
						logger.debug("ciclo="+atributo.isCiclo());
						logger.debug("tipoProducto="+atributo.getTipoProducto());
						logger.debug("claseProducto="+atributo.getClaseProducto());
						logger.debug("cicloFacturacion="+atributo.getCicloFacturacion());
						logger.debug("codigoArticuloServicio="+atributo.getCodigoArticuloServicio());
						logger.debug("numAbonado="+atributo.getNumAbonado());
						
					}//fin for cargos
				}
				logger.debug("-------------------------------------------");
				
				obtencionCargos = mergeCargos(obtencionCargos, sessionData.getCargosObtenidos()==null?null:sessionData.getCargosObtenidos().getOcacionales());
				
				
				//(+) Evera 16/09/08
				/*Eliminar cargo abonado cero repetido*/
				//verificar si viene cargo abonado cero, y dejar solo uno
				if (cambiarPlanForm!= null && cambiarPlanForm.getCodEmpresaDestino()>0){
					GedCodigosListDTO gedCodigosListDTO=new GedCodigosListDTO();
					GedCodigosDTO gedCodigosDTO=new GedCodigosDTO();
					gedCodigosDTO.setCod_modulo(global.getValor("modulo.ge"));
					gedCodigosDTO.setNom_tabla(global.getValor("tabla.fa_conceptos"));
					gedCodigosDTO.setNom_columna(global.getValor("columna.cod_concepto"));
					
					gedCodigosListDTO=delegate.obtenerListaGedCodigos(gedCodigosDTO);
					boolean isExisteGedCodigos=gedCodigosListDTO!=null&&gedCodigosListDTO.getGedCodigosDTO()!=null
					&&gedCodigosListDTO.getGedCodigosDTO().length>0?true:false;
					String codigoConceptoAbonadoCero=null;
					if (isExisteGedCodigos){
						codigoConceptoAbonadoCero=gedCodigosListDTO.getGedCodigosDTO()[0].getCod_valor();
					}
					int contador = 0;
					ArrayList listaCargosTMP = new ArrayList();
					CargosDTO[] cargosTMP = obtencionCargos.getCargos();
					
					for(int i=0;i<cargosTMP.length;i++){
						PrecioDTO precio = cargosTMP[i].getPrecio();
						logger.debug("codigoConcepto="+precio.getCodigoConcepto());
						
						if (!precio.getCodigoConcepto().equals(codigoConceptoAbonadoCero)
								|| (precio.getCodigoConcepto().equals(codigoConceptoAbonadoCero) && contador==0)){
							listaCargosTMP.add(cargosTMP[i]);
						}
						
						if (precio.getCodigoConcepto().equals(codigoConceptoAbonadoCero)) contador++;	
					}//fin for
					
					obtencionCargos.setCargos((CargosDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listaCargosTMP.toArray(), CargosDTO.class));
				}
				//(-)

				
				
			} catch (ManReqException e) {
				String msg="Error al obtener cargos";
				
				if(e.getCodigo()==null || e.getCodigo().equals("0")){
					logger.debug("ERROR (ManReqException) :"+e.getMessage());
					if (e.getMessage()!=null)	msg = e.getMessage();
					
				}else{
					logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
					msg  = e.getDescripcionEvento();
				}
				
				session.setAttribute("mensajeError", msg); //EV
				
			} catch (Exception e) {
				String msg="Error al obtener cargos";
				logger.debug("ERROR (Exception) :"+e.getMessage());
				if (e.getMessage()!=null)	msg = e.getMessage();
				
				session.setAttribute("mensajeError", msg); //EV	
			}
	    	//(-) Evera 02/08/08
			
			//(+) EV
			ObtencionCargosDTO cargosDestino = new ObtencionCargosDTO();
			
			MapperIF mapper = new DozerBeanMapper();
			mapper.map(obtencionCargos, cargosDestino);
			
			
			//cargosForm.setCargosMerge(obtencionCargos);
			cargosForm.setCargosMerge(cargosDestino);
			//(-) 
			
			// GS
			CargosObtenidosDTO cargosObtenidos = new CargosObtenidosDTO();
			cargosObtenidos.setOcacionales(cargosForm.getCargosMerge());
			sessionData.setCargosObtenidos(cargosObtenidos);
			

		}

	ObtencionCargosDTO cargosAgrupados = agruparCargos(obtencionCargos);
		
	TablaCargosDTO[] tablaCargosDTO =null;
	
	//int totalAbonados = sessionData.getCliente().getNumAbonados();
	//int OOSSEmpresa = Integer.parseInt(global.getValor("EMPRESA"));
	
	
	if (cargosAgrupados!=null && cargosAgrupados.getCargos()!=null){ 
		
		tablaCargosDTO = new TablaCargosDTO[cargosAgrupados.getCargos().length];
		String [] valorChecks = new String[cargosAgrupados.getCargos().length];

		for(int i = 0; i<cargosAgrupados.getCargos().length;i++){
			
			/*if (sessionData.getCodOrdenServicio() == OOSSEmpresa){
				cargosAgrupados.getCargos()[i].setCantidad(totalAbonados);
			}*/
		
			tablaCargosDTO[i] = new TablaCargosDTO();
			//tablaCargosDTO[i].setAutManDes(cargosAgrupados.getCargos()[0].getPrecio().getIndicadorAutMan());
			tablaCargosDTO[i].setAutManDes("A"); //revisar porque estaba llegando nulo
			tablaCargosDTO[i].setDescripcion(cargosAgrupados.getCargos()[i].getPrecio().getDescripcionConcepto());
			tablaCargosDTO[i].setCantidad(String.valueOf(cargosAgrupados.getCargos()[i].getCantidad()));
			tablaCargosDTO[i].setImporteTotal(String.valueOf(cargosAgrupados.getCargos()[i].getPrecio().getMonto()*cargosAgrupados.getCargos()[i].getCantidad()));
			tablaCargosDTO[i].setImporteTotalOriginal(String.valueOf(cargosAgrupados.getCargos()[i].getPrecio().getMonto()));
			
			tablaCargosDTO[i].setMoneda(cargosAgrupados.getCargos()[i].getPrecio().getUnidad().getDescripcion());
			tablaCargosDTO[i].setCodConcepto(cargosAgrupados.getCargos()[i].getPrecio().getCodigoConcepto());
			if(cargosAgrupados.getCargos()[i].getDescuento()!=null&&cargosAgrupados.getCargos()[i].getDescuento()[0]!=null){
				tablaCargosDTO[i].setCodConceptoDescuento(cargosAgrupados.getCargos()[i].getDescuento()[0].getCodigoConcepto());
				logger.debug("COD CONCEPTO DESCUENTO :" +tablaCargosDTO[i].getCodConceptoDescuento());
			}
			String tipDescuento;
			String tipoDescuentoAplicar;
			if(cargosAgrupados.getCargos()[i]!=null && cargosAgrupados.getCargos()[i].getDescuento() !=null &&cargosAgrupados.getCargos()[i].getDescuento()[0]!=null&& cargosAgrupados.getCargos()[i].getDescuento()[0].getTipo()!=null){
				tipDescuento = cargosAgrupados.getCargos()[i].getDescuento()[0].getTipo();//Esto siempre es 1 debido a q es automático.
				tipDescuento=tipDescuento==null?"":tipDescuento;
				tipoDescuentoAplicar=cargosAgrupados.getCargos()[i].getDescuento()[0].getTipoAplicacion();
				tipoDescuentoAplicar=tipoDescuentoAplicar==null?"":tipoDescuentoAplicar;
				logger.debug("Tipo de Descuento Automatico en el cargo  "+i+" : "+tipoDescuentoAplicar);
				if(tipoDescuentoAplicar.equalsIgnoreCase("0")){
					tipoDescuentoAplicar = "Monto";
				}else if (tipoDescuentoAplicar.equalsIgnoreCase("1")){
					tipoDescuentoAplicar = "Porcentaje";
				}
			}else{
				tipoDescuentoAplicar="N/A";
			}
			tablaCargosDTO[i].setTipoDescuentoAut(tipoDescuentoAplicar);
			
			String descuentoUnit;
			if(cargosAgrupados.getCargos()[i]!=null && cargosAgrupados.getCargos()[i].getDescuento()!=null &&cargosAgrupados.getCargos()[i].getDescuento()[0]!=null){
				descuentoUnit=String.valueOf(cargosAgrupados.getCargos()[i].getDescuento()[0].getMonto());
			}else{
				descuentoUnit="0";
			}
			tablaCargosDTO[i].setDescuentoUnitarioAut(descuentoUnit);

			valorChecks[i]=String.valueOf(i);
			String saldo="0";
			
			
			float cantDescUnit = descuentoUnit==null?0:Float.parseFloat(descuentoUnit);
			float impTotal = tablaCargosDTO[i].getImporteTotal()==null?0:Float.parseFloat(tablaCargosDTO[i].getImporteTotal());
			
			if(tipoDescuentoAplicar.equals("Monto")){
				saldo = String.valueOf(impTotal-cantDescUnit);
			}else if(tipoDescuentoAplicar.equals("Porcentaje")){
				saldo = String.valueOf((impTotal-(impTotal/100)*cantDescUnit));
			}else{
				saldo = String.valueOf(impTotal);
			}
			tablaCargosDTO[i].setSaldo(saldo);
			total = total + Float.parseFloat(saldo);
			tablaCargosDTO[i].setValorCheck(String.valueOf(i));

		}
		ArrayList listaCheckSeleccionados = new ArrayList();
		for(int i = 0; i<tablaCargosDTO.length;i++){
			if("A".equalsIgnoreCase(tablaCargosDTO[i].getAutManDes())){
				listaCheckSeleccionados.add(String.valueOf(tablaCargosDTO[i].getCodConcepto()));
			}
		}
		//String [] checks = new String[tablaCargosDTO.length];
		/*for(int i = 0; i<tablaCargosDTO.length;i++){
			checks[i]=(String)listaCheckSeleccionados.get(i);
		}*/
		String [] checks = new String[listaCheckSeleccionados.size()];
		for(int i = 0; i<listaCheckSeleccionados.size();i++){
			checks[i]=(String)listaCheckSeleccionados.get(i);
		}
		

		((CargosForm)form).setSelectedValorCheck(checks);
		((CargosForm)form).setTotal(String.valueOf(total));
		((CargosForm)form).setTablaCargos(tablaCargosDTO);
		
	}//fin if (cargosAgrupados!=null){
	

	if( (sessionData.getSinCondicionesComerciales()!=null && sessionData.getSinCondicionesComerciales().equalsIgnoreCase("SI")) // GS 
		|| (tablaCargosDTO == null ||tablaCargosDTO.length == 0)){  //EV
			session.setAttribute("primeraPagina", "negocio");

			int totalCargos = (tablaCargosDTO==null?0:tablaCargosDTO.length);
			
			logger.debug("Total Cargos=" + totalCargos);
			
			//DANIEL SAGREDO: Sábado 10-11
			//sessionData.getCargosObtenidos().setOcacionales(cargosForm.getCargosMerge()); 
			
			// GS
			CargosObtenidosDTO cargosObtenidos = new CargosObtenidosDTO();
			cargosObtenidos.setOcacionales(cargosForm.getCargosMerge());
			sessionData.setCargosObtenidos(cargosObtenidos);
			
			//(+)EV 02/08/08
			//return mapping.findForward(RESUMEN);
			if (session.getAttribute("mensajeError")==null){
				return mapping.findForward(RESUMEN);
			}
			else{
				return mapping.findForward(SIGUIENTE);
			}
			//(-)
			
			
		}

		logger.debug("execute():end");
		session.setAttribute("recalculado", "NO");
		return mapping.findForward(SIGUIENTE);
	}

	private void ordenarCuotas(List lcta, ArrayList cuotasProductoArrList) {
		logger.debug("ordenarCuotas -------------------------------------------------->");
		List lctaswap = new ArrayList();//hm.remove(n
		if(lcta == null) {logger.debug("----NULL NULL NULL---------ordenarCuotas: Lista de cuotas NULL --------------");}
		if(lcta.size()== 1)
		{	
			cuotasProductoArrList.add((CuotasProductoDTO)lcta.get(0));
		}
		else
		{
			int indiceMenor = buscaIndiceDeMenor(lcta);
			CuotasProductoDTO cuotaMenorProductoDTO = (CuotasProductoDTO)lcta.get(indiceMenor);
			//imprimeCuota(cuotaMenorProductoDTO);
			cuotasProductoArrList.add(cuotaMenorProductoDTO);
			for(int i=0;i<lcta.size();i++)
			{
				if(!(i == indiceMenor)) lctaswap.add(lcta.get(i));
			}//lcta.remove(cuotasProductoDTO); <-- no funcionó
			ordenarCuotas(lctaswap,cuotasProductoArrList);
		}
	}

	private int buscaIndiceDeMenor(List lcta) {
		int indiceDeMenor = 0;
		int numeroCuotas ;
		try
		{
			logger.debug("lcta.lensizegth "+lcta.size());
			numeroCuotas = ((CuotasProductoDTO)lcta.get(0)).getNum_cuotas();
			for(int i=1;i<lcta.size();i++)
			{ //System.out.println("cuotasProducto[i].getNum_cuotas() "+((CuotasProductoDTO)lcta.get(i)).getNum_cuotas() +"< numeroCuotas "+numeroCuotas);
				if(((CuotasProductoDTO)lcta.get(i)).getNum_cuotas() < numeroCuotas)
				{
					//System.out.println(((CuotasProductoDTO)lcta.get(i)).getNum_cuotas()+" < "+numeroCuotas);
					numeroCuotas = ((CuotasProductoDTO)lcta.get(i)).getNum_cuotas();
					indiceDeMenor = i;
				}
			}
		}
		catch(Exception e)
		{
			logger.debug("Exception buscaIndiceDeMenor "+e.getMessage());
		}

		return indiceDeMenor;
	}
	
	private List obtenerTiposDescuentos(){
		TiposDescuentoDTO[] tipDesc= new TiposDescuentoDTO[3];
		tipDesc[0] = new TiposDescuentoDTO();
		tipDesc[0].setCodTipoDescuento(String.valueOf(2));
		tipDesc[0].setDescTipoDescuento("");
		tipDesc[1] = new TiposDescuentoDTO();
		tipDesc[1].setCodTipoDescuento(String.valueOf(0));
		tipDesc[1].setDescTipoDescuento("Monto");
		tipDesc[2] = new TiposDescuentoDTO();
		tipDesc[2].setCodTipoDescuento(String.valueOf(1));
		tipDesc[2].setDescTipoDescuento("Porcentaje");
		return Arrays.asList(tipDesc);
	}

	/**
	 * @param cargosNuevos Cargos obtenidos desde el método 
	 * @param cargosSession Cargos obtenidos desde la sesión
	 * @return ObtencionCargosDTO que contiene cargosNuevos y cargosSession como un unico dto
	 */
	private ObtencionCargosDTO mergeCargos(ObtencionCargosDTO cargosNuevos, ObtencionCargosDTO cargosSession){

		if(cargosSession == null||cargosSession.getCargos()==null||cargosSession.getCargos().length==0){
			return cargosNuevos;
		}

		if(cargosNuevos.getCargos()==null||cargosNuevos.getCargos().length==0){
			return cargosSession;
		}

		ArrayList cargos = new ArrayList();
		cargos.addAll(Arrays.asList(cargosNuevos.getCargos()));
		cargos.addAll(Arrays.asList(cargosSession.getCargos()));

		CargosDTO[] cargosMerge = new CargosDTO[cargos.size()];
		for(int f = 0; f<cargos.size();f++){
			cargosMerge[f] = new CargosDTO();
			cargosMerge[f] = (CargosDTO)cargos.get(f);
		}
		cargosSession.setCargos(cargosMerge);
		return cargosSession;
	}

	private ObtencionCargosDTO agruparCargos(ObtencionCargosDTO obt){
		ObtencionCargosDTO cargosObt = new ObtencionCargosDTO();
		List cargos = new ArrayList();
		if (obt!=null&&obt.getCargos()!=null&&obt.getCargos().length!=0){
			for(int i = 0; i<obt.getCargos().length;i++){
				if(obt.getCargos()[i].getPrecio()!=null&&obt.getCargos()[i].getPrecio().getCodigoConcepto()!=null){
					int existeCargo = existeCodConcepto(obt.getCargos()[i].getPrecio().getCodigoConcepto(), cargos);
					if(existeCargo==-1){
						cargos.add(obt.getCargos()[i]);
					}else{
						((CargosDTO)cargos.get(existeCargo)).setCantidad(((CargosDTO)cargos.get(existeCargo)).getCantidad()+1);
					}
				}

			}
		}

		if(cargos.size()!=0){
			Iterator iterator = cargos.iterator();
			CargosDTO[]x= new CargosDTO[cargos.size()];
			for(int a = 0;iterator.hasNext();a++){
				x[a]= (CargosDTO)iterator.next();
			}
			cargosObt.setCargos(x);
		}

		return cargosObt;
	}

	private int existeCodConcepto(String codConcepto, List cargos){
		for(int i = 0; i<cargos.size();i++){
			if(codConcepto.equalsIgnoreCase(((CargosDTO)cargos.get(i)).getPrecio().getCodigoConcepto())){
				return i;
			}
		}
		return -1;
	}

	public boolean aplicaCargo(String codConcepto, CargosForm cargosForm){
		TablaCargosDTO[] tablaCargos = cargosForm.getTablaCargos();
		String checks[] = cargosForm.getSelectedValorCheck();
		if(tablaCargos!=null&&tablaCargos.length>0){
			if(checks!=null&&checks.length>0){
				for(int x = 0;x<checks.length;x++){
					for(int i = 0 ; i<tablaCargos.length; i++){
						if(checks[i].equalsIgnoreCase(tablaCargos[x].getValorCheck())){
							return true;
						}
					}
				}
			}else{
				return false;
			}
		}else{
			return false;
		}
		return false;
	}

	public DescuentoDTO[] obtenerDescuentos(String codConcepto, TablaCargosDTO []tablaCargos, DescuentoDTO[] arregloDescuentos) throws Exception{
		boolean yaEntro = false;
		DescuentoDTO[] retorno=null;
		DescuentoDTO descuentoNuevo = new DescuentoDTO();
		for(int i = 0; i<tablaCargos.length;i++){
			if(tablaCargos[i].getCodConcepto().equalsIgnoreCase(codConcepto) && 
					(tablaCargos[i].getDescuentoUnitarioMan()!=null 
							&& !tablaCargos[i].getDescuentoUnitarioMan().trim().equals("") ) ){
				yaEntro=true;
				//descuentoNuevo.setCodigoConcepto(tablaCargos[i].getTipoDescuentoManual());
				//descuentoNuevo.setCodigoConceptoCargo(codConcepto);
				//descuentoNuevo.setTipoAplicacion("0"); //?????

				descuentoNuevo.setCodigoConceptoCargo(codConcepto);
				descuentoNuevo.setTipoAplicacion(tablaCargos[i].getTipoDescuentoManual());

				//descuentoNuevo.setTipo("0");
				descuentoNuevo.setTipo(tablaCargos[i].getTipoDescuentoManual());
				
				int cantidad = Integer.parseInt(tablaCargos[i].getCantidad());				
				if("0".equalsIgnoreCase(tablaCargos[i].getTipoDescuentoManual())){ //importe*/
				
					descuentoNuevo.setMonto(Float.parseFloat(tablaCargos[i].getDescuentoUnitarioMan())/cantidad);
					
				}else{//porcentaje
			
					descuentoNuevo.setMonto(Float.parseFloat(tablaCargos[i].getDescuentoUnitarioMan()));
					
				/*	float porcentajeIngresado = Float.parseFloat(tablaCargos[i].getDescuentoUnitarioMan());
					float montoCargo = Float.parseFloat(tablaCargos[i].getImporteTotalOriginal());
					
					descuentoNuevo.setMonto( (porcentajeIngresado * montoCargo)/100 ) ;
					*/
				
				}

				if(arregloDescuentos!= null&&arregloDescuentos.length>0){
					descuentoNuevo.setCodigoConcepto(arregloDescuentos[0].getCodigoConcepto());
					List listaDescuentos = null;
					listaDescuentos = Arrays.asList(arregloDescuentos);
					//listaDescuentos.add(descuentoNuevo);
					
					if(listaDescuentos.size()<=2){
						if(listaDescuentos.size()==1){
							if(((DescuentoDTO) listaDescuentos.get(0)).getTipoAplicacion().equals("1")){
								//retorno = new DescuentoDTO[2];
								retorno = new DescuentoDTO[1];
							}else{
								retorno = new DescuentoDTO[1];
							}
							
						}else if(listaDescuentos.size()==2){
							retorno = new DescuentoDTO[2];
						}else if(listaDescuentos.size()==0){
							retorno = new DescuentoDTO[1];
						}
						
					}else{
						throw new ManReqException("La lista de descuentos contiene más de dos descuentos");
					}
					
					
					int array=0;
					if(listaDescuentos!=null&&listaDescuentos.size()!=0){
						for(int s = 0; s<listaDescuentos.size();s++){
						
							if(((DescuentoDTO) listaDescuentos.get(s)).getTipoAplicacion()!=null&& ((DescuentoDTO) listaDescuentos.get(s)).getTipoAplicacion().equals("1")){
								retorno[array]=(DescuentoDTO) listaDescuentos.get(s);
								array++;
							}
						}
					}
					//retorno[array]=descuentoNuevo;
					retorno[0]=descuentoNuevo;
				}else{
					retorno = new DescuentoDTO[1];

					//Agregar metodo para obtener
					//conceptos de descuento default

					//(+)evera 26/09/2007
					//retorno[0].setCodigoConcepto("447");
					//obtener secuencia de venta
					SecuenciaDTO secuencia = new SecuenciaDTO();
					secuencia.setNomSecuencia("GA_SEQ_TRANSACABO");
					long numSecuencia = delegate.obtenerSecuencia(secuencia).getNumSecuencia();
					DescuentoDTO descuento = new DescuentoDTO();
					descuento.setNumTransaccion(String.valueOf(numSecuencia));
					descuento.setCodigoConceptoCargo(tablaCargos[i].getCodConcepto());
					//inserta concepto en ga_transacabo
					delegate.insertarConceptoDescuento(descuento);
					DatosGeneralesDTO param = new DatosGeneralesDTO();
					param.setSecuencia(numSecuencia);
					//obtiene codigo desde ga_transacabo
					descuento = delegate.obtenerCodConceptoDescuento(param);
					String codigoDef  = descuento.getCodigoConcepto();
					logger.debug("codigoDef=["+codigoDef+"]");

					//elimina registro insertado
					delegate.eliminaCodConceptoDescuento(numSecuencia);

					descuentoNuevo.setCodigoConcepto(codigoDef);
					retorno[0]=descuentoNuevo;
					//(-)evera 26/09/2007					
				}
				
				
			}else if(tablaCargos[i].getCodConcepto().equalsIgnoreCase(codConcepto)){
				if(arregloDescuentos!= null&&arregloDescuentos.length>0){
					//if(arregloDescuentos[0].getTipoAplicacion()!=null&&	arregloDescuentos[0].getTipoAplicacion().equals("0")&&tablaCargos[i].getDescuentoUnitarioMan()!=null&&tablaCargos[i].getDescuentoUnitarioMan().trim().equals("")){
					if(arregloDescuentos[0].getTipoAplicacion()!=null&&tablaCargos[i].getDescuentoUnitarioMan()!=null&&tablaCargos[i].getDescuentoUnitarioMan().trim().equals("")){
						//tablaCargos[i].setDescuentoUnitarioMan(null);
						retorno = null;
					}else{
						retorno = arregloDescuentos;
					}
				}else{
					
					
				}
				
			}
			if(retorno!=null&&yaEntro){
				tablaCargos[i].setCodConceptoDescuento(retorno[0].getCodigoConcepto());
				yaEntro=false;
			}

		}//fin for
	
		return retorno;
	}

}