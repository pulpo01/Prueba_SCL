package com.tmmas.scl.operations.crm.fab.cim.manreq.web.helper;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import uk.ltd.getahead.dwr.WebContext;
import uk.ltd.getahead.dwr.WebContextFactory;

import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioListOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioOutDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaSaldoDTO;
import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteTipoPlanListDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.LimiteLineasDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ObtencionLineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CicloDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConvertActAboDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RestriccionesDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ValidaOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntarcelDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ValidaPermanenciaDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productPromotionABE.dataTransferObject.EliminaPromocionDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.ConsultaPrepagosDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.EvalCrediticiaDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.MensajeDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ParametrosCondicionesCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.RespuestaClienteDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.RespuestaEvalCrediticiaDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.RespuestaPlanTarifarioDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.RetornoCondicionesCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.RetornoListaAjaxDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.RetornoListaClientesDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.vendedor.dto.ConfiguracionVendedorCPUDTO;
import com.tmmas.scl.vendedor.dto.UsuarioSistemaDTO;
import com.tmmas.scl.vendedor.dto.UsuarioVendedorDTO;
import com.tmmas.scl.vendedor.exception.VendedorException;


public class CondicionesOOSSReorden {
	private final Logger logger = Logger.getLogger(CondicionesOOSSReorden.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	private Map abonadosMap;
	private AbonadoDTO[] listaAbonados;
	private AbonadoDTO[] listaAbonadosSel;
	private ClienteDTO cliente;
	private ParametroListDTO paramGeneral;
	private MensajeDTO[] mensajes;
	private int MSGCONFIRM;
	private int MSGACEPTAR;
	
	//parametros segun combinatoria
	private long codOOSS;
	private String combinatoria;
	private long codOSAnt;
	private String codActuacion;
	private String codActuacionWeb;
	
	/**
	 * Crea e inicializa los códigos de mensajes que seran usados para interactuar con el usuario web
	 *
	 */
	private void cargaMensajes(){
		//inicializa mensajes
		ArrayList lista = new ArrayList();
		MensajeDTO mensaje = null;
		
		mensaje =  new MensajeDTO(); mensaje.setCodigo("a.001"); mensaje.setRespuesta("I"); lista.add(mensaje);
		mensaje =  new MensajeDTO(); mensaje.setCodigo("a.002"); mensaje.setRespuesta("I"); lista.add(mensaje);
		mensaje =  new MensajeDTO(); mensaje.setCodigo("c.001"); mensaje.setRespuesta("I"); lista.add(mensaje);
		mensaje =  new MensajeDTO(); mensaje.setCodigo("c.002"); mensaje.setRespuesta("I"); lista.add(mensaje);
		mensaje =  new MensajeDTO(); mensaje.setCodigo("c.003"); mensaje.setRespuesta("I"); lista.add(mensaje);
					
		//pospagoprepago
		this.mensajes = (MensajeDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	lista.toArray(), MensajeDTO.class);
		
	}


	/**
	 * Carga el valor de respuesta de un mensaje enviado al usuario
	 * @param codigo
	 * @param respuesta
	 */
	private void repondeMensaje(String codigo, String respuesta){
		
		for(int i=0; i<this.mensajes.length; i++){
			if(this.mensajes[i].getCodigo().equals(codigo)){
				this.mensajes[i].setRespuesta(respuesta);
				break;
			}
		}
	}

	/**
	 * Obtiene el valor de respuesta asignado al mensaje
	 * 
	 * @param codigo
	 * @return
	 */
	private String obtieneRespuestaMensaje(String codigo){
		String respuesta = " ";
		
		for(int i=0; i<this.mensajes.length; i++){
			if(this.mensajes[i].getCodigo().equals(codigo)){
				respuesta = this.mensajes[i].getRespuesta();
				break;
			}
		}
		return respuesta;
	}
	
	
	/**
	 * Carga en memoria la lista de abonados seleccionados a partir de un arreglos de números de abonados
	 * @param abonadosSel
	 */
	private void cargaAbonadosSeleccionados(long[] abonadosSel){
		AbonadoDTO[] seleccion = new AbonadoDTO[abonadosSel.length];
		
		logger.debug("totalAbo="+abonadosSel.length);
		
		for(int i=0; i<abonadosSel.length; i++){
			seleccion[i] = (AbonadoDTO) this.abonadosMap.get(String.valueOf(abonadosSel[i]));
		}
		this.listaAbonadosSel = (AbonadoDTO[])seleccion;
	}

	/**
	 * Realiza la carga inicial de la informacion que debe quedar en memoria para su uso posterior
	 * @param codCliente
	 */
	public void cargaInicial(){
		logger.debug("cargaInicial : inicio");
		
		cargaMensajes();
		
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);
		
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		
		try{
		    if (sessionData!=null){
		    	logger.debug("carga datos desde session");
		    	
		    	this.cliente = sessionData.getCliente();
		    	this.listaAbonados = sessionData.getAbonados();
		    	
				//los deja disponible en un map, para hacer mas facil su busqueda
				this.abonadosMap = new HashMap();
				logger.debug("this.listaAbonados.length="+this.listaAbonados.length);
				for(int i=0; i<this.listaAbonados.length; i++){
					this.abonadosMap.put(String.valueOf(this.listaAbonados[i].getNumAbonado()), this.listaAbonados[i]);
				}
		    }

			//obtiene parametros generales
			logger.debug("obtenerParametrosGenerales :antes");
			this.paramGeneral = delegate.obtenerParametrosGenerales();
			logger.debug("obtenerParametrosGenerales :despues");
			//obtener info de constantes:
			this.MSGCONFIRM = Integer.parseInt(global.getValor("MSGCONFIRMAR"));
			this.MSGACEPTAR = Integer.parseInt(global.getValor("MSGACEPTAR"));
			
		}catch(Exception e){
			logger.debug("Exception "+e);
		}
		logger.debug("cargaInicial : fin");
	}
	
	public void obtenerLimiteLineas(){
		ObtencionLineasClienteDTO obtencionLinea = new ObtencionLineasClienteDTO();
		
		obtencionLinea.setCodCliente(cliente.getCodCliente());
		obtencionLinea.setCodCuenta(cliente.getCodCuenta());
		obtencionLinea.setCodTipIdent(cliente.getCodigoTipoIdentificacion());
		obtencionLinea.setNumIdent(cliente.getNumeroIdentificacion());
        // cliente.getCodCliente // Si es cliente nuevo debe llegar como parametro desde JSP 
		//cliente.getCodTipIdent(); // Si es cliente nuevo debe llegar como parametro desde JSP
		//cliente.getNumIdent(); //Si es cliente nuevo debe llegar como parametro desde JSP
		//cliente.getCodCuenta(); //Si es cliente nuevo debe llegar como parametro desde JSP
		
		try {
			LimiteLineasDTO limiteLineas = delegate.obtenerLimiteLineas(obtencionLinea);
			limiteLineas.getSuperaLimite(); // String
			limiteLineas.getNumeroLineasCliente();//String  
			limiteLineas.getMaximoPermitido(); //String
		}
		catch (ManReqException e) {
			logger.debug("ERROR (ManReqException):"+e.getMessage());
		}
		catch (Exception e){
			logger.debug("ERROR (Exception):"+e.getMessage());
		}
	} 
	
	/**
	 * Realiza las validaciones para la combinatoria generada
	 * 
	 * @param parametros, abonadosSel[]
	 * @return RetornoCondicionesCPUDTO
	 */
	public RetornoCondicionesCPUDTO validaCondicionesInicio(ParametrosCondicionesCPUDTO parametros, long[] abonadosSel ){
		RetornoCondicionesCPUDTO respuesta = new RetornoCondicionesCPUDTO();
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		
		logger.debug("validaCondicionesInicio():inicio");
		
		cargaAbonadosSeleccionados(abonadosSel);
		
		ConversionListDTO conversionList=null;
		
		try {
			
			//limpia mensajes
			for(int i=0; i<this.mensajes.length; i++){ this.mensajes[i].setRespuesta("I");	}
			
			//obtiene informacion basica para validar la combinatoria, deja la informacion disponible en esta clase
			this.codOOSS = parametros.getCodOOSS();
			this.combinatoria = parametros.getCombinatoriaGenerada();
			logger.debug("codOOSS              :"+this.codOOSS );
			logger.debug("combinatoria         :"+this.combinatoria);
			
			ConversionDTO param = new ConversionDTO();
			param.setCodOOSS(parametros.getCodOOSS());
			param.setCodTipModi(parametros.getCombinatoriaGenerada());
			logger.debug("obtenerConversionOOSS():inicio");
			conversionList = delegate.obtenerConversionOOSS(param);
			logger.debug("obtenerConversionOOSS():fin");
			
			this.codOSAnt = conversionList.getRegistros()[0].getCodOSAnt();
			this.codActuacion = conversionList.getRegistros()[0].getCodActuacion();
			this.codActuacionWeb = conversionList.getRegistros()[0].getCodActuacionWeb();
			logger.debug("codOSAnt              :"+codOSAnt);
			logger.debug("codActuacion          :"+codActuacion);
			logger.debug("codActuacionWeb       :"+codActuacionWeb);
			
			//continua validaciones
			respuesta = validaCondicionesContinuar(parametros, null, null);
			
		} catch (ManReqException e) {
			
			if(e.getCodigo()==null || e.getCodigo().equals("0")){
				logger.debug("ERROR (ManReqException) :"+e.getMessage());
				respuesta.setMensaje(e.getMessage());
			}else{
				logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
				respuesta.setCodMensaje(e.getCodigo());
				respuesta.setCodTipMensaje(e.getCodigoEvento());
				respuesta.setMensaje(e.getDescripcionEvento());
			}
			parametros=null;
		
		} catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			respuesta.setMensaje(e.getMessage());
			parametros=null;
		}

