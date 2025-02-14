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
import com.tmmas.cl.scl.socketps.common.dto.ConsultaBolsasDTO;
import com.tmmas.cl.scl.socketps.common.dto.ConsultaSaldoDTO;
import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CicloDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConversionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConvertActAboDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RestriccionesDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ValidaOOSSDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntarcelDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ValidaPermanenciaDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanCicloDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
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

public class CondicionesOOSSCPU {
	
	private final Logger logger = Logger.getLogger(CondicionesOOSSCPU.class);
	private Global global = Global.getInstance();
	private ManageRequestBussinessDelegate delegate = ManageRequestBussinessDelegate.getInstance();
	
	private Map abonadosMap;
	private AbonadoDTO[] listaAbonados;
	private AbonadoDTO[] listaAbonadosSel;
	private ClienteDTO cliente;
	private long codCliente;
	private long numAbonado;
	//private ClienteDTO clienteDestino;
	//private PlanTarifarioDTO planTarif;
	//private PlanTarifarioDTO planTarifDestino;
	private ParametroListDTO paramGeneral;
	private MensajeDTO[] mensajes;
	private int MSGCONFIRM;
	private int MSGACEPTAR;
	private int PUNTUAL; 
	private int REORDENAMIENTO;
	private int EMPRESA;
	
