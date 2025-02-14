package com.tmmas.scl.operations.crm.fab.cim.manreq.web.action;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioListOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.SalidaOutDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.CargoClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroPlanDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.AbonadoNumerosFrecuentesDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.NumeroFrecuenteTipoListDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.form.CambiarPlanForm;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper.Global;

public class ControlFlujoCPUAction extends BaseAction{

	private final Logger logger = Logger.getLogger(ControlFlujoCPUAction.class);
	private Global global = Global.getInstance();

	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	private final int FLG_PLAN_RANGO = 1;

	public ActionForward executeAction(ActionMapping mapping, ActionForm form,
			HttpServletRequest request, HttpServletResponse response)
	throws Exception {

		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);

		logger.debug("executeAction():start");
		CambiarPlanForm form1 = (CambiarPlanForm) form;

		ClienteOSSesionDTO sessionData=null;
		HttpSession session = request.getSession(false);
		sessionData = new ClienteOSSesionDTO();
		sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		sessionData.setResumenOS("");

		//Bloqueo de la solicitud de evaluación de riesgos
		LstPTaPlanTarifarioListOutDTO dataPlanesEval = (LstPTaPlanTarifarioListOutDTO) session.getAttribute("dataPlanesEval");
		if (dataPlanesEval!=null && dataPlanesEval.getNumSol()!=null && !dataPlanesEval.getNumSol().trim().equals("0") ){
			SalidaOutDTO resultado = delegate.bloqueaSolicitudEvRiesgo(Long.parseLong(dataPlanesEval.getNumSol()));
			logger.debug("resultado bloqueaSolicitudEvRiesgo:inicio");
			logger.debug("resultado.getCodError():"+resultado.getCodError());
			logger.debug("resultado.getCodEvento():"+resultado.getCodEvento());
			logger.debug("resultado.getMsgError():"+resultado.getMsgError());
			logger.debug("resultado bloqueaSolicitudEvRiesgo:fin");
		}
		
		if(form1.getBotonSeleccionadoCambioPlan()!=null && form1.getBotonSeleccionadoCambioPlan().equalsIgnoreCase("anterior")){
			if (session.getAttribute("BusquedaAbonadosForm")!=null){
				form1.setBotonSeleccionadoCambioPlan(null);
				session.removeAttribute("ResumenForm");
				session.setAttribute("ResumenForm", form1);
				return mapping.findForward("busquedaAbonados");
			}
		}
		
		//************ Va a la pagiba donde se hara el ingreso de los numeros frecuentes a los abonado (CPU) santiago ********************/
		if(form1.getBotonNumerosFrecuentesCPU()!=null && form1.getBotonNumerosFrecuentesCPU().equalsIgnoreCase("numfreccpu")){
			form1.setBotonNumerosFrecuentesCPU(null);	
			String fwdr = this.inicializaNumerosFrecuentes(form1, session);
			return mapping.findForward(fwdr);
		}		
		
		//******************flags, borrar al terminar*****************************
		logger.debug("form1.getCondicH()            ["+form1.getCondicH()+"]");
		logger.debug("form1.getSubCuentaCB()        ["+form1.getSubCuentaCB()+"]");
		logger.debug("form1.getTipoPlanRB()         ["+form1.getTipoPlanRB()+"]");
		logger.debug("form1.getCondicH()            ["+form1.getCondicH()+"]");
		logger.debug("form1.getCodActuacion()       ["+form1.getCodActuacion()+"]");
		logger.debug("form1.getCodPlanServNuevo()   ["+form1.getCodPlanServNuevo()+"]");
		logger.debug("form1.getCausaBajaCB()        ["+form1.getCausaBajaCB()+"]");
		//logger.debug("form1.getCausaBajaCB()      ["+form1.getCausaBajaCB()+"]");
		logger.debug("form1.getCodClienteDestSelec()["+form1.getCodClienteDestSelec()+"]");
		logger.debug("form1.getCargoBasicoSelec()   ["+form1.getCargoBasicoSelec()+"]");
		logger.debug("form1.getCodPlanTarifSelec()  ["+form1.getCodPlanTarifSelec()+"]");
		logger.debug("form1.getRangoPlanCB()        ["+form1.getRangoPlanCB()+"]");
		logger.debug("form1.getRadioTipoPlan()      ["+form1.getRadioTipoPlan()+"]");
		logger.debug("form1.getNumDiasDestino()     ["+form1.getNumDiasDestino()+"]");
		logger.debug("form1.getCelularPers()        ["+form1.getCelularPers()+"]");
		logger.debug("form1.getCambioDePlanRB()     ["+form1.getCambioDePlanRB()+"]");
		logger.debug("form1.getFecDesdeLlam()       ["+form1.getFecDesdeLlam()+"]");
		logger.debug("form1.getPrestacionCB()       ["+form1.getPrestacionCB()+"]");
		logger.debug("form1.getCausaCambioCB()      ["+form1.getCausaCambioCB()+"]");
		logger.debug("form1.getCodLimiteConsumo()   ["+form1.getCodLimiteConsumo()+"]");
		//*************************************************************************
		String codLimiteConsumoTMP[] = form1.getCodLimiteConsumo().split("-");
		if (codLimiteConsumoTMP!=null && codLimiteConsumoTMP.length>0)	form1.setCodLimiteConsumo(codLimiteConsumoTMP[0]);
		
		String siguiente = "cargosCPU";
		//form1.setObtenerCargos("SI"); 
		sessionData.setObtenerCargos("SI");