		logger.debug("validaCondicionesInicio():fin");
		return respuesta;
	}
	
	/**
	 * Continua validaciones, si hay mensajes de confirmacion, luego de la confirmacion se debe llamar solo 
	 * a este metodo.
	 * @param parametros, codigoMsg, respuestaMsg
	 * @return RetornoCondicionesCPUDTO
	 */
	public RetornoCondicionesCPUDTO validaCondicionesContinuar(ParametrosCondicionesCPUDTO parametros,String codigoMsg, String respuestaMsg) throws ManReqException { 
		logger.debug("validaCondicionesContinuar():ini");
		RetornoCondicionesCPUDTO respuesta = new RetornoCondicionesCPUDTO();
		String respuestaConfirm = " ";
		String msgUsuario = " ";
		
		if (codigoMsg != null) repondeMensaje(codigoMsg, respuestaMsg);
		
		try {
			
			//confirmaciones que cancelan la ooss
			//c.001:esta línea es una cuenta personal asociada a la linea corporativa, si prosigue con el cambio perderá esta relación ¿Desea Continuar S/N?
			respuestaConfirm = this.obtieneRespuestaMensaje("c.001");
			if (respuestaConfirm.equals("N")){
				throw new ManReqException("1",0, msgUsuario);  //no continua ooss
			}
			//c.002:validacion atlantida
			respuestaConfirm = this.obtieneRespuestaMensaje("c.002");
			if (respuestaConfirm.equals("N")){
				throw new ManReqException("1",0, msgUsuario); //no continua ooss
			}
			//fin confirm
	
			//campos comunes para validacion
		    RestriccionesDTO restricciones = new RestriccionesDTO();
		    restricciones.setPrograma("GPA");
		    restricciones.setProceso("");
		    restricciones.setCodActuacion(this.codActuacion);
		    restricciones.setCodCliente(cliente.getCodCliente());
		    restricciones.setCodModGener("OSF");
		    restricciones.setCodOOSS(String.valueOf(this.codOSAnt));
		    restricciones.setCodVendedor(parametros.getUsuario());
		    restricciones.setDesactivacionSS(0);
		    
		    // (+)GS 02-06-08
		    /* 040608
		    logger.debug("CombinatoriaGenerada[" + parametros.getCombinatoriaGenerada() + "]");
		    logger.debug("CodTipoPlanTarifOrigen[" + listaAbonadosSel[0].getCodTipoPlanTarif() + "]");
		    logger.debug("CodTipoPlanTarifDestino[" + parametros.getCodTipoPlanTarif() + "]");
		    		    
		    if ( (parametros.getCombinatoriaGenerada().equalsIgnoreCase("POSPAGOPOSPAGO")&& listaAbonadosSel[0].getCodTipoPlanTarif().equalsIgnoreCase("I")&& parametros.getCodTipoPlanTarif().equalsIgnoreCase("I")) 
		    		 ||
		    	 (parametros.getCombinatoriaGenerada().equalsIgnoreCase("HIBRIDOHIBRIDO")&& listaAbonadosSel[0].getCodTipoPlanTarif().equalsIgnoreCase("I")&& parametros.getCodTipoPlanTarif().equalsIgnoreCase("I"))
		       )  {
		    	      restricciones.setPlanDestino(listaAbonadosSel[0].getCodPlanTarif());  // Setear el valor del plan tarifario ORIGEN
		    	      WebContext ctx = WebContextFactory.get();
		    		  HttpSession session = ctx.getHttpServletRequest().getSession(false);
		    		  CambiarPlanForm form1 = (CambiarPlanForm)session.getAttribute("CambiarPlanForm"); // obtener el form para setear un atributo
		    		  form1.setCodPlanTarifSelec(restricciones.getPlanDestino()); // setear valor del plan origen, en el atributo del form (valido solo para individuales y no masivas)
		    }else{
		    	      restricciones.setPlanDestino(parametros.getCodPlanTarifSelec());    
		    }*/
		    // (-)
		    restricciones.setPlanDestino(parametros.getCodPlanTarifSelec());
		    
		    restricciones.setCodClienteDestino(Long.parseLong(parametros.getCodClienteDestino()));
		    restricciones.setTipoPlanDestino(parametros.getTipoPlanTarifDestino());
		    restricciones.setFechaSistema(new Date());
		    restricciones.setRestriccionAux(cliente.getCodTipoPlanTarif()+parametros.getTipoPlanTarifDestino());  //GS
		    restricciones.setCodTarea(0);
		    restricciones.setCodEvento(global.getValor("codigo.evento.siguiente").trim());
		
			if (
				 this.combinatoria.equalsIgnoreCase("POSPAGOPOSPAGO")    //P,R,E
				 || this.combinatoria.equalsIgnoreCase("HIBRIDOHIBRIDO") //P,R(HIBRIDOHIBRIDO)
			   )			
			{ 
				respuesta =  validaCondicionesPospagoPospago(parametros,restricciones);
			}
			else if(this.combinatoria.equalsIgnoreCase("POSPAGOPREPAGO") 
					|| this.combinatoria.equalsIgnoreCase("HIBRIDOPREPAGO")){//P,R
				respuesta =  validaCondicionesPospagoPrepago(parametros,restricciones);
			}
			else if(this.combinatoria.equalsIgnoreCase("POSPAGOHIBRIDO")
					|| this.combinatoria.equalsIgnoreCase("HIBRIDOPOSPAGO")){ //P
				respuesta =  validaCondicionesPospagoHibrido(parametros,restricciones);
			}
			else if(this.combinatoria.equalsIgnoreCase("PREPAGOPREPAGO")) {
				respuesta = validaCondicionesPrepagoPrepago(parametros,restricciones);
			}
			else if(this.combinatoria.equalsIgnoreCase("PREPAGOPOSPAGO")
					|| this.combinatoria.equalsIgnoreCase("PREPAGOHIBRIDO")){//P migracion
				respuesta = validaCondicionesPrepagoPospago(parametros,restricciones);
			}	
			
		} catch (ManReqException e) {
			
			if(e.getCodigo()==null || e.getCodigo().equals("0")){
				logger.debug("ERROR (ManReqException) :"+e.getMessage());
				respuesta.setCodMensaje("-1");
				if (e.getMessage()!=null)	respuesta.setMensaje(e.getMessage());
				else respuesta.setMensaje("Error al validar combinatoria");
			}else{
				logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
				respuesta.setCodMensaje(e.getCodigo());
				respuesta.setCodTipMensaje(e.getCodigoEvento());
				respuesta.setMensaje(e.getDescripcionEvento());
			}
			
		} catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			respuesta.setCodMensaje("-1");
			if (e.getMessage()!=null)	respuesta.setMensaje(e.getMessage());
			else respuesta.setMensaje("Error al validar combinatoria");
		
		}
		
		WebContext ctx = WebContextFactory.get();
		HttpSession session = ctx.getHttpServletRequest().getSession(false);
			
	    session.setAttribute("AbonadosSeleccionados",this.listaAbonadosSel);
	    if (respuesta.getAplicaTraspaso()==null) respuesta.setAplicaTraspaso("N");
		respuesta.setAbonadosValidos(this.listaAbonadosSel);
		respuesta.setCodActuacion(codActuacion);
		respuesta.setCodOSAnt(codOSAnt);
		logger.debug("respuesta.getCodActuacion() :"+respuesta.getCodActuacion());	
		logger.debug("respuesta.getCodOSAnt()     :"+respuesta.getCodOSAnt());
		logger.debug("validaCondicionesContinuar():fin");		
		return respuesta;
		
	} //fin validaCondicionesContinuar
	
	/**
	 * Valida condiciones POSPAGOPOSPAGO
	 * @param parametros
	 * @return RetornoCondicionesCPUDTO
	 */
	public RetornoCondicionesCPUDTO validaCondicionesPospagoPospago(ParametrosCondicionesCPUDTO parametros,RestriccionesDTO restricciones) throws ManReqException{
		logger.debug("validaCondicionesPospagoPospago():ini");
		RetornoCondicionesCPUDTO respuesta = new RetornoCondicionesCPUDTO();
		String respuestaConfirm = " ";
		String msgUsuario = " ";
		String msgError="";
		SecuenciaDTO parametro = null;
		SecuenciaDTO retornoSecuencia = null;
		
	    ArrayList abonadosValidos = new ArrayList();
	    ArrayList abonadosInvalidos = new ArrayList();
	    //Recorre lista de abonados seleccionados
		for (int i=0; i<listaAbonadosSel.length;i++){ 
			restricciones.setNumAbonado(listaAbonadosSel[i].getNumAbonado());
			restricciones.setNumVenta(this.listaAbonadosSel[i].getNumVenta());
		    restricciones.setCodUso(Integer.parseInt(this.listaAbonadosSel[i].getCodUso()));
		    restricciones.setCodCuentaOrigen(this.listaAbonadosSel[i].getCodCuenta());
		    restricciones.setCodCuentaDestino(this.listaAbonadosSel[i].getCodCuenta());
		    restricciones.setTipoPlan(this.listaAbonadosSel[i].getCodTipoPlanTarif());
		    restricciones.setNumCiclo(this.listaAbonadosSel[i].getCodCiclo());
		    restricciones.setCodCentral(this.listaAbonadosSel[i].getCodCentral());
		    
		    boolean validaEventos = true;
		    /* 040608
		    logger.debug("Combinatoria[" + parametros.getCombinatoriaGenerada() + "]");
		    logger.debug("TipoPlanTarifOrigen[" + listaAbonadosSel[i].getCodTipoPlanTarif() + "]");
		    logger.debug("TipoPlanTarifDestino[" + parametros.getCodTipoPlanTarif() + "]");
		    
		    if ( !(parametros.getCombinatoriaGenerada().equalsIgnoreCase("POSPAGOPOSPAGO")&& listaAbonadosSel[i].getCodTipoPlanTarif().equalsIgnoreCase("I")&& parametros.getCodTipoPlanTarif().equalsIgnoreCase("I")) 
		    		 &&
		    	 !(parametros.getCombinatoriaGenerada().equalsIgnoreCase("HIBRIDOHIBRIDO")&& listaAbonadosSel[i].getCodTipoPlanTarif().equalsIgnoreCase("I")&& parametros.getCodTipoPlanTarif().equalsIgnoreCase("I"))    )    {
		    	// valida Plan Tarifario Origen con Destino */	
		    	if (restricciones.getPlanDestino().equals(this.listaAbonadosSel[i].getCodPlanTarif())) {
		    		logger.debug("error en abonado :"+listaAbonadosSel[i].getNumAbonado());
			    	listaAbonadosSel[i].setDesSituacion("Plan tarifario debe ser distinto al seleccionado");
					validaEventos = false;
		    	}
		    /*   	
		    }
		    */
		    	    
		    if (validaEventos){  // valida Restricciones Comerciales
		    	 //obtener secuencia
			    parametro = new SecuenciaDTO();
				parametro.setNomSecuencia("GA_SEQ_TRANSACABO");
				
				logger.debug("obtenerSecuencia():inicio");
				retornoSecuencia = delegate.obtenerSecuencia(parametro);
				logger.debug("obtenerSecuencia():fin");
				
			    restricciones.setIdSecuencia(retornoSecuencia.getNumSecuencia());
			    
				//ejecutar metodo que valida las restricciones comerciales
				logger.debug("validaRestriccionComerOoss : inicio, abonado="+listaAbonadosSel[i].getNumAbonado());
				try{
					delegate.validaRestriccionComerOoss(restricciones);
				}catch(ManReqException e){	
					logger.debug("error en abonado :"+listaAbonadosSel[i].getNumAbonado());
					logger.debug("codigo="+e.getCodigo()+", Mensaje="+e.getDescripcionEvento());
					listaAbonadosSel[i].setDesSituacion(e.getDescripcionEvento()); 
					validaEventos = false;
				}
				logger.debug("validaRestriccionComerOoss:fin");
		    	
		    }
		    
		    /*
		        
		    //valida plan tarifario
		    if (parametros.getCodPlanTarifSelec().equals(this.listaAbonadosSel[i].getCodPlanTarif())){ // MODIFICAR !!! ...Para POSPAGOPOSPAGO e HIBRIDOHIBRIDO origen y destino INDIVIDUAL
		    	logger.debug("error en abonado :"+listaAbonadosSel[i].getNumAbonado());
		    	listaAbonadosSel[i].setDesSituacion("Plan tarifario debe ser distinto al seleccionado");
				validaEventos = false;
		    }
		    else{ //valida restriccciones comerciales
		    	
			    //obtener secuencia
			    parametro = new SecuenciaDTO();
				parametro.setNomSecuencia("GA_SEQ_TRANSACABO");
				
				logger.debug("obtenerSecuencia():inicio");
				retornoSecuencia = delegate.obtenerSecuencia(parametro);
				logger.debug("obtenerSecuencia():fin");
				
			    restricciones.setIdSecuencia(retornoSecuencia.getNumSecuencia());
			    
				//ejecutar metodo que valida las restricciones comerciales
				logger.debug("validaRestriccionComerOoss : inicio, abonado="+listaAbonadosSel[i].getNumAbonado());
				try{
					delegate.validaRestriccionComerOoss(restricciones);
				}catch(ManReqException e){	
					logger.debug("error en abonado :"+listaAbonadosSel[i].getNumAbonado());
					logger.debug("codigo="+e.getCodigo()+", Mensaje="+e.getDescripcionEvento());
					listaAbonadosSel[i].setDesSituacion(e.getDescripcionEvento()); 
					validaEventos = false;
				}
				logger.debug("validaRestriccionComerOoss:fin");
		    }
		    */
		    
		    
			if (validaEventos){
				abonadosValidos.add(listaAbonadosSel[i]);
			}
			else {
				abonadosInvalidos.add(listaAbonadosSel[i]);
			}
		}//fin valida lista de abonados seleccionados
		
		if (!abonadosInvalidos.isEmpty()){
			AbonadoDTO[] arrayAbonadosInvalidos = (AbonadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(abonadosInvalidos.toArray(),AbonadoDTO.class);
			respuesta.setAbonadosInvalidos(arrayAbonadosInvalidos);
			respuesta.setMensaje(" ");
			return respuesta;
		}
		

		//if es reordenamiento se debe enviar mensaje indicando que hay abonados que no cumplen las condiciones
		//y mantener seleccionados solo los abonados validos
		int numAbonadosSel = this.listaAbonadosSel.length;
		//actualiza lista de abonados por lista de abonados validos.
		this.listaAbonadosSel = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	abonadosValidos.toArray(), AbonadoDTO.class);
		
		if (listaAbonadosSel.length == 0){// no hay abonados validos
			msgUsuario = global.getValor("e.001"); //msg:Abonado(s) inválido(s)
			
			if (!msgError.trim().equals("")) msgUsuario = msgError;
			throw new ManReqException("e.001",0, msgUsuario); //no continua ooss
		}
		
		if (numAbonadosSel != abonadosValidos.size()){
			msgUsuario = global.getValor("a.001"); //msg:Existen abonados que no cumplen las condiciones, estos no seran considerados
			throw new ManReqException("a.001",MSGACEPTAR, msgUsuario);					
		}
		
		int totalAbonadosSel = listaAbonadosSel.length;
		
		
		//6.- validar cuenta personal , solo si existe un abonado seleccionado
		/* Esta validacion no aplica para esta combinatoria -- GS 27/02/08
		if (totalAbonadosSel == 1){
			respuestaConfirm = obtieneRespuestaMensaje("c.001");
			if (respuestaConfirm.equals("I")){
				boolean valCuentaPersonal = false;
				CuentaPersonalDTO cuentaPers = new CuentaPersonalDTO();
				cuentaPers.setNumCelularCorp(0);
				cuentaPers.setNumCelular(listaAbonadosSel[0].getNumCelular());
				logger.debug("validaCuentaPersonal():inicio");
				valCuentaPersonal = delegate.validaCuentaPersonal(cuentaPers).isResultado();
				logger.debug("validaCuentaPersonal():inicio");
				
				//obtener plan atlantida
				AbonadoDTO abonadop = new AbonadoDTO();
				abonadop.setCodPlanTarif(parametros.getCodPlanTarifSelec());
				logger.debug("obtenerPlanAtlantida():inicio");
				boolean valPlanAtlantida = delegate.obtenerPlanAtlantida(abonadop).isResultado();
				logger.debug("obtenerPlanAtlantida():fin");
				if (valPlanAtlantida && valCuentaPersonal){ 
					msgUsuario = global.getValor("c.001"); //msg:Esta línea es una cuenta personal asociada a ...
					throw new ManReqException("c.001",MSGCONFIRM, msgUsuario);
				}
			} //si respuesta es si(S) continua la orden de servicio
			
		}//fin si totalAbonadosSel ==1
		*/
		
		
		//7.- si aplica Atlantida, validar y anular ooss pendientes
		respuestaConfirm = obtieneRespuestaMensaje("c.002");
		if (respuestaConfirm.equals("I")){

			ValidaOOSSDTO validaOS = new ValidaOOSSDTO();
			validaOS.setCodCliente(cliente.getCodCliente());
			validaOS.setCodOS(String.valueOf(this.codOSAnt));
			for(int i=0; i<totalAbonadosSel; i++){
				
				validaOS.setCodPlanTarif(listaAbonadosSel[i].getCodPlanTarif());
				validaOS.setNumAbonado(listaAbonadosSel[i].getNumAbonado());
				
				logger.debug("validaOossPendPlan():inicio");
				validaOS = delegate.validaOossPendPlan(validaOS);
				logger.debug("validaOossPendPlan():fin");
				
				//Se debe validar retorno y desplegar mensaje de confirmacion
				if (validaOS.getCodigo().equals("1")){
					//mensaje de anulacion de ordenes de servicio pendientes
					msgUsuario = validaOS.getMensaje();
					throw new ManReqException("c.002",MSGCONFIRM, msgUsuario);	
				}//fin existen ordenes pendientes, codigo==1
				
			}//fin for
			
		}//fin if (respuestaConfirm.equals("I"))
		
		/*
		if (this.combinatoria.equalsIgnoreCase("HIBRIDOHIBRIDO")){
			if (parametros.getCodClienteDestino()!=null){
				    LineasClienteDTO obtLineas = new LineasClienteDTO();
					ClienteDTO clienteDestino = buscaClienteSeleccionado(Long.parseLong(parametros.getCodClienteDestino()),3);
						
					obtLineas.setCodCliente(clienteDestino.getCodCliente());
					LineasClienteDTO limite = delegate.obtenerCantidadLineasCliente(obtLineas);
					int numLineas = limite.getNumLineas();
					
					PlanTarifarioDTO plan = new PlanTarifarioDTO();
				    plan.setCodPlanTarif(parametros.getCodPlanTarifSelec());
				    plan.setCodCliente(parametros.getCodClienteDestino());
				    logger.debug("obtenerPlanTarifario():inicio");
				    plan =delegate.obtenerPlanTarifario(plan);
				    logger.debug("obtenerPlanTarifario():fin");
				    int numAbonadosPermitidosPlan = plan.getCantidadAbonadosPermitidos();
					int totalAbonadosCliente =   numLineas +  listaAbonadosSel.length; 
				    
					if (totalAbonadosCliente > numAbonadosPermitidosPlan){
						msgUsuario = global.getValor("e.013"); //msg:Ha superado el total de abonados...
						throw new ManReqException("e.013",0, msgUsuario); //no continua ooss	
					}
			}//Fin if (parametros.getCodClienteDestino()!=null)
		}//fin if (this.combinatoria.equalsIgnoreCase("HIBRIDOHIBRIDO"))
		/*/
		
		//8.- validar traspaso de servicios homologos
		respuestaConfirm = obtieneRespuestaMensaje("c.003");
		if (respuestaConfirm.equals("I")){
			String aplicaTraspasoSS = null;
			ParametroDTO paramAplicaTraspaso= paramGeneral.obtieneParametro("APLICA_TRASP_SS_OPC");
			if (paramAplicaTraspaso != null) aplicaTraspasoSS = paramAplicaTraspaso.getValorDominio();
			
			if (aplicaTraspasoSS.equalsIgnoreCase("TRUE")){
				msgUsuario = global.getValor("c.003");//msg:¿Desea mantener los servicios suplementarios opcionales?
				throw new ManReqException("c.003",MSGCONFIRM, msgUsuario);
			}
		}else if (respuestaConfirm.equals("S")){
			this.repondeMensaje("c.003", " ");
			respuesta.setAplicaTraspaso("S");
		}
		
		//9.- obtener fecha ciclo
		CicloDTO ciclo = new CicloDTO();
		ciclo.setCodCiclo(cliente.getCodCiclo());
		logger.debug("obtenerFechaCiclo():inicio");
		ciclo = delegate.obtenerFechaCiclo(ciclo);
		logger.debug("obtenerFechaCiclo():fin");
		
		String fecDesdeLlam = ciclo.getFecDesdeLlam();
		int periodoFact = ciclo.getPeriodoCodCiclFact();
		
		respuesta.setFecDesdeLlam(fecDesdeLlam);
		respuesta.setPeriodoFact(periodoFact);
		
		//10.- validaOossPendPlan cliente destino empresa
		logger.debug("tipoPlanTarifDestino[" + parametros.getTipoPlanTarifDestino() + "]");
		if("E".equals(parametros.getTipoPlanTarifDestino())){
			ValidaOOSSDTO validaOS = new ValidaOOSSDTO();
			validaOS.setCodClienteDestino(Long.parseLong(parametros.getCodClienteDestino()));
			logger.debug("codClienteDestino[" + validaOS.getCodClienteDestino() + "]");
			logger.debug("validaOossPendPlan():inicio");
			validaOS = delegate.validaOossPendPlan(validaOS);
			logger.debug("validaOossPendPlan():fin");
			if (validaOS.getCodigo().equals("1")){
				msgUsuario = validaOS.getMensaje();
				throw new ManReqException("c.002",0, msgUsuario);
			}
			
		}
		
		logger.debug("validaCondicionesPospagoPospago():fin");	
		return respuesta;
		
	}//fin validaCondicionesPospagoPospago

	/**
	 * Valida condiciones POSPAGOPREPAGO
	 * @param parametros
	 * @return RetornoCondicionesCPUDTO
	 */
	public RetornoCondicionesCPUDTO validaCondicionesPospagoPrepago(ParametrosCondicionesCPUDTO parametros,RestriccionesDTO restricciones) throws ManReqException{
		logger.debug("validaCondicionesPospagoPrepago():ini");
		RetornoCondicionesCPUDTO respuesta = new RetornoCondicionesCPUDTO();
		String respuestaConfirm = " ";
		String msgUsuario = " ";
		String msgError="";
		SecuenciaDTO parametro=null;
		SecuenciaDTO retornoSecuencia=null;
		String tipPlanDestino = "3";
		String actabo_AUX = global.getValor("pospagoprepago.actaboAux");
    	restricciones.setCodActuacion(actabo_AUX);
	    
	    ArrayList abonadosValidos = new ArrayList();//guarda abonados validos que cumplen  restricciones comerciales y permanencia
	    ArrayList abonadosInvalidos = new ArrayList();

	    for (int i=0; i<listaAbonadosSel.length;i++){ 
			restricciones.setNumAbonado(listaAbonadosSel[i].getNumAbonado());
		    restricciones.setNumVenta(this.listaAbonadosSel[i].getNumVenta());
		    restricciones.setCodUso(Integer.parseInt(this.listaAbonadosSel[i].getCodUso()));
		    restricciones.setCodCuentaOrigen(this.listaAbonadosSel[i].getCodCuenta());
		    restricciones.setCodCuentaDestino(this.listaAbonadosSel[i].getCodCuenta());
		    restricciones.setTipoPlan(this.listaAbonadosSel[i].getCodTipoPlanTarif());
		    restricciones.setNumCiclo(this.listaAbonadosSel[i].getCodCiclo());
		    restricciones.setCodCentral(this.listaAbonadosSel[i].getCodCentral());
		    
		    boolean validaEventos = true; 
		    
		    //valida plan tarifario
		    if (parametros.getCodPlanTarifSelec().equals(this.listaAbonadosSel[i].getCodPlanTarif())){
		    	logger.debug("error en abonado :"+listaAbonadosSel[i].getNumAbonado());
		    	listaAbonadosSel[i].setDesSituacion("Plan tarifario debe ser distinto al seleccionado");
				validaEventos = false;
		    }
		    else{ //valida restriccciones comerciales
		    	
				parametro = new SecuenciaDTO();
				parametro.setNomSecuencia("GA_SEQ_TRANSACABO");
					
				logger.debug("obtenerSecuencia():inicio");
				retornoSecuencia = delegate.obtenerSecuencia(parametro);
				logger.debug("obtenerSecuencia():fin");
					
				restricciones.setIdSecuencia(retornoSecuencia.getNumSecuencia());
				    
				//ejecutar metodo que valida las restricciones comerciales
				logger.debug("validaRestriccionComerOoss : inicio, abonado="+listaAbonadosSel[i].getNumAbonado());
				try{
					delegate.validaRestriccionComerOoss(restricciones);
				}catch(ManReqException e){	
					logger.debug("error en abonado :"+listaAbonadosSel[i].getNumAbonado());
					logger.debug("codigo="+e.getCodigo()+", Mensaje="+e.getDescripcionEvento());
					listaAbonadosSel[i].setDesSituacion(e.getDescripcionEvento()); 
					validaEventos = false;
				}
				logger.debug("validaRestriccionComerOoss:fin");
		    }
			if (validaEventos){
				abonadosValidos.add(listaAbonadosSel[i]);
			}
			else {
				abonadosInvalidos.add(listaAbonadosSel[i]);
			}
		}//fin valida lista de abonados seleccionados

		if (!abonadosInvalidos.isEmpty() ){
			AbonadoDTO[] arrayAbonadosInvalidos = (AbonadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(abonadosInvalidos.toArray(),AbonadoDTO.class);
			respuesta.setAbonadosInvalidos(arrayAbonadosInvalidos);
			respuesta.setMensaje(" ");
			return respuesta;
		}
	    
	    
		//if es reordenamiento se debe enviar mensaje indicando que hay abonados que no cumplen las condiciones
		//y mantener seleccionados solo los usuarios validos
		int numAbonadosSel = this.listaAbonadosSel.length; //nro de abonados seleccionados por el usuario
		
		//actualiza lista de abonados por lista de abonados validos.
		this.listaAbonadosSel = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	abonadosValidos.toArray(), AbonadoDTO.class);
		if (listaAbonadosSel.length == 0){// no hay abonados validos
			msgUsuario = global.getValor("e.001"); //msg:Abonado(s) inválido(s)
			if (!msgError.trim().equals("")) msgUsuario = msgError;
			throw new ManReqException("e.001",0, msgUsuario); //no continua ooss
		}
		
		if ( numAbonadosSel != abonadosValidos.size()){
			msgUsuario = global.getValor("a.001"); //msg: Existen abonados que no cumplen las condiciones, ...
			throw new ManReqException("a.001",MSGACEPTAR, msgUsuario);					
		}
		
		//ejecutar validaPermanencia
		int tiempoMin = 0;
		String causaBaja = " ";
		ParametroDTO paramTiempoMin = paramGeneral.obtieneParametro("MIN_OPTARAMISTAR");
		ParametroDTO paramCausaBaja = paramGeneral.obtieneParametro("COD_OPTAAMISTAR");
		
		if (paramTiempoMin != null) tiempoMin = Integer.parseInt(paramTiempoMin.getValor().trim()) ;
		if (paramCausaBaja != null) causaBaja = paramCausaBaja.getValor();
		
		ValidaPermanenciaDTO paramValidaPerm = new ValidaPermanenciaDTO();
		paramValidaPerm.setTiempoMin(tiempoMin);
		paramValidaPerm.setCodCausaBaja(parametros.getCodCausaBajaSel());
		paramValidaPerm.setCodCausaBajaParam(causaBaja);
		boolean  validaPermanencia = false;
		
		AbonadoDTO abonadoAux= null;
		
		
		abonadosValidos = new ArrayList(); 
		for (int i=0; i<listaAbonadosSel.length;i++){ 
			paramValidaPerm.setNumAbonado(listaAbonadosSel[i].getNumAbonado());
			logger.debug("validaPermanencia():ini");
			validaPermanencia = delegate.validaPermanencia(paramValidaPerm).isResultado();  
			logger.debug("validaPermanencia():fin");	
			//(+) evera 22/08/08
			if (!validaPermanencia){
				listaAbonadosSel[i].setDesSituacion("Abonado no cumple validación de permanencia");
				abonadosInvalidos.add(listaAbonadosSel[i]);
			}
			//(-)
			
			if (validaPermanencia){
				RetornoDTO ret = new RetornoDTO();
				abonadoAux = new AbonadoDTO();
				abonadoAux.setCodUso(listaAbonadosSel[i].getCodUso());
				abonadoAux.setCodUsoDestino(tipPlanDestino);
				abonadoAux.setCodTecnologia(listaAbonadosSel[i].getCodTecnologia());
				abonadoAux.setCodActAbo("BA");
				logger.debug("validarOriDesUso():inicio");
				ret = delegate.validarOriDesUso(abonadoAux);
				logger.debug("validarOriDesUso():fin");
				
				if(ret.getCodigo().equals("0")){
					ret.setCodigo("");
					abonadoAux.setNumAbonado(listaAbonadosSel[i].getNumAbonado());
					logger.debug("validarSolicitudesBaja():inicio");
					ret = delegate.validarSolicitudesBaja(abonadoAux);
					logger.debug("validarSolicitudesBaja():fin");
					if(ret.getCodigo().equals("0")){
						abonadosValidos.add(listaAbonadosSel[i]);
					}
				}
						
			} // del validaPermanencia
				
		} //del for 
		//(+) evera 22/08/08
		if (!abonadosInvalidos.isEmpty() ){
			AbonadoDTO[] arrayAbonadosInvalidos = (AbonadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(abonadosInvalidos.toArray(),AbonadoDTO.class);
			respuesta.setAbonadosInvalidos(arrayAbonadosInvalidos);
			respuesta.setMensaje(" ");
			return respuesta;
		}
		//(-)
		
		//actualiza lista de abonados por lista de abonados validos.
		this.listaAbonadosSel = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	abonadosValidos.toArray(), AbonadoDTO.class);
		if (listaAbonadosSel.length == 0){// no hay abonados validos
			msgUsuario = global.getValor("e.001"); //msg:Abonado(s) inválido(s)
			throw new ManReqException("e.001",0, msgUsuario); //no continua ooss
		}
		
		if (abonadosValidos.size() == 0){// no hay abonados que cumplan las condiciones
			msgUsuario = global.getValor("e.012"); //msg:Abonado(s) inválido(s)
			throw new ManReqException("e.012",0, msgUsuario); //no continua ooss
		}
		
		
		if ( numAbonadosSel != abonadosValidos.size()){
			msgUsuario = global.getValor("a.002"); //msg:Existen abonados que no cumple la permanencia ...
			throw new ManReqException("a.002",MSGACEPTAR, msgUsuario);					
		}
		
		int totalAbonadosSel = listaAbonadosSel.length;
		
		//3.- validar cuenta personal , solo si existe un abonado seleccionado
		/*
		if (totalAbonadosSel == 1){
			respuestaConfirm = obtieneRespuestaMensaje("c.001");
			if (respuestaConfirm.equals("I")){
				boolean valCuentaPersonal = false;
				CuentaPersonalDTO cuentaPers = new CuentaPersonalDTO();
				cuentaPers.setNumCelularCorp(0);
				cuentaPers.setNumCelular(listaAbonadosSel[0].getNumCelular());
				logger.debug("validaCuentaPersonal():inicio");
				valCuentaPersonal = delegate.validaCuentaPersonal(cuentaPers).isResultado();
				logger.debug("validaCuentaPersonal():inicio");
				
				//obtener plan atlantida
				AbonadoDTO abonadop = new AbonadoDTO();
				abonadop.setCodPlanTarif(parametros.getCodPlanTarifSelec());
				logger.debug("obtenerPlanAtlantida():inicio");
				boolean valPlanAtlantida = delegate.obtenerPlanAtlantida(abonadop).isResultado();
				logger.debug("obtenerPlanAtlantida():fin");
				if (valPlanAtlantida && valCuentaPersonal){ 
					msgUsuario = global.getValor("c.001"); //msg:Esta línea es una cuenta personal asociada a ...
					throw new ManReqException("c.001",MSGCONFIRM, msgUsuario);
				}
			} //si respuesta es si(S) continua la orden de servicio
			
		}//fin si totalAbonadosSel ==1
		*/
		
		//4.- si aplica Atlantida, validar y anular ooss pendientes
		respuestaConfirm = obtieneRespuestaMensaje("c.002");
		if (respuestaConfirm.equals("I")){

			ValidaOOSSDTO validaOS = new ValidaOOSSDTO();
			validaOS.setCodCliente(cliente.getCodCliente());
			validaOS.setCodOS(String.valueOf(this.codOSAnt));
			for(int i=0; i<totalAbonadosSel; i++){
				
				validaOS.setCodPlanTarif(listaAbonadosSel[i].getCodPlanTarif());
				validaOS.setNumAbonado(listaAbonadosSel[i].getNumAbonado());
				
				logger.debug("validaOossPendPlan():inicio");
				validaOS = delegate.validaOossPendPlan(validaOS);
				logger.debug("validaOossPendPlan():fin");
				
				//Se debe validar retorno y desplegar mensaje de confirmacion
				if (validaOS.getCodigo().equals("1")){
					//mensaje de anulacion de ordenes de servicio pendientes
					msgUsuario = validaOS.getMensaje();
					throw new ManReqException("c.002",MSGCONFIRM, msgUsuario);	
				}//fin existen ordenes pendientes, codigo==1
				
			}//fin for
			
		}//fin if (respuestaConfirm.equals("I"))

		// Inicio activacion de linea Prepago
		/*
		String codigoCausaExcepcion = parametros.getCodCausaExcepcion();
		if (codigoCausaExcepcion!=null && codigoCausaExcepcion.trim().equals("")){
			if (parametros.getCodClienteDestino()!=null){
				ObtencionLineasClienteDTO obtLineas = new ObtencionLineasClienteDTO();
				ClienteDTO clienteDestino = buscaClienteSeleccionado(Long.parseLong(parametros.getCodClienteDestino()),1);
					
				obtLineas.setCodCliente(clienteDestino.getCodCliente());
				obtLineas.setCodTipIdent(clienteDestino.getCodigoTipoIdentificacion());
				obtLineas.setCodCuenta(clienteDestino.getCodCuenta());
				obtLineas.setNumIdent(clienteDestino.getNumeroIdentificacion());
				LimiteLineasDTO limite = delegate.obtenerLimiteLineas(obtLineas);
					
				if (limite.getSuperaLimite()!=null && limite.getSuperaLimite().equals("1")){
					// Se levanta una excepción para agregar nueva linea
					ObtencionRolUsuarioDTO obtRol = new ObtencionRolUsuarioDTO();
					obtRol.setNomUsuarOra(parametros.getUsuario());
					obtRol = delegate.obtenerRolUsuario(obtRol);
					msgUsuario= "El cliente tiene "+ limite.getNumeroLineasCliente() + " líneas activas, ";
					msgUsuario+=" de un máximo de "+limite.getMaximoPermitido();
					
					if(obtRol.getRol()==0){
						throw new ManReqException("c.004",0, msgUsuario); //no continua ooss
					}
					else if(obtRol.getRol()>0){
						//msgUsuario = global.getValor("c.004"); //msg:Desea continuar ...
						msgUsuario="El cliente tiene "+ limite.getNumeroLineasCliente() + " líneas activas, ";
						msgUsuario+=" de un máximo de "+limite.getMaximoPermitido();
						throw new ManReqException("c.004",MSGCONFIRM, msgUsuario);
					}
				}
				else if (limite.getSuperaLimite()!=null && limite.getSuperaLimite().equals("4") ){
					msgUsuario = global.getValor("e.011"); //msg:Error al recuperar límite de compras del cliente
					throw new ManReqException("e.011",0, msgUsuario); //no continua ooss	
				}
			}//Fin de activacion de linea prepago
		}		
		*/
		
		//Validar traspaso de servicios homologos}
		respuestaConfirm = obtieneRespuestaMensaje("c.003");
		if (respuestaConfirm.equals("I")){
			String aplicaTraspasoSS = null;
			ParametroDTO paramAplicaTraspaso= paramGeneral.obtieneParametro("APLICA_TRASP_SS_OPC");
			if (paramAplicaTraspaso != null) aplicaTraspasoSS = paramAplicaTraspaso.getValorDominio();
			
			if (aplicaTraspasoSS.equalsIgnoreCase("TRUE")){
				msgUsuario = global.getValor("c.003");//msg:¿Desea mantener los servicios suplementarios opcionales?
				throw new ManReqException("c.003",MSGCONFIRM, msgUsuario);
			}
		}else if (respuestaConfirm.equals("S")){
			this.repondeMensaje("c.003", " ");
			respuesta.setAplicaTraspaso("S");
		}
		

		logger.debug("validaCondicionesPospagoPrepago():fin");	
		return respuesta;
		
	}//fin validaCondicionesPospagoPrepago
	
	/**
	 * Valida condiciones POSPAGOHIBRIDO, solo aplica puntual
	 * @param parametros
	 * @return RetornoCondicionesCPUDTO
	 */
	public RetornoCondicionesCPUDTO validaCondicionesPospagoHibrido(ParametrosCondicionesCPUDTO parametros,RestriccionesDTO restricciones ) throws ManReqException{
		logger.debug("validaCondicionesPospagoHibrido():ini");
		RetornoCondicionesCPUDTO respuesta = new RetornoCondicionesCPUDTO();
		String respuestaConfirm = " ";
		String msgUsuario = " ";
		String msgError="";
		SecuenciaDTO parametro=null;
		SecuenciaDTO retornoSecuencia=null;
		
				
		
		ArrayList abonadosValidos = new ArrayList();
	    ArrayList abonadosInvalidos = new ArrayList();
		//2.- validar restricciones comerciales
		//campos comunes para validacion
		
		for (int i=0; i<listaAbonadosSel.length;i++){ 
			restricciones.setNumVenta(this.listaAbonadosSel[i].getNumVenta());
		    restricciones.setCodUso(Integer.parseInt(this.listaAbonadosSel[i].getCodUso()));
		    restricciones.setCodCuentaOrigen(this.listaAbonadosSel[i].getCodCuenta());
		    restricciones.setCodCuentaDestino(this.listaAbonadosSel[i].getCodCuenta());
		    restricciones.setTipoPlan(this.listaAbonadosSel[i].getCodTipoPlanTarif());
		    restricciones.setNumCiclo(this.listaAbonadosSel[i].getCodCiclo());
		    restricciones.setCodCentral(this.listaAbonadosSel[i].getCodCentral());
		    restricciones.setNumAbonado(listaAbonadosSel[i].getNumAbonado());
		    
		    boolean validaEventos = true;
		    
		    //valida plan tarifario
		    if (parametros.getCodPlanTarifSelec().equals(this.listaAbonadosSel[i].getCodPlanTarif())){
		    	logger.debug("error en abonado :"+listaAbonadosSel[i].getNumAbonado());
		    	listaAbonadosSel[i].setDesSituacion("Plan tarifario debe ser distinto al seleccionado");
				validaEventos = false;
		    }
		    else{ //valida restriccciones comerciales
		    	
			    parametro = new SecuenciaDTO();
				parametro.setNomSecuencia("GA_SEQ_TRANSACABO");
				
				logger.debug("obtenerSecuencia():inicio");
				retornoSecuencia = delegate.obtenerSecuencia(parametro);
				logger.debug("obtenerSecuencia():fin");
				
				restricciones.setIdSecuencia(retornoSecuencia.getNumSecuencia());
				
				//ejecutar metodo que valida las restricciones comerciales
				logger.debug("validaRestriccionComerOoss : inicio, abonado="+listaAbonadosSel[i].getNumAbonado());
				try{
					delegate.validaRestriccionComerOoss(restricciones);
				}catch(ManReqException e){	
					logger.debug("error en abonado :"+listaAbonadosSel[i].getNumAbonado());
					logger.debug("codigo="+e.getCodigo()+", Mensaje="+e.getDescripcionEvento());
					listaAbonadosSel[i].setDesSituacion(e.getDescripcionEvento()); 
					validaEventos = false;
					/*AbonadoDTO[] arrayAbonadosInvalidos = new AbonadoDTO[1];
					arrayAbonadosInvalidos[0] = listaAbonadosSel[0]; 
					respuesta.setAbonadosInvalidos(arrayAbonadosInvalidos);
					respuesta.setMensaje(" ");
					return respuesta;*/
				}
				logger.debug("validaRestriccionComerOoss:fin");
		    }
		    
			if (validaEventos){
				abonadosValidos.add(listaAbonadosSel[i]);
			}
			else {
				abonadosInvalidos.add(listaAbonadosSel[i]);
			}
					
		}//fin valida lista de abonados seleccionados
		
		if (!abonadosInvalidos.isEmpty()){
			AbonadoDTO[] arrayAbonadosInvalidos = (AbonadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(abonadosInvalidos.toArray(),AbonadoDTO.class);
			respuesta.setAbonadosInvalidos(arrayAbonadosInvalidos);
			respuesta.setMensaje(" ");
			return respuesta;
		}
		

		//if es reordenamiento se debe enviar mensaje indicando que hay abonados que no cumplen las condiciones
		//y mantener seleccionados solo los abonados validos
		int numAbonadosSel = this.listaAbonadosSel.length;
		//actualiza lista de abonados por lista de abonados validos.
		this.listaAbonadosSel = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	abonadosValidos.toArray(), AbonadoDTO.class);
		
		if (listaAbonadosSel.length == 0){// no hay abonados validos
			msgUsuario = global.getValor("e.001"); //msg:Abonado(s) inválido(s)
			if (!msgError.trim().equals("")) msgUsuario = msgError;
			throw new ManReqException("e.001",0, msgUsuario); //no continua ooss
		}
		
		if (numAbonadosSel != abonadosValidos.size()){
			msgUsuario = global.getValor("a.001"); //msg:Existen abonados que no cumplen las condiciones, estos no seran considerados
			throw new ManReqException("a.001",MSGACEPTAR, msgUsuario);					
		}
		
		int totalAbonadosSel = listaAbonadosSel.length;
		AbonadoDTO abonadoAux = new AbonadoDTO();
		
		//3.- validar portabilidad
		/*abonadoAux.setCodUso(listaAbonadosSel[0].getCodUso());
		abonadoAux.setCodTecnologia(listaAbonadosSel[0].getCodTecnologia());
		abonadoAux.setCodActAbo(this.codActuacion);
		logger.debug("validarPortabilidad : inicio");
		boolean valPortabilidad = delegate.validarPortabilidad(abonadoAux).isResultado();
		logger.debug("validarPortabilidad : fin");
		
		if (!valPortabilidad){
			msgUsuario = global.getValor("e.004");//No se puede realizar cambio de plan, ...
			throw new ManReqException("e.004",0, msgUsuario); //no continua ooss
		}*/

		
		
		//4.- validar periodo facturacion
		boolean valPeriodoFac=true;
		logger.debug("validarPeriodoFact : inicio");
		for (int i=0; i<abonadosValidos.size();i++){
			AbonadoDTO abonado = (AbonadoDTO)abonadosValidos.get(i);
			logger.debug("abonado.getNumAbonado()[" + abonado.getNumAbonado() + "]");
			valPeriodoFac = delegate.validarPeriodoFact(abonado).isResultado();
		}
		logger.debug("validarPeriodoFact : fin");
		
		if (!valPeriodoFac){
			msgUsuario = global.getValor("e.005");//msg:Abonado no tiene periodo de facturación vigente ...
			throw new ManReqException("e.005",0, msgUsuario); //no continua ooss
		}
		
		//5.- validar servicios duplicados
		abonadoAux.setCodTipoTerminal(listaAbonadosSel[0].getCodTipoTerminal());
		abonadoAux.setCodPlanTarif(parametros.getCodPlanTarifSelec()); 
		abonadoAux.setCodTecnologia(listaAbonadosSel[0].getCodTecnologia());
		abonadoAux.setCodCentral(listaAbonadosSel[0].getCodCentral());
		logger.debug("validarServiciosDuplicados : inicio");
		boolean valServiciosDupl = delegate.validarServiciosDuplicados(abonadoAux).isResultado();
		logger.debug("validarServiciosDuplicados : fin");
		
		if (!valServiciosDupl){
			msgUsuario = global.getValor("e.006");//msg:El Plan nuevo  tiene parametrizado dos servicios ...
			throw new ManReqException("e.006",0, msgUsuario); //no continua ooss
		}
		
		//6.- obtener categoria y eliminar promoción
		PlanTarifarioDTO plan = new PlanTarifarioDTO();
		plan.setCodPlanTarif(listaAbonadosSel[0].getCodPlanTarif());
		
		logger.debug("obtenerCategPlan():inicio");
		plan = delegate.obtenerCategPlan(plan);
		logger.debug("obtenerCategPlan():fin");
		//msgUsuario = global.getValor("i.001"); //msg:Al cambiar de plan perdera en forma definitiva ...
		//respuesta.setMensaje(msgUsuario);
		
		String codCatCtaSegNue = null;
		ParametroDTO paramCatCtaSegNue = paramGeneral.obtieneParametro("COD_CAT_CTA_SEG_NUE");
		if (paramCatCtaSegNue != null) codCatCtaSegNue = paramCatCtaSegNue.getValor().trim();

		//Si categoria plan del abonado es igual al parametro COD_CAT_CTA_SEG_NUE
		//enviar mensaje informativo y eliminar promocion
		if(plan.getCodigoCategoria().equalsIgnoreCase(codCatCtaSegNue)){
			//msgUsuario = global.getValor("i.001"); //msg:Al cambiar de plan perdera en forma definitiva ...
			//respuesta.setMensaje(msgUsuario);
			
			//eliminar promocion
						
			logger.debug("eliminarPromocion():inicio");
			for (int i=0; i<abonadosValidos.size();i++){
				AbonadoDTO abonado = (AbonadoDTO)abonadosValidos.get(i);
				EliminaPromocionDTO promocion = new EliminaPromocionDTO();
				promocion.setSvCombinatoria(this.combinatoria);
				promocion.setFlgAplica(true);
				promocion.setSvMensaje(" ");
				//promocion.setNumAbonado(listaAbonadosSel[i].getNumAbonado());
				promocion.setNumAbonado(abonado.getNumAbonado());
				delegate.eliminarPromocion(promocion);
			}
			logger.debug("eliminarPromocion():fin");
		}
		
		//7.- validar cuenta personal
		/*
		respuestaConfirm = obtieneRespuestaMensaje("c.001");
		if (respuestaConfirm.equals("I")){
				boolean valCuentaPersonal = false;
				CuentaPersonalDTO cuentaPers = new CuentaPersonalDTO();
				cuentaPers.setNumCelularCorp(0);
				cuentaPers.setNumCelular(listaAbonadosSel[0].getNumCelular());
				logger.debug("validaCuentaPersonal():inicio");
				valCuentaPersonal = delegate.validaCuentaPersonal(cuentaPers).isResultado();
				logger.debug("validaCuentaPersonal():inicio");
				
				//obtener plan atlantida
				AbonadoDTO abonadop = new AbonadoDTO();
				abonadop.setCodPlanTarif(parametros.getCodPlanTarifSelec());
				logger.debug("obtenerPlanAtlantida():inicio");
				boolean valPlanAtlantida = delegate.obtenerPlanAtlantida(abonadop).isResultado();
				logger.debug("obtenerPlanAtlantida():fin");
				if (valPlanAtlantida && valCuentaPersonal){ 
					msgUsuario = global.getValor("c.001"); //msg:Esta línea es una cuenta personal asociada a ...
					throw new ManReqException("c.001",MSGCONFIRM, msgUsuario);
				}
		} //si respuesta es si(S) continua la orden de servicio
		*/
		
		
		//8.- si aplica Atlantida, validar y anular ooss pendientes
		respuestaConfirm = obtieneRespuestaMensaje("c.002");
		if (respuestaConfirm.equals("I")){

			ValidaOOSSDTO validaOS = new ValidaOOSSDTO();
			validaOS.setCodCliente(cliente.getCodCliente());
			validaOS.setCodOS(String.valueOf(this.codOSAnt));
			for(int i=0; i<abonadosValidos.size(); i++){
				AbonadoDTO abonado = (AbonadoDTO)abonadosValidos.get(i);
				//validaOS.setCodPlanTarif(listaAbonadosSel[i].getCodPlanTarif());
				//validaOS.setNumAbonado(listaAbonadosSel[i].getNumAbonado());
				validaOS.setCodPlanTarif(abonado.getCodPlanTarif());
				validaOS.setNumAbonado(abonado.getNumAbonado());
				logger.debug("validaOossPendPlan():inicio");
				validaOS = delegate.validaOossPendPlan(validaOS);
				logger.debug("validaOossPendPlan():fin");
				
				//Se debe validar retorno y desplegar mensaje de confirmacion
				if (validaOS.getCodigo().equals("1")){
					//mensaje de anulacion de ordenes de servicio pendientes
					msgUsuario = validaOS.getMensaje();
					throw new ManReqException("c.002",MSGCONFIRM, msgUsuario);	
				}//fin existen ordenes pendientes, codigo==1
				
			}//fin for
			
		}//fin if (respuestaConfirm.equals("I"))

		//9.- validar traspaso de servicios homologos
		respuestaConfirm = obtieneRespuestaMensaje("c.003");
		if (respuestaConfirm.equals("I")){
			String aplicaTraspasoSS = null;
			ParametroDTO paramAplicaTraspaso= paramGeneral.obtieneParametro("APLICA_TRASP_SS_OPC");
			if (paramAplicaTraspaso != null) aplicaTraspasoSS = paramAplicaTraspaso.getValorDominio();
			
			if (aplicaTraspasoSS.equalsIgnoreCase("TRUE")){
				msgUsuario = global.getValor("c.003");//msg:¿Desea mantener los servicios suplementarios opcionales?
				throw new ManReqException("c.003",MSGCONFIRM, msgUsuario);
			}
		}else if (respuestaConfirm.equals("S")){
			this.repondeMensaje("c.003", " ");
			respuesta.setAplicaTraspaso("S");
		}
		
		// obtener cambio de plan serv
		abonadoAux.setCodTecnologia(listaAbonadosSel[0].getCodTecnologia());
		abonadoAux.setCodPlanTarif(parametros.getCodPlanTarifSelec());
		logger.debug("obtenerDatosCambPlanServ():inicio");
		abonadoAux = delegate.obtenerDatosCambPlanServ(abonadoAux);
		logger.debug("obtenerDatosCambPlanServ():fin");
		respuesta.setCodPlanServNuevo(abonadoAux.getCodPlanServ());
		
		//10.- obtener fecha ciclo
		IntarcelDTO intarcel = new IntarcelDTO();
		intarcel.setCodCliente(cliente.getCodCliente());
		intarcel.setNumAbonado(listaAbonadosSel[0].getNumAbonado());
		logger.debug("obtenerFecDesdeCtaSeg():inicio");
		
		intarcel = delegate.obtenerFecDesdeCtaSeg(intarcel);
		logger.debug("obtenerFecDesdeCtaSeg():fin");
		
		Date fechaDesde = intarcel.getFecDesde();
		logger.debug("fechaDesde:"+fechaDesde);
		if (fechaDesde != null){
			String fecha = Formatting.dateTime(intarcel.getFecDesde(), "dd-MM-yyyy");
			logger.debug("fecha:"+fecha);
			respuesta.setFecDesdeLlam(fecha);
		}
		
		//11.- validaOossPendPlan cliente destino empresa
		logger.debug("tipoPlanTarifDestino[" + parametros.getTipoPlanTarifDestino() + "]");
		if("E".equals(parametros.getTipoPlanTarifDestino())){
			ValidaOOSSDTO validaOS = new ValidaOOSSDTO();
			validaOS.setCodClienteDestino(Long.parseLong(parametros.getCodClienteDestino()));
			logger.debug("codClienteDestino[" + validaOS.getCodClienteDestino() + "]");
			logger.debug("validaOossPendPlan():inicio");
			validaOS = delegate.validaOossPendPlan(validaOS);
			logger.debug("validaOossPendPlan():fin");
			if (validaOS.getCodigo().equals("1")){
				msgUsuario = validaOS.getMensaje();
				throw new ManReqException("c.002",0, msgUsuario);
			}
			
		}
		
		//validaPlanTarif
		String codTipPlan = this.listaAbonadosSel[0].getCodTipPlan();
		
		String codTipPlanTarifAux = "";
		String planCtaSegura = global.getValor("planCtaSegura");
		String codUsoB = listaAbonadosSel[0].getCodUso();
		String moduloGA =  global.getValor("codigo.modulo.GA");
		String codProducto = global.getValor("codigo.producto");
		String codActAboAux = " ";
			
		ParametroDTO param = new ParametroDTO();
		param.setNomParametro("TIPOPOSTPAGO");
		param.setCodModulo(moduloGA);
		param.setCodProducto(Integer.parseInt(codProducto));
		logger.debug("obtenerParametroGeneral():inicio");
		param = delegate.obtenerParametroGeneral(param);
		logger.debug("obtenerParametroGeneral():fin");
			
		if(codTipPlan.equals(param.getValor())){
			codUsoB = planCtaSegura;
			codTipPlanTarifAux = "3";
		}else{
			param.setNomParametro("TIPOHIBRIDO");
			param.setCodModulo(moduloGA);
			param.setCodProducto(Integer.parseInt(codProducto));
			logger.debug("obtenerParametroGeneral():inicio");
			param = delegate.obtenerParametroGeneral(param);
			logger.debug("obtenerParametroGeneral():fin");
				
			if(codTipPlan.equals(param.getValor())){
					param.setNomParametro("USO_LINEA");
					param.setCodModulo(moduloGA);
					param.setCodProducto(Integer.parseInt(codProducto));
					logger.debug("obtenerParametroGeneral():inicio");
					param = delegate.obtenerParametroGeneral(param);
					logger.debug("obtenerParametroGeneral():fin");
					codUsoB = param.getValor();
					codTipPlanTarifAux = "2";
				}
			}
			
			param = new ParametroDTO();
			param.setCodModulo(moduloGA);
			param.setCodProducto(Integer.parseInt(codProducto));
			
			if (codUsoB.equals(planCtaSegura)) param.setNomParametro("INPUT_HIBRIDO"); 
			else param.setNomParametro("OUTPUT_HIBRIDO"); 
			
			logger.debug("obtenerParametroGeneral():inicio");
			param = delegate.obtenerParametroGeneral(param);
			logger.debug("obtenerParametroGeneral():fin");
			codActAboAux = param.getValor();
			
			//obtener conversion de actuacion abonado
			ConvertActAboDTO convert = new ConvertActAboDTO();
			convert.setCodActAbo(codActAboAux);
			convert.setCodTipPlan(codTipPlanTarifAux); 
			logger.debug("obtenerConverActAbo():inicio");
			convert = delegate.obtenerConverActAbo(convert);
			logger.debug("obtenerConverActAbo():inicio");

			if ((convert.getCodActAboHom()== null) || convert.getCodActAboHom().trim().equals("")){
				msgUsuario = global.getValor("e.010");//msg:No existe actuación comercial  para la OOSS
				throw new ManReqException("e.010",0, msgUsuario); //salir y desmarcar opcion
			}

			String codActAboHom= convert.getCodActAboHom();
			logger.debug("codActAboHom="+codActAboHom);
			respuesta.setCodActAboAux(codActAboHom);
			
		logger.debug("validaCondicionesPospagoHibrido():fin");
			
		return respuesta;
		
	}//fin validaCondicionesPospagoHibrido

	/**
	 * Valida condiciones PREPAGOPREPAGO-HIBRIDOHIBRIDO
	 * @param parametros
	 * @return RetornoCondicionesCPUDTO
	 */
	public RetornoCondicionesCPUDTO validaCondicionesPrepagoPrepago(ParametrosCondicionesCPUDTO parametros,RestriccionesDTO restricciones) throws ManReqException{
		logger.debug("validaCondicionesPrepagoPrepago():ini");
		RetornoCondicionesCPUDTO respuesta = new RetornoCondicionesCPUDTO();
		String respuestaConfirm = " ";
		String msgUsuario = " ";
		String msgError ="";
		SecuenciaDTO parametro=null;
		SecuenciaDTO retornoSecuencia=null;

	    ArrayList abonadosValidos = new ArrayList();
	    ArrayList abonadosInvalidos = new ArrayList();
	    
	    //Recorre lista de abonados seleccionados
		for (int i=0; i<listaAbonadosSel.length;i++){ 
			restricciones.setNumAbonado(listaAbonadosSel[i].getNumAbonado());
		    restricciones.setNumVenta(this.listaAbonadosSel[i].getNumVenta());
		    restricciones.setCodUso(Integer.parseInt(this.listaAbonadosSel[i].getCodUso()));
		    restricciones.setCodCuentaOrigen(this.listaAbonadosSel[i].getCodCuenta());
		    restricciones.setCodCuentaDestino(this.listaAbonadosSel[i].getCodCuenta());
		    restricciones.setTipoPlan(this.listaAbonadosSel[i].getCodTipoPlanTarif());
		    restricciones.setNumCiclo(this.listaAbonadosSel[i].getCodCiclo());
		    restricciones.setCodCentral(this.listaAbonadosSel[i].getCodCentral());

		    logger.debug("restricciones.getIdSecuencia()       :"+restricciones.getIdSecuencia());
		    logger.debug("restricciones.getPrograma()          :"+restricciones.getPrograma());
		    logger.debug("restricciones.getProceso()           :"+restricciones.getProceso());
		    logger.debug("restricciones.getCodActuacion()      :"+restricciones.getCodActuacion());
		    logger.debug("restricciones.getCodCliente()        :"+restricciones.getCodCliente());
		    logger.debug("restricciones.getCodModGener()       :"+restricciones.getCodModGener());
		    logger.debug("restricciones.getNumVenta()          :"+restricciones.getNumVenta());
		    logger.debug("restricciones.getCodOOSS()           :"+restricciones.getCodOOSS());
		    logger.debug("restricciones.getCodVendedor()       :"+restricciones.getCodVendedor());
		    logger.debug("restricciones.getDesactivacionSS()   :"+restricciones.getDesactivacionSS());
		    logger.debug("restricciones.getPlanDestino()       :"+restricciones.getPlanDestino());
		    logger.debug("restricciones.getCodUso()            :"+restricciones.getCodUso());
		    logger.debug("restricciones.getCodCuentaOrigen()   :"+restricciones.getCodCuentaOrigen());
		    logger.debug("restricciones.getCodCuentaDestino()  :"+restricciones.getCodCuentaDestino());
		    logger.debug("restricciones.getCodClienteDestino() :"+restricciones.getCodClienteDestino());
		    logger.debug("restricciones.getTipoPlan()          :"+restricciones.getTipoPlan());
		    logger.debug("restricciones.getTipoPlanDestino()   :"+restricciones.getTipoPlanDestino());
		    logger.debug("restricciones.getNumCiclo()          :"+restricciones.getNumCiclo());
		    logger.debug("restricciones.getFechaSistema()      :"+restricciones.getFechaSistema());
		    logger.debug("restricciones.getRestriccionAux()    :"+restricciones.getRestriccionAux());
		    logger.debug("restricciones.getCodModulo()         :"+restricciones.getCodModulo());
		    logger.debug("restricciones.getCodTarea()          :"+restricciones.getCodTarea());
		    logger.debug("restricciones.getCodCentral()        :"+restricciones.getCodCentral());
		    
		    boolean validaEventos = true; 

		    //valida plan tarifario
		    if (parametros.getCodPlanTarifSelec().equals(this.listaAbonadosSel[i].getCodPlanTarif())){
		    	logger.debug("error en abonado :"+listaAbonadosSel[i].getNumAbonado());
		    	listaAbonadosSel[i].setDesSituacion("Plan tarifario debe ser distinto al seleccionado");
				validaEventos = false;
		    }
		    else{ //valida restriccciones comerciales
		    	
			    parametro = new SecuenciaDTO();
				parametro.setNomSecuencia("GA_SEQ_TRANSACABO");
					
				logger.debug("obtenerSecuencia():inicio");
				retornoSecuencia = delegate.obtenerSecuencia(parametro);
				logger.debug("obtenerSecuencia():fin");
	
			    restricciones.setIdSecuencia(retornoSecuencia.getNumSecuencia());
				    
				//ejecutar metodo que valida las restricciones comerciales
				logger.debug("validaRestriccionComerOoss : inicio, abonado="+listaAbonadosSel[i].getNumAbonado());
				try{
					delegate.validaRestriccionComerOoss(restricciones);
				}catch(ManReqException e){	
					logger.debug("error en abonado :"+listaAbonadosSel[i].getNumAbonado());
					logger.debug("codigo="+e.getCodigo()+", Mensaje="+e.getDescripcionEvento());
					listaAbonadosSel[i].setDesSituacion(e.getDescripcionEvento()); 
					validaEventos = false;
				}
				logger.debug("validaRestriccionComerOoss:fin");
		    }
		    
			if (validaEventos){
				abonadosValidos.add(listaAbonadosSel[i]);
			}
			else {
				abonadosInvalidos.add(listaAbonadosSel[i]);
			}
		}//fin valida lista de abonados seleccionados
		
		if (!abonadosInvalidos.isEmpty()){
			AbonadoDTO[] arrayAbonadosInvalidos = (AbonadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(abonadosInvalidos.toArray(),AbonadoDTO.class);
			respuesta.setAbonadosInvalidos(arrayAbonadosInvalidos);
			respuesta.setMensaje(" ");
			return respuesta;
		}
		

		//if es reordenamiento se debe enviar mensaje indicando que hay abonados que no cumplen las condiciones
		//y mantener seleccionados solo los abonados validos
		int numAbonadosSel = this.listaAbonadosSel.length;
		//actualiza lista de abonados por lista de abonados validos.
		this.listaAbonadosSel = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	abonadosValidos.toArray(), AbonadoDTO.class);
		
		if (listaAbonadosSel.length == 0){// no hay abonados validos
			msgUsuario = global.getValor("e.001"); //msg:Abonado(s) inválido(s)
			if (!msgError.trim().equals("")) msgUsuario = msgError;
			throw new ManReqException("e.001",0, msgUsuario); //no continua ooss
		}
		
		if (numAbonadosSel != abonadosValidos.size()){
			msgUsuario = global.getValor("a.001"); //msg:Existen abonados que no cumplen las condiciones, estos no seran considerados
			throw new ManReqException("a.001",MSGACEPTAR, msgUsuario);					
		}
		
		int totalAbonadosSel = listaAbonadosSel.length;
		
	    //3.- validar traspaso de servicios homologos
		logger.debug("3.- validar traspaso de servicios homologos");
		respuestaConfirm = obtieneRespuestaMensaje("c.003");
		if (respuestaConfirm.equals("I")){
			String aplicaTraspasoSS = null;
			ParametroDTO paramAplicaTraspaso= paramGeneral.obtieneParametro("APLICA_TRASP_SS_OPC");
			if (paramAplicaTraspaso != null) aplicaTraspasoSS = paramAplicaTraspaso.getValorDominio();
			
			if (aplicaTraspasoSS.equalsIgnoreCase("TRUE")){
				msgUsuario = global.getValor("c.003");//msg:¿Desea mantener los servicios suplementarios opcionales?
				throw new ManReqException("c.003",MSGCONFIRM, msgUsuario);
			}
		}else if (respuestaConfirm.equals("S")){
			this.repondeMensaje("c.003", " ");
			respuesta.setAplicaTraspaso("S");
		}

		//4.- consultar saldo y prepago
		logger.debug("4.- consultar saldo y prepago");
		ConsultaSaldoDTO consultaSaldo = new ConsultaSaldoDTO();
		SaldoDTO retornoSaldo = new SaldoDTO();
		ConsultaPrepagosDTO consultaPrepagos = new ConsultaPrepagosDTO();
		String saldo = "0";
		for(int i=0; i<numAbonadosSel; i++){
			//consulta saldo
			//consultaSaldo.setNumCelular(this.listaAbonadosSel[i].getNumCelular());
			//consultaSaldo.setCodTecnologia(this.listaAbonadosSel[i].getCodTecnologia());
			saldo = "0";
			if (aplicaConsultaSaldo()){
				consultaSaldo.setLin(String.valueOf(this.listaAbonadosSel[i].getNumCelular()));
				consultaSaldo.setRegion(String.valueOf(this.listaAbonadosSel[i].getCodTecnologia()));
				logger.debug("consultaSaldo.getLin()    :"+consultaSaldo.getLin());
				logger.debug("consultaSaldo.getRegion() :"+consultaSaldo.getRegion());
				logger.debug("consultaSaldo():inicio");
				
				retornoSaldo = delegate.consultaSaldo(consultaSaldo);
				logger.debug("consultaSaldo():fin");
				if(retornoSaldo.getSaldo()!= null ){
					logger.debug("retornoSaldo.getSaldo()   :"+retornoSaldo.getSaldo());
					logger.debug("saldo length="+retornoSaldo.getSaldo().length());
					saldo = retornoSaldo.getSaldo();
				}
			}
			
			//consulta prepago
			consultaPrepagos.setNumAbonado(this.listaAbonadosSel[i].getNumAbonado());
			consultaPrepagos.setCodPlanTarifActual(this.listaAbonadosSel[i].getCodPlanTarif());
			consultaPrepagos.setCodActAbo(this.codActuacion);
			consultaPrepagos.setCodPlanServ(this.listaAbonadosSel[i].getCodPlanServ());
			consultaPrepagos.setCodTecnologia(this.listaAbonadosSel[i].getCodTecnologia());
			consultaPrepagos.setVnSaldo(Float.parseFloat(saldo));
			logger.debug("consultaPrepago():ini");
			delegate.consultaPrepago(consultaPrepagos);
			logger.debug("consultaPrepago():fin");
		}
		respuesta.setSaldo(saldo);
		
		//5.- obtener cambio de plan serv
		logger.debug("5.- obtener cambio de plan serv");
		AbonadoDTO abonadoAux = this.listaAbonadosSel[0];
		abonadoAux.setCodPlanTarif(parametros.getCodPlanTarifSelec());
		logger.debug("obtenerDatosCambPlanServ():inicio");
		abonadoAux = delegate.obtenerDatosCambPlanServ(abonadoAux);
		logger.debug("obtenerDatosCambPlanServ():fin");
		respuesta.setCodPlanServNuevo(abonadoAux.getCodPlanServ());
		logger.debug("validaCondicionesPrepagoPrepago():fin");	
		return respuesta;
		
	}//fin validaCondicionesPrepagoPrepago

	/**
	 * Valida condiciones PREPAGOPOSPAGO-PREPAGOHIBRIDO, solo aplica puntual
	 * @param parametros
	 * @return RetornoCondicionesCPUDTO
	 */
	public RetornoCondicionesCPUDTO validaCondicionesPrepagoPospago(ParametrosCondicionesCPUDTO parametros,RestriccionesDTO restricciones) throws ManReqException{
		logger.debug("validaCondicionesPrepagoPospago():ini");
		RetornoCondicionesCPUDTO respuesta = new RetornoCondicionesCPUDTO();
		String respuestaConfirm = " ";
		String msgUsuario = " ";
		SecuenciaDTO parametro=null;
		SecuenciaDTO retornoSecuencia=null;
		
	    restricciones.setNumVenta(this.listaAbonadosSel[0].getNumVenta());
	    restricciones.setCodUso(Integer.parseInt(this.listaAbonadosSel[0].getCodUso()));
	    restricciones.setCodCuentaOrigen(this.listaAbonadosSel[0].getCodCuenta());
	    restricciones.setCodCuentaDestino(this.listaAbonadosSel[0].getCodCuenta());
	    restricciones.setTipoPlan(this.listaAbonadosSel[0].getCodTipoPlanTarif());
	    restricciones.setNumCiclo(this.listaAbonadosSel[0].getCodCiclo());
	    restricciones.setCodCentral(this.listaAbonadosSel[0].getCodCentral());
	    restricciones.setNumAbonado(listaAbonadosSel[0].getNumAbonado());

		parametro = new SecuenciaDTO();
		parametro.setNomSecuencia("GA_SEQ_TRANSACABO");
		
		logger.debug("obtenerSecuencia():inicio");
		retornoSecuencia = delegate.obtenerSecuencia(parametro);
		logger.debug("obtenerSecuencia():fin");
		
	    restricciones.setIdSecuencia(retornoSecuencia.getNumSecuencia());
	    
		//ejecutar metodo que valida las restricciones comerciales
		logger.debug("validaRestriccionComerOoss : inicio, abonado="+listaAbonadosSel[0].getNumAbonado());
		try{
			delegate.validaRestriccionComerOoss(restricciones);
		}catch(ManReqException e){	
			logger.debug("error en abonado :"+listaAbonadosSel[0].getNumAbonado());
			logger.debug("codigo="+e.getCodigo()+", Mensaje="+e.getDescripcionEvento());
			listaAbonadosSel[0].setDesSituacion(e.getDescripcionEvento()); 
			AbonadoDTO[] arrayAbonadosInvalidos = new AbonadoDTO[1];
			arrayAbonadosInvalidos[0] = listaAbonadosSel[0]; 
			respuesta.setAbonadosInvalidos(arrayAbonadosInvalidos);
			respuesta.setMensaje(" ");
			return respuesta;
		}
		logger.debug("validaRestriccionComerOoss:fin");
		
		//3.- validar cuenta personal
		respuestaConfirm = obtieneRespuestaMensaje("c.001");
		if (respuestaConfirm.equals("I")){
				boolean valCuentaPersonal = false;
				CuentaPersonalDTO cuentaPers = new CuentaPersonalDTO();
				cuentaPers.setNumCelularCorp(0);
				cuentaPers.setNumCelular(listaAbonadosSel[0].getNumCelular());
				logger.debug("validaCuentaPersonal():inicio");
				valCuentaPersonal = delegate.validaCuentaPersonal(cuentaPers).isResultado();
				logger.debug("validaCuentaPersonal():inicio");
				
				//obtener plan atlantida
				AbonadoDTO abonadop = new AbonadoDTO();
				abonadop.setCodPlanTarif(parametros.getCodPlanTarifSelec());
				logger.debug("obtenerPlanAtlantida():inicio");
				boolean valPlanAtlantida = delegate.obtenerPlanAtlantida(abonadop).isResultado();
				logger.debug("obtenerPlanAtlantida():fin");
				if (valPlanAtlantida && valCuentaPersonal){ 
					msgUsuario = global.getValor("c.001"); //msg:Esta línea es una cuenta personal asociada a ...
					throw new ManReqException("c.001",MSGCONFIRM, msgUsuario);
				}
		} //si respuesta es si(S) continua la orden de servicio
		
		
		//consultar saldo
		String saldo = "0";
		if (aplicaConsultaSaldo()){
			logger.debug(" consultar saldo");
			ConsultaSaldoDTO consultaSaldo = new ConsultaSaldoDTO();
			SaldoDTO retornoSaldo = new SaldoDTO();
			consultaSaldo.setLin(String.valueOf(this.listaAbonadosSel[0].getNumCelular()));
			consultaSaldo.setRegion(String.valueOf(this.listaAbonadosSel[0].getCodTecnologia()));
			logger.debug("consultaSaldo.getLin()    :"+consultaSaldo.getLin());
			logger.debug("consultaSaldo.getRegion() :"+consultaSaldo.getRegion());
			logger.debug("consultaSaldo():inicio");
				
			retornoSaldo = delegate.consultaSaldo(consultaSaldo);
			logger.debug("consultaSaldo():fin");
			if(retornoSaldo.getSaldo()!= null)logger.debug("retornoSaldo.getSaldo()   :"+retornoSaldo.getSaldo());
			saldo = retornoSaldo.getSaldo();
		}
		
		respuesta.setSaldo(saldo);

		logger.debug("validaCondicionesPrepagoPospago():fin");	
		return respuesta;
		
	}//fin validaCondicionesPrepagoPospago
	
	/**
	 * Valida seleccion de opcion hibrido
	 * @param parametros
	 * @param abonadosSel
	 * @return RetornoCondicionesCPUDTO
	 */
	public RetornoCondicionesCPUDTO validaOpcion(ParametrosCondicionesCPUDTO parametros, long[] abonadosSel  ){
		RetornoCondicionesCPUDTO respuesta = new RetornoCondicionesCPUDTO();
		String msgUsuario = " ";
		
		logger.debug("validaOpcion():ini");
		try{
			//para pospagohibrido
			if (parametros.getCombinatoriaGenerada().equals("POSPAGOHIBRIDO") ||parametros.getCombinatoriaGenerada().equals("HIBRIDOPOSPAGO")){
				//carga abonado seleccionado
				cargaAbonadosSeleccionados(abonadosSel);
				int totalAbonadosSel = this.listaAbonadosSel.length;
				if (totalAbonadosSel == 1){
					AbonadoDTO abonadoAux = this.listaAbonadosSel[0];
					
					//validar codSituacion AAA
					if (!abonadoAux.getCodSituacion().equals("AAA")){
							msgUsuario = global.getValor("e.007");//msg:El abonado no cumple las condiciones que exige ...
							msgUsuario = msgUsuario.replaceFirst("xx", abonadoAux.getCodSituacion());
							throw new ManReqException("e.007",0, msgUsuario); //salir y desmarcar opcion
					}
					
					//validar disponibilidad
					if (abonadoAux.getIndDisp() == 0){ 
						msgUsuario = global.getValor("e.008");//msg:El abonado tiene su Equipo en Serv. Tecnico ...
						throw new ManReqException("e.008",0, msgUsuario); //salir y desmarcar opcion
					}
					
					//validar  tipo plan tarifario
					if (abonadoAux.getCodTipoPlanTarif().equals("E")){
						msgUsuario = global.getValor("e.009");//msg:Operación Permitida Solo para Abonados con ...
						throw new ManReqException("e.009",0, msgUsuario); //salir y desmarcar opcion
					}
					
				}//fin totalAbonadoSel == 1
			}//fin combinatoria pospagohibrido
			
		} catch (ManReqException e) {
			
			if(e.getCodigo()==null || e.getCodigo().equals("0")){
				logger.debug("ERROR (ManReqException) :"+e.getMessage());
				respuesta.setMensaje(e.getMessage());
			}else{
				logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
				respuesta.setCodMensaje(e.getCodigo());
				respuesta.setCodTipMensaje(e.getCodigoEvento());
				respuesta.setMensaje(e.getDescripcionEvento());
			}
			parametros=null;
		
		} catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			respuesta.setMensaje(e.getMessage());
			parametros=null;
		
		}
		
		logger.debug("validaOpcion():fin");
		return respuesta;
	}
	
	
	/**
	 * Valida evaluacion crediticia
	 * @param parametros
	 * @param codCliente
	 * @return RetornoCondicionesCPUDTO
	 */
	public RetornoCondicionesCPUDTO validaEvalCrediticia(String combinatoria, EvalCrediticiaDTO cliente ){
		RetornoCondicionesCPUDTO respuesta = new RetornoCondicionesCPUDTO();
		String msgUsuario = " ";
		
		logger.debug("validaEvalCrediticia():ini");
		try{
			if (combinatoria.equals("PREPAGOPOSPAGO")||
					combinatoria.equals("POSPAGOPOSPAGO")||
					combinatoria.equals("HIBRIDOPOSPAGO")){
				
		        /*parametros entrada: codCliente,tipoIdentificador,numIdentificador,
		          nombres,apellido1,apellido2 */
				RespuestaEvalCrediticiaDTO retornoWS = delegate.validarEvaluacionCrediticia(cliente);
								
				if (!retornoWS.isResultado()){
					msgUsuario = retornoWS.getMensajeError();
					throw new ManReqException("-1",0, msgUsuario); 
				}
				logger.debug("Eval Crediticia, LimiteCliente="+retornoWS.getLimiteCliente());
				respuesta.setLimConsumoEvalCred(retornoWS.getLimiteCliente());
				//respuesta.setLimConsumoEvalCred("100000");//BORRAR DESPUES
			}
			
		} catch (ManReqException e) {
			
			if(e.getCodigo()==null || e.getCodigo().equals("0")){
				logger.debug("ERROR (ManReqException) :"+e.getMessage());
				respuesta.setCodMensaje("-1");
				if (e.getMessage()!=null)	respuesta.setMensaje(e.getMessage());
				else respuesta.setMensaje("Error al obtener importe para evaluacion crediticia");
			}else{
				logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
				respuesta.setCodMensaje(e.getCodigo());
				respuesta.setCodTipMensaje(e.getCodigoEvento());
				respuesta.setMensaje(e.getDescripcionEvento());
			}
		
		} catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			respuesta.setCodMensaje("-1");
			if (e.getMessage()!=null)	respuesta.setMensaje(e.getMessage());
			else respuesta.setMensaje("Error al obtener importe para evaluacion crediticia");
		
		}
		
		logger.debug("validaEvalCrediticia():fin");
		return respuesta;
	}
	
	/**
	 * Valida plan tarifario
	 * @param parametros
	 * @param abonadosSel
	 * @return RetornoCondicionesCPUDTO
	 */	
	/*public RetornoCondicionesCPUDTO validaPlanTarif(ParametrosCondicionesCPUDTO parametros, long[] abonadosSel  ){
		RetornoCondicionesCPUDTO respuesta = new RetornoCondicionesCPUDTO();
		String msgUsuario = " ";
		String codTipPlanTarifAux = "";
		
		logger.debug("validaPlanTarif():ini");
		logger.debug("parametros.getCombinatoriaGenerada()="+parametros.getCombinatoriaGenerada());
		try{
			//para pospagohibrido
			if (parametros.getCombinatoriaGenerada().equals("POSPAGOHIBRIDO") ||parametros.getCombinatoriaGenerada().equals("HIBRIDOPOSPAGO") ){
				//carga abonado seleccionado
				cargaAbonadosSeleccionados(abonadosSel);
				int totalAbonadosSel = this.listaAbonadosSel.length;
				if (totalAbonadosSel == 1){
					AbonadoDTO abonadoAux = this.listaAbonadosSel[0];
					
					
					String planCtaSegura = global.getValor("planCtaSegura");
					String codUsoB = abonadoAux.getCodUso();
					String moduloGA =  global.getValor("codigo.modulo.GA");
					String codProducto = global.getValor("codigo.producto");
					String codActAboAux = " ";
					
					ParametroDTO param = new ParametroDTO();
					param.setNomParametro("TIPOPOSTPAGO");
					param.setCodModulo(moduloGA);
					param.setCodProducto(Integer.parseInt(codProducto));
					logger.debug("obtenerParametroGeneral():inicio");
					param = delegate.obtenerParametroGeneral(param);
					logger.debug("obtenerParametroGeneral():fin");
					
					if(abonadoAux.getCodTipPlan().equals(param.getValor())){
						codUsoB = planCtaSegura;
						codTipPlanTarifAux = "3";
					}else{
						param.setNomParametro("TIPOHIBRIDO");
						param.setCodModulo(moduloGA);
						param.setCodProducto(Integer.parseInt(codProducto));
						logger.debug("obtenerParametroGeneral():inicio");
						param = delegate.obtenerParametroGeneral(param);
						logger.debug("obtenerParametroGeneral():fin");
						
						if(abonadoAux.getCodTipPlan().equals(param.getValor())){
							param.setNomParametro("USO_LINEA");
							param.setCodModulo(moduloGA);
							param.setCodProducto(Integer.parseInt(codProducto));
							logger.debug("obtenerParametroGeneral():inicio");
							param = delegate.obtenerParametroGeneral(param);
							logger.debug("obtenerParametroGeneral():fin");
							codUsoB = param.getValor();
							codTipPlanTarifAux = "2";
						}
					}
					
					
				
					ParametroDTO parametro = new ParametroDTO();
					parametro.setCodModulo(moduloGA);
					parametro.setCodProducto(Integer.parseInt(codProducto));
					
					if (codUsoB.equals(planCtaSegura)) parametro.setNomParametro("INPUT_HIBRIDO"); 
					else parametro.setNomParametro("OUTPUT_HIBRIDO"); 
					
					logger.debug("obtenerParametroGeneral():inicio");
					parametro = delegate.obtenerParametroGeneral(parametro);
					logger.debug("obtenerParametroGeneral():fin");
					codActAboAux = parametro.getValor();
					
					//obtener conversion de actuacion abonado
					ConvertActAboDTO convert = new ConvertActAboDTO();
					convert.setCodActAbo(codActAboAux);
					convert.setCodTipPlan(codTipPlanTarifAux); 
					logger.debug("obtenerConverActAbo():inicio");
					convert = delegate.obtenerConverActAbo(convert);
					logger.debug("obtenerConverActAbo():inicio");

					if ((convert.getCodActAboHom()== null) || convert.getCodActAboHom().trim().equals("")){
						msgUsuario = global.getValor("e.010");//msg:No existe actuación comercial  para la OOSS
						throw new ManReqException("e.010",0, msgUsuario); //salir y desmarcar opcion
					}

					String codActAboHom= convert.getCodActAboHom();
					logger.debug("codActAboHom="+codActAboHom);
					respuesta.setCodActAboAux(codActAboHom);
					
				}
			}//fin combinatoria pospagohibrido
			
		} catch (ManReqException e) {
			
			if(e.getCodigo()==null || e.getCodigo().equals("0")){
				logger.debug("ERROR (ManReqException) :"+e.getMessage());
				respuesta.setMensaje(e.getMessage());
			}else{
				logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
				respuesta.setCodMensaje(e.getCodigo());
				respuesta.setCodTipMensaje(e.getCodigoEvento());
				respuesta.setMensaje(e.getDescripcionEvento());
			}
			parametros=null;
		
		} catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			respuesta.setMensaje(e.getMessage());
			parametros=null;
		
		}
		
		logger.debug("validaPlanTarif():fin");
		return respuesta;		
	}*/
	public void actualizaListaCliente(int tipoCliente){
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    HttpSession session = WebContextFactory.get().getSession();
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    ClienteDTO cliente = sessionData.getCliente();
	    String strTipoCliente = null;
	    ClienteDTO[] arrayClientes = null;
	    ArrayList listClientes = new ArrayList();
	    
	    try {
	    	ClienteTipoPlanListDTO listasDeClientes=delegate.obtenerDatosClienteCuenta(cliente);
		    switch(tipoCliente){
				case 1://prepago
					arrayClientes = listasDeClientes.getClientesPrepago();
					strTipoCliente = "clientesPrepago";
				break;
				case 2://pospago
					arrayClientes = listasDeClientes.getClientesPospago();
					strTipoCliente = "clientesPospago";
				break;
				case 3://hibrido
					arrayClientes = listasDeClientes.getClientesHibrido();
					strTipoCliente = "clientesHibrido";
				break;
		    }
		    
			if (arrayClientes!=null) for(int i=0;i<arrayClientes.length;i++) listClientes.add(arrayClientes[i]);		
			session.setAttribute(strTipoCliente, listClientes);
	    }
	    catch(Exception e){
	    	System.out.println(e);	
	    }
		
	}
	
	public ClienteDTO buscaClienteSeleccionado (String codCliente,int tipoPlan){
		logger.debug("buscaClienteSeleccionado():ini");
		ClienteDTO cliente = null;
	    HttpSession session = WebContextFactory.get().getSession();
	    ArrayList listClientes = null;
	    long codClienteSel = 0;
	    try{
	    	codClienteSel = Long.parseLong(codCliente);
	    }catch(Exception e){}
	    
	    switch(tipoPlan){
			case 1://prepago
				listClientes =  (ArrayList) session.getAttribute("clientesPrepago");
			break;
			case 2://pospago
				listClientes =  (ArrayList) session.getAttribute("clientesPospago");
			break;
			case 3://hibrido
				listClientes =  (ArrayList) session.getAttribute("clientesHibrido");
			break;
		}
		if (listClientes!=null && !listClientes.isEmpty()){
			Iterator it = listClientes.iterator();
			while(it.hasNext()){
			   ClienteDTO clienteLista = (ClienteDTO) it.next();
			   if (clienteLista.getCodCliente() == codClienteSel){
				   cliente = clienteLista;
				   break;
			   }
			}	
		}
		session.setAttribute("consultaEvalRiesgoReo","false");
		logger.debug("buscaClienteSeleccionado():fin");
		return cliente;
	}
	
	public void actualizaListaPlanTarifario(
			int tipoPlan,String	codigoPlanTarifario,String descripcionPlanTarifario,String tipoPlanTarifario,
			String codigoCargoBasico,String descripcionCargoBasico,String importeCargoBasico,String importeLimite,
			String importeFinal,String codigoLimiteConsumo,String descripcionLimiteConsumo,String numDias
	){
	    HttpSession session = WebContextFactory.get().getSession();
	    String strTipoPlan = null;
	    ArrayList listPlanesTarifarios = new ArrayList();

	    switch(tipoPlan){
			case 1://prepago
				strTipoPlan = "planTarifPrepago";
			break;
			case 2://pospago
				strTipoPlan = "planTarifPospago";
			break;
			case 3://hibrido
				strTipoPlan = "planTarifHibrido";
			break;
	    }
	    
	    listPlanesTarifarios = (ArrayList) session.getAttribute(strTipoPlan);
	    PlanTarifarioDTO plan = new PlanTarifarioDTO();
	    plan.setCodPlanTarif(codigoPlanTarifario);
	    plan.setDesPlanTarif(descripcionPlanTarifario);
	    plan.setLimiteConsumo(codigoLimiteConsumo);
	    plan.setDescripcionLimiteConsumo(descripcionLimiteConsumo);
	    plan.setImpCargoBasico(importeCargoBasico!=null?Float.parseFloat(importeCargoBasico):0.0f);
	    plan.setTipoPlanTarifario(tipoPlanTarifario);
	    plan.setCodCargoBasico(codigoCargoBasico);
	    plan.setNumDias(numDias!=null?Integer.parseInt(numDias):0);
	    plan.setImpFinal(importeFinal!=null?Float.parseFloat(importeFinal):0.0f);
	    plan.setImporteLimite(importeLimite!=null?Double.parseDouble(importeLimite):0.0);
	    
		if (listPlanesTarifarios!=null){
			listPlanesTarifarios.add(plan);
		}     
		session.setAttribute(strTipoPlan,listPlanesTarifarios);
	    listPlanesTarifarios = (ArrayList) session.getAttribute(strTipoPlan);
	   // System.out.println("Tamaño despues:"+listPlanesTarifarios.size());

	}
	public PlanTarifarioDTO buscaPlanTarifSeleccionado (String codPlan,int tipoPlan){
		PlanTarifarioDTO plan = null;
	    HttpSession session = WebContextFactory.get().getSession();
	    ArrayList listPlanes = null;
	    
	    switch(tipoPlan){
			case 1://prepago
				listPlanes =  (ArrayList) session.getAttribute("planTarifPrepago");
			break;
			case 2://pospago
				listPlanes =  (ArrayList) session.getAttribute("planTarifPospago");
			break;
			case 3://hibrido
				listPlanes =  (ArrayList) session.getAttribute("planTarifHibrido");
			break;
		}
	    
		if (listPlanes!=null && !listPlanes.isEmpty()){
			Iterator it = listPlanes.iterator();
			while(it.hasNext()){
			   PlanTarifarioDTO planLista = (PlanTarifarioDTO) it.next();
			   if (planLista.getCodPlanTarif().equals(codPlan)){
				   plan = planLista;
				   break;
			   }
			}	
		}
		return plan;
	}
	
	public ArrayList quitarPlanTarifarioEmpresa (){
	    // Elimina el último elemento de la lista
		HttpSession session = WebContextFactory.get().getSession();
	    ArrayList listPlanes = (ArrayList) session.getAttribute("planTarifPospago");
	    PlanTarifarioDTO plan = (PlanTarifarioDTO)listPlanes.get(listPlanes.size()-1);

	    if (plan.getTipoPlanTarifario().equals("E")){
	    	listPlanes.remove(listPlanes.size()-1);
	    }
	    session.setAttribute("planTarifPospago",listPlanes);
	    session.setAttribute("consultaEvalRiesgoReo","false");
	    return listPlanes;
		
	}
	public RespuestaPlanTarifarioDTO cargarPlanTarifarioEmpresa (String codPlanTarif, String codCliente){
		quitarPlanTarifarioEmpresa();
		RespuestaPlanTarifarioDTO respuesta = new RespuestaPlanTarifarioDTO();
		PlanTarifarioDTO plan = new PlanTarifarioDTO();
	    HttpSession session = WebContextFactory.get().getSession();
	    ArrayList listPlanes = (ArrayList) session.getAttribute("planTarifPospago");

	    try{
		    //busca plan tarifario empresa
		    plan.setCodPlanTarif(codPlanTarif);
		    plan.setCodCliente(codCliente);
		    logger.debug("obtenerPlanTarifario():inicio");
		    plan =delegate.obtenerPlanTarifario(plan);
		    plan.setDesPlanTarif(plan.getCodPlanTarif()+"-"+plan.getDesPlanTarif());
		    logger.debug("obtenerPlanTarifario():fin");

		    //carga nuevo plan en la lista
		    listPlanes.add(plan);
		    
		    //devuelve plan
		    respuesta.setCodPlanTarif(plan.getCodPlanTarif());
		    respuesta.setDesPlanTarif(plan.getDesPlanTarif());
		    respuesta.setCodLimiteConsumo(plan.getCodigoLimiteConsumo());
		    respuesta.setDesLimiteConsumo(plan.getDescripcionLimiteConsumo());
		    respuesta.setCodCargoBasico(plan.getCodCargoBasico());
		    respuesta.setDesCargoBasico(plan.getDesCargoBasico());
		    respuesta.setImpCargoBasico(plan.getImpCargoBasico());
		    respuesta.setNumDias(plan.getNumDias());
		    respuesta.setTipPlanTarif(plan.getTipoPlanTarifario());
		    respuesta.setImpLimiteConsumo(plan.getImpLimiteConsumo());
		    respuesta.setCantidadAbonadosPermitidos(plan.getCantidadAbonadosPermitidos());
		    respuesta.setNumFrecFijos(plan.getNumFrecFijos());
		    respuesta.setNumFrecMovil(plan.getNumFrecMovil());
		    respuesta.setIndFf(plan.getIndFf());
		    respuesta.setNumFrecIng(plan.getNumFrecIng());
			
		    logger.debug("CodPlanTarif="+plan.getCodPlanTarif());
		    logger.debug("DesPlanTarif="+plan.getDesPlanTarif());
		    logger.debug("CodLimiteConsumo="+plan.getCodigoLimiteConsumo());
		    logger.debug("DesLimiteConsumo="+plan.getDescripcionLimiteConsumo());
		    logger.debug("CodCargoBasico="+plan.getCodCargoBasico());
		    logger.debug("DesCargoBasico="+plan.getDesCargoBasico());
		    logger.debug("ImpCargoBasico="+plan.getImpCargoBasico());
		    logger.debug("NumDias="+plan.getNumDias());
		    logger.debug("TipPlanTarif="+plan.getTipoPlanTarifario());
		    logger.debug("ImpLimiteConsumo="+plan.getImpLimiteConsumo());
		    logger.debug("CantidadAbonadosPermitidos="+plan.getCantidadAbonadosPermitidos());
		    logger.debug("NumFrecFijos="+plan.getNumFrecFijos());
		    logger.debug("NumFrecMovil="+plan.getNumFrecMovil());
		    logger.debug("IndFf="+plan.getIndFf());
		    logger.debug("NumFrecIng="+plan.getNumFrecIng());
		
	    } catch (ManReqException e) {
		
	    	if(e.getCodigo()==null || e.getCodigo().equals("0")){
	    		logger.debug("ERROR (ManReqException) :"+e.getMessage());
	    		respuesta.setMensaje(e.getMessage());
	    	}else{
	    		logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
	    		respuesta.setCodMensaje(e.getCodigo());
	    		respuesta.setCodTipMensaje(e.getCodigoEvento());
	    		respuesta.setMensaje(e.getDescripcionEvento());
	    	}
	
	    } catch (Exception e) {
	    	logger.debug("ERROR (Exception) :"+e.getMessage());
	    	respuesta.setMensaje(e.getMessage());
	    }	
		
		return respuesta;
	}	
	
	public RespuestaClienteDTO obtenerNumAbonadosCliente (long codCliente, long codCuenta){
		RespuestaClienteDTO respuesta = new RespuestaClienteDTO();
		ClienteDTO cliente = new ClienteDTO();
	    
	    try{
		    cliente.setCodCliente(codCliente);
		    cliente.setCodCuenta(codCuenta);
		    logger.debug("obtenerNumAbonadosCliente():inicio");
		    cliente =delegate.obtenerNumAbonadosCliente(cliente);
		    logger.debug("obtenerNumAbonadosCliente():fin");
		    logger.debug("numAbonados="+cliente.getNumAbonados());
		    respuesta.setNumAbonados(cliente.getNumAbonados());
		
	    } catch (ManReqException e) {
		
	    	if(e.getCodigo()==null || e.getCodigo().equals("0")){
	    		logger.debug("ERROR (ManReqException) :"+e.getMessage());
	    		respuesta.setMensaje(e.getMessage());
	    	}else{
	    		logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
	    		respuesta.setCodMensaje(e.getCodigo());
	    		respuesta.setCodTipMensaje(e.getCodigoEvento());
	    		respuesta.setMensaje(e.getDescripcionEvento());
	    	}
	
	    } catch (Exception e) {
	    	logger.debug("ERROR (Exception) :"+e.getMessage());
	    	respuesta.setMensaje(e.getMessage());
	    }	
		
		return respuesta;
	}		
	public RetornoCondicionesCPUDTO ValidaCuentaPersonal(ParametrosCondicionesCPUDTO parametros , long[] abonadosSel,String tipoPlanDestinoSel ){
		RetornoCondicionesCPUDTO retorno = new RetornoCondicionesCPUDTO();
		String mensajeRetorno = null; 
		
		logger.debug("ValidaCuentaPersonal():inicio");
		ParametroDTO paramGral = null;		
		int clieOriEsAtlantida = 0;
		int aboOriEsCorporativo = 0;
		int planDestinoEsAtlantida = 0;
		int aboOriEsPersonal = 0;
		int count = 0;
		
		try {
			ParametroDTO param = new ParametroDTO();
			param.setNomParametro("APLICA_NUMPERS_GSM");
			param.setCodModulo("GA");
			param.setCodProducto(1);						
			paramGral = delegate.obtenerParametroGeneral(param);
			cargaAbonadosSeleccionados(abonadosSel);
			
    		logger.debug("APLICA_NUMPERS_GSM = "+paramGral.getValor());
			
			if(paramGral.getValor().equals("TRUE")){
				
				/*ClienteDTO cliente = new ClienteDTO();
				cliente.setCodCliente(this.codCliente);
				clieOriEsAtlantida = delegate.validaAtlantida(cliente);*/
				
				
				logger.debug("clieOriEsAtlantida = "+clieOriEsAtlantida);
				
				int totalAbonadosSel = listaAbonadosSel.length;
				for (int i=0; i<totalAbonadosSel;i++){
						CuentaPersonalDTO cuentaPersonalDTO = new CuentaPersonalDTO();
						cuentaPersonalDTO.setCodPlanTarifNuevo(parametros.getCodPlanTarifSelec());
						cuentaPersonalDTO.setNumCelular(listaAbonadosSel[i].getNumCelular());
						
						CuentaPersonalDTO cuentaPersRetorno  = delegate.obtenerNumeroPersonal(cuentaPersonalDTO);
						
						AbonadoDTO abonado = new AbonadoDTO();
						abonado.setNumAbonado(listaAbonadosSel[i].getNumAbonado());
						clieOriEsAtlantida = delegate.validaAtlantida(abonado);
						
						if(cuentaPersRetorno.getNumCelular() == 0){
							cuentaPersonalDTO.setNumCelularPers(0);
						}
						else{
							cuentaPersonalDTO.setNumCelularPers(cuentaPersRetorno.getNumCelular());
						}
					
						planDestinoEsAtlantida    = delegate.obtenerInfoAtl(cuentaPersonalDTO);
						
						if(clieOriEsAtlantida == 1)	aboOriEsCorporativo = delegate.obtenerInfoPer(cuentaPersonalDTO);
						else						aboOriEsPersonal = delegate.validaPersonal(cuentaPersonalDTO);
						
						//ESPERSONAL
						if (aboOriEsPersonal == 1 && planDestinoEsAtlantida == 0 && aboOriEsCorporativo == 0){
							cuentaPersonalDTO.setNumCelularPers(listaAbonadosSel[i].getNumCelular());
							cuentaPersonalDTO = delegate.obtieneNumeroCorporativo(cuentaPersonalDTO);
							long numCelularCorp = cuentaPersonalDTO.getNumCelularCorp();
							
							if (tipoPlanDestinoSel.equals("combopre")){
								if (totalAbonadosSel ==  1){
									retorno.setMensaje("El abonado está como Número Personal de la línea Corporativa N° " + numCelularCorp + ".\n No podrá continuar con la orden de servicio hasta que efectúe la desasociación \n de Número Personal.");
								}
								else{
									retorno.setMensaje("Los abonados se encuentran como número personal de una línea corporativa.\n No podrá continuar con la orden de servicio hasta que efectúe la desasociación \n de Número Personal.");
								}
							}else{
								if (totalAbonadosSel ==  1){
									retorno.setMensaje("El abonado está como Número Personal de la línea Corporativa N° "+numCelularCorp+", \n continuará con la asociación.");
								}
								else{
									retorno.setMensaje("Los abonados se encuentran como número personal de una línea corporativa.\n continuará con la asociación.");
								}
							}
												
							retorno.setCodActuacion("ESPERSONAL");
							logger.debug("ESPERSONAL, codActuacion=" + retorno.getCodActuacion());
						}
						
						//TIENEPERSONAL
						if (aboOriEsPersonal == 0 && planDestinoEsAtlantida == 1 && clieOriEsAtlantida == 1 && aboOriEsCorporativo==1){
							
							if (totalAbonadosSel ==  1){
								retorno.setMensaje("El abonado tiene asociado el "+cuentaPersonalDTO.getNumCelularPers()+" como Número Personal. \n Continuará con la asociación");
							}
							else{
								retorno.setMensaje("Los abonados tienen asociaciado un número personal.\n Continuará con la asociación");
							}
							
							retorno.setCodActuacion("TIENEPERSONAL");
							logger.debug("TIENEPERSONAL, codActuacion=" + retorno.getCodActuacion());
						}
						
						
						//BAJA
						boolean condicion1 = aboOriEsPersonal == 1 && planDestinoEsAtlantida == 1;
						boolean condicion2 = aboOriEsCorporativo == 1 && planDestinoEsAtlantida == 0;
						if (condicion1 || condicion2 ) {		  
							 retorno.setCodActuacion("BAJA");
							 logger.debug("BAJA, codActuacion=" + retorno.getCodActuacion());
							 if (totalAbonadosSel ==  1){
								 retorno.setMensaje("El abonado tiene el N° "+cuentaPersRetorno.getNumCelular()+" como número personal. \n Con esta transacción se desasociará automaticamente.");
							 }
							 else if (totalAbonadosSel >  1){
								 if (condicion1)
								   retorno.setMensaje("Algunos abonados se encuentran como número personal de un cliente corporativo, si continúa se desasociará automáticamente."); 	 
								 else{	 
								   retorno.setMensaje("Los abonados perderán automáticamente la asociación de número personal.");
								 }
							 }
						}
						
						
						
						
						//ALTA
						if( (totalAbonadosSel == 1 && aboOriEsPersonal == 0 && planDestinoEsAtlantida == 1 && clieOriEsAtlantida == 0 )
								    || (totalAbonadosSel == 1 && aboOriEsPersonal == 0 && planDestinoEsAtlantida == 1 && clieOriEsAtlantida == 1 && aboOriEsCorporativo==0) ) 
						{
								retorno.setCodActuacion("ALTA");
								logger.debug("ALTA, codActuacion=" + retorno.getCodActuacion());
								
								AbonadoDTO[] arrayAbonadosValidos = new AbonadoDTO[1];
								arrayAbonadosValidos[0] = listaAbonadosSel[0]; 
								logger.debug("listaAbonadosSel[0].getNumAbonado() = "+listaAbonadosSel[0].getNumAbonado());
								retorno.setAbonadosValidos(arrayAbonadosValidos);
						}
						
						//BAJAALTA
						if(totalAbonadosSel == 1 && aboOriEsPersonal == 1 && planDestinoEsAtlantida == 1 && clieOriEsAtlantida == 0){
							retorno.setCodActuacion("BAJAALTA");
							logger.debug("BAJAALTA, codActuacion=" + retorno.getCodActuacion());
							// Obtención de línea corporativa que va en el mensaje
							cuentaPersonalDTO.setNumCelularPers(listaAbonadosSel[i].getNumCelular());
							
							cuentaPersonalDTO = delegate.obtieneNumeroCorporativo(cuentaPersonalDTO);
							long numCelularCorp = cuentaPersonalDTO.getNumCelularCorp();
							retorno.setMensaje("El abonado está como Número Personal de la línea Corporativa N° "+numCelularCorp+", \n si continúa se desasociará automaticamente.");
							
							AbonadoDTO[] arrayAbonadosValidos = new AbonadoDTO[1];
							arrayAbonadosValidos[0] = listaAbonadosSel[0]; 
							logger.debug("listaAbonadosSel[0].getNumAbonado() = "+listaAbonadosSel[0].getNumAbonado());
							retorno.setAbonadosValidos(arrayAbonadosValidos);
						}
				  
				}//fin for (int i=0; i<listaAbonadosSel.length;i++)
			}//fin if(paramGral.getValor().equals("TRUE"))
			
			retorno.setCodMensaje("0");
			
		} catch (ManReqException e) {
			
			if(e.getCodigo()==null || e.getCodigo().equals("0")){
				retorno.setCodMensaje("-1");
				logger.debug("ERROR (ManReqException) :"+e.getMessage());
				retorno.setMensaje(e.getMessage());
			}else{
				logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
				retorno.setCodMensaje(e.getCodigo());
				retorno.setCodTipMensaje(e.getCodigoEvento());
				retorno.setMensaje(e.getDescripcionEvento());
			}
			parametros=null;
		
		} catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			retorno.setMensaje(e.getMessage());
			parametros=null;
		}
		
		logger.debug("ValidaCuentaPersonal():fin");
		return retorno;
	}
	
	public RetornoCondicionesCPUDTO ValidaAltaCuentaPersonal(long celPers){
		RetornoCondicionesCPUDTO retorno = new RetornoCondicionesCPUDTO();
		
		int valAtlantida = 0;
		int esPersonal = 0;
		ClienteDTO cliente = null;
			  //cliente.setCodCliente(listaAbonadosSel[0].getCodCliente());
		try {
			//valida numero de celular
			AbonadoDTO abonado = new AbonadoDTO();
			abonado.setNumCelularString(String.valueOf(celPers));
			delegate.validarNumPer(abonado);
			//fin valida numero de celular
			
			  CuentaPersonalDTO cuentaPersonalDTO = new CuentaPersonalDTO();
			  cuentaPersonalDTO.setNumCelular(celPers);	
			  
			  cliente      = delegate.obtenerCliente(cuentaPersonalDTO);
			  valAtlantida = delegate.validaAtlantidaCliente(cliente);					  
			  esPersonal   = delegate.validaPersonal(cuentaPersonalDTO);
			  
			  /*
			   * 0 = no es atlantida
			   * 1 = es atlantida
			   */
			  if(valAtlantida != 0){
				  retorno.setCodActuacion("CA"); // 1
			  }
			  else{
				  /*
				   * 0 = no existe como personal de otro cliente
				   * 1 = existe como personal de otro cliente
				   */
				  if(esPersonal == 0 && valAtlantida == 0 ){
					  retorno.setCodActuacion("OK");
				  } 
				  else {
					  retorno.setCodActuacion("CP");
				  }
			  }
				  
		} catch (ManReqException e) {
			
			if(e.getCodigo()==null || e.getCodigo().equals("0")){
				logger.debug("ERROR (ManReqException) :"+e.getMessage());
				retorno.setMensaje(e.getMessage());
			}else{
				logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
				retorno.setCodMensaje(e.getCodigo());
				retorno.setCodTipMensaje(e.getCodigoEvento());
				retorno.setMensaje(e.getDescripcionEvento());
			}
		
		} catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			retorno.setMensaje(e.getMessage());
		}		  
		return retorno;
	}
	
	
	/**
	 * Recupera la informacion de la combinatoria para el vendedor comisionable dada una combinatoria
	 * @param config
	 * @return
	 * @throws ManReqException
	 */
	public ConfiguracionVendedorCPUDTO  recuperarConfiguracionVendedorCPU(ConfiguracionVendedorCPUDTO config) throws ManReqException {
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		logger.debug("recuperarConfiguracionVendedorCPU():start");
		HttpSession session = WebContextFactory.get().getSession();

		ConfiguracionVendedorCPUDTO resultado = null;
		try {
			logger.debug("recuperarInformacionVendedor():antes");
			resultado = delegate.recuperarConfiguracionVendedorCPU(config);
			logger.debug("recuperarInformacionVendedor():despues");
		}catch (ManReqException e) {
			logger.debug("removiendo de sesion UsuarioVendedorComisionable");
			session.removeAttribute("UsuarioVendedorComisionable");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("SupOrdHanException[" + loge + "]");
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("removiendo de sesion UsuarioVendedorComisionable");
			session.removeAttribute("UsuarioVendedorComisionable");
			logger.debug("Exception", e);
			throw new ManReqException(e);			
		}
		logger.debug("recuperarConfiguracionVendedorCPU():end");
		return resultado;
	}	
	
	/**
	 * Obtiene la informacion del usuario y el vendedor. Aplica cuando se quiere tomar la informacion del vendedor
	 * del usuario que se loguea
	 * @param usuarioSistema
	 * @return
	 * @throws ManReqException
	 */
	public UsuarioVendedorDTO  obtenerInformacionUsuarioVendedor(UsuarioSistemaDTO usuarioSistema) throws ManReqException {
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		logger.debug("obtenerInformacionUsuarioVendedor():start");
		HttpSession session = WebContextFactory.get().getSession();

		UsuarioVendedorDTO resultado = new UsuarioVendedorDTO();
		try {
			logger.debug("obtenerInformacionUsuarioVendedor():antes");
			resultado = delegate.obtenerInformacionUsuarioVendedor(usuarioSistema);
			logger.debug("obtenerInformacionUsuarioVendedor():despues");
			resultado.setCodMensaje("0");
			logger.debug("CodMensaje[" + resultado.getCodMensaje() + "]");
		}catch (ManReqException e) {
			logger.debug("removiendo de sesion UsuarioVendedorComisionable");
			session.removeAttribute("UsuarioVendedorComisionable");
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ManReqException[" + loge + "]");

			if (e.getCause()!= null ) {
				logger.debug("Causa error["+ e.getCause().getClass().getName()+ "]");
				if (e.getCause() instanceof VendedorException) {
					VendedorException ex = (VendedorException) e.getCause();
					logger.debug("Instancia de VendedorException");
					logger.debug("codigo[" + ex.getCodigo() + "]");
					logger.debug("codigoEvento[" + ex.getCodigoEvento() + "]");
					logger.debug("descripcionEvento[" + ex.getDescripcionEvento() + "]");
										
					String error_203 = global.getValor("e.vendededor.203");
					logger.debug("error_203[" + error_203 + "]");
					
					if (ex.getCodigo().equalsIgnoreCase(error_203)) {
						logger.debug("getCodigo() == 203");
						resultado.setCodMensaje(error_203);
						resultado.setCodTipMensaje(ex.getCodigoEvento());
						resultado.setMensaje(ex.getDescripcionEvento());
						return resultado;
					}
					else {
						logger.debug("getCodigo() != 203");
					}
				}
				else {
					 logger.debug("No es instancia de VendedorException...");
				}				 
			}
			else {
				logger.debug("e.getCause() es igual a nulo...");
			}
			throw new ManReqException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			logger.debug("removiendo de sesion UsuarioVendedorComisionable");
			session.removeAttribute("UsuarioVendedorComisionable");
			logger.debug("Exception", e);
			throw new ManReqException(e);			
		}

		//El usuario se obtiene de la sesion, osea, el vendedor asociado al usuario que se loguea en la aplicacion
		//resultado.setVendedorenSesion(true);
		resultado.getVendedor().setUsuario(usuarioSistema.getNom_usuario());
		resultado.getVendedor().setFecha(new Date());
		session.setAttribute("UsuarioVendedorComisionable", resultado);
		logger.debug("obtenerInformacionUsuarioVendedor():end");
		return resultado;
	}	
	/**
	 * Averigua si el vendedor comisionable esta configurado en el xml o no
	 * @return SI o NO
	 */
	public String estaVendedorComisionableConfigurado() {
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);	
		logger.debug("estaVendedorComisionableConfigurado():start");
		String respuesta =  "";
		HttpSession session = WebContextFactory.get().getSession();
		respuesta = (String) session.getAttribute("oossComisionable");
		if (respuesta == null) {
			logger.debug("Respuesta nula");
			respuesta = "NO";
		}
		logger.debug("respuesta[" + respuesta + "]");
		logger.debug("estaVendedorComisionableConfigurado():end");
		return respuesta;
		
	}
	
	/**
	 * Averigua si el usuario pertenece al grupo callcenter para el vendedor comisionable
	 * @param usr
	 * @returnb N o S
	 */
	public String usuarioesdeGrupoComisionable(String usr) {
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		String respuesta = "N";
		logger.debug("usuarioesdeGrupoComisionable():start");
		HttpSession session = WebContextFactory.get().getSession();
		UsuarioVendedorDTO usuarioVendedor = (UsuarioVendedorDTO) session.getAttribute("UsuarioVendedorComisionable");
		if (usuarioVendedor == null) {
			logger.debug("UsuarioVendedorComisionable es nulo");
			return respuesta;
		}
		UsuarioSistemaDTO usuario = usuarioVendedor.getUsuario();
		String esCallCenter = usuario.getCall_center();
		logger.debug("esCallCenter[" + esCallCenter + "]");

		session.setAttribute("esCallCenter",esCallCenter);// RRG	

		logger.debug("usuarioesdeGrupoComisionable():end");
		return esCallCenter;
	}	
	
	
	
	public LstPTaPlanTarifarioListOutDTO obtenerPlanesEvaluacion(String tipoListaPlan,String cliDesTipPlan,String numIdentCliOrigen,String tipIdentCliOrigen){
		logger.debug("Consultando planes evaluacion riesgo reorden");
		LstPTaPlanTarifarioListOutDTO dataPlanesEval = null; 
	    List listaPlanesSesion = null;
	    List listaFiltrada = null;
	    LstPTaPlanTarifarioOutDTO[] listaPlanesEval = null;
	    String tipoProducto = null;
	    
	    if (tipoListaPlan.equals("planTarifPospago")){
	    	tipoProducto = global.getValor("tipo.producto.pospago").trim();
	    }
	    else if (tipoListaPlan.equals("planTarifHibrido")){
	    	tipoProducto = global.getValor("tipo.producto.hibrido").trim();
	    }

		ClienteDTO clienteOrigen = new ClienteDTO();
		clienteOrigen.setNumeroIdentificacion(numIdentCliOrigen);
		clienteOrigen.setCodigoTipoIdentificacion(tipIdentCliOrigen);
		
		try{
			HttpSession session = WebContextFactory.get().getSession();
			dataPlanesEval = delegate.obtenerPlanesEvaluacion(clienteOrigen);
			
			listaPlanesEval = dataPlanesEval.getallLstPTaPlanTarifarioOutDTO();
			listaPlanesSesion =  (ArrayList) session.getAttribute(tipoListaPlan);
		    
			if (listaPlanesEval!=null && listaPlanesSesion!=null ){
				listaFiltrada = new ArrayList();
				for (int i = 0;i<listaPlanesEval.length; i++){
					for (Iterator it = listaPlanesSesion.iterator(); it.hasNext();) {
						PlanTarifarioDTO plan = (PlanTarifarioDTO) it.next();
						if(
							  listaPlanesEval[i].getCodigoPlanTarifario().equals(plan.getCodPlanTarif()) && cliDesTipPlan!=null &&
							  listaPlanesEval[i].getTipoProducto().equals(tipoProducto) &&	
							  listaPlanesEval[i].getTipoPlan().equals(cliDesTipPlan)
						  )
						{
							plan.setCanLineas(listaPlanesEval[i].getCanLineas()!=null?listaPlanesEval[i].getCanLineas().intValue():0);
							listaFiltrada.add(plan);
							break;
						}
					}
				}
				
				// Pasar la lista filtrada a arreglo
				if (!listaFiltrada.isEmpty()){
					//session.setAttribute(tipoListaPlan,listaFiltrada);
					logger.debug("lista filtrada no es vacia");
					session.setAttribute("consultaEvalRiesgoReo","true");
					listaPlanesEval = new LstPTaPlanTarifarioOutDTO[listaFiltrada.size()];
					int i = 0;
					for (Iterator it = listaFiltrada.iterator();it.hasNext();){
					  PlanTarifarioDTO plan = (PlanTarifarioDTO) it.next();
					  listaPlanesEval[i] = new LstPTaPlanTarifarioOutDTO();
					  listaPlanesEval[i].setCodigoPlanTarifario(plan.getCodPlanTarif());
					  listaPlanesEval[i].setDescripcionPlanTarifario(plan.getDesPlanTarif());
					  listaPlanesEval[i].setCanLineas(new Long(plan.getCanLineas()));
					  i++;
					}// fin for

					// Setea el arreglo filtrado
					dataPlanesEval.setallLstPTaPlanTarifarioOutDTO(listaPlanesEval);
					session.setAttribute("dataPlanesEval", dataPlanesEval);
				}//fin if
			}
		}
	    catch (ManReqException e) {
			if(e.getCodigo()==null || e.getCodigo().equals("0")){
				logger.debug("ERROR (ManReqException) :"+e.getMessage());
			}
			else{
				logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
			}
	    }
	    catch (Exception e) {
	    	logger.debug("ERROR (Exception) :"+e.getMessage());
	    }		  
	    
	    return dataPlanesEval;
    }
	
	
	/**
	 * Indica que el vendedor se toma de la sesion de usuario
	 */
	public void setUsuarioVendedorenSesion() {
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		HttpSession session = WebContextFactory.get().getSession();
		UsuarioVendedorDTO usuarioVendedor = (UsuarioVendedorDTO) session.getAttribute("UsuarioVendedorComisionable");
		usuarioVendedor.setVendedorenSesion(true);
		logger.debug("setUsuarioVendedorenSesion():end");
	}
	
	/**
	 * Remueve usuario vendedor de sesion para combinatorias no configurables
	 */
	public void removerUsuarioVendedordeSesion() {
		logger.debug("removerUsuarioVendedordeSesion():start");
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		HttpSession session = WebContextFactory.get().getSession();
		session.removeAttribute("UsuarioVendedorComisionable");
		logger.debug("removerUsuarioVendedordeSesion():end");
	}	

	// Se traspasa funcionalidad desde javascript, ya que debe usar las listas de sesion 
	// evera 15/07/08
	public ClienteDTO actualizaListaClientesDestino(int tipoCliente, long codCliente, String nomCliente, 
			String primerAp, String segundoAp, String codTipIdent, String numIdent, int codCiclo,
			String tipPlanTarif, String codPlanTarif, long codEmpresa){
		logger.debug("actualizaListaClientesDestino():ini");
		
	    HttpSession session = WebContextFactory.get().getSession();
	    String strTipoCliente = null;
	    ArrayList listClientes = new ArrayList();
	    
	    switch(tipoCliente){
			case 1://prepago
				strTipoCliente = "clientesPrepago";
			break;
			case 2://pospago
				strTipoCliente = "clientesPospago";
			break;
			case 3://hibrido
				strTipoCliente = "clientesHibrido";
			break;
	    }
	    
	    listClientes = (ArrayList) session.getAttribute(strTipoCliente);
	    if (listClientes==null)	listClientes = new ArrayList();
	    
	    ClienteDTO cliente = new ClienteDTO();
	    cliente.setCodCliente(codCliente);
	    cliente.setNombreCompleto(nomCliente);
	    cliente.setApellido1(primerAp);
	    cliente.setApellido2(segundoAp);
	    cliente.setCodCiclo(codCiclo);
	    cliente.setCodigoTipoIdentificacion(codTipIdent);
	    cliente.setNumeroIdentificacion(numIdent);
	    cliente.setTipPlanTarif(tipPlanTarif);
	    cliente.setCodPlanTarif(codPlanTarif);
	    cliente.setCodEmpresa(codEmpresa);
	        
		listClientes.add(cliente);	
		session.setAttribute(strTipoCliente,listClientes);
		logger.debug("actualizaListaClientesDestino():fin");
		return cliente;
	}
	
	/**
	 * 
	 */
	public RetornoListaClientesDTO buscarClientes(int maxClientesPermitidos, int tipoCliente, long codCliente, int tipoFiltro){
		logger.debug("buscarClientes():start");
		logger.debug("maxClientesPermitidos,tipoCliente,codCliente,tipoFiltro="+maxClientesPermitidos+","+
				tipoCliente+","+codCliente+","+tipoFiltro);
		HttpSession session = WebContextFactory.get().getSession();
	    
		RetornoListaClientesDTO retorno = new RetornoListaClientesDTO();
		ClienteDTO[] clientesFiltrados = null;
		ArrayList listClientes = new ArrayList(); //lista que se muestra
		String strTipoCliente = null;
		String strComboCliente = null;
		String muestraBuscador = "N";
		String codError = "0";
		String msgError = " ";
		
	    switch(tipoCliente){
			case 1://prepago
				strTipoCliente = "clientesPrepago";
				strComboCliente = "clienteDestPre";
			break;
			case 2://pospago
				strTipoCliente = "clientesPospago";
				strComboCliente = "clienteDestPos";
			break;
			case 3://hibrido
				strTipoCliente = "clientesHibrido";
				strComboCliente = "clienteDestHib";
			break;
	    }
	    
	    try{
		    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
		    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
		    
	    	ClienteDTO clienteAux =  new ClienteDTO();
	    	clienteAux.setCodCuenta(((ClienteOSSesionDTO)session.getAttribute("ClienteOOSS")).getCliente().getCodCuenta());
	    	clienteAux.setCodTipoPlan(String.valueOf(tipoCliente));
	    	clienteAux.setCodTecnologia(this.listaAbonados[0].getCodTecnologia()); // EV 05/09/08
	    	
			if (tipoFiltro == 1){//para las puntuales donde cliente origen es igual a cliente destino
				//listar el mismo cliente origen
			    listClientes.add(sessionData.getCliente());
			}
			else if (tipoFiltro == 2){//la carga inicial de clientes si es que son menos que el maxClientesPermitidos
				//obtener total de registros y comparar con maxClientesPermitidos
				//si es menor que el maximo guardar lista en session y cargar combo
				int numClientesCuentas =  delegate.obtenerNumClientesCuenta(clienteAux).intValue();
				
				if (numClientesCuentas > 0){//si no hay clientes, solo se mostrara la lista vacia, sin buscador
					boolean listaEnSesion=false;
					ArrayList listClientesSesion = (ArrayList) session.getAttribute(strTipoCliente);
					if (listClientesSesion==null){
						listClientesSesion = new ArrayList();
					}
					else if(listClientesSesion.size()> 0){
						listaEnSesion = true;
					}

					//cargar lista, si ya existe en sesion, la carga
					if (listaEnSesion){
						listClientes = listClientesSesion;
						if (numClientesCuentas > maxClientesPermitidos)		muestraBuscador = "S";
					}
					else{
						if (numClientesCuentas <= maxClientesPermitidos ){
							ClienteDTO[] clientes = delegate.listarClientesCuenta(clienteAux).getClienteList();
							//lo pasa a un arrayList
						    for(int i=0;i<clientes.length;i++){
						    	if (sessionData.getCliente().getCodCliente()!=clientes[i].getCodCliente() ){
						    		listClientes.add(clientes[i]);
						    	}
						    }
						}
						else{
							//la lista quedara vacia y se debe habilitar el buscador
							muestraBuscador = "S";
						}//fin if (numClientesCuentas <= maxClientesPermitidos )
						
					}//if (listaEnSesion){
					
				}// fin if (numClientesCuentas > 0)
			}else if (tipoFiltro == 3){//el usuario ha ingresado un codigo cliente destino en el buscador
				clienteAux.setCodCliente(codCliente);
				//cargar lista con 0 o 1 registro
				ClienteDTO[] clientes = delegate.listarClientesCuenta(clienteAux).getClienteList();
				
				if (clientes.length>0){
					
					if (sessionData.getCliente().getCodCliente()!=clientes[0].getCodCliente() ){
						listClientes.add(clientes[0]);
					}else{
						codError = "1";
						msgError = "No se encontraron datos para código :"+codCliente;	
					}
				}else{
					codError = "1";
					msgError = "No se encontraron datos para código :"+codCliente;
				}
					
				muestraBuscador = "S"; //en esta opcion siempre debe estar visible el buscador
			}
			
			retorno.setCodMensaje(codError);
			retorno.setMensaje(msgError);
			retorno.setMuestraBuscador(muestraBuscador);
			
		} catch (ManReqException e) {
			
			if(e.getCodigo()==null || e.getCodigo().equals("0")){
				logger.debug("ERROR (ManReqException) :"+e.getMessage());
				retorno.setMensaje(e.getMessage());
			}else{
				logger.debug("ERROR (ManReqException) :"+e.getDescripcionEvento());
				retorno.setCodMensaje(e.getCodigo());
				retorno.setCodTipMensaje(e.getCodigoEvento());
				retorno.setMensaje(e.getDescripcionEvento());
			}
		} catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			retorno.setMensaje(e.getMessage());
		}	
		
		session.setAttribute(strTipoCliente, listClientes); //actualiza lista en sesion
		
		clientesFiltrados = (ClienteDTO[]) ArrayUtl.copiaArregloTipoEspecifico(listClientes.toArray(), ClienteDTO.class);
		retorno.setStrComboCliente(strComboCliente);
		retorno.setClientesFiltrados(clientesFiltrados);
		
		logger.debug("buscarClientes():end");
		
		return retorno;
	    
	}//fin buscar clientes
	
	public LstPTaPlanTarifarioListOutDTO obtenerPlanesEvalSesion (){
	    // Obtiene planes  de evaluacion de riesgo en sesion
		HttpSession session = WebContextFactory.get().getSession();
		LstPTaPlanTarifarioListOutDTO dataPlanesEval = (LstPTaPlanTarifarioListOutDTO) session.getAttribute("dataPlanesEval"); 
		return dataPlanesEval;
		
	}

	/*
	 * Carga la limite de consumo dependiendo  
	 * del plan tarifario selecionado
	 * Lista : "codigoLimiteConsumo,descripcionLimiteConsumo"
	 */	
	public RetornoListaAjaxDTO obtenerLimitesConsumo(String codPlanTarif, String clienteDestino) throws Exception {
		logger.debug("obtenerLimitesConsumo:inicio()");
		WebContext ctx = WebContextFactory.get();
		HttpSession sesion = ctx.getHttpServletRequest().getSession(false);
		RetornoListaAjaxDTO retorno = new RetornoListaAjaxDTO();
		
		logger.debug("clienteDestino["+clienteDestino+"]");
		String codCliente = clienteDestino;//String.valueOf(cliente.getCodCliente()); 
		PlanTarifarioDTO[] listaLimites = null;
		try{
			PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
			planTarifario.setCodigoPlanTarifario(codPlanTarif);
			planTarifario.setCodCliente(codCliente);
			listaLimites = delegate.obtenerLimitesPlan(planTarifario);
			
		}catch(Exception e){
			logger.debug("Ocurrio un error al obtener limites consumo ",e);
        	String mensaje = e.getMessage()==null?" ":", "+e.getMessage();
        	retorno.setCodError("1");
			retorno.setMsgError("Ocurrio un error al obtener limites consumo "+mensaje);

		}
		retorno.setLista(listaLimites);
		logger.debug("obtenerLimitesConsumo:fin()");
		return retorno;
	}	
	
	/*Indica si esta habilitada la consulta de saldo en la plataforma */
	public boolean aplicaConsultaSaldo(){
		boolean resultado = false;
		
		try {
			ParametroDTO param = new ParametroDTO();
			param.setCodModulo(global.getValor("codigo.modulo.GA"));
			param.setCodProducto(Integer.parseInt(global.getValor("codigo.producto").trim())); 
			param.setNomParametro(global.getValor("parametro.cons_saldo_prepago"));
			ParametroDTO paramGral = delegate.obtenerParametroGeneral(param);
			logger.debug("CONS_SALDO_PREPAGO="+paramGral.getValor());
			resultado = (paramGral.getValor().equalsIgnoreCase("S"))?true:false;
		} catch (Exception e) {
			logger.debug("Error al obtener parametro CONS_SALDO_PREPAGO");
			e.printStackTrace();
		}
		logger.debug("aplicaConsultaSaldo="+resultado);
		return resultado;
	}

}
