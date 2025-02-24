package com.tmmas.scl.operations.frmkooss.web.action;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.BaseAction;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.SeccionDTO;
import com.tmmas.scl.framework.commonDoman.dataTransferObject.ValoresJSPPorDefectoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.CuotasProductoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaFormasPagoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BusquedaTiposDocumentoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.DocumentoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.FormaPagoListDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.web.delegate.SuspensionVoluntariaBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cusintman.web.form.SuspensionVoluntariaForm;
import com.tmmas.scl.operations.frmkooss.web.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.frmkooss.web.delegate.FrmkOOSSBussinessDelegate;
import com.tmmas.scl.operations.frmkooss.web.dto.TablaCargosDTO;
import com.tmmas.scl.operations.frmkooss.web.dto.TiposDescuentoDTO;
import com.tmmas.scl.operations.frmkooss.web.form.CargosForm;
import com.tmmas.scl.operations.frmkooss.web.helper.Global;

public class CargosAction extends BaseAction {
	private final Logger logger = Logger.getLogger(CargosAction.class);
	private Global global = Global.getInstance();
	private FrmkOOSSBussinessDelegate delegate = FrmkOOSSBussinessDelegate.getInstance();
	private SuspensionVoluntariaBussinessDelegate delegateSS= SuspensionVoluntariaBussinessDelegate.getInstance();
	private final String SIGUIENTE = "cargos";
	private final String RESUMEN = "resumen";
	private final String CONTROL_NAVEGACION = "controlNavegacion";
	//private final String INICIO = "inicio";
	private String textoMensajeRestricciones;

