package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;



import java.sql.Timestamp;

import java.text.SimpleDateFormat;
import java.util.Date;



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
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.AtributosCargoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.PrecioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PenalizacionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RangoAntiguedadDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ParamCargosAbonadoCeroDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.CargosObtenidosDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.businessObject.bo.XMLDefault;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ControlDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.DefaultPaginaCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ParamObtCargOOSSDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CambiarPlanForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CargosForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class CargosCPUAction extends BaseAction{
	
	private final Logger logger = Logger.getLogger(CargosCPUAction.class);
	private Global global = Global.getInstance();
	
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
 
	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)throws Exception {
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("executeAction():start");
		CambiarPlanForm form1 = (CambiarPlanForm) form;
		
		ClienteOSSesionDTO sessionData=null;
		HttpSession session = request.getSession(false);
		sessionData = new ClienteOSSesionDTO();
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		
	    session.removeAttribute("mensajeError"); //EV
	    
	    String SIGUIENTE="frameworkCargos";
			    
		String destinoTipoPlan=null;
		if(form1.getRadioTipoPlan().equals("combopre"))destinoTipoPlan="PREPAGO";
		if(form1.getRadioTipoPlan().equals("combopos"))destinoTipoPlan="POSPAGO";
		if(form1.getRadioTipoPlan().equals("combohib"))destinoTipoPlan="HIBRIDO";
		
	    ParametrosDescuentoDTO parametrosDescuento= new ParametrosDescuentoDTO();
	    
	    
	
	    
	    //(+) Parametros para obtener DESCUENTOS AUTOMATICOS PUNTUAL (Generico para todas las combinatorias)
	    if (sessionData.getCodOrdenServicio()== 40006){
	    	logger.debug("seteando parametros para obtener descuentos por segmentacion");
    	    
		    parametrosDescuento.setCodigoOperacion(form1.getCodActuacion());
		    parametrosDescuento.setTipoContrato(sessionData.getAbonados()[0].getCodTipContrato());
		    
		    if(form1.getCombinatoria().equalsIgnoreCase("POSPAGOPREPAGO") || form1.getCombinatoria().equalsIgnoreCase("HIBRIDOPREPAGO")){
		    	RangoAntiguedadDTO rango = new RangoAntiguedadDTO();
		    	rango.setNumSerie(sessionData.getAbonados()[0].getNumSerie());
		    	rango.setCodCausaBaja(form1.getCausaBajaCB());
		    	
		    	if(sessionData.getAbonados()[0].getFecAlta()!= null){
		    		rango.setFechaAlta(new Timestamp(sessionData.getAbonados()[0].getFecAlta().getTime()));
		    	}else{
		    		rango.setFechaAlta(null);
		    	}
		    	
		    	if(sessionData.getAbonados()[0].getFecProrroga()!= null){
		    		rango.setFechaProrroga(new Timestamp(sessionData.getAbonados()[0].getFecProrroga().getTime()));
		    	}else{
		    		rango.setFechaProrroga(null);
		    	}
		    	
		    	logger.debug("rango.getNumSerie()         :"+rango.getNumSerie());
		    	logger.debug("rango.getCodCausaBaja()     :"+rango.getCodCausaBaja());
		    	logger.debug("rango.getFechaAlta()        :"+rango.getFechaAlta());
		    	logger.debug("rango.getFechaProrroga()    :"+rango.getFechaProrroga());
		       	logger.debug("obtenerRangoAntiguedad():inicio ");
		    	rango = delegate.obtenerRangoAntiguedad(rango);
		    	logger.debug("obtenerRangoAntiguedad():fin ");
		    	parametrosDescuento.setCodigoAntiguedad(rango.getRangoAntiguedad());
		       	
		    }else{
		    	parametrosDescuento.setCodigoAntiguedad("0");
		    }
		    
		    parametrosDescuento.setCodigoContratoNuevo(parametrosDescuento.getTipoContrato());
		    parametrosDescuento.setCodigoArticulo("0");
		    
		    
		    
		      
		    if(form1.getCombinatoria().equalsIgnoreCase("POSPAGOPREPAGO") || form1.getCombinatoria().equalsIgnoreCase("HIBRIDOPREPAGO")){
		    	parametrosDescuento.setCodigoCausaVenta(form1.getCausaBajaCB());
		    }else{
		    	parametrosDescuento.setCodigoCausaVenta("");
		    }
		   
		    PlanTarifarioDTO plan = new PlanTarifarioDTO();
		    plan.setCodPlanTarif(form1.getCodPlanTarifSelec());
		    logger.debug("obtenerCategPlan():antes");
		    PlanTarifarioDTO categoria = delegate.obtenerCategPlan(plan);
		    logger.debug("obtenerCategPlan():despues");
		    parametrosDescuento.setCodigoCategoria(categoria.getCodigoCategoria());
		    
		    if(destinoTipoPlan.equalsIgnoreCase("PREPAGO"))parametrosDescuento.setTipoPlanTarifario("1");
		    if(destinoTipoPlan.equalsIgnoreCase("POSPAGO"))parametrosDescuento.setTipoPlanTarifario("2");
		    if(destinoTipoPlan.equalsIgnoreCase("HIBRIDO"))parametrosDescuento.setTipoPlanTarifario("3");
		    
		    parametrosDescuento.setEquipoEstado("N"); // opera de la misma manera que en la obtencion de los cargos baja opta por prepago
		    
		    logger.debug("parametrosDescuento.getCodigoOperacion()             :"+parametrosDescuento.getCodigoOperacion());
		    logger.debug("parametrosDescuento.getTipoContrato()                :"+parametrosDescuento.getTipoContrato());
		    logger.debug("parametrosDescuento.getCodigoAntiguedad()            :"+parametrosDescuento.getCodigoAntiguedad());
		    logger.debug("parametrosDescuento.getCodigoContratoNuevo()         :"+parametrosDescuento.getCodigoContratoNuevo());
		    logger.debug("parametrosDescuento.getCodigoArticulo()              :"+parametrosDescuento.getCodigoArticulo());
		    logger.debug("parametrosDescuento.getCodigoVendedor()              :"+parametrosDescuento.getCodigoVendedor());
		    logger.debug("parametrosDescuento.getCodigoCausaVenta()            :"+parametrosDescuento.getCodigoCausaVenta());
		    logger.debug("parametrosDescuento.getCodigoCategoria()             :"+parametrosDescuento.getCodigoCategoria());
		    logger.debug("parametrosDescuento.getTipoPlanTarifario()           :"+parametrosDescuento.getTipoPlanTarifario());
		    logger.debug("parametrosDescuento.getEquipoEstado()                :"+parametrosDescuento.getEquipoEstado());
	    	
	    }
	      
	    //(-)
	    
	   
	    
	    XMLDefault objetoXML	= new XMLDefault();
	    DefaultPaginaCPUDTO objetoXMLSession = new DefaultPaginaCPUDTO();
	    ControlDTO control = new ControlDTO();
	    String modalidadPago=null;
	    
	    //(+) Obtiene el valor de modalidad de pagos del form de Cargos o desde el XML de configuracion
	    if (((CargosForm)session.getAttribute("CargosForm")) == null){
	    	objetoXMLSession = sessionData.getDefaultPagina(); 
	  	    control = objetoXML.obtenerControl(objetoXMLSession, "cargosPAG", "CondicionesComercialesSS", "ModalidadCB");
	 	    modalidadPago = control.getValorDefecto();  //asigna el valor por defecto del XML
	    }else{
	    	if( ((CargosForm)session.getAttribute("CargosForm")).getCbModPago() != null) {
	    		modalidadPago = ((CargosForm)session.getAttribute("CargosForm")).getCbModPago();  //asigna el valor seteado en el form de Cargos
	    	}else{
	    		objetoXMLSession = sessionData.getDefaultPagina(); 
		  	    control = objetoXML.obtenerControl(objetoXMLSession, "cargosPAG", "CondicionesComercialesSS", "ModalidadCB");
		 	    modalidadPago = control.getValorDefecto();  //asigna el valor por defecto del XML
	    	}
	    }
	    logger.debug("modalidadPago  :"+modalidadPago);
	    sessionData.setModalidad(modalidadPago);
	   
	    ParametrosObtencionCargosDTO parametrosCargos=new ParametrosObtencionCargosDTO();
	    ObtencionCargosDTO obtencionCargos=null;
	    CargosObtenidosDTO cargosObtenidos = null;
	   
	    
	    //(+) Si es Baja opta por PREPAGO (Se deben setear atributos para obtener cargos por SEGMENTACION, PENALIZACION y EQUIPO*)
	    if(form1.getCombinatoria().equalsIgnoreCase("POSPAGOPREPAGO") || form1.getCombinatoria().equalsIgnoreCase("HIBRIDOPREPAGO")){
	    	parametrosCargos = asignarParametrosSegmentacion(sessionData, form1, modalidadPago);
	    	parametrosCargos = asignarParamBajaOptaPrepago(parametrosCargos, sessionData, form1, modalidadPago);
	    }else{//- Se debe setear atributos para obtener solo cargos por SEGMENTACION
	    	parametrosCargos = asignarParametrosSegmentacion(sessionData, form1, modalidadPago);
	    }
	    
	    //Se asigna Valor a codigo de Vendedor
	    UsuarioDTO usuario = new UsuarioDTO();
	    usuario.setNombre(sessionData.getUsuario());
	    logger.debug("obtenerVendedor():antes");
	    UsuarioDTO vendedor = delegate.obtenerVendedor(usuario);
	    logger.debug("obtenerVendedor():despues");
	    parametrosDescuento.setCodigoVendedor(String.valueOf(vendedor.getCodigo()));
	    	    
	    parametrosCargos.setParametrosDescuentoDTO(parametrosDescuento); 
	    
		//	ini-Proyecto p-mix-09003 OCB; 	
	    parametrosCargos.setNumOsRenova(sessionData.getParamRenova());
	    parametrosCargos.setOrdenServicio(String.valueOf(sessionData.getCodOrdenServicio()));
	    //	fin-Proyecto p-mix-09003 OCB; 
	    
	    
	    
	    
		logger.debug("-------------Datos enviados al obtener cargos---------------");	    	    
	    logger.debug("parametrosCargos.getTipoPantalla()           :"+parametrosCargos.getTipoPantalla()); // 2 veces
	    logger.debug("parametrosCargos.getCodigoModalidadVenta()   :"+parametrosCargos.getCodigoModalidadVenta()); // 2 veces
	    logger.debug("parametrosCargos.getCodigoClienteOrigen()    :"+parametrosCargos.getCodigoClienteOrigen());
	    logger.debug("parametrosCargos.getCodigoClienteDestino()   :"+parametrosCargos.getCodigoClienteDestino());
	    logger.debug("parametrosCargos.getCodigoPlanTarifOrigen()  :"+parametrosCargos.getCodigoPlanTarifOrigen());
	    logger.debug("parametrosCargos.getCodigoPlanTarifDestino() :"+parametrosCargos.getCodigoPlanTarifDestino());
	    logger.debug("parametrosCargos.getTipoSegOrigen()          :"+parametrosCargos.getTipoSegOrigen());
	    logger.debug("parametrosCargos.getTipoSegDestino()         :"+parametrosCargos.getTipoSegDestino());
	    logger.debug("parametrosCargos.getCodCausaCambioPlan()     :"+parametrosCargos.getCodCausaCambioPlan()); // 2 veces
	    logger.debug("parametrosCargos.getCodActabo()              :"+parametrosCargos.getCodActabo()); // 2 veces
	    logger.debug("parametrosCargos.getCodigoTecnologia()       :"+parametrosCargos.getCodigoTecnologia());
	    logger.debug("parametrosCargos.getCodPenalizacion()        :"+parametrosCargos.getCodPenalizacion());
	    logger.debug("parametrosCargos.getIndComodato()            :"+parametrosCargos.getIndComodato());
	    logger.debug("parametrosCargos.getCodCategoria()           :"+parametrosCargos.getCodCategoria());
	    logger.debug("parametrosCargos.getTipoContrato()           :"+parametrosCargos.getTipoContrato());
	    logger.debug("parametrosCargos.getIndCausa()               :"+parametrosCargos.getIndCausa());
	    logger.debug("parametrosCargos.getEstdDevlCargador()       :"+parametrosCargos.getEstdDevlCargador());
	    logger.debug("parametrosCargos.getFechaVigenciaAbonadoCero() :"+parametrosCargos.getFechaVigenciaAbonadoCero());
	    logger.debug("parametrosCargos.getNumOsRenova()            :"+ parametrosCargos.getNumOsRenova()); //	ini-Proyecto p-mix-09003 OCB; 
	    logger.debug("parametrosCargos.getOrdenServicio()          :"+ parametrosCargos.getOrdenServicio()); //	ini-Proyecto p-mix-09003 OCB;
		logger.debug("Abonados		:");
		
        //INI 72181; COLOMBIA; AVC; 17-12-2008--------------->71897
		
		if (sessionData.getCodOrdenServicio()== 40008) {
			RegistroPlanDTO registroPlanAux = (RegistroPlanDTO)session.getAttribute("registroPlan");
			
			String tipPlanTarifEmpresa = global.getValor("parametro.tipo.plan.tarifario.empresa");
			
			if (registroPlanAux.getParamRegistroPlan().getTipPlanTarifDestino().equals(tipPlanTarifEmpresa)){
				ParamCargosAbonadoCeroDTO paramCargos = new ParamCargosAbonadoCeroDTO();
				paramCargos.setCodCliente(registroPlanAux.getParamRegistroPlan().getCodClienteDestino());
				boolean isAplicaAbonadoCero = delegate.getValidacionAbonadoCero(paramCargos).isResultado();
				logger.debug("isAplicaAbonadoCero="+isAplicaAbonadoCero);
				if (isAplicaAbonadoCero){//solo envia un abonado a frmcargos
					if (parametrosCargos.getAbonados().length>1){
						String[] abonadosCero = new String[1];
						abonadosCero[0] = parametrosCargos.getAbonados()[0];
						parametrosCargos.setAbonados(abonadosCero);
					}
				}
			}
		}
		
        //FIN 72181; COLOMBIA; AVC; 17-12-2008
		
		for(int i=0; i<parametrosCargos.getAbonados().length;i++)	logger.debug(i+".-"+parametrosCargos.getAbonados()[i]);
		
		
		//(+)evera 02/08/08
		try{
	    	logger.debug("obtencionCargos(): inicio");
	    	obtencionCargos = delegate.obtencionCargos(parametrosCargos);
	    	int numAbonados = sessionData.getCliente().getNumAbonados();/* pv 300508 */
	    	
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
					if(sessionData.getAbonados()[0].getCodTipoPlanTarif().equalsIgnoreCase("E")
						&& (sessionData.getCodOrdenServicio()== 40007)	){ // GS solo cuando es cliente EMPRESA se multiplica por cant. de abonados seleccionados
						cargo.setCantidad(cargo.getCantidad()*numAbonados);/* pv 300508 */
					}
					
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
					logger.debug("-----------------------------------------");
				}//fin for cargos
			}
			logger.debug("-------------------------------------------");
	    	
	    	
	    	if(obtencionCargos.getCargos() != null){
		    	for(int i=0; i<obtencionCargos.getCargos().length; i++){
		    		logger.debug("obtencionCargos.getCargos()[" + i + "].getPrecio().getMonto() :"+obtencionCargos.getCargos()[i].getPrecio().getMonto());
		    		if(obtencionCargos.getCargos()[i].getDescuento() != null){
		    			for(int j=0; j<obtencionCargos.getCargos()[i].getDescuento().length; j++){
		    				logger.debug("codigoConcepto[" + j + "]: "+obtencionCargos.getCargos()[i].getDescuento()[j].getMonto());
		    			}
		    		}else{
		    			logger.debug("descuento == null");
		    		}
		    	}
	    	}else{
	    		logger.debug("cargos == null");
	    	}
	    	
	    	logger.debug("obtencionCargos(): fin");
	    	
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
    	
    	
    	/*
    	//(+) Setear parametros que seran utilizados en cargos por uso OS
		ParamObtCargOOSSDTO paramCargosUsoOOSS= new ParamObtCargOOSSDTO();
		    
		paramCargosUsoOOSS.setCodAbonado(form1.getListaAbonados());
		paramCargosUsoOOSS.setCodClienteDestino(Long.parseLong(form1.getCodClienteDestSelec()));
		paramCargosUsoOOSS.setCodPlanTarifDestino(form1.getCodPlanTarifSelec());
		paramCargosUsoOOSS.setSinCondicionesComerciales(form1.getCondicH());
		paramCargosUsoOOSS.setCodActAbo(form1.getCodActuacion());
		paramCargosUsoOOSS.setTipoPantallaPrevia(parametrosCargos.getTipoPantalla());
		logger.debug("paramCargosUsoOOSS.getCodAbonado()               :"+paramCargosUsoOOSS.getCodAbonado()[0]);
		logger.debug("paramCargosUsoOOSS.getCodClienteDestino()        :"+paramCargosUsoOOSS.getCodClienteDestino());
		logger.debug("paramCargosUsoOOSS.getCodPlanTarifDestino()      :"+paramCargosUsoOOSS.getCodPlanTarifDestino());
		logger.debug("paramCargosUsoOOSS.getSinCondicionesComerciales():"+paramCargosUsoOOSS.getSinCondicionesComerciales());
		logger.debug("paramCargosUsoOOSS.getCodActAbo()                :"+paramCargosUsoOOSS.getCodActAbo());
		logger.debug("paramCargosUsoOOSS.getTipoPantallaPrevia()       :"+paramCargosUsoOOSS.getTipoPantallaPrevia());
		    
		session.setAttribute("paramCargosUsoOOSS", paramCargosUsoOOSS);
		//(-)
		*/
    	ConversionListDTO conversionList=null;
    	RegistroPlanDTO registroPlan = (RegistroPlanDTO)session.getAttribute("registroPlan");
    	ConversionDTO param = new ConversionDTO();
		param.setCodOOSS(sessionData.getCodOrdenServicio());
		param.setCodTipModi(registroPlan.getParamRegistroPlan().getCombinatoria());
		logger.debug("obtenerConversionOOSS():inicio");
		conversionList = delegate.obtenerConversionOOSS(param);
		logger.debug("obtenerConversionOOSS():fin");
		
		
	   	cargosObtenidos = new CargosObtenidosDTO();
	   	cargosObtenidos.setOcacionales(obtencionCargos);
	   	sessionData.setCargosObtenidos(cargosObtenidos);
	   	sessionData.setCodAbonado(form1.getListaAbonados());
 	    sessionData.setSinCondicionesComerciales(form1.getCondicH());
 	    sessionData.setCodActAbo(form1.getCodActuacion());
 	    
 	   if(!form1.getCombinatoria().equalsIgnoreCase("PREPAGOPREPAGO"))
 		   sessionData.setTipoPantallaPrevia("2");
 	   
	   	sessionData.setCodActAboCargosUso(conversionList.getRegistros()[0].getCodActuacionWeb());
 	    
	   	logger.debug("siguiente     :"+SIGUIENTE);
		return mapping.findForward(SIGUIENTE);
	}
	
	
	
	/**
	 * Setea los atributos necesarios en el objeto que se utilizara para obtener cargos por segmentacion
	 * @param sessionData
	 * @param form1
	 * @param modalidad
	 * @return ParametrosObtencionCargosDTO
	 */	
	public ParametrosObtencionCargosDTO asignarParametrosSegmentacion(ClienteOSSesionDTO sessionData, ActionForm form1, String modalidad) throws ManReqException{
		
		logger.debug("asignarParametrosSegmentacion : inicio");
		ParametrosObtencionCargosDTO paramSegmentacion=new ParametrosObtencionCargosDTO();
		ClienteDTO paramCliente= new ClienteDTO();
    	    	
    		logger.debug("combinatoria    :"+((CambiarPlanForm) form1).getCombinatoria());
    		if( !((CambiarPlanForm) form1).getCombinatoria().equalsIgnoreCase("POSPAGOPREPAGO") && !((CambiarPlanForm) form1).getCombinatoria().equalsIgnoreCase("HIBRIDOPREPAGO") ){
    			paramSegmentacion.setTipoPantalla("3"); // Corresponde a cargos por SEGMENTACION
    		}
    		paramCliente.setCodCliente(sessionData.getCliente().getCodCliente());
    		logger.debug("obtenerValorCalculado() :inicio");
        	ClienteDTO clienteValorCalc=delegate.obtenerValorCalculado(paramCliente);
        	logger.debug("obtenerValorCalculado() :fin");
        	paramSegmentacion.setCodigoModalidadVenta(modalidad);

        	//DANIEL SAGREDO (+)
        	//SE COMENTA LA LINEA DE ABAJO Y SE REEMPLAZA POR LA SIGUIENTE
        	//paramSegmentacion.setAbonados(((CambiarPlanForm) form1).getListaAbonados());
        	String[] arrAbonados = sessionData.getCodAbonadosAplicarCargos()==null||sessionData.getCodAbonadosAplicarCargos().length==0?((CambiarPlanForm) form1).getListaAbonados():sessionData.getCodAbonadosAplicarCargos();
        	paramSegmentacion.setAbonados(arrAbonados);
        	//DANIEL SAGREDO (-)
        	paramSegmentacion.setCodigoClienteOrigen(String.valueOf(sessionData.getCliente().getCodCliente()));
        	paramSegmentacion.setCodigoClienteDestino(((CambiarPlanForm) form1).getCodClienteDestSelec());
        	paramSegmentacion.setCodigoPlanTarifOrigen(sessionData.getAbonados()[0].getCodPlanTarif());
        	paramSegmentacion.setCodigoPlanTarifDestino(((CambiarPlanForm) form1).getCodPlanTarifSelec());
        	paramSegmentacion.setTipoSegOrigen(clienteValorCalc.getCodValor());
        	paramSegmentacion.setCodigoTecnologia(sessionData.getAbonados()[0].getCodTecnologia());
        	
        	String codClienteOrigen= String.valueOf(sessionData.getCliente().getCodCliente());
        	
        	if(codClienteOrigen.equals(String.valueOf(((CambiarPlanForm) form1).getCodClienteDestSelec()))){
        		paramSegmentacion.setTipoSegDestino(clienteValorCalc.getCodValor());
        	}else{
        		ClienteDTO clienteSegDestino=new ClienteDTO();
        		if( ((CambiarPlanForm) form1).getCodClienteDestSelec()!= null )
        		    		clienteSegDestino.setCodCliente(Long.parseLong(((CambiarPlanForm) form1).getCodClienteDestSelec()));
        		
        		logger.debug("clienteSegDestino.getCodCliente()  :"+clienteSegDestino.getCodCliente());
        		logger.debug("obtenerValorCalculado2() :inicio");
    	    	clienteValorCalc=delegate.obtenerValorCalculado(clienteSegDestino);
    	    	logger.debug("obtenerValorCalculado2() :fin");
    	    	paramSegmentacion.setTipoSegDestino(clienteValorCalc.getCodValor());
        	}
        	
        	paramSegmentacion.setCodCausaCambioPlan("0");
        	paramSegmentacion.setCodActabo(((CambiarPlanForm) form1).getCodActuacion());
        	
        	// -Estos atributos se obtienen al setear parametros baja opta x prepago y se setean en vacios para que el obtener cargos no tenga valores null
        	paramSegmentacion.setCodPenalizacion("");
        	paramSegmentacion.setCodCategoria("");
        	paramSegmentacion.setTipoContrato("");
        	paramSegmentacion.setIndCausa("");
        	paramSegmentacion.setEstdDevlCargador("");
        	
        	
        	
        	//Date fechaVigencia =null;
        	String fecVig = ((CambiarPlanForm)form1).getFecDesdeLlam();
        	logger.debug("fecVig[" + fecVig + "]");
        	        	
			SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
			try{
				
				Date fechaVigencia = format.parse(fecVig);
				java.sql.Date fechaVigenciaFinal = new java.sql.Date(fechaVigencia.getTime());
				paramSegmentacion.setFechaVigenciaAbonadoCero(fechaVigenciaFinal);
				
			}catch(Exception e){}
        	
        	
        	
        	
        	/*
        	DateFormat fecha = DateFormat.getInstance();
        	try{
        		fechaVigencia = fecha.parse(fecVig);
        	}catch (Exception e){
        		logger.debug("Exception" + e);
        	}
        	paramSegmentacion.setFechaVigenciaAbonadoCero((java.sql.Date) fechaVigencia);
        	*/
      	
        	
		    UsuarioDTO usuario = new UsuarioDTO();
		    usuario.setNombre(sessionData.getUsuario());
		    logger.debug("obtenerVendedor():antes");
		    UsuarioDTO vendedor = delegate.obtenerVendedor(usuario);
		    logger.debug("obtenerVendedor():despues");
		    paramSegmentacion.setCodigoVendedor(String.valueOf(vendedor.getCodigo()));
		    
		    
        	       	
        	logger.debug("paramSegmentacion.getTipoPantalla()                :"+paramSegmentacion.getTipoPantalla());
        	logger.debug("paramSegmentacion.getCodigoModalidadVenta(         :"+paramSegmentacion.getCodigoModalidadVenta());
        	logger.debug("paramSegmentacion.getAbonados()                    :"+paramSegmentacion.getAbonados()[0]);
        	logger.debug("paramSegmentacion.getCodigoClienteOrigen()         :"+paramSegmentacion.getCodigoClienteOrigen());
        	logger.debug("paramSegmentacion.getCodigoClienteDestino()        :"+paramSegmentacion.getCodigoClienteDestino());
        	logger.debug("paramSegmentacion.getCodigoPlanTarifOrigen()       :"+paramSegmentacion.getCodigoPlanTarifOrigen());
        	logger.debug("paramSegmentacion.getCodigoPlanTarifDestino()      :"+paramSegmentacion.getCodigoPlanTarifDestino());
        	logger.debug("paramSegmentacion.getTipoSegOrigen()               :"+paramSegmentacion.getTipoSegOrigen());
        	logger.debug("paramSegmentacion.getTipoSegDestino()              :"+paramSegmentacion.getTipoSegDestino());
        	logger.debug("paramSegmentacion.getCodCausaCambioPlan()          :"+paramSegmentacion.getCodCausaCambioPlan());
        	logger.debug("paramSegmentacion.getCodActabo()                   :"+paramSegmentacion.getCodActabo());
        	logger.debug("paramSegmentacion.getCodigoTecnologia()            :"+paramSegmentacion.getCodigoTecnologia());
        	logger.debug("paramSegmentacion.getCodigoVendedor()              :"+paramSegmentacion.getCodigoVendedor());
        	logger.debug("paramSegmentacion.getFechaVigenciaAbonadoCero()    :"+paramSegmentacion.getFechaVigenciaAbonadoCero());

		logger.debug("asignarParametrosSegmentacion : fin");
		return paramSegmentacion;
	}
	
	/**
	 * Setea los atributos necesarios en el objeto que se utilizara para obtener cargos de baja opta por prepago
	 * @param parametrosCargosSegmentacion
	 * @param sessionData
	 * @param form1
	 * @param modalidad
	 * @return
	 */
		
	public ParametrosObtencionCargosDTO asignarParamBajaOptaPrepago(ParametrosObtencionCargosDTO parametrosCargosSegmentacion, ClienteOSSesionDTO sessionData, ActionForm form1, String modalidad) throws ManReqException{
		
		logger.debug("asignarParamBajaOptaPrepago : inicio");
		ParametrosObtencionCargosDTO paramBajaAbonado=new ParametrosObtencionCargosDTO();
		paramBajaAbonado=parametrosCargosSegmentacion;
		
			PenalizacionDTO param = new PenalizacionDTO();
	    	param.setNumAbonado(sessionData.getAbonados()[0].getNumAbonado());
	    	param.setFecFinContrato(new Timestamp(sessionData.getAbonados()[0].getFecFinContrato().getTime()));
	    	param.setModalidadPago(Integer.parseInt(modalidad)); 
	    	logger.debug("param.getNumAbonado()     :"+param.getNumAbonado());
	    	logger.debug("param.getFecFinContrato() :"+param.getFecFinContrato());
	    	logger.debug("param.getModalidadPago()  :"+param.getModalidadPago());
	    	
	    	logger.debug("obtenerPenalizacion():antes");
	    	PenalizacionDTO penalizacion = delegate.obtenerPenalizacion(param);
	    	logger.debug("obtenerPenalizacion():despues");
	       	logger.debug("penalizacion.getCodPenalizacion() :"+penalizacion.getCodPenalizacion());
	       	logger.debug("penalizacion.getTipoIndemizacion():"+penalizacion.getTipoIndemizacion());
	       	logger.debug("penalizacion.getAfectoIndemiza()  :"+penalizacion.getAfectoIndemiza());
	       	    	
	    	paramBajaAbonado.setCodPenalizacion(String.valueOf(penalizacion.getCodPenalizacion()));
	    	
	    	if (sessionData.getAbonados()[0].getIndEqPrestado()!=null) { // INC-75791; COL; 14-01-2009; AVC
	    	   paramBajaAbonado.setIndComodato(Integer.parseInt(sessionData.getAbonados()[0].getIndEqPrestado()));
	    	}else{
	    		sessionData.getAbonados()[0].setIndEqPrestado("0"); // INC-75791; COL; 14-01-2009; AVC
	    		paramBajaAbonado.setIndComodato(Integer.parseInt(sessionData.getAbonados()[0].getIndEqPrestado())); // INC-75791; COL; 14-01-2009; AVC
	    	}
	       	
	       	if(penalizacion.getAfectoIndemiza().equalsIgnoreCase("FALSE")){
	       		if(sessionData.getAbonados()[0].getIndEqPrestado().equals("1")){
	       			paramBajaAbonado.setTipoPantalla("1");
	       		}else{
	       			paramBajaAbonado.setTipoPantalla("2");
	       		}
	       	}else{
	       		if(penalizacion.getTipoIndemizacion().equals("0")){
	       			paramBajaAbonado.setTipoPantalla("2");
	       		}else{
	       			paramBajaAbonado.setTipoPantalla("4");
	       		}
	       	}
	    	
	    	
	    	PlanTarifarioDTO planTarif = new PlanTarifarioDTO();
			planTarif.setCodPlanTarif(String.valueOf(sessionData.getAbonados()[0].getCodPlanTarif()));
			logger.debug("planTarif.getCodPlanTarif()  :"+planTarif.getCodPlanTarif());
			logger.debug("obtenerCategPlan():inicio");
			planTarif = delegate.obtenerCategPlan(planTarif);
			logger.debug("obtenerCategPlan():fin");
			
			paramBajaAbonado.setCodCategoria(planTarif.getCodigoCategoria());
			paramBajaAbonado.setTipoContrato(sessionData.getAbonados()[0].getCodTipContrato());
			paramBajaAbonado.setCodActabo(((CambiarPlanForm) form1).getCodActuacion());
			
			ParametroDTO paramGral= new ParametroDTO();
			paramGral.setNomParametro("BA");
			paramGral.setCodModulo("GA");
			paramGral.setCodProducto(1);
			logger.debug("obtenerParametroGeneral(): inicio");
			paramGral = delegate.obtenerParametroGeneral(paramGral);
			logger.debug("obtenerParametroGeneral(): fin");
			
			paramBajaAbonado.setIndCausa(paramGral.getValor());
			paramBajaAbonado.setCodCausaCambioPlan(((CambiarPlanForm) form1).getCausaBajaCB());
			paramBajaAbonado.setCodigoModalidadVenta(modalidad); 
			paramBajaAbonado.setEstdDevlCargador("N"); // cambiar cuando se implemente la devolucion de equipos
			
			logger.debug("paramBajaAbonado.getTipoPantalla()        :"+paramBajaAbonado.getTipoPantalla());
			logger.debug("paramBajaAbonado.getCodPenalizacion()     :"+paramBajaAbonado.getCodPenalizacion());
			logger.debug("paramBajaAbonado.getIndComodato()         :"+paramBajaAbonado.getIndComodato());
			logger.debug("paramBajaAbonado.getCodCategoria()        :"+paramBajaAbonado.getCodCategoria());
			logger.debug("paramBajaAbonado.getTipoContrato()        :"+paramBajaAbonado.getTipoContrato());
			
			logger.debug("paramBajaAbonado.getCodActabo()           :"+paramBajaAbonado.getCodActabo());
			logger.debug("paramBajaAbonado.getIndCausa()            :"+paramBajaAbonado.getIndCausa());
			logger.debug("paramBajaAbonado.getCodCausaCambioPlan()  :"+paramBajaAbonado.getCodCausaCambioPlan());
			logger.debug("paramBajaAbonado.getCodigoModalidadVenta():"+paramBajaAbonado.getCodigoModalidadVenta());
			logger.debug("paramBajaAbonado.getEstdDevlCargador()    :"+paramBajaAbonado.getEstdDevlCargador());
				
		logger.debug("asignarParamBajaOptaPrepago : fin");
		return paramBajaAbonado;
	}
	
	
	
	
}