		//Obtención de la colección de aboandos que han sido seleccionados
		AbonadoDTO [] abonados =  delegate.obtenerAbonados(form1.getListaAbonados());

		// 2. para la combinatoria POSPAGOPOSPAGO EMPRESA, deshabilitar llamada a cargos de negocio y framework de cargos	    
		if(form1.getCombinatoria().equalsIgnoreCase("POSPAGOPOSPAGO") && sessionData.getCodOrdenServicio()== 40007){
			float impCargoBasicoOrigen=0;
			float impCargoBasicoDestino=0;

			if(sessionData.getAbonados()[0].getFlgRango()== FLG_PLAN_RANGO){
				CargoClienteDTO cargoCliente = new CargoClienteDTO();
				cargoCliente.setCodCliente(sessionData.getAbonados()[0].getCodCliente());
				cargoCliente.setFecha(new Date());
				logger.debug("obtenerCargoBasicoActual() :inicio");
				cargoCliente = delegate.obtenerCargoBasicoActual(cargoCliente);
				logger.debug("obtenerCargoBasicoActual() :fin");
				impCargoBasicoOrigen = cargoCliente.getImpCargo();

			}else{
				impCargoBasicoOrigen = Float.parseFloat(sessionData.getAbonados()[0].getImpCargoBasico());
			}

			//if(form1.getOpcionPlanORango().equals("PLAN")){
			/**rlozano
			 * form1.setCargoBasicoSelec viene vacio. se realiza validacion para q tome valor 0
			 */
			String cargBasicoSel=form1.getCargoBasicoSelec()==null||form1.getCargoBasicoSelec().trim().equals("")?"0":form1.getCargoBasicoSelec().trim();
			form1.setCargoBasicoSelec(cargBasicoSel);
			impCargoBasicoDestino = Float.parseFloat(form1.getCargoBasicoSelec());//impCargoBasico

		}

		String destinoTipoPlan=null;

		if(form1.getRadioTipoPlan().equals("combopre")) destinoTipoPlan="PREPAGO";
		if(form1.getRadioTipoPlan().equals("combopos"))	destinoTipoPlan="POSPAGO";
		if(form1.getRadioTipoPlan().equals("combohib"))	destinoTipoPlan="HIBRIDO";

		String codModulo=null;
		int codProducto=0;

		logger.debug("asignado valores de parametros generales : inicio");
		String[] constantesParam=new String[4];
		constantesParam[0]="COD_CAT_CTA_SEG_NUE";
		constantesParam[1]="MAX_INTENTOS";
		constantesParam[2]="EST_RESPCENTRAL";
		constantesParam[3]="COD_EST_TRX_PEND";
		codModulo="GA";
		codProducto=1;
		ParametroDTO[] arregloParamGrales=new ParametroDTO[constantesParam.length];
		arregloParamGrales=seteaParametros(constantesParam, codModulo, codProducto);
		logger.debug("asignado valores de parametros generales : fin");

		ParametroDTO retornoParamGral=null;
		for(int i=0; i<arregloParamGrales.length; i++){
			retornoParamGral=new ParametroDTO();
			logger.debug("obtenerParametroGeneral():inicio");
			retornoParamGral=delegate.obtenerParametroGeneral(arregloParamGrales[i]);
			arregloParamGrales[i]=retornoParamGral;
			logger.debug("arregloParamGrales["+i+"].getNomParametro   :"+arregloParamGrales[i].getNomParametro());
			logger.debug("arregloParamGrales["+i+"].getCodModulo      :"+arregloParamGrales[i].getCodModulo());
			logger.debug("arregloParamGrales["+i+"].getCodProducto    :"+arregloParamGrales[i].getCodProducto());
			logger.debug("arregloParamGrales["+i+"].getValor          :"+arregloParamGrales[i].getValor());
			logger.debug("arregloParamGrales["+i+"].getDescripcion    :"+arregloParamGrales[i].getDescripcion());
			logger.debug("obtenerParametroGeneral():fin");

		}


		logger.debug("asignando valores a parametros simples : inicio");
		String[] constantesParamSimples=new String[1];
		constantesParamSimples[0]="APLICA_ATLANTIDA";
		codModulo="GA";
		ParametroDTO[] arregloParamSimples=new ParametroDTO[constantesParamSimples.length];
		arregloParamSimples=seteaParametros(constantesParamSimples, codModulo, codProducto);
		logger.debug("asignando valores a parametros simples : fin");

		ParametroDTO retornoParamSimple=null;
		for(int i=0; i<arregloParamSimples.length; i++){
			retornoParamSimple=new ParametroDTO();
			logger.debug("obtenerParametrosSimples : inicio");
			retornoParamSimple=delegate.obtenerParametrosSimples(arregloParamSimples[i]);
			arregloParamSimples[i]=retornoParamSimple;
			logger.debug("arregloParamSimples["+i+"].getNomParametro   :"+arregloParamSimples[i].getNomParametro());
			logger.debug("arregloParamSimples["+i+"].getCodModulo      :"+arregloParamSimples[i].getCodModulo());
			logger.debug("arregloParamSimples["+i+"].getCodProducto    :"+arregloParamSimples[i].getCodProducto());
			logger.debug("arregloParamSimples["+i+"].getValor          :"+arregloParamSimples[i].getValor());
			logger.debug("arregloParamSimples["+i+"].getDescripcion    :"+arregloParamSimples[i].getDescripcion());
			logger.debug("obtenerParametrosSimples: fin");

		}

		RegistroPlanDTO registroPlan=null;
		ClienteDTO cliente=null;
		//AbonadoDTO abonado=null;
		ParamRegistroPlanDTO param=null;
		UsuarioDTO usuario=null;

		registroPlan=new RegistroPlanDTO();
		cliente=new ClienteDTO();
		//abonado=new AbonadoDTO();
		param=new ParamRegistroPlanDTO();
		
		usuario=new UsuarioDTO();

		//- Setear datos cliente
		cliente.setCodCliente(sessionData.getCliente().getCodCliente());
		cliente.setCodTipoTerminal(sessionData.getCliente().getCodTipoTerminal());
		cliente.setCodCuenta(sessionData.getCliente().getCodCuenta());
		cliente.setCodCiclo(sessionData.getCliente().getCodCiclo());

		//vendedor
		usuario.setNombre(sessionData.getUsuario());
		usuario= delegate.obtenerVendedor(usuario);
		
		//tipo movimiento
		param.setCodTipoMovimiento(sessionData.getAbonados()[0].getCodTipoPlanTarif()+form1.getTipoPlanTarifDestino());

		//- Setear parametros sueltos
		if ( (sessionData.getCodOrdenServicio() == 40006) ||(sessionData.getCodOrdenServicio() == 40008)){
	    	if( param.getCodTipoMovimiento().equals("EE")){
				param.setSujeto("C");
	    		param.setCodSujeto(cliente.getCodCliente());
	    	}
	    	else{
	    		param.setSujeto("A");
	    		param.setCodSujeto(sessionData.getAbonados()[0].getNumAbonado());
	    	}
	    	
		}else{
			param.setSujeto("C");
			param.setCodSujeto(cliente.getCodCliente());
		}
		
		param.setCombinatoria(sessionData.getAbonados()[0].getDesTipPlan()+ destinoTipoPlan); 
		param.setCodTipModi(form1.getCodActuacion());
		param.setCodOOSS(form1.getCodOSAnt());
		param.setTipOOSS(String.valueOf(sessionData.getCodOrdenServicio())); //corresponde al codOS del link
		param.setCodPlanTarifDestino(form1.getCodPlanTarifSelec()); //corresponde al plan tarifario seleccionado por el usuario
		
		// Cantidad de abonados seleccionados
		int cantAboSel = 0;
		
		if  ( 
			  sessionData.getCodOrdenServicio()== 40006 || 
			  sessionData.getCodOrdenServicio()== 40008
			)
		{
			cantAboSel = abonados.length;  
		} 
		else if	(sessionData.getCodOrdenServicio()== 40007){
			// Si es empresa que haga el seteo con la cantidad total de abonados
			cantAboSel = sessionData.getCliente().getNumAbonados();
		}
		
		param.setCantLineasCodPlanTarifDestino(cantAboSel);
		
		param.setNomUsuaOra(sessionData.getUsuario());
		param.setParamRenova(sessionData.getParamRenova());   // INI P-MIX-09003 OCB
		param.setCodCausaCambioPlan(form1.getCausaCambioCB());// INI P-MIX-09003 pv 110809
		param.setCodOS(String.valueOf(form1.getCodOSAnt()));
		param.setAplicaTraspaso(form1.getAplicaTraspaso());
		param.setCodActAbo(form1.getCodActuacion());
		param.setCodPlanServNuevo(form1.getCodPlanServNuevo());
		param.setNumDiaDestino(form1.getNumDiasDestino());		
		param.setCodCausaBajaSel(form1.getCausaBajaCB());
		param.setCodCausaExcepcion(form1.getCausaExcepcionCB()!=null?Integer.parseInt(form1.getCausaExcepcionCB()):-1);
		param.setCodActAboAux(form1.getCodActAboAux());
		param.setCelularPers(form1.getCelularPers());
		param.setIndTraspaso(form1.getIndTraspaso());
		param.setCodCicloClienteDestino(form1.getCodCicloClienteDestino());
		param.setNumFrecFijos(form1.getNumFrecFijos());
		param.setNumFrecMovil(form1.getNumFrecMovil());
		param.setIndFF(form1.getIndFf());
		param.setNumFrecIng(form1.getNumFrecIng());
		param.setCodEmpresaDestino(form1.getCodEmpresaDestino());

		
		if (form1.getSaldo()!=null && !form1.getSaldo().trim().equals("")){
			if (!(form1.getSaldo().equalsIgnoreCase("null")))
				param.setValorOOSS(Float.parseFloat(form1.getSaldo()));
		}
			
		
		//(+)evera 23/04/08
		if (form1.getFecDesdeLlam() == null || form1.getFecDesdeLlam().trim().equals("null") || form1.getFecDesdeLlam().trim().equals("")){
			//Cargar fecha actual
			Date fecha = new Date();
			form1.setFecDesdeLlam(Formatting.dateTime(fecha, "dd-MM-yyyy"));
		}
		//(-)evera
		param.setFecDesdeLlam(form1.getFecDesdeLlam());
		param.setFechaDesde(Formatting.getFecha(form1.getFecDesdeLlam(), "dd-MM-yyyy"));
		param.setFecDesdeLlamTS(Timestamp.valueOf(Formatting.dateTime(param.getFechaDesde(),"yyyy-MM-dd")+" 00:00:00.000000000"));

		for(int i=0; i<arregloParamGrales.length; i++){
			if(arregloParamGrales[i].getNomParametro().equalsIgnoreCase("COD_CAT_CTA_SEG_NUE")) param.setCodCatCtaSegNue(arregloParamGrales[i].getValor());
			if(arregloParamGrales[i].getNomParametro().equalsIgnoreCase("MAX_INTENTOS")) param.setMaxIntentos(arregloParamGrales[i].getValor());
			if(arregloParamGrales[i].getNomParametro().equalsIgnoreCase("EST_RESPCENTRAL")) param.setEstRespCentral(arregloParamGrales[i].getValor());
			if(arregloParamGrales[i].getNomParametro().equalsIgnoreCase("COD_EST_TRX_PEND")) param.setCodEstTrxPend(arregloParamGrales[i].getValor());
		}
		param.setAplicaAtlantida(arregloParamSimples[0].getValor());
		param.setCodEstadoPend(param.getCodEstTrxPend());
		param.setCodEstadoPendInt(Integer.parseInt(param.getCodEstTrxPend()));
		param.setComentario("");

		Date fecha = new Date();
		Timestamp fechaActual = new Timestamp(fecha.getTime());
		param.setFechaActual(fechaActual);
		
	 if( (sessionData.getCodOrdenServicio()== 40006)
		 &&
		 (form1.getCombinatoria().equalsIgnoreCase("POSPAGOPOSPAGO") || 
		  form1.getCombinatoria().equalsIgnoreCase("HIBRIDOHIBRIDO") ||
		  form1.getCombinatoria().equalsIgnoreCase("POSPAGOHIBRIDO") || 
		  form1.getCombinatoria().equalsIgnoreCase("HIBRIDOPOSPAGO")) 
		){
		 
		//evera 05 de julio, siempre es aciclo para estas combinatorias
		//form1.setCambioDePlanRB("aciclo"); // despues del 14 de agosto esta linea de código queda obsoleta OCB - PVAR
		
		if (form1.getCambioDePlanRB() != null){
			
			String periodoCodCiclFact = (String)session.getAttribute("periodoCodCiclFact");
			String fecDesdeLlama = (String)session.getAttribute("fecDesdeLlam");
			String tipoEjecucion = "C";
			if(form1.getCambioDePlanRB().trim().equals("aciclo")){
				param.setCodHolding("99");
				param.setFecDesdeLlam(fecDesdeLlama);
				param.setPeriodoFact(Integer.parseInt(periodoCodCiclFact));
				
				SimpleDateFormat fechaDesde = new SimpleDateFormat("dd-MM-yyyy");
				java.util.Date fecha2 = fechaDesde.parse(fecDesdeLlama); 
				param.setFechaDesde(fecha2);
				param.setFecDesdeLlamTS(new Timestamp(fecha2.getTime()));
				
			}else{
				tipoEjecucion = "I";
				param.setCodHolding("0");
				
				Date fechaAct = new Date();
				SimpleDateFormat formato = new SimpleDateFormat("dd-MM-yyyy");
				String cadenaFecha = formato.format(fechaAct);	
				
				param.setFecDesdeLlam(cadenaFecha);
				param.setPeriodoFact(0);
				param.setFechaDesde(fechaActual);
				param.setFecDesdeLlamTS(new Timestamp(fechaActual.getTime()));
			}
			param.setPeriodoFactAux(Integer.parseInt(periodoCodCiclFact));
			param.setIndEjecucion(tipoEjecucion);

			SimpleDateFormat fechaFutura = new SimpleDateFormat("dd-MM-yyyy");
			java.util.Date fecha3 = fechaFutura.parse(fecDesdeLlama); 
			param.setFechaFutura(fecha3);
			
		}

		//(+) evera 090408
		//cambioDePlanRB
		String rb = form1.getCambioDePlanRB();
		logger.debug("cambioDePlanRB="+rb);
		if (rb.equals("inmediato")){
			param.setFecDesdeLlamAux("*");
		}
		//(-) evera
		
	 }//fin  if( (sessionData.getCodOrdenServicio()== 40006)

		
		if (sessionData.getCodOrdenServicio()== 40007){
			param.setCodHolding(String.valueOf(sessionData.getCliente().getCodEmpresa()));
		}
		
		param.setCodSubCuentaDestino(form1.getSubCuentaCB());
		param.setCodClienteDestino(Long.parseLong(form1.getCodClienteDestSelec()));
		param.setImpCargoBasicoDestino(Float.parseFloat(form1.getCargoBasicoSelec()));
		if(form1.getRadioTipoPlan().equalsIgnoreCase("combopre"))param.setCodTipPlanDestino("1");
		if(form1.getRadioTipoPlan().equalsIgnoreCase("combopos"))param.setCodTipPlanDestino("2");
		if(form1.getRadioTipoPlan().equalsIgnoreCase("combohib"))param.setCodTipPlanDestino("3");
		param.setCodCuentaDestino(sessionData.getCliente().getCodCuenta());
		//param.setCodLimiteConsumoDestino(form1.getCodLimiteConsumoSelec());
		param.setCodCargoBasicoDestino(form1.getCodCargoBasicoDestino());
		param.setModuloEspecial("MODULO_ESPECIAL");		
		param.setTipPlanTarifDestino(form1.getTipoPlanTarifDestino());		
		if(form1.getCambioDePlanRB()!=null && form1.getCambioDePlanRB().equals("inmediato")){
			param.setFechaProgramacion(new Date());
		}else{
			String fecDesdeLlam = (String)session.getAttribute("fecDesdeLlam");
			SimpleDateFormat format = new SimpleDateFormat("dd-MM-yyyy");
			try{
				Date fechaProg = format.parse(fecDesdeLlam);
				param.setFechaProgramacion(fechaProg);
			}catch(Exception e){}
		}

		//(+) EV 11/12/09
		param.setCodLimiteConsumoDestino(form1.getCodLimiteConsumo());
		param.setMontoLimiteConsumoDestino(form1.getMontoLimiteConsumo());
		//(-)
		
		if(form1.getCombinatoria().equalsIgnoreCase("PREPAGOHIBRIDO") && sessionData.getCodOrdenServicio()== 40006){
		
			String moduloGE =  global.getValor("codigo.modulo.GE");
			int codigoProducto = Integer.parseInt(global.getValor("codigo.producto"));
	
            //Si se cumple condición se realiza prorrateo, en caso contrario se mantiene el valor
            //del importe del plan y se le aplica los impuestos correspondientes
			ParametroDTO parametro = new ParametroDTO();
			parametro.setCodModulo(moduloGE);
			parametro.setCodProducto(codigoProducto);
			parametro.setNomParametro(global.getValor("parametro.formato.fecha1"));
			parametro = delegate.obtenerParametroGeneral(parametro);
			String sFormatoFecha = parametro.getValor();
			
            RegistroFacturacionDTO registroFacturacionDTO = new RegistroFacturacionDTO();
            registroFacturacionDTO.setCodigoCicloFacturacion(form1.getCodCicloClienteDestino());
            registroFacturacionDTO.setFormatoFecha(sFormatoFecha);

            registroFacturacionDTO = delegate.getDiasProrrateo(registroFacturacionDTO);
            float fImportePlan = Float.parseFloat(sessionData.getAbonados()[0].getImpCargoBasico());
            if (registroFacturacionDTO!=null){
                        fImportePlan = (fImportePlan * registroFacturacionDTO.getDiasDiferencia()/ registroFacturacionDTO.getDiasProrrateo());
            }

            RegistroFacturacionDTO registroFacturacionDTO2 = new RegistroFacturacionDTO();
            registroFacturacionDTO2.setCodigoCliente(form1.getCodClienteDestSelec());
            
			parametro = new ParametroDTO();
			parametro.setCodModulo(moduloGE);
			parametro.setCodProducto(codigoProducto);
			parametro.setNomParametro(global.getValor("parametro.decimal.facturacion"));
			parametro = delegate.obtenerParametroGeneral(parametro);
			String sDecimales = parametro.getValor();
            int numDecimalBD = Integer.parseInt(sDecimales);
            
            registroFacturacionDTO2.setCodigoOficina(usuario.getCodOficina());
            Double  dValorImporteAux = new Double((fImportePlan*Math.pow(10,numDecimalBD))/Math.pow(10,numDecimalBD));
            fImportePlan =  dValorImporteAux.floatValue();
            registroFacturacionDTO2.setImportePlan(fImportePlan);
            registroFacturacionDTO2 = delegate.aplicaImpuestoImporte(registroFacturacionDTO2);

            if (registroFacturacionDTO2!=null) 	param.setImportePlan(registroFacturacionDTO2.getImporteTotal());
		}
		
		//Inicio INC 180388 - FADL - 30/01/2012
		if(form1.getCombinatoria().equalsIgnoreCase("POSPAGOPOSPAGO") && sessionData.getCodOrdenServicio()== 40008){
			
			if(form1.getCambioDePlanRB().trim().equals("inmediato")){
				
				param.setFechaDesde(fechaActual);
			}
		}
		//Fin INC 180388 - FADL - 30/01/2012
		
		//if(form1.getCambioDePlanRB().trim().equals("aciclo")){ esto se utilizara despues del 14 de agosto ocb-pvar
		if("0".equals(param.getCodHolding()))
		{
			param.setInmdCiclo(0);
		}else//if(param.setCodHolding("99")
		{
			param.setInmdCiclo(1);
		}
		
		registroPlan.setCliente(cliente);
		//registroPlan.setAbonado(abonado); //no es necesario, se obtiene de la lista de session
		
		/** precalificados ini 070610 pv*/
		String accioncal = "0";
		if(form1.getCombinatoria().equalsIgnoreCase("PREPAGOPOSPAGO"))
		{
			accioncal = global.getValor("accion.prepagopospago");
		}
		if(form1.getCombinatoria().equalsIgnoreCase("PREPAGOHIBRIDO"))
		{
			accioncal = global.getValor("accion.prepagohibrido");
		}
		param.setCodAccioncal(Integer.parseInt(accioncal));
		/** precalificados fin */
		
		registroPlan.setParamRegistroPlan(param);
		registroPlan.setUsuario(usuario);

		logger.debug("registroPlan.getCliente().getCodCliente()             : "+ registroPlan.getCliente().getCodCliente());
		logger.debug("registroPlan.getCliente().getCodTipoTerminal()        : "+ registroPlan.getCliente().getCodTipoTerminal());
		logger.debug("registroPlan.getCliente().getCodCuenta()        		: "+ registroPlan.getCliente().getCodCuenta());
		logger.debug("registroPlan.getCliente().getCodCiclo()       		: "+ registroPlan.getCliente().getCodCiclo());
		
		if (sessionData.getAbonados().length == 1){
			logger.debug("sessionData.getAbonados()[0].getNumAbonado()             : "+ sessionData.getAbonados()[0].getNumAbonado());
			logger.debug("sessionData.getAbonados()[0].getCodTecnologia()          : "+ sessionData.getAbonados()[0].getCodTecnologia());
			logger.debug("sessionData.getAbonados()[0].getCodCentral()             : "+ sessionData.getAbonados()[0].getCodCentral());
			logger.debug("sessionData.getAbonados()[0].getNumCelular()             : "+ sessionData.getAbonados()[0].getNumCelular());
			logger.debug("sessionData.getAbonados()[0].getNumSerie()               : "+ sessionData.getAbonados()[0].getNumSerie());
			logger.debug("sessionData.getAbonados()[0].getNumImei()                : "+ sessionData.getAbonados()[0].getNumImei());
			logger.debug("sessionData.getAbonados()[0].getCodTipPlan()             : "+ sessionData.getAbonados()[0].getCodTipPlan());
			logger.debug("sessionData.getAbonados()[0].getCodPlanTarif()           : "+ sessionData.getAbonados()[0].getCodPlanTarif());
		}
		logger.debug("registroPlan.getUsuario().getCodigo()           		: "+ registroPlan.getUsuario().getCodigo());

		logger.debug("registroPlan.getParamRegistroPlan().getSujeto()                 : "+ registroPlan.getParamRegistroPlan().getSujeto());
		logger.debug("registroPlan.getParamRegistroPlan().getCombinatoria()           : "+ registroPlan.getParamRegistroPlan().getCombinatoria());
		logger.debug("registroPlan.getParamRegistroPlan().getCodTipModi()             : "+ registroPlan.getParamRegistroPlan().getCodTipModi());
		logger.debug("registroPlan.getParamRegistroPlan().getCodOOSS()                : "+ registroPlan.getParamRegistroPlan().getCodOOSS());
		logger.debug("registroPlan.getParamRegistroPlan().getTipOOSS()                : "+ registroPlan.getParamRegistroPlan().getTipOOSS());
		logger.debug("registroPlan.getParamRegistroPlan().getCodPlanTarifDestino()    : "+ registroPlan.getParamRegistroPlan().getCodPlanTarifDestino());
		logger.debug("registroPlan.getParamRegistroPlan().getTipoPlanTarifDestino()   : "+ registroPlan.getParamRegistroPlan().getTipPlanTarifDestino());
		logger.debug("registroPlan.getParamRegistroPlan().getNomUsuaOra()             : "+ registroPlan.getParamRegistroPlan().getNomUsuaOra());
		logger.debug("registroPlan.getParamRegistroPlan().getNumOOSS()                : "+ registroPlan.getParamRegistroPlan().getNumOOSS());
		logger.debug("registroPlan.getParamRegistroPlan().getAplicaTraspaso()         : "+ registroPlan.getParamRegistroPlan().getAplicaTraspaso());
		logger.debug("registroPlan.getParamRegistroPlan().getCodActAbo()              : "+ registroPlan.getParamRegistroPlan().getCodActAbo());
		logger.debug("registroPlan.getParamRegistroPlan().getCodActAboAux()           : "+ registroPlan.getParamRegistroPlan().getCodActAboAux());
		logger.debug("registroPlan.getParamRegistroPlan().getCodPlanServNuevo()       : "+ registroPlan.getParamRegistroPlan().getCodPlanServNuevo());
		logger.debug("registroPlan.getParamRegistroPlan().getCodCatCtaSegNue()        : "+ registroPlan.getParamRegistroPlan().getCodCatCtaSegNue());
		logger.debug("registroPlan.getParamRegistroPlan().getMaxIntentos()            : "+ registroPlan.getParamRegistroPlan().getMaxIntentos());
		logger.debug("registroPlan.getParamRegistroPlan().getEstRespCentral()         : "+ registroPlan.getParamRegistroPlan().getEstRespCentral());
		logger.debug("registroPlan.getParamRegistroPlan().getCodEstTrxPend()          : "+ registroPlan.getParamRegistroPlan().getCodEstTrxPend());
		logger.debug("registroPlan.getParamRegistroPlan().getAplicaAtlantida()        : "+ registroPlan.getParamRegistroPlan().getAplicaAtlantida());
		logger.debug("registroPlan.getParamRegistroPlan().getCodEstadoPend()          : "+ registroPlan.getParamRegistroPlan().getCodEstadoPend());
		logger.debug("registroPlan.getParamRegistroPlan().getComentario()             : "+ registroPlan.getParamRegistroPlan().getComentario());
		logger.debug("registroPlan.getParamRegistroPlan().getCodEstadoPendInt()       : "+ registroPlan.getParamRegistroPlan().getCodEstadoPendInt());
		logger.debug("registroPlan.getParamRegistroPlan().getFechaActual()            : "+ registroPlan.getParamRegistroPlan().getFechaActual());
		logger.debug("registroPlan.getParamRegistroPlan().getCodSubCuentaDestino()    : "+ registroPlan.getParamRegistroPlan().getCodSubCuentaDestino());
		logger.debug("registroPlan.getParamRegistroPlan().getCodClienteDestino()      : "+ registroPlan.getParamRegistroPlan().getCodClienteDestino());
		logger.debug("registroPlan.getParamRegistroPlan().getImpCargoBasicoDestino()  : "+ registroPlan.getParamRegistroPlan().getImpCargoBasicoDestino());
		logger.debug("registroPlan.getParamRegistroPlan().getCodTipPlanDestino()      : "+ registroPlan.getParamRegistroPlan().getCodTipPlanDestino());
		logger.debug("registroPlan.getParamRegistroPlan().getCodCuentaDestino()       : "+ registroPlan.getParamRegistroPlan().getCodCuentaDestino());
		logger.debug("registroPlan.getParamRegistroPlan().getCodLimiteConsumoDestino(): "+ registroPlan.getParamRegistroPlan().getCodLimiteConsumoDestino());
		logger.debug("registroPlan.getParamRegistroPlan().getCodCargoBasicoDestino()  : "+ registroPlan.getParamRegistroPlan().getCodCargoBasicoDestino());
		logger.debug("registroPlan.getParamRegistroPlan().getModuloEspecial()         : "+ registroPlan.getParamRegistroPlan().getModuloEspecial());
		logger.debug("registroPlan.getParamRegistroPlan().getFecDesdeLlam()           : "+ registroPlan.getParamRegistroPlan().getFecDesdeLlam());
		logger.debug("registroPlan.getParamRegistroPlan().getPeriodoFact()            : "+ registroPlan.getParamRegistroPlan().getPeriodoFact());
		logger.debug("registroPlan.getParamRegistroPlan().getCodCicloClienteDestino() : "+ registroPlan.getParamRegistroPlan().getCodCicloClienteDestino());
		logger.debug("registroPlan.getParamRegistroPlan().getNumFrecFijos()           : "+ registroPlan.getParamRegistroPlan().getNumFrecFijos());
		logger.debug("registroPlan.getParamRegistroPlan().getNumFrecMovil()           : "+ registroPlan.getParamRegistroPlan().getNumFrecMovil());
		logger.debug("registroPlan.getParamRegistroPlan().getIndFf()                  : "+ registroPlan.getParamRegistroPlan().getIndFF());		
		logger.debug("registroPlan.getParamRegistroPlan().getCodTipoMovimiento()      : "+ registroPlan.getParamRegistroPlan().getCodTipoMovimiento());
		logger.debug("registroPlan.getParamRegistroPlan().getCodHolding()             : "+ registroPlan.getParamRegistroPlan().getCodHolding());		
		logger.debug("registroPlan.getParamRegistroPlan().getCodEmpresaDestino()      : "+ registroPlan.getParamRegistroPlan().getCodEmpresaDestino());
		logger.debug("registroPlan.getParamRegistroPlan().getImportePlan()            : "+ registroPlan.getParamRegistroPlan().getImportePlan());
		logger.debug("registroPlan.getParamRegistroPlan().getCantLineasCodPlanTarifDestino(): "+ registroPlan.getParamRegistroPlan().getCantLineasCodPlanTarifDestino());
		logger.debug("registroPlan.getParamRegistroPlan().getParamRenova()            : "+ registroPlan.getParamRegistroPlan().getParamRenova());
		logger.debug("registroPlan.getParamRegistroPlan().getCodCausaCambioPlan()     : "+ registroPlan.getParamRegistroPlan().getCodCausaCambioPlan());
		logger.debug("registroPlan.getParamRegistroPlan().getFechaDesde()             : "+ registroPlan.getParamRegistroPlan().getFechaDesde());
		logger.debug("registroPlan.getParamRegistroPlan().getPeriodoFactAux()         : "+ registroPlan.getParamRegistroPlan().getPeriodoFactAux());
		logger.debug("registroPlan.getParamRegistroPlan().getIndEjecucion()           : "+ registroPlan.getParamRegistroPlan().getIndEjecucion());
		logger.debug("registroPlan.getParamRegistroPlan().getFechaFutura()            : "+ registroPlan.getParamRegistroPlan().getFechaFutura());
		logger.debug("registroPlan.getParamRegistroPlan().getCodAccioncal()           : "+ registroPlan.getParamRegistroPlan().getCodAccioncal());
		
		session.removeAttribute("registroPlan");	    
		session.setAttribute("registroPlan", registroPlan);	

		logger.debug("siguiente      :"+siguiente);
		logger.debug("executeAction():end");
		return mapping.findForward(siguiente);

	}

	public ParametroDTO[] seteaParametros(String[] constantes, String modulo, int producto){

		ParametroDTO[] arregloRetorno=new ParametroDTO[constantes.length];
		for(int i=0;i<constantes.length;i++){
			ParametroDTO parametro=new ParametroDTO();
			parametro.setNomParametro(constantes[i]);
			parametro.setCodModulo(modulo);
			parametro.setCodProducto(producto);
			arregloRetorno[i]=parametro;
		}
		return arregloRetorno;
	}

	private String[] convertirStringListAStringArray(List lista){
		String retorno[] = null;
		if(lista!=null){
			retorno = new String[lista.size()];
			for(int i = 0; i<retorno.length;i++){
				retorno[i] = (String)lista.get(i);
			}
		}
		return retorno;
	}


	private String inicializaNumerosFrecuentes(CambiarPlanForm form, HttpSession session) throws ManReqException{				
		//Se obtiene los valores maximos para cada tipo
		int  maximoNumFijos = form.getNumFrecFijos();
		int  maximoNumMoviles = form.getNumFrecMovil();
		System.out.println("maximoNumFijos: "+maximoNumFijos+" maximoNumMoviles: "+maximoNumMoviles);

		long cantMax = form.getNumFrecFijos()+ form.getNumFrecMovil();		
		System.out.println("santiago cantMax: "+cantMax);
		Long cantMaxNrosFrecuentes = new Long(cantMax);
		//Se obtiene la lista de abonados seleccionados
	
		//Se crea la lista de tipos de números
		ArrayList arrTipos = new ArrayList();
		arrTipos.add("MOVILES");
		arrTipos.add("RED-FIJA");		
		//arrTipos.add("ON-NET");
		//arrTipos.add("OFF-NET");					
		
		ArrayList numerosFrecuentesTipoListDTO = null;
		AbonadoNumerosFrecuentesDTO anbonadoNumFrecDTO = null;
		if (session.getAttribute("abonadoNumerosFrecuentesListDTO")!=null && session.getAttribute("anbonadoNumFrecDTO")!=null){
			numerosFrecuentesTipoListDTO = (ArrayList)session.getAttribute("abonadoNumerosFrecuentesListDTO");	
			anbonadoNumFrecDTO = (AbonadoNumerosFrecuentesDTO) session.getAttribute("anbonadoNumFrecDTO");
			for (int l = 0;l<numerosFrecuentesTipoListDTO.size();l++) {				
				NumeroFrecuenteTipoListDTO numeroFrecuenteTipoListDTO = (NumeroFrecuenteTipoListDTO)numerosFrecuentesTipoListDTO.get(l);
				NumeroFrecuenteDTO [] numFrecuentesIngresadosList = numeroFrecuenteTipoListDTO.getNumFrecuentesIngresadosList();
				String tp = numeroFrecuenteTipoListDTO.getTipo();
				NumeroFrecuenteDTO [] numFrecuentesMovilesList = new NumeroFrecuenteDTO[maximoNumMoviles];
				NumeroFrecuenteDTO [] numFrecuentesFijosList = new NumeroFrecuenteDTO[maximoNumFijos];
				boolean add = false;
				if(numFrecuentesIngresadosList.length>0){
					System.out.println("inicializaNumerosFrecuentes: numFrecuentesIngresadosList.length:"+numFrecuentesIngresadosList.length+" numFrecuentesMovilesList.length: "+numFrecuentesMovilesList.length);
					if (tp.equals("MOVILES")) {						
						for(int m = 0; m < numFrecuentesMovilesList.length; m++) {
							add = true;
							try {
								if (numFrecuentesIngresadosList[m]!=null){
									numFrecuentesMovilesList[m] = numFrecuentesIngresadosList[m];
								} else {
									add = false;
								}
							} catch(ArrayIndexOutOfBoundsException ai) {
								add = false;
								//ai.printStackTrace();
							}
						}		
						if (add) {
							numeroFrecuenteTipoListDTO.setNumFrecuentesIngresadosList(numFrecuentesMovilesList);
						}
					} else if (tp.equals("RED-FIJA")) {
						for(int f = 0; f < numFrecuentesFijosList.length; f++) {
							add = true;
							try {
								if (numFrecuentesIngresadosList[f]!=null) {
									numFrecuentesFijosList[f] = numFrecuentesIngresadosList[f];	
								} else {
									add = false;
								}
							} catch(ArrayIndexOutOfBoundsException ai) {
								add = false;								
								//ai.printStackTrace();								
							}							
						}				
						if (add) {
							numeroFrecuenteTipoListDTO.setNumFrecuentesIngresadosList(numFrecuentesFijosList);
						}					
					}
					numerosFrecuentesTipoListDTO.remove(l);
					numerosFrecuentesTipoListDTO.add(l, numeroFrecuenteTipoListDTO);
				}
			}
		} else {
			numerosFrecuentesTipoListDTO = new ArrayList();
			anbonadoNumFrecDTO = new AbonadoNumerosFrecuentesDTO();																		
		
			NumeroFrecuenteTipoListDTO numeroFrecuenteTipoListDTO = null;
			for (int x = 0; x < 2; x++){				
				numeroFrecuenteTipoListDTO = new NumeroFrecuenteTipoListDTO();
				numeroFrecuenteTipoListDTO.setTipo((String) arrTipos.get(x));
				if (((String)arrTipos.get(x)).equals("MOVILES")) {
					numeroFrecuenteTipoListDTO.setCantidadMaxTipo(maximoNumMoviles);
				} else {
					numeroFrecuenteTipoListDTO.setCantidadMaxTipo(maximoNumFijos);
				}
				
				NumeroFrecuenteDTO [] numFrecuentesIngresadosList = new NumeroFrecuenteDTO[0];
				numeroFrecuenteTipoListDTO.setNumFrecuentesIngresadosList(numFrecuentesIngresadosList);
				numerosFrecuentesTipoListDTO.add(numeroFrecuenteTipoListDTO);
			}										
			anbonadoNumFrecDTO.setNumerosFrecuentesTipoListDTO(numerosFrecuentesTipoListDTO);			
		}										

		//NOTA ESTO DEBE IR EN EL ACTION DE NUMEROSFRECUENTESCPU		
		session.setAttribute("anbonadoNumFrecDTO", anbonadoNumFrecDTO); 
		session.setAttribute("maximoNumFijos", ""+maximoNumFijos);
		session.setAttribute("maximoNumMoviles", ""+maximoNumMoviles);		
		//session.setAttribute("maximoOnNet", maximoOnNet);
		//session.setAttribute("maximoOffNet", maximoOffNet);
		session.setAttribute("cantMaxNrosFrecuentes", cantMaxNrosFrecuentes);
		session.setAttribute("numFrecDeOtrosProductos", "");
		session.setAttribute("abonadoNumerosFrecuentesListDTO", numerosFrecuentesTipoListDTO);
	    session.setAttribute("arrTipos", arrTipos);
	    session.setAttribute("maxNumPermitido", null);		
		session.setAttribute("paginaRegreso",form.getPaginaRegreso());
	    
		return "numerosfrecuentescpu";
	}


}