	//parametros segun combinatoria
	private long codOOSS;
	private String combinatoria;
	private long codOSAnt;
	private String codActuacion;
	private String[] conversionEvento;
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
		mensaje =  new MensajeDTO(); mensaje.setCodigo("c.004"); mensaje.setRespuesta("I"); lista.add(mensaje);
		
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
			logger.debug("this.abonadosMap="+this.abonadosMap);
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
			this.PUNTUAL = Integer.parseInt(global.getValor("PUNTUAL"));
			this.REORDENAMIENTO = Integer.parseInt(global.getValor("REORDENAMIENTO"));
			this.EMPRESA = Integer.parseInt(global.getValor("EMPRESA"));

			
		}catch(Exception e){
			logger.debug("Exception "+e);
		}
		logger.debug("cargaInicial : fin");
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
	 * Realiza las validaciones para la combinatoria generada  
	 * al seleccionar el tipo de plan (prepago,pospago,híbrido) 
	 * 
	 * @param parametros, abonadosSel[]
	 * @return RetornoCondicionesCPUDTO
	 */
	public RetornoCondicionesCPUDTO validaCondicionesCarga (ParametrosCondicionesCPUDTO parametros){
		logger.debug("validaCondicionesCarga():inicio");
		RetornoCondicionesCPUDTO respuesta = new RetornoCondicionesCPUDTO();
		
		String log = global.getValor("web.log");
		log=System.getProperty("user.dir")+ log;
		PropertyConfigurator.configure(log);
		String respuestaConfirm = " ";
		String msgUsuario = " ";
		SecuenciaDTO parametro = null;
		SecuenciaDTO retornoSecuencia = null;
		
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
			conversionList.getRegistros()[0].getCodActuacionWeb();
			logger.debug("codOSAnt              :"+codOSAnt);
			logger.debug("codActuacion          :"+codActuacion);
			
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
		    restricciones.setPlanDestino(parametros.getCodPlanTarifSelec());
		    restricciones.setTipoPlanDestino(parametros.getTipoPlanTarifDestino());
		    restricciones.setFechaSistema(new Date());
		    restricciones.setCodTarea(0);
		    restricciones.setCodEvento(global.getValor("codigo.evento.cargar").trim());
		    
		    // Iterar por cada elemento del mapa de abonados
		    if (this.abonadosMap!=null && this.abonadosMap.size() >1 ){
			    Iterator it = this.abonadosMap.entrySet().iterator();
			    while (it.hasNext()) {
			    	Map.Entry e = (Map.Entry)it.next();
			    	AbonadoDTO abonado =  (AbonadoDTO) e.getValue();
					restricciones.setNumAbonado(abonado.getNumAbonado());
					restricciones.setNumVenta(abonado.getNumVenta());
				    restricciones.setCodUso(Integer.parseInt(abonado.getCodUso()));
				    restricciones.setCodCuentaOrigen(abonado.getCodCuenta());
				    restricciones.setCodCuentaDestino(abonado.getCodCuenta());
				    restricciones.setTipoPlan(abonado.getCodTipoPlanTarif());
				    restricciones.setNumCiclo(abonado.getCodCiclo());
				    restricciones.setCodCentral(abonado.getCodCentral());
					//obtener secuencia
				    parametro = new SecuenciaDTO();
					parametro.setNomSecuencia("GA_SEQ_TRANSACABO");
					logger.debug("obtenerSecuencia():inicio");
					retornoSecuencia = delegate.obtenerSecuencia(parametro);
					logger.debug("obtenerSecuencia():fin");
				    restricciones.setIdSecuencia(retornoSecuencia.getNumSecuencia());
				    
				    logger.debug("validaRestriccionComerOoss:inicio,abonado="+abonado.getNumAbonado());
				    try{
						delegate.validaRestriccionComerOoss(restricciones);
					}
					catch(ManReqException ex){	
						logger.debug("error en abonado :"+abonado.getNumAbonado());
						logger.debug("codigo="+ex.getCodigo()+", Mensaje="+ex.getDescripcionEvento());
						//msgError = ex.getDescripcionEvento();
						//validaEventos = false;
					}
					logger.debug("validaRestriccionComerOoss : fin");
			    }
		    }
		} 
		catch (ManReqException e) {
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
		} 
		catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			respuesta.setMensaje(e.getMessage());
			parametros=null;
		}

		logger.debug("validaCondicionesCarga():fin");
		
		return respuesta;
	}
	
	
	
	/**
	 * Continua validaciones, si hay mensajes de confirmacion, luego de la confirmacion se debe llamar solo 
	 * a este metodo.
	 * @param parametros, codigoMsg, respuestaMsg
	 * @return RetornoCondicionesCPUDTO
	 */
	public RetornoCondicionesCPUDTO validaCondicionesContinuar(ParametrosCondicionesCPUDTO parametros,String codigoMsg, String respuestaMsg)
		throws ManReqException { 
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
		//c.002:validacion ooss pendientes
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
	
	public RetornoCondicionesCPUDTO validaCondicionesPospagoPospago(ParametrosCondicionesCPUDTO parametros,RestriccionesDTO restricciones ) throws ManReqException{
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
		    
		    //valida plan tarifario
		    if (parametros.getCodPlanTarifSelec().equals(this.listaAbonadosSel[i].getCodPlanTarif())){
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
		    
			if (validaEventos){
				abonadosValidos.add(listaAbonadosSel[i]);
			}
			else {
				abonadosInvalidos.add(listaAbonadosSel[i]);
			}
		}//fin for valida lista de abonados seleccionados
		
		if (!abonadosInvalidos.isEmpty()){
			AbonadoDTO[] arrayAbonadosInvalidos = (AbonadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(abonadosInvalidos.toArray(),AbonadoDTO.class);
			respuesta.setAbonadosInvalidos(arrayAbonadosInvalidos);
			respuesta.setMensaje(" ");
			return respuesta;
		}
		
		this.listaAbonadosSel = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	abonadosValidos.toArray(), AbonadoDTO.class);
		
		if (listaAbonadosSel.length == 0){// no hay abonados validos
			msgUsuario = global.getValor("e.001"); //msg:Abonado(s) inválido(s)
			
			if (!msgError.trim().equals("")) msgUsuario = msgError;
			throw new ManReqException("e.001",0, msgUsuario); //no continua ooss
		}
		
		int totalAbonadosSel = listaAbonadosSel.length;
		

		//2.- validar plan freedom
		ClienteDTO clientef =new ClienteDTO();
		clientef.setCodCliente(cliente.getCodCliente());
		logger.debug("validaFreedom():inicio");
		boolean validaFreedom = delegate.validaFreedom(clientef).isResultado();
		logger.debug("validaFreedom():fin");
		
		//si tiene plan freedom , obtener y validar ciclo freedom
		if (validaFreedom){
			//obtener ciclo freedom
			PlanCicloDTO planCiclo = new PlanCicloDTO();
			planCiclo.setCodPlanTarif(listaAbonadosSel[0].getCodPlanTarif());
			
			logger.debug("obtenerCicloFreedom():inicio");
			planCiclo = delegate.obtenerCicloFreedom(planCiclo);
			logger.debug("obtenerCicloFreedom():fin");
			int codCiclo2 = planCiclo.getCodCiclo();
			
			//validar codigo del ciclo freedom
			int codCiclo1 = 0;
			codCiclo1 = cliente.getCodCiclo();
			if (codCiclo1 != codCiclo2){
				msgUsuario =  global.getValor("e.003");//msg:No es posible efectuar el cambio de ciclo...
				throw new ManReqException("e.003",0, msgUsuario); //no continua ooss
			}
		}//fin validaFredom
		
		//3.- validar ordenes pendientes plan   
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

		//4.- validar traspaso de servicios homologos
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
		
		//5.- obtener fecha ciclo
		CicloDTO ciclo = new CicloDTO();
		ciclo.setCodCiclo(cliente.getCodCiclo());
		logger.debug("obtenerFechaCiclo():inicio");
		ciclo = delegate.obtenerFechaCiclo(ciclo);
		logger.debug("obtenerFechaCiclo():fin");
		
		String fecDesdeLlam = ciclo.getFecDesdeLlam();
		int periodoFact = ciclo.getPeriodoCodCiclFact();
		
		respuesta.setFecDesdeLlam(fecDesdeLlam);
		respuesta.setPeriodoFact(periodoFact);
		
		// obtener cambio de plan serv
		AbonadoDTO abonadoAux = new AbonadoDTO(); 
		abonadoAux.setCodPlanTarif(parametros.getCodPlanTarifSelec());
		abonadoAux.setCodTecnologia(listaAbonadosSel[0].getCodTecnologia());
		logger.debug("obtenerDatosCambPlanServ():inicio");
		abonadoAux = delegate.obtenerDatosCambPlanServ(abonadoAux);
		logger.debug("obtenerDatosCambPlanServ():fin");
		respuesta.setCodPlanServNuevo(abonadoAux.getCodPlanServ());

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


	    ArrayList abonadosValidos = new ArrayList();//guarda abonados validos que cumplen  restricciones comerciales y permanencia
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

		
		//actualiza lista de abonados por lista de abonados validos.
		this.listaAbonadosSel = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	abonadosValidos.toArray(), AbonadoDTO.class);
		if (listaAbonadosSel.length == 0){// no hay abonados validos
			msgUsuario = global.getValor("e.001"); //msg:Abonado(s) inválido(s)
			if (!msgError.trim().equals("")) msgUsuario = msgError;
			throw new ManReqException("e.001",0, msgUsuario); //no continua ooss
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
		
		abonadosValidos = new ArrayList(); 
		for (int i=0; i<listaAbonadosSel.length;i++){ 
			paramValidaPerm.setNumAbonado(listaAbonadosSel[i].getNumAbonado());
			logger.debug("validaPermanencia():ini");
			validaPermanencia = delegate.validaPermanencia(paramValidaPerm).isResultado();  
			logger.debug("validaPermanencia():fin");	
			
			if (validaPermanencia)	abonadosValidos.add(listaAbonadosSel[i]);
		}
		
		//actualiza lista de abonados por lista de abonados validos.
		this.listaAbonadosSel = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	abonadosValidos.toArray(), AbonadoDTO.class);
		if (listaAbonadosSel.length == 0){// no hay abonados validos
			msgUsuario = global.getValor("e.001"); //msg:Abonado(s) inválido(s)
			throw new ManReqException("e.001",0, msgUsuario); //no continua ooss
		}
		
		
		int totalAbonadosSel = listaAbonadosSel.length;
		
		//3.- validar cuenta personal , solo si existe un abonado seleccionado
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
		
		//4.- validar y anular ooss pendientes
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

		//5.- validar traspaso de servicios homologos}
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
	public RetornoCondicionesCPUDTO validaCondicionesPospagoHibrido(ParametrosCondicionesCPUDTO parametros,RestriccionesDTO restricciones) throws ManReqException{
		logger.debug("validaCondicionesPospagoHibrido():ini");
		RetornoCondicionesCPUDTO respuesta = new RetornoCondicionesCPUDTO();
		AbonadoDTO aboAux = new AbonadoDTO();
		String respuestaConfirm = " ";
		String msgUsuario = " ";
		String msgError="";
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

		    boolean validaEventos = true; 
		    
		    //valida plan tarifario
		    if (parametros.getCodPlanTarifSelec().equals(this.listaAbonadosSel[i].getCodPlanTarif())){
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
				
			if (validaEventos){
				abonadosValidos.add(listaAbonadosSel[i]);
			}
			else {
				abonadosInvalidos.add(listaAbonadosSel[i]);
			}
		}//fin for valida lista de abonados seleccionados
		
		if (!abonadosInvalidos.isEmpty()){
			AbonadoDTO[] arrayAbonadosInvalidos = (AbonadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(abonadosInvalidos.toArray(),AbonadoDTO.class);
			respuesta.setAbonadosInvalidos(arrayAbonadosInvalidos);
			respuesta.setMensaje(" ");
			return respuesta;
		}
		
		this.listaAbonadosSel = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	abonadosValidos.toArray(), AbonadoDTO.class);
		
		if (listaAbonadosSel.length == 0){// no hay abonados validos
			msgUsuario = global.getValor("e.001"); //msg:Abonado(s) inválido(s)
			
			if (!msgError.trim().equals("")) msgUsuario = msgError;
			throw new ManReqException("e.001",0, msgUsuario); //no continua ooss
		}
		
		int totalAbonadosSel = listaAbonadosSel.length;
		for (int i=0; i<listaAbonadosSel.length;i++)//se agrega for para recorrer abonados seleccionados [AROG]
		{		
			String codSituacion = this.listaAbonadosSel[i].getCodSituacion();
			int indDisponibilidad = this.listaAbonadosSel[i].getIndDisp();
			String codTipoPlanTarif = this.listaAbonadosSel[i].getCodTipoPlanTarif();
			
			//validar codSituacion AAA
			if (!codSituacion.equals("AAA")){
					msgUsuario = global.getValor("e.007");//msg:El abonado no cumple las condiciones que exige ...
					msgUsuario = msgUsuario.replaceFirst("xx", codSituacion);
					throw new ManReqException("e.007",0, msgUsuario); //no continua ooss
			}
			
			//validar disponibilidad
			if (indDisponibilidad == 0){ 
				msgUsuario = global.getValor("e.008");//msg:El abonado tiene su Equipo en Serv. Tecnico ...
				throw new ManReqException("e.008",0, msgUsuario); //no continua ooss
			}
			
			//validar  tipo plan tarifario
			if (codTipoPlanTarif.equals("E")){
				msgUsuario = global.getValor("e.009");//msg:Operación Permitida Solo para Abonados con ...
				throw new ManReqException("e.009",0, msgUsuario); //no continua ooss
			}
			


			//	3.- validar portabilidad
			/*
			listaAbonadosSel[i].setCodActAbo(this.codActuacion);
			logger.debug("validarPortabilidad : inicio");
			boolean valPortabilidad = delegate.validarPortabilidad(listaAbonadosSel[i]).isResultado();
			logger.debug("validarPortabilidad : fin");
			
			if (!valPortabilidad){
				msgUsuario = global.getValor("e.004");//No se puede realizar cambio de plan, ...
				throw new ManReqException("e.004",0, msgUsuario); //no continua ooss
			}
			*/
			
			//4.- validar periodo facturacion
			logger.debug("validarPeriodoFact : inicio");
			boolean valPeriodoFac = delegate.validarPeriodoFact(listaAbonadosSel[i]).isResultado();
			logger.debug("validarPeriodoFact : fin");
			
			if (!valPeriodoFac){
				msgUsuario = global.getValor("e.005");//msg:Abonado no tiene periodo de facturación vigente ...
				throw new ManReqException("e.005",0, msgUsuario); //no continua ooss
			}
			
			//5.- validar servicios duplicados
			
			aboAux.setCodTipoTerminal(listaAbonadosSel[i].getCodTipoTerminal());
			aboAux.setCodPlanTarif(parametros.getCodPlanTarifSelec());
			aboAux.setCodTecnologia(listaAbonadosSel[i].getCodTecnologia());
			aboAux.setCodCentral(listaAbonadosSel[i].getCodCentral());
			
			//listaAbonadosSel[0].setCodPlanTarif(parametros.getCodPlanTarifSelec()); //REVISAR!!
			logger.debug("validarServiciosDuplicados : inicio");
			boolean valServiciosDupl = delegate.validarServiciosDuplicados(aboAux).isResultado();
			logger.debug("validarServiciosDuplicados : fin");
			
			if (!valServiciosDupl){
				msgUsuario = global.getValor("e.006");//msg:El Plan nuevo  tiene parametrizado dos servicios ...
				throw new ManReqException("e.006",0, msgUsuario); //no continua ooss
			}
			
			//6.- obtener categoria y eliminar promoción
			PlanTarifarioDTO plan = new PlanTarifarioDTO();
			plan.setCodPlanTarif(listaAbonadosSel[i].getCodPlanTarif());
			
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
//***************************************************************************************/
// SE COMENTA ESTE CODIGO PUES NO PERTENECE A LA LOGICA POSPAGO-HIBRIDO o HIBRIDO-POSPAGO [AROG]
//				if(plan.getCodigoCategoria().equalsIgnoreCase(codCatCtaSegNue)){
//					//msgUsuario = global.getValor("i.001"); //msg:Al cambiar de plan perdera en forma definitiva ...
//					//respuesta.setMensaje(msgUsuario);
//					
//					//eliminar promocion
//					EliminaPromocionDTO promocion = new EliminaPromocionDTO();
//					promocion.setSvCombinatoria(this.combinatoria);
//					promocion.setFlgAplica(true);
//					promocion.setSvMensaje(" ");
//					promocion.setNumAbonado(listaAbonadosSel[i].getNumAbonado());
//					
//					logger.debug("eliminarPromocion():inicio");
//					delegate.eliminarPromocion(promocion);
//					logger.debug("eliminarPromocion():fin");
//				}
//************************************************************************************/			
		}// Fin del for para recorrer los abonados seleccionados
		
		//7.- validar cuenta personal , solo si existe un abonado seleccionado
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
					logger.debug("validaCuentaPersonal():fin");
					
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
		
		//8.- validar y anular ooss pendientes
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
		
		//10.- obtener fecha ciclo
		IntarcelDTO intarcel = new IntarcelDTO(); //IMPLICANCIA DE ESTO EN LISTA DE ABONADOS 
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
			respuesta.setFecDesdeLlam(fecha); //POR ESTA FECHA
		}
		
//		11.- validar reversa
		RetornoDTO retorno = new RetornoDTO();
		OrdenServicioDTO ordenServicioDto = new OrdenServicioDTO();
		
		AbonadoListDTO listAbonado = new AbonadoListDTO();
		ClienteDTO clienteDto = new ClienteDTO();
		
		listAbonado.setAbonados(listaAbonadosSel);
		clienteDto.setAbonados(listAbonado);
		ordenServicioDto.setNumOrdenServicio(String.valueOf(codOSAnt));		
		ordenServicioDto.setCliente(clienteDto);
		
		logger.debug("validarReversa():inicio");
		retorno = delegate.validarReversa(ordenServicioDto);
		logger.debug("validarReversa():fin");
		respuesta.setMensaje(retorno.getDescripcion());
		
		
		// obtener cambio de plan serv
		AbonadoDTO abonadoAux = new AbonadoDTO(); 
		abonadoAux.setCodPlanTarif(parametros.getCodPlanTarifSelec());
		abonadoAux.setCodTecnologia(listaAbonadosSel[0].getCodTecnologia());
		logger.debug("obtenerDatosCambPlanServ():inicio");
		abonadoAux = delegate.obtenerDatosCambPlanServ(abonadoAux);
		logger.debug("obtenerDatosCambPlanServ():fin");
		respuesta.setCodPlanServNuevo(abonadoAux.getCodPlanServ());
		
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
		
		
		
	    //2.- validar traspaso de servicios homologos
		logger.debug("2.- validar traspaso de servicios homologos");
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

		//3.- consultar saldo y prepago
		logger.debug("3.- consultar saldo y prepago");
		ConsultaSaldoDTO consultaSaldo = new ConsultaSaldoDTO();
		SaldoDTO retornoSaldo = new SaldoDTO();
		ConsultaPrepagosDTO consultaPrepagos = new ConsultaPrepagosDTO();
		String saldo = "0";
		for(int i=0; i<numAbonadosSel; i++){
			
			saldo ="0";
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
					if (retornoSaldo.getSaldo().length()>0){
						saldo = retornoSaldo.getSaldo();
					}else{
						msgUsuario ="Ocurrio un error al consultar saldo, componente: SocketPSEJBEARProvider";
						throw new ManReqException("1",0, msgUsuario); //no continua ooss
					}
				}
			}
			
			float saldoAbonado = Float.parseFloat(saldo);
			
			//consulta prepago
			consultaPrepagos.setNumAbonado(this.listaAbonadosSel[i].getNumAbonado());
			consultaPrepagos.setCodPlanTarifActual(this.listaAbonadosSel[i].getCodPlanTarif());
			consultaPrepagos.setCodActAbo(this.codActuacion);
			consultaPrepagos.setCodPlanServ(this.listaAbonadosSel[i].getCodPlanServ());
			consultaPrepagos.setCodTecnologia(this.listaAbonadosSel[i].getCodTecnologia());
			consultaPrepagos.setVnSaldo(saldoAbonado);
			logger.debug("consultaPrepago():ini");
			delegate.consultaPrepago(consultaPrepagos);
			logger.debug("consultaPrepago():fin");
			
			//obtiene cargos
			String[] numAbonadosCargos = new String[1];
			numAbonadosCargos[0] = String.valueOf(this.listaAbonadosSel[i].getNumAbonado());
			
			ParametrosObtencionCargosDTO paramObtCargos = new ParametrosObtencionCargosDTO();
			paramObtCargos.setTipoPantalla("3");
			paramObtCargos.setAbonados(numAbonadosCargos);
			paramObtCargos.setCodigoClienteOrigen(String.valueOf(this.listaAbonadosSel[i].getCodCliente()));
			paramObtCargos.setCodigoClienteDestino(String.valueOf(parametros.getCodClienteDestino())); 
			paramObtCargos.setCodigoPlanTarifDestino(parametros.getCodPlanTarifSelec());
			paramObtCargos.setCodigoPlanTarifOrigen(parametros.getCodPlanTarifActual());
			paramObtCargos.setCodActabo(this.codActuacionWeb);
			paramObtCargos.setOrdenServicio(String.valueOf(this.codOSAnt));
			paramObtCargos.setCodPlanServ(this.listaAbonadosSel[i].getCodPlanServ());
			paramObtCargos.setCodigoTecnologia(this.listaAbonadosSel[i].getCodTecnologia());

			
			ObtencionCargosDTO obtencionCargos=delegate.obtencionCargos(paramObtCargos);
			
			CargosDTO[] cargos = obtencionCargos.getCargos();
			if (cargos!=null){
				float montoTotal = 0;
				
				//obtiene monto total de cargos por abonado
				for(int j=0; j<cargos.length; j++){
					float monto = (Float.parseFloat(String.valueOf(cargos[j].getCantidad()))) *(cargos[j].getPrecio().getMonto());
					//agregar el descuento --- falta!!
					montoTotal = montoTotal + monto;
				}
				
				//obtiene saldo del que dispone el abonado
				float saldoFinalAbonado = saldoAbonado - montoTotal;
				
				/*if (saldoFinalAbonado < 0){
					msgUsuario ="Abonado "+ this.listaAbonadosSel[i].getNumAbonado() + " no tiene saldo suficiente ";
					throw new ManReqException("1",0, msgUsuario); //no continua ooss
					
				}*/
			}//fin if (cargos!=null)
			
		}

		
		//4.- obtener cambio de plan serv
		logger.debug("5.- obtener cambio de plan serv");
		AbonadoDTO abonadoAux = new AbonadoDTO(); 
		abonadoAux.setCodPlanTarif(parametros.getCodPlanTarifSelec());
		abonadoAux.setCodTecnologia(listaAbonadosSel[0].getCodTecnologia());
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
		String msgUsuario = " ";
		String msgError ="";
		SecuenciaDTO parametro=null;
		SecuenciaDTO retornoSecuencia=null;
		
	    ArrayList abonadosValidos = new ArrayList();
	    ArrayList abonadosInvalidos = new ArrayList();
	    String tipPlanDestino = "2";
	    
	    if(	this.combinatoria.equals("PREPAGOPOSPAGO"))	tipPlanDestino = "2";
	    else tipPlanDestino = "10";
	    
		//validaciones de cliente 
		ClienteDTO clienteAux = new ClienteDTO();
		clienteAux.setCodCliente(this.cliente.getCodCliente());
		logger.debug("validarClienteNPW():inicio");
		delegate.validarClienteNPW(clienteAux);
		logger.debug("validarClienteNPW():fin");
		
		logger.debug("validarSituaCliEmp():inicio");
		delegate.validarSituaCliEmp(clienteAux);
		logger.debug("validarSituaCliEmp():fin");
		
		//fin validaciones de cliente
		
		ObtencionCargosDTO obtencionCargos=null; //BORRAR DESPUES
			
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

			//valida origen destino uso
			AbonadoDTO abonadoAux= new AbonadoDTO();
			abonadoAux.setNumAbonado(listaAbonadosSel[i].getNumAbonado());
			abonadoAux.setCodUso(listaAbonadosSel[i].getCodUso());
			abonadoAux.setCodUsoDestino(tipPlanDestino);
			abonadoAux.setCodTecnologia(listaAbonadosSel[i].getCodTecnologia());
			abonadoAux.setCodActAbo("VO");
			delegate.validarOriDesUso(abonadoAux);
			//fin valida origen destino uso			
			
		}//fin valida lista de abonados seleccionados

		if (!abonadosInvalidos.isEmpty()){
			AbonadoDTO[] arrayAbonadosInvalidos = (AbonadoDTO[])ArrayUtl.copiaArregloTipoEspecifico(abonadosInvalidos.toArray(),AbonadoDTO.class);
			respuesta.setAbonadosInvalidos(arrayAbonadosInvalidos);
			respuesta.setMensaje(" ");
			return respuesta;
		}

		int numAbonadosSel = this.listaAbonadosSel.length;
		//actualiza lista de abonados por lista de abonados validos.
		this.listaAbonadosSel = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	abonadosValidos.toArray(), AbonadoDTO.class);
		
		if (listaAbonadosSel.length == 0){// no hay abonados validos
			msgUsuario = global.getValor("e.001"); //msg:Abonado(s) inválido(s)
			if (!msgError.trim().equals("")) msgUsuario = msgError;
			throw new ManReqException("e.001",0, msgUsuario); //no continua ooss
		}

		//Consultar saldo
		if (this.combinatoria.equals("PREPAGOHIBRIDO")){
		
			logger.debug(" consultar bolsas");
			ConsultaBolsasDTO consultaBolsas= new ConsultaBolsasDTO();
			SaldoDTO retornoSaldo = new SaldoDTO();
			String cadenaBolsas = "0";
			
			for(int i=0; i<numAbonadosSel; i++){
				
				if (aplicaConsultaBolsas()){
					consultaBolsas.setLin(String.valueOf(this.listaAbonadosSel[i].getNumCelular()));
					logger.debug("consultaBolsas.getLin()    :"+consultaBolsas.getLin());
					logger.debug("consultaBolsas():inicio");
					retornoSaldo = delegate.consultaBolsas(consultaBolsas);
					logger.debug("consultaBolsas():fin");
					if(retornoSaldo.getSaldo()!= null ){
						logger.debug("retornoSaldo.getSaldo()   :"+retornoSaldo.getSaldo());
						logger.debug("saldo length="+retornoSaldo.getSaldo().length());
						if (retornoSaldo.getSaldo().length()>0){
							cadenaBolsas = retornoSaldo.getSaldo();
						}else{
							msgUsuario ="Ocurrio un error al consultar bolsas, componente: SocketPSEJBEARProvider";
							throw new ManReqException("1",0, msgUsuario); //no continua ooss
						}
					}
					
				}else{
					cadenaBolsas = "|1|0.00|0|2|0.00|0|3|0.00|0|4|0.00|0|";
				}//fin if (aplicaConsultaBolsas())
				
				//carga saldo
				listaAbonadosSel[i].setCadenaSaldo(cadenaBolsas);
				
			}
		}
		
		//guardar parametro indTraspaso
		if (this.combinatoria.equals("PREPAGOPOSPAGO")){
			ParametroDTO param = new ParametroDTO();
			param.setNomParametro("TRASP_PRE_POSTPAGO");
			param.setCodModulo("GA");
			param.setCodProducto(1);
			param = delegate.obtenerParametroGeneral(param);
			logger.debug("TRASP_PRE_POSTPAGO =" + param.getValor());
			respuesta.setIndTraspaso(param.getValor());
		}else{
			respuesta.setIndTraspaso("");
		}
		
		// validaOossPendPlan cliente destino empresa
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
	public RetornoCondicionesCPUDTO validaPlanTarif(ParametrosCondicionesCPUDTO parametros, long[] abonadosSel  ){
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
	}
	/*public void actualizaListaCliente(int tipoCliente){
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
		
	}*/
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
		
		session.setAttribute("consultaEvalRiesgo","false");
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
	    //System.out.println("Tamaño despues:"+listPlanesTarifarios.size());

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
	    //session.setAttribute("consultaEvalRiesgo","false");
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
		    
		    //session.setAttribute("consultaEvalRiesgo","false");
		
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
	public RetornoCondicionesCPUDTO ValidaCuentaPersonal(ParametrosCondicionesCPUDTO parametros , long[] abonadosSel){
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
							if (totalAbonadosSel ==  1){
								retorno.setMensaje("El abonado está como Número Personal de la línea Corporativa N° "+numCelularCorp+", \n continuará con la asociación.");
							}
							else{
								retorno.setMensaje("Los abonados se encuentran como número personal de una línea corporativa.\n continuará con la asociación.");
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
				  retorno.setCodActuacion("CA"); // 
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
		logger.debug("Consultando planes evaluacion riesgo");
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
						if (
								listaPlanesEval[i].getCodigoPlanTarifario().equals(plan.getCodPlanTarif()) &&
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
					session.setAttribute("consultaEvalRiesgo","true");
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
					// Setea el arreglo flitrado
					dataPlanesEval.setallLstPTaPlanTarifarioOutDTO(listaPlanesEval);
					session.setAttribute("dataPlanesEval", dataPlanesEval);
				}//fin if
				else {
					dataPlanesEval.setCodError(new Long(999));
					dataPlanesEval.setMsgError("Debe realizar una evaluacion de riesgo para el cliente "+numIdentCliOrigen);
				}
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
	    
	    	ClienteDTO clienteAux =  new ClienteDTO();
	    	clienteAux.setCodCuenta(((ClienteOSSesionDTO)session.getAttribute("ClienteOOSS")).getCliente().getCodCuenta());
	    	clienteAux.setCodTipoPlan(String.valueOf(tipoCliente));
	    	clienteAux.setCodTecnologia(this.listaAbonados[0].getCodTecnologia()); // EV 05/09/08
			
			if (tipoFiltro == 1){//para las puntuales donde cliente origen es igual a cliente destino
				//listar el mismo cliente origen
			    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
			    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
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
							for(int i=0;i<clientes.length;i++)  listClientes.add(clientes[i]);
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
					listClientes.add(clientes[0]);
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
	
	/*Indica si esta habilitada la consulta de bolsas en la plataforma */
	public boolean aplicaConsultaBolsas(){
		boolean resultado = false;
		
		try {
			ParametroDTO param = new ParametroDTO();
			param.setCodModulo(global.getValor("codigo.modulo.GA"));
			param.setCodProducto(Integer.parseInt(global.getValor("codigo.producto").trim())); 
			param.setNomParametro(global.getValor("parametro.cons_bolsas_prepago"));
			ParametroDTO paramGral = delegate.obtenerParametroGeneral(param);
			logger.debug("CONS_BOLSAS_PREPAGO="+paramGral.getValor());
			resultado = (paramGral.getValor().equalsIgnoreCase("S"))?true:false;
		} catch (Exception e) {
			logger.debug("Error al obtener parametro CONS_BOLSAS_PREPAGO");
			e.printStackTrace();
		}
		logger.debug("aplicaConsultaBolsas="+resultado);
		return resultado;
	}	

}