	protected ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response) throws Exception {

		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		logger.debug("execute():start");
		CargosForm cargosForm = (CargosForm)form;
		ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		//FlujoNavegacionPag flujoNav=new FlujoNavegacionPag();
		HttpSession session = request.getSession(false);
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		String botonSeleccionado = ((CargosForm)form).getBotonSeleccionado(); 
		ObtencionCargosDTO obtencionCargos = new ObtencionCargosDTO (); 

		SuspensionVoluntariaForm suspensionVoluntariaForm = (SuspensionVoluntariaForm)session.getAttribute("suspensionVoluntariaForm");
		
		if(botonSeleccionado!=null && botonSeleccionado.equals("siguiente")){
			CargosForm a= (CargosForm)form;

			//obtener secuencia de venta
			
			if((a.getNumVenta()==0)&&"NO".equals(a.getRbCiclo())){
				//OBTENER SECUENCIA DE VENTA
				SecuenciaDTO secuencia = new SecuenciaDTO();
				secuencia.setNomSecuencia("GA_SEQ_VENTA");
				
				//REGISTRO DE VENTA
				IngresoVentaDTO venta = new IngresoVentaDTO();
				venta.setNumVenta(delegate.obtenerSecuencia(secuencia).getNumSecuencia());
				venta.setCodCliente(sessionData.getCliente().getCodCliente());
				venta.setNomUsuarioVenta(sessionData.getUsuario());
				venta.setCodModVenta(1);
				venta.setCodCuota(null);
				venta.setCodTipDocumento(Integer.parseInt(((CargosForm)form).getCbNumCuotas().trim()));

				a.setNumVenta(venta.getNumVenta());
				delegate.registrarVenta(venta);
			}
			

			//Filtrar los seleccionados //CAMBIAR : Validar que los cargos no sean nulos
			//CargosDTO[] cargos = sessionData.getCargosObtenidos().getOcacionales().getCargos();
			//CargosDTO[] cargos = sessionData.getCargosObtenidos().getOcacionales().getCargos()==null?null:sessionData.getCargosObtenidos().getOcacionales().getCargos();
			CargosDTO[] cargos = cargosForm.getCargosMerge()==null?null:cargosForm.getCargosMerge().getCargos();

			 
			
			
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
				
				
				
				/*if(aplicaCargo(cargos[i].getPrecio().getCodigoConcepto(),cargosForm)){
					cargosList.add(cargos[i]);
				}*/
			}
			CargosDTO [] cargosAprobados= new CargosDTO[cargosList.size()];
			for(int cont = 0 ; cont<cargosList.size();cont++){
				cargosAprobados[cont] = (CargosDTO)cargosList.get(cont);
			}
			ObtencionCargosDTO obtCargosDTO =new ObtencionCargosDTO();
			obtCargosDTO.setCargos(cargosAprobados);
			//cargosForm.getCargosSeleccionados().setCargos(cargosAprobados);
			cargosForm.setCargosSeleccionados(obtCargosDTO);


			//AplicarDescuentos
			if(cargosForm.getCargosSeleccionados()!=null&&cargosForm.getCargosSeleccionados().getCargos()!=null){
				for(int i = 0 ; i<cargosForm.getCargosSeleccionados().getCargos().length;i++){
					String concCargoSelec=cargosForm.getCargosSeleccionados().getCargos()[i].getPrecio().getCodigoConcepto();
					concCargoSelec=concCargoSelec==null?"":concCargoSelec;
					for(int j=0;j<cargosForm.getTablaCargos().length;j++){
						String codConcepTabla=cargosForm.getTablaCargos()[j].getCodConcepto();
						codConcepTabla=codConcepTabla==null?"":codConcepTabla;
						if (concCargoSelec.equals(codConcepTabla)){
							String impTotalOrg= cargosForm.getTablaCargos()[j].getImporteTotalOriginal();
							impTotalOrg=impTotalOrg==null?"0.0":impTotalOrg;
							String saldo=cargosForm.getTablaCargos()[j].getSaldo();
							saldo=saldo==null?"0.0":saldo;
							
							if (!saldo.equals(impTotalOrg)){
								cargosForm.getCargosSeleccionados().getCargos()[i].setDescuento(obtenerDescuentos(cargosForm.getCargosSeleccionados().getCargos()[i].getPrecio().getCodigoConcepto(), cargosForm.getTablaCargos(), cargosForm.getCargosSeleccionados().getCargos()[i].getDescuento()));
							}
						}
					}
				}
			}


			a.setBotonSeleccionado(null);
			session.setAttribute("CargosForm", a);
			CargosForm f = new CargosForm();
			f = a;
			f.setBotonSeleccionado("retrocedio");
			session.setAttribute("CargosForm", f);
			boolean existCargosSeleccionados=cargosForm.getCargosSeleccionados()==null||cargosForm.getCargosSeleccionados().getCargos()==null||cargosForm.getCargosSeleccionados().getCargos().length==0?false:true;
			UsuarioAbonadoDTO usuarioAbonadoDTO= new UsuarioAbonadoDTO();
			usuarioAbonadoDTO=(UsuarioAbonadoDTO)session.getAttribute("usuarioAbonado");
			String desTipContrato=usuarioAbonadoDTO.getDes_tipcontrato();
			desTipContrato=desTipContrato==null?"":desTipContrato;
			//if (!existCargosSeleccionados||"PREPAGO".equalsIgnoreCase(desTipContrato)){
			if (!existCargosSeleccionados){
				return  mapping.findForward(RESUMEN);
			}


			if(a.getCumpleDescuento()!=null&&"SI".equalsIgnoreCase(a.getCumpleDescuento())){
				a.setCumpleDescuento("NO");
				session.setAttribute("cumpleDescuento", "SI");
				session.setAttribute("ultimaPagina","cargos");
				return mapping.findForward(CONTROL_NAVEGACION);
			}

			if(a.getRbCiclo().equalsIgnoreCase("NO")){
				session.setAttribute("ultimaPagina","cargos");
				return mapping.findForward(CONTROL_NAVEGACION);
			}
			session.setAttribute("ultimaPagina","cargos");
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
			session.setAttribute("ultimaPagina","cargos");
			return mapping.findForward(CONTROL_NAVEGACION);
		}

		if(botonSeleccionado!=null && botonSeleccionado.equals("anterior")){
			CargosForm a= (CargosForm)form;
			a.setBotonSeleccionado(null);
			session.setAttribute("CargosForm", a);	
			logger.debug("DESDE CARGOS AL ANTERIOR");
			String ultpag = (String)session.getAttribute("ultimaPagina");
			ultpag = ultpag==null||"".equals(ultpag)?"cargos":ultpag;
			session.setAttribute("ultimaPagina", ultpag);
			sessionData.setObtenerCargos("NO");
			return mapping.findForward(CONTROL_NAVEGACION);
		}


		UsuarioDTO usuario = new UsuarioDTO();
		usuario.setNombre(sessionData.getUsuario());
		logger.debug("obtenerVendedor():antes");
		UsuarioDTO vendedor = delegate.obtenerVendedor(usuario);
		session.setAttribute("vendedor", vendedor);
		logger.debug("obtenerVendedor():despues");

		DescuentoVendedorDTO descVend = new DescuentoVendedorDTO();
		descVend.setCodVendedor(vendedor.getCodigo());
		descVend = delegate.obtenerDescuentoVendedor(descVend);
		request.setAttribute("indCreaDesc",String.valueOf(descVend.getIndCreaDescuento()));
		request.setAttribute("rangoInf",String.valueOf(descVend.getRangoInfPorcDescuento()));
		request.setAttribute("rangoSup", String.valueOf(descVend.getRangoSupPorcDescuento()));
		
        //Obtiene cantidad de decimales usados en facturaci�n
		ParametroDTO paramGral = null;
		ParametroDTO param = new ParametroDTO();
		param.setNomParametro(global.getValor("parametro.decimal.facturacion").trim());
		param.setCodModulo(global.getValor("codigo.modulo.GE").trim());
		param.setCodProducto(Integer.parseInt(global.getValor("codigo.producto").trim())); 
		paramGral = delegate.obtenerParametroGeneral(param);
		request.setAttribute("numDecimalesFormulario",paramGral.getValor());
		

		//Par�metros para creaci�n de dto para obtenci�n de cargos
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
		
		long numeroDeVenta = 0;
		if(sessionData!=null&&
		   sessionData.getAbonados()!=null&&
		   sessionData.getAbonados().length!=0&&
		   sessionData.getAbonados()[0].getNumVenta()!=0)
			{
				numeroDeVenta=sessionData.getAbonados()[0].getNumVenta();
			}else{
				SecuenciaDTO secuencia = new SecuenciaDTO();
				secuencia.setNomSecuencia("GA_SEQ_VENTA");
				numeroDeVenta = delegate.obtenerSecuencia(secuencia).getNumSecuencia();
			}
		
		formasPago.setNumVenta(numeroDeVenta);
		FormaPagoListDTO formaPagoList;
		formaPagoList = delegate.obtenerFromasPago(formasPago);
		
		request.setAttribute("formaPagoList", Arrays.asList(formaPagoList.getFormasPago()));
		((CargosForm)form).setFormaPagoList( Arrays.asList(formaPagoList.getFormasPago()));

		//Obtener tiposDescuento
		request.setAttribute("tipDescuentosList", obtenerTiposDescuentos());
		((CargosForm)form).setTipDescuentosList(obtenerTiposDescuentos());
		//Llamada al obtenerCuotas
		CuotasProductoDTO[] cuotasProducto = null;
		cuotasProducto = delegate.obtenerCuotasProducto();

		
		request.setAttribute("cuotasList", Arrays.asList(cuotasProducto));
		((CargosForm)form).setCuotasList(Arrays.asList(cuotasProducto));

		
		
		
		XMLDefault objetoXML    = new XMLDefault();
		ValoresJSPPorDefectoDTO objetoXMLSession = new ValoresJSPPorDefectoDTO();
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

		/*if(((CargosForm)form).getRbCiclo()==null)
			((CargosForm)form).setRbCiclo(seccion.obtControl("CargosCicloRB").getValorDefecto());
		
		if (!sessionData.isExistVendUsuario()){
			//((CargosForm)form).setRbCiclo("NO");
		}*/
		((CargosForm)form).setRbCiclo("SI");

		float total=0;

		
		Object cambiarPlanForm = session.getAttribute("CambiarPlanForm"); //REVISAR !!!!!!!!!!!!!!!!
		
		ParametrosObtencionCargosDTO paramObtCargos = new ParametrosObtencionCargosDTO();
		paramObtCargos.setTipoPantalla("0");

		
		//Abonados a los que se les aplicar�n cargos
		String [] abonadosAplicCargos = null;
		if(cambiarPlanForm==null){
			abonadosAplicCargos = sessionData.getCodAbonado();
		}else if(sessionData.getCodAbonadosAplicarCargos()==null||
			   sessionData.getCodAbonadosAplicarCargos().length==0)	
			{
				abonadosAplicCargos = sessionData.getCodAbonado();
			}else{
				abonadosAplicCargos = sessionData.getCodAbonadosAplicarCargos();
			}
		if(abonadosAplicCargos==null||abonadosAplicCargos.length==0){
			abonadosAplicCargos = new String[1];
			abonadosAplicCargos[0]=String.valueOf(sessionData.getAbonados()[0].getNumAbonado());
			paramObtCargos.setAbonados(abonadosAplicCargos);
		}
			//paramObtCargos.setAbonados(cambiarPlanForm==null?sessionData.getCodAbonado():sessionData.getCodAbonadosAplicarCargos()==null||sessionData.getCodAbonadosAplicarCargos().length==0?sessionData.getCodAbonado():sessionData.getCodAbonadosAplicarCargos());	
		paramObtCargos.setAbonados(abonadosAplicCargos);
		
		paramObtCargos.setCodigoClienteOrigen(String.valueOf(sessionData.getCliente().getCodCliente()));
		paramObtCargos.setCodigoClienteDestino(String.valueOf(sessionData.getCliente().getCodCliente()));   //GS

		paramObtCargos.setCodigoPlanTarifDestino(cambiarPlanForm!=null?sessionData.getCodPlanTarifSelec():null); //CORREGIR!!

		String codPlanTarifOrig = null;
		if(sessionData.getAbonados()!=null&&
		   sessionData.getAbonados().length!=0&&
		   sessionData.getAbonados()[0].getCodPlanTarif()!=null)
		{
			codPlanTarifOrig = sessionData.getAbonados()[0].getCodPlanTarif();
		}

		paramObtCargos.setCodigoPlanTarifOrigen(codPlanTarifOrig);
		paramObtCargos.setCodActabo(sessionData.getCodActAboCargosUso());
		//paramObtCargos.setCodActabo(sessionData.getCodActAbo());
		paramObtCargos.setTipoPantallaPrevio("2");   //GS
		paramObtCargos.setOrdenServicio(String.valueOf(sessionData.getCodOrdenServicio()));
		paramObtCargos.setCodPlanServ(sessionData.getAbonados()[0].getCodPlanServ());
		
		
		paramObtCargos.setCodCausaCambioPlan("Act/Desc Servicios Suplementarios");

		logger.debug("DATOS ENVIADOS AL OBTENER CARGOS");
		logger.debug("TIPO PANTALLA       ["+paramObtCargos.getTipoPantalla()+"]");
		logger.debug("ABONADOS            ["+paramObtCargos.getAbonados()+"]");
		logger.debug("CLIENTE ORIGEN      ["+paramObtCargos.getCodigoClienteOrigen()+"]");
		logger.debug("CLIENTE DESTINO     ["+paramObtCargos.getCodigoClienteDestino()+"]");
		logger.debug("PLAN TARIF ORIGEN   ["+paramObtCargos.getCodigoPlanTarifOrigen()+"]");
		logger.debug("COD ACTUACION       ["+paramObtCargos.getCodActabo()+"]");
		logger.debug("TIPO PANTALLA PREVIO["+paramObtCargos.getTipoPantallaPrevio()+"]");
		logger.debug("Orden de Servicio   ["+paramObtCargos.getOrdenServicio()+"]");
		logger.debug("COD.PLAN.SERV.      ["+paramObtCargos.getCodPlanServ()+"]");
		logger.debug("CAUSA CAMBIO SIMCARD["+paramObtCargos.getCodCausaCambioPlan()+"]");
		

		/**
		 * @author rlozano
		 * @description Se debe instanciar solo al momento de cargar los cargos ---> pantalla de inicio hacia pantalla de cargos
		 * @param ObtencionCargosDTO obtencionCargos = new ObtencionCargosDTO();
		 */
		session.setAttribute("recalculado", "NO");
		if(botonSeleccionado!=null && botonSeleccionado.equals("retrocedio")){
			CargosForm a= (CargosForm)form;
			a.setBotonSeleccionado(null);
			session.setAttribute("CargosForm", a);	
			logger.debug("DESDE ANTERIOR A CARGOS");
			obtencionCargos = sessionData.getCargosObtenidos().getOcacionales()==null?null:sessionData.getCargosObtenidos().getOcacionales(); //GS
			//obtencionCargos = mergeCargos(obtencionCargos, sessionData.getCargosObtenidos()==null?null:sessionData.getCargosObtenidos().getOcacionales());
			String tipoDescuentoAplicar;
			for (int k=0;k<obtencionCargos.getCargos().length;k++)
			{
				for (int i=0;(obtencionCargos.getCargos()[k].getDescuento()!=null&&i<obtencionCargos.getCargos()[k].getDescuento().length);i++){
					DescuentoDTO descuento  = obtencionCargos.getCargos()[k].getDescuento()[i];
					tipoDescuentoAplicar = descuento.getTipoAplicacion();
					if(tipoDescuentoAplicar.equalsIgnoreCase("0")){
						tipoDescuentoAplicar = "Monto";
					}else if (tipoDescuentoAplicar.equalsIgnoreCase("1")){
						tipoDescuentoAplicar = "Porcentaje";
					}
					else{
						tipoDescuentoAplicar = "N/A";
					}
					obtencionCargos.getCargos()[k].getDescuento()[i].setTipoAplicacion(tipoDescuentoAplicar);
				}
			}
			cargosForm.setCargosMerge(obtencionCargos);
			return mapping.findForward(SIGUIENTE);
		}else{
			try{
				logger.debug("delegate.obtencionCargos ini");
				obtencionCargos=delegate.obtencionCargos(paramObtCargos);
				logger.debug("delegate.obtencionCargos fin");
				if(obtencionCargos!=null && obtencionCargos.getCargos()!=null && obtencionCargos.getCargos().length>0)
				{
					logger.debug("obtencionCargos, numero de cargos obtenidos["+obtencionCargos.getCargos().length+"]");
				}else{
					logger.debug("obtencionCargos, no hay cargos obtenidos");
				}
				obtencionCargos = mergeCargos(obtencionCargos, sessionData.getCargosObtenidos()==null?null:sessionData.getCargosObtenidos().getOcacionales());
				cargosForm.setCargosMerge(obtencionCargos);
			}
			catch(Exception e){
				delegateSS.guardaMensajesError(request, "Error en el M�dulo de Cargos", loadCargosError(suspensionVoluntariaForm));
				logger.debug("Exception "+e.getMessage());
				String loge = StackTraceUtl.getStackTrace(e);
				logger.debug("Exception[" + loge + "]");
				return mapping.findForward("error");
			}
			
			// GS
			CargosObtenidosDTO cargosObtenidos = new CargosObtenidosDTO();
			cargosObtenidos.setOcacionales(cargosForm.getCargosMerge());
			if (cargosObtenidos==null||cargosObtenidos.getOcacionales()==null||cargosObtenidos.getOcacionales().getCargos().length==0){
				return  mapping.findForward(RESUMEN);
			}
			
			/***
			 * @author rlozano
			 * @description : evaluar ! : se debe dejar checkados e inhabilitados los cargos Automaticos al momento de cargar la pagina
			 */
			/*String indicaAutoOManual;
			String codConceptoCargo="";
			List listaCargosAut=new ArrayList();
			List listCargos=new ArrayList();
			for (int j=0;j<obtencionCargos.getCargos().length;j++){
				indicaAutoOManual=obtencionCargos.getCargos()[j].getPrecio().getIndicadorAutMan();
				indicaAutoOManual=indicaAutoOManual==null?"":indicaAutoOManual.trim();
				codConceptoCargo=obtencionCargos.getCargos()[j].getPrecio().getCodigoConcepto();
				codConceptoCargo=codConceptoCargo==null?"":codConceptoCargo.trim();
				if ("A".equalsIgnoreCase(indicaAutoOManual)){
					listaCargosAut.add(codConceptoCargo);
				}
				listCargos.add(codConceptoCargo);
			}
			if (listaCargosAut.size()>0){
				String [] cargosAut=null;
				cargosAut=(String[])ArrayUtl.copiaArregloTipoEspecifico(listaCargosAut.toArray(), String.class);
				cargosForm.setSelectedValorCheck(cargosAut);
				
				String [] listCargosForm=null;
				listCargosForm=(String[])ArrayUtl.copiaArregloTipoEspecifico(listCargos.toArray(), String.class);
				cargosForm.setListaCargos(listCargosForm);
				
			}*/
			sessionData.setCargosObtenidos(cargosObtenidos);
		}

		ObtencionCargosDTO cargosAgrupados = agruparCargos(obtencionCargos);
		
	TablaCargosDTO[] tablaCargosDTO =null;
	if (cargosAgrupados!=null && cargosAgrupados.getCargos()!=null){ 
		
		tablaCargosDTO = new TablaCargosDTO[cargosAgrupados.getCargos().length];
		String [] valorChecks = new String[cargosAgrupados.getCargos().length];

		for(int i = 0; i<cargosAgrupados.getCargos().length;i++){
			tablaCargosDTO[i] = new TablaCargosDTO();
			tablaCargosDTO[i].setAutManDes(cargosAgrupados.getCargos()[i].getPrecio().getIndicadorAutMan());
			tablaCargosDTO[i].setDescripcion(cargosAgrupados.getCargos()[i].getPrecio().getDescripcionConcepto());
			tablaCargosDTO[i].setCantidad(String.valueOf(cargosAgrupados.getCargos()[i].getCantidad()));
			tablaCargosDTO[i].setImporteTotal(String.valueOf(cargosAgrupados.getCargos()[i].getPrecio().getMonto()*cargosAgrupados.getCargos()[i].getCantidad()));
			tablaCargosDTO[i].setImporteTotalOriginal(String.valueOf(cargosAgrupados.getCargos()[i].getPrecio().getMonto()));
			
			tablaCargosDTO[i].setMoneda(cargosAgrupados.getCargos()[i].getPrecio().getUnidad().getDescripcion());
			tablaCargosDTO[i].setCodConcepto(cargosAgrupados.getCargos()[i].getPrecio().getCodigoConcepto());
			if(cargosAgrupados.getCargos()[i].getDescuento()!=null&&cargosAgrupados.getCargos()[i].getDescuento().length>0&&cargosAgrupados.getCargos()[i].getDescuento()[0]!=null){
				tablaCargosDTO[i].setCodConceptoDescuento(cargosAgrupados.getCargos()[i].getDescuento()[0].getCodigoConcepto());
				logger.debug("COD CONCEPTO DESCUENTO :" +tablaCargosDTO[i].getCodConceptoDescuento());
			}
			String tipDescuento;
			String tipoDescuentoAplicar;
			if(cargosAgrupados.getCargos()[i]!=null && cargosAgrupados.getCargos()[i].getDescuento() !=null&& cargosAgrupados.getCargos()[i].getDescuento().length>0 &&cargosAgrupados.getCargos()[i].getDescuento()[0]!=null&& cargosAgrupados.getCargos()[i].getDescuento()[0].getTipo()!=null){
				tipDescuento = cargosAgrupados.getCargos()[i].getDescuento()[0].getTipo();//Esto siempre es 1 debido a q es autom�tico.
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
			if(cargosAgrupados.getCargos()[i]!=null && cargosAgrupados.getCargos()[i].getDescuento()!=null &&cargosAgrupados.getCargos()[i].getDescuento().length>0&&cargosAgrupados.getCargos()[i].getDescuento()[0]!=null){
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
			//DANIEL SAGREDO: S�bado 10-11
			//sessionData.getCargosObtenidos().setOcacionales(cargosForm.getCargosMerge()); 

			// GS
			CargosObtenidosDTO cargosObtenidos = new CargosObtenidosDTO();
			cargosObtenidos.setOcacionales(cargosForm.getCargosMerge());
			sessionData.setCargosObtenidos(cargosObtenidos);
			
			//Con este if se evita que se pase directamente a la p�gina de resumen
			//si no se encuentran cargos
			//05/02/08 (+)
			if(sessionData.getSinCondicionesComerciales()!=null && (sessionData.getSinCondicionesComerciales().equalsIgnoreCase("")||sessionData.getSinCondicionesComerciales().equalsIgnoreCase("NO"))){
				session.setAttribute("recalculado", "NO");
				logger.debug("execute():end");
				return mapping.findForward(SIGUIENTE);
			}//05/02/08 (-)
			
			logger.debug("execute():end");
			return mapping.findForward(RESUMEN);
		}

		logger.debug("execute():end");
		session.setAttribute("recalculado", "NO");
		return mapping.findForward(SIGUIENTE);
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

	// ----------------------------------------------------------------------------------------------------------------------------------
	
	private String loadCargosError( SuspensionVoluntariaForm suspensionVoluntariaForm )	{
		
		StringBuffer layout = new StringBuffer();
		
		textoMensajeRestricciones="No existen tarifas para el equipo seleccionado. " +
		"No es posible llevar a cabo la transacci�n con el m�dulo de cargos, " +
		"favor verificar que exista la siguiente informaci�n:" ;
		
		layout.append("<table width='100%'>");
		layout.append("<tr>");
		layout.append("<td align='center'>" + textoMensajeRestricciones + "</td>");
		layout.append("</tr>");
		
		layout.append("<tr>");
		layout.append("<td align='center'>");
		layout.append("<table style='font-style:verdana; font-size: 8pt;width:400px'>");
		layout.append("<tr>");
		layout.append("<td class='textoColumnaTabla'>Producto</td>");
		layout.append("<td class='textoFilasTabla'>1</td>");
		layout.append("</tr>");
		layout.append("<tr>");
		layout.append(" <td class='textoColumnaTabla'>Causa de Suspensi�n</td>");
		layout.append("<td class='textoFilasTabla'>" + suspensionVoluntariaForm.getCausaSuspension() + "</td>");
		layout.append("</tr>");
		layout.append("<tr>");
		layout.append("<td class='textoColumnaTabla'>Fecha de Solicitud</td>");
		layout.append("<td class='textoFilasTabla'>" + suspensionVoluntariaForm.getFecSolicitud() + "</td>");
		layout.append("</tr>");
		layout.append("<tr>");
		layout.append("<td class='textoColumnaTabla'>Fecha de Suspensi�n</td>");
		layout.append("<td class='textoFilasTabla'>" + suspensionVoluntariaForm.getFecSuspension() + "</td>");
		layout.append("</tr>");
		layout.append("<tr>");
		layout.append("<td class='textoColumnaTabla'>Fecha de Rehabilitaci�n</td>");
		layout.append("<td class='textoFilasTabla'>" + suspensionVoluntariaForm.getFecRehabilitacion() + "</td>");
		layout.append("</tr>");
		layout.append("<tr>");
		layout.append("<td class='textoColumnaTabla'>Cantidad de D�as</td>");
		layout.append("<td class='textoFilasTabla'>" + suspensionVoluntariaForm.getCantDias() + "</td>");
		layout.append("</tr>");
		layout.append("</table>");
		layout.append("</td>");
		layout.append("</tr>");
		layout.append("<tr>");
		layout.append("<p><td align='center'>Si el problema persiste, favor comunicarse con el administrador de sistema.</td>");
		layout.append("</tr>");
		layout.append("</table>");		
		
		return layout.toString();
		
	}  // loadCargosError
	
	// ----------------------------------------------------------------------------------------------------------------------------------
	
	/**
	 * @param cargosNuevos Cargos obtenidos desde el m�todo 
	 * @param cargosSession Cargos obtenidos desde la sesi�n
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
		DescuentoDTO descuentoNuevo = null;
		DescuentoDTO descuentoAutomatico=null;
		List listDescuentos=new ArrayList();
		
		/**@author: rlozano
		 * @Description:Recorremos la tabla web para encontrar el registro correspondiente mediante el codConcepto
 		*/
		for(int i = 0; i<tablaCargos.length;i++){
//			 nos ubicamos en el registro
			String montoDescManual=null;
			String montoDescAutom=null;
			if(tablaCargos[i].getCodConcepto().equalsIgnoreCase(codConcepto)){
				//verificamos q existan decuentos manuales y descuentos automaticos
				montoDescManual=tablaCargos[i].getDescuentoUnitarioMan();
				montoDescManual=montoDescManual==null||montoDescManual.equals("")?"0":montoDescManual.trim();
				montoDescAutom=tablaCargos[i].getDescuentoUnitarioAut();
				montoDescAutom=montoDescAutom==null||montoDescAutom.equals("")?"0":montoDescAutom.trim();
				String tipoMontoAutom=null;
				if (!"0".equals(montoDescAutom)){
					descuentoAutomatico=new DescuentoDTO();
					descuentoAutomatico.setCodigoConcepto(tablaCargos[i].getCodConceptoDescuento());
					descuentoAutomatico.setCodigoConceptoCargo(codConcepto);
					tipoMontoAutom=tablaCargos[i].getTipoDescuentoAut();
					tipoMontoAutom=tipoMontoAutom==null?"":tipoMontoAutom.trim();
					tipoMontoAutom=tipoMontoAutom.equals("Porcentaje")?"1":tipoMontoAutom;
					tipoMontoAutom=tipoMontoAutom.equals("Monto")?"0":tipoMontoAutom;
					tablaCargos[i].setTipoDescuentoAut(tipoMontoAutom);
					descuentoAutomatico.setTipoAplicacion(tipoMontoAutom);//si es monto / porcentaje
					descuentoAutomatico.setTipo("1");
					
					int cantidad = Integer.parseInt(tablaCargos[i].getCantidad());				
					if("0".equalsIgnoreCase(tablaCargos[i].getTipoDescuentoAut())){ //importe*/
						descuentoAutomatico.setMonto(Float.parseFloat(tablaCargos[i].getDescuentoUnitarioAut())/cantidad);
						
					}else{//porcentaje
				
						descuentoAutomatico.setMonto(Float.parseFloat(tablaCargos[i].getDescuentoUnitarioAut()));
					}
					listDescuentos.add(descuentoAutomatico);
				}
				
				//Creamos registro para descuento Manual
				
				if (!"0".equals(montoDescManual)){
						yaEntro=true;
						descuentoNuevo=new DescuentoDTO();
						descuentoNuevo.setCodigoConceptoCargo(codConcepto);
						descuentoNuevo.setTipoAplicacion(tablaCargos[i].getTipoDescuentoManual());//si es monto / porcentaje
						descuentoNuevo.setTipo("0");
						
						int cantidad = Integer.parseInt(tablaCargos[i].getCantidad());				
						if("0".equalsIgnoreCase(tablaCargos[i].getTipoDescuentoManual())){ //importe*/
							descuentoNuevo.setMonto(Float.parseFloat(montoDescManual)/cantidad);
							
						}else{//porcentaje
					
							descuentoNuevo.setMonto(Float.parseFloat(montoDescManual));
						}
						
						/**
						 * @author : rlozano
						 * @descripcion :  Se procede a crear cod concepto para el decuento manual siempre 
						 * y cuando no existan descuentos automaticos asociados
						 */ 

						if ("0".equals(montoDescAutom)){
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
						//	retorno[0]=descuentoNuevo;
							//(-)evera 26/09/2007		
						}
						else{
							descuentoNuevo.setCodigoConcepto(tablaCargos[i].getCodConceptoDescuento());//corresponde al autom�tico
						}
						listDescuentos.add(descuentoNuevo);
				}
				
				
			}else if(tablaCargos[i].getCodConcepto().equalsIgnoreCase(codConcepto)){
				if(arregloDescuentos!= null&&arregloDescuentos.length>0){
					if(arregloDescuentos[0].getTipoAplicacion()!=null&&
							arregloDescuentos[0].getTipoAplicacion().equals("0")&& 
							tablaCargos[i].getDescuentoUnitarioMan()!=null	&& 
									tablaCargos[i].getDescuentoUnitarioMan().trim().equals("")){
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
		}
		if (!listDescuentos.isEmpty()){
			retorno=(DescuentoDTO[])ArrayUtl.copiaArregloTipoEspecifico(listDescuentos.toArray(), DescuentoDTO.class);
		}
		
		//Verificar;
		
		return retorno;
  }

}