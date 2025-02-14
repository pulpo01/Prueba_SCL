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
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioListOutDTO;
import com.tmmas.cl.scl.commonbusinessentities.dto.ws.LstPTaPlanTarifarioOutDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.CargoClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteTipoPlanListDTO;
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
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CtaPersonalEmpDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CuentaPersonalDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GaAbocelDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BolsaDinamicaDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ClienteOSSesionDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.EvalCrediticiaDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.MensajeDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.ParametrosCondicionesCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.RespuestaEvalCrediticiaDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.dataTransferObject.RetornoCondicionesCPUDTO;
import com.tmmas.scl.operations.crm.fab.cim.manreq.frmk.exception.ManReqException;
import com.tmmas.scl.operations.crm.fab.cim.manreq.web.delegate.ManageRequestBussinessDelegate;
import com.tmmas.scl.vendedor.dto.ConfiguracionVendedorCPUDTO;
import com.tmmas.scl.vendedor.dto.UsuarioSistemaDTO;
import com.tmmas.scl.vendedor.dto.UsuarioVendedorDTO;
import com.tmmas.scl.vendedor.exception.VendedorException;

public class CondicionesOOSSEmpresa {
	private final Logger logger = Logger.getLogger(CondicionesOOSSEmpresa.class);
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
		ConversionDTO[] registrosConversion=null;
		
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
			logger.debug("codOSAnt              :"+codOSAnt);
			logger.debug("codActuacion          :"+codActuacion);

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
		    restricciones.setCodModulo("GA");  //gsaavedra 03/03/2007

			respuesta =  validaCondicionesPospagoPospago(parametros,restricciones); //POSPAGOPOSPAGO EMPRESA
			
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
		RetornoCondicionesCPUDTO respuesta = new RetornoCondicionesCPUDTO();
		logger.debug("validaCondicionesPospagoPospago():ini");
		String respuestaConfirm = " ";
		String msgUsuario = " ";
		String msgError = "";
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
				//evera 25 julio, al primer error no continua ooss
				/*listaAbonadosSel[i].setDesSituacion(e.getDescripcionEvento()); 
				validaEventos = false;*/
				throw new ManReqException("e.001",0, e.getDescripcionEvento()); //no continua ooss
				
			}
			logger.debug("validaRestriccionComerOoss:fin");
				
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
		
		//actualiza lista de abonados por lista de abonados validos.
		this.listaAbonadosSel = (AbonadoDTO[]) ArrayUtl.copiaArregloTipoEspecifico(	abonadosValidos.toArray(), AbonadoDTO.class);
		
		if (listaAbonadosSel.length == 0){// no hay abonados validos
			msgUsuario = global.getValor("e.001"); //msg:Abonado(s) inválido(s)
			
			if (!msgError.trim().equals("")) msgUsuario = msgError;
			throw new ManReqException("e.001",0, msgUsuario); //no continua ooss
		}

		int totalAbonadosSel = listaAbonadosSel.length;
		
		//3.- obtener y validar fecha cumplimiento de plan, solo si es Empresa
		//obtener fecha cumplimiento plan
		GaAbocelDTO abocel = new GaAbocelDTO();
		abocel.setCodCliente(cliente.getCodCliente());
		logger.debug("obtenerFecCumPlan():inicio");
		abocel = delegate.obtenerFecCumPlan(abocel);
		logger.debug("obtenerFecCumPlan():fin");
		
		Date fecCumplan =  abocel.getFecCumplan();
		//respuesta.setFecCumplan(fecCumplan); //REVISAR SI ES NECESARIO GUARDAR ESTA FECHA
		//validar fecha cumplimiento plan
		Date fechaActual = new Date();
		long numDias = (fechaActual.getTime() - fecCumplan.getTime())/(1000*60*60*24);
		
		if (numDias <= 0){
			numDias = Math.abs(numDias + 1);
			msgUsuario = global.getValor("e.002");//msg:El Cliente no cumple las condiciones que exige el mantenimiento ...
			msgUsuario = msgUsuario.replaceFirst("xx", String.valueOf(numDias));
			throw new ManReqException("e.002",0, msgUsuario); //no continua ooss
		}

		
		/*
		 * NO SE UTILIZA ESTE METODO, BORRAR DESPUES DE LAS PRUEBAS -- gsaavedra 04/03/07
		//4.- validar plan freedom
		ClienteDTO clientef =new ClienteDTO();
		clientef.setCodCliente(cliente.getCodCliente());
		logger.debug("validaFreedom():inicio");
		boolean validaFreedom = delegate.validaFreedom(clientef).isResultado();
		logger.debug("validaFreedom():fin");
		
		//si tiene plan freedom , obtener y validar ciclo freedom
		if (validaFreedom){
			//obtener ciclo freedom
			PlanCicloDTO planCiclo = new PlanCicloDTO();
			
			planCiclo.setCodPlanTarif(cliente.getCodPlanTarif());
			
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
		
		//10.- obtener cargo basico y anular bolsa dinamica, solo si es empresa
		//a.- ejecutar obtenerCargoBasicoActual()
		if (cliente.getFlgRango() == 1){
			CargoClienteDTO cargoCliente = new CargoClienteDTO();
			cargoCliente.setCodCliente(cliente.getCodCliente());
			cargoCliente.setFecha(new Date());
			cargoCliente = delegate.obtenerCargoBasicoActual(cargoCliente);
			float impCargo = cargoCliente.getImpCargo(); //DUDA
			//respuesta.setImpCargo(impCargo);
		}
		
		//b.- obtener secuencia
		logger.debug("obtenerSecuencia():inicio");
		retornoSecuencia = delegate.obtenerSecuencia(parametro);
		logger.debug("obtenerSecuencia():fin");
		
		//c.- anular cargo bolsa dinamica
		BolsaDinamicaDTO bolsa =  new BolsaDinamicaDTO();
		bolsa.setIdSecuencia(retornoSecuencia.getNumSecuencia());
		bolsa.setCodCliente(cliente.getCodCliente());
		bolsa.setCodCiclo(cliente.getCodCiclo());
		bolsa.setCodPlanTarif(cliente.getCodPlanTarif());
		
		logger.debug("anularCargoBolsaDinamica():inicio");
		delegate.anularCargoBolsaDinamica(bolsa);
		logger.debug("anularCargoBolsaDinamica():fin");
		
		//11.- obtener cambio de plan serv -- gsaavedra 04/03/08
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
					convert.setCodTipPlan(parametros.getCodTipoPlanTarif()); 
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
	public ClienteDTO buscaClienteSeleccionado(){
		ClienteDTO cliente = null;
	    HttpSession session = WebContextFactory.get().getSession();
	    
	    //(+) evera, 19/07/08 para empresa el cliente destino es igual al origen
	    ClienteOSSesionDTO sessionData = new ClienteOSSesionDTO();
	    sessionData = (ClienteOSSesionDTO)session.getAttribute("ClienteOOSS");
	    cliente = sessionData.getCliente();

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
	    System.out.println("Tamaño despues:"+listPlanesTarifarios.size());

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
	
	public RetornoCondicionesCPUDTO ValidaCuentaPersonal(ParametrosCondicionesCPUDTO parametros , long[] abonadosSel){	
		RetornoCondicionesCPUDTO retorno = new RetornoCondicionesCPUDTO();
		
		ParametroDTO paramGral = null;		
		CuentaPersonalDTO cuentaPersRetorno = null;
		int clieOriEsAtlantida = 0;
		int aboOriEsCorporativo = 0;
		int planDestinoEsAtlantida = 0;
		int aboOriEsPersonal = 0;
		long totalAbonados = parametros.getNumAbonados();
		
		try {
			ParametroDTO param = new ParametroDTO();
			param.setNomParametro("APLICA_NUMPERS_GSM");
			param.setCodModulo("GA");
			param.setCodProducto(1);						
			paramGral = delegate.obtenerParametroGeneral(param);
			cargaAbonadosSeleccionados(abonadosSel);
			
			if(paramGral.getValor().equals("TRUE")){
				
				CuentaPersonalDTO cuentaPersonalDTO = new CuentaPersonalDTO();
				cuentaPersonalDTO.setCodPlanTarifNuevo(parametros.getCodPlanTarifSelec());
				planDestinoEsAtlantida    = delegate.obtenerInfoAtl(cuentaPersonalDTO);
				
				
				if (totalAbonados == 1){
					AbonadoDTO abonado = new AbonadoDTO();
					abonado.setNumAbonado(listaAbonadosSel[0].getNumAbonado());
					clieOriEsAtlantida = delegate.validaAtlantida(abonado);
					cuentaPersonalDTO.setNumCelular(listaAbonadosSel[0].getNumCelular());
					cuentaPersRetorno    = delegate.obtenerNumeroPersonal(cuentaPersonalDTO);
					
					
					if(cuentaPersRetorno.getNumCelular() == 0){
						cuentaPersonalDTO.setNumCelularPers(cuentaPersonalDTO.getNumCelularPers());
					}else{
						cuentaPersonalDTO.setNumCelularPers(cuentaPersRetorno.getNumCelular());
					}
					
					if(clieOriEsAtlantida == 1)	
						aboOriEsCorporativo = delegate.obtenerInfoPer(cuentaPersonalDTO);
					else						
						aboOriEsPersonal = delegate.validaPersonal(cuentaPersonalDTO);
					
					
					//ESPERSONAL
					if (aboOriEsPersonal == 1 && planDestinoEsAtlantida == 0 && aboOriEsCorporativo == 0){
						cuentaPersonalDTO.setNumCelularPers(listaAbonadosSel[0].getNumCelular());
						cuentaPersonalDTO = delegate.obtieneNumeroCorporativo(cuentaPersonalDTO);
						long numCelularCorp = cuentaPersonalDTO.getNumCelularCorp();
						retorno.setMensaje("El abonado está como Número Personal de la línea Corporativa N° "+numCelularCorp+", \n continuará con la asociación.");
						retorno.setCodActuacion("ESPERSONAL");
						logger.debug("ESPERSONAL, codActuacion=" + retorno.getCodActuacion());
					}
					
					//TIENEPERSONAL
					if (aboOriEsPersonal == 0 && planDestinoEsAtlantida == 1 && clieOriEsAtlantida == 1 && aboOriEsCorporativo==1){
						retorno.setMensaje("El abonado tiene asociado el "+cuentaPersonalDTO.getNumCelularPers()+" como Número Personal. \n Continuará con la asociación");
						retorno.setCodActuacion("TIENEPERSONAL");
						logger.debug("TIENEPERSONAL, codActuacion=" + retorno.getCodActuacion());
					}
				
					// ALTA
					if( 
						 totalAbonados == 1 && 
						((aboOriEsPersonal == 0 && planDestinoEsAtlantida == 1 && clieOriEsAtlantida == 0 ) ||
						(aboOriEsPersonal == 0 && planDestinoEsAtlantida == 1 && clieOriEsAtlantida == 1 && aboOriEsCorporativo==0))
					  ) 
					{
						AbonadoDTO abonadosValidos = new AbonadoDTO();
						abonadosValidos.setNumAbonado(parametros.getNumAbonado());
						abonadosValidos.setNumCelular(parametros.getNumCelular());
						retorno.setCodActuacion("ALTA");
						logger.debug("ALTA");
						AbonadoDTO[] arrayAbonadosValidos = new AbonadoDTO[1];
						arrayAbonadosValidos[0] = listaAbonadosSel[0]; 
						retorno.setAbonadosValidos(arrayAbonadosValidos);
					}
					
					//BAJAALTA					
					if( totalAbonados == 1 && aboOriEsPersonal == 1 && planDestinoEsAtlantida == 1 && clieOriEsAtlantida == 0){
						retorno.setCodActuacion("BAJAALTA");
						logger.debug("BAJAALTA");
						
						cuentaPersonalDTO.setNumCelularPers(listaAbonadosSel[0].getNumCelular());
						cuentaPersonalDTO = delegate.obtieneNumeroCorporativo(cuentaPersonalDTO);
						
						long numCelularCorp = cuentaPersonalDTO.getNumCelularCorp();
						retorno.setMensaje("El abonado está como Número Personal de la línea Corporativa N° "+numCelularCorp+", \n si continúa se desasociará automaticamente.");
						
						AbonadoDTO[] arrayAbonadosValidos = new AbonadoDTO[1];
						arrayAbonadosValidos[0] = listaAbonadosSel[0]; 
						logger.debug("listaAbonadosSel[0].getNumAbonado() = "+listaAbonadosSel[0].getNumAbonado());
						retorno.setAbonadosValidos(arrayAbonadosValidos);
					}
					
					//BAJA
					ClienteDTO cli = new ClienteDTO();
					cli.setCodCliente(cliente.getCodCliente());
					boolean flagBaja = delegate.validaBajaAtlEmpresa(cli).isResultado();
				    if ((flagBaja && planDestinoEsAtlantida == 0) || (aboOriEsPersonal == 1 && planDestinoEsAtlantida == 1)) 
				    {
						retorno.setMensaje("Los abonados perderán automáticamente la asociación de número personal.");
						retorno.setCodActuacion("BAJA");
						logger.debug("BAJA");
				    }					
					
			  	}
				else{
				    // Obtencion datos de cuenta personal empresa
					CtaPersonalEmpDTO ctaPersonal = new  CtaPersonalEmpDTO();
				    ctaPersonal.setCodCliente(cliente.getCodCliente());
				    ctaPersonal = delegate.obtenerDatosCtaPersonalCliEmp(ctaPersonal);
				    long totAboServAtl = ctaPersonal.getTotAboServAtl();
				    long totCorporativo = ctaPersonal.getTotCorporativo();
				    long totPersonal = ctaPersonal.getTotPersonal();
					
				    //ESPERSONAL
					if (totPersonal > 0 && planDestinoEsAtlantida == 0 && totCorporativo == 0){
						retorno.setMensaje("Los abonados se encuentran como Número Personal de una línea Corporativa. \n Continuará con la asociación.");
						retorno.setCodActuacion("ESPERSONAL");
						logger.debug("ESPERSONAL, codActuacion=" + retorno.getCodActuacion());
					}
					
					//TIENEPERSONAL
					if (totPersonal == 0 && planDestinoEsAtlantida == 1 && totAboServAtl >0 && totCorporativo>0) {
						retorno.setMensaje("Los abonados tienen asociado Número Personal. \n Continuará con la asociación");
						retorno.setCodActuacion("TIENEPERSONAL");
						logger.debug("TIENEPERSONAL, codActuacion=" + retorno.getCodActuacion());
					}
				    
					//BAJA
					ClienteDTO cli = new ClienteDTO();
					cli.setCodCliente(cliente.getCodCliente());
					boolean flagBaja = delegate.validaBajaAtlEmpresa(cli).isResultado();
				    if ((flagBaja && planDestinoEsAtlantida == 0) || (aboOriEsPersonal == 1 && planDestinoEsAtlantida == 1)) 
				    {
						retorno.setMensaje("Los abonados perderán automáticamente la asociación de número personal.");
						retorno.setCodActuacion("BAJA");
						logger.debug("BAJA");
				    }
				    
				} //if (totalAbonados == 1){
			}//fin if paramGral.getValor().equals("TRUE")
			
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
			parametros=null;
		
		} catch (Exception e) {
			logger.debug("ERROR (Exception) :"+e.getMessage());
			retorno.setMensaje(e.getMessage());
			parametros=null;
		}
		return retorno;
	}
	
	public RetornoCondicionesCPUDTO ValidaAltaCuentaPersonal(long celPers){
		RetornoCondicionesCPUDTO retorno = new RetornoCondicionesCPUDTO();
		
		int clieOriEsAtlantida = 0;
		int aboOriEsPersonal = 0;
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
			  
			  clieOriEsAtlantida = delegate.validaAtlantidaCliente(cliente);					  
			  aboOriEsPersonal   = delegate.validaPersonal(cuentaPersonalDTO);
				
			  /*
			   * 0 = no es atlantida
			   * 1 = es atlantida
			   */
			  if(clieOriEsAtlantida != 0){
				  retorno.setCodActuacion("CA"); // 1
			  }else{
			  
				  /*
				   * 0 = no existe como personal de otro cliente
				   * 1 = existe como personal de otro cliente
				   */
				  if(aboOriEsPersonal == 0 && clieOriEsAtlantida == 0 ){
					  retorno.setCodActuacion("OK");
					  
				  } else{
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

	
	public LstPTaPlanTarifarioListOutDTO obtenerPlanesEvaluacion(String tipoListaPlan,String numIdentCliOrigen,String tipIdentCliOrigen){
		logger.debug("Consultando planes evaluacion riesgo empresa");
		LstPTaPlanTarifarioListOutDTO dataPlanesEval = null; 
	    List listaPlanesSesion = null;
	    List listaFiltrada = null;
	    LstPTaPlanTarifarioOutDTO[] listaPlanesEval = null;
	    String tipoProducto = global.getValor("tipo.producto.pospago").trim();
	   
	    String tipoPlan = global.getValor("tipo.plan.empresa").trim();  
	    
	    int cantAbonados =  (this.listaAbonados!=null && this.listaAbonados[0]!=null)?this.listaAbonados[0].getCantAbonados():0; 
	    
		ClienteDTO clienteOrigen = new ClienteDTO();
		clienteOrigen.setNumeroIdentificacion(numIdentCliOrigen);
		clienteOrigen.setCodigoTipoIdentificacion(tipIdentCliOrigen);
		
		try{
			HttpSession session = WebContextFactory.get().getSession();
			dataPlanesEval = delegate.obtenerPlanesEvaluacion(clienteOrigen);
			
			listaPlanesEval = dataPlanesEval.getallLstPTaPlanTarifarioOutDTO();
			listaPlanesSesion =  (ArrayList) session.getAttribute(tipoListaPlan);
		    
			if (listaPlanesEval!=null && listaPlanesSesion!=null ){
				int numSolicitud = Integer.parseInt(dataPlanesEval.getNumSol()); 
				boolean esClienteExcepcionado = numSolicitud==0?true:false;
				listaFiltrada = new ArrayList();

				for (int i = 0;i<listaPlanesEval.length; i++){
					for (Iterator it = listaPlanesSesion.iterator(); it.hasNext();) {
						PlanTarifarioDTO plan = (PlanTarifarioDTO) it.next();
						// Si  el cliente no es excepcionado validar cantidad de lineas
						boolean validacionCantLineas = true;
						if (!esClienteExcepcionado)	 validacionCantLineas = listaPlanesEval[i].getCanLineas().intValue() >= cantAbonados;
						
						if (  validacionCantLineas && 
							  listaPlanesEval[i].getCodigoPlanTarifario().equals(plan.getCodPlanTarif()) &&
							  listaPlanesEval[i].getTipoProducto().equals(tipoProducto) &&
							  listaPlanesEval[i].getTipoPlan().equals(tipoPlan)
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
					session.setAttribute("consultaEvalRiesgoEmp","true");
					int tamano = listaFiltrada.size();
					if (tipoListaPlan.equals("rango")) tamano++;
					
					listaPlanesEval = new LstPTaPlanTarifarioOutDTO[tamano];
					int i = 0;
					for (Iterator it = listaFiltrada.iterator();it.hasNext();){
					  PlanTarifarioDTO plan = (PlanTarifarioDTO) it.next();
					  listaPlanesEval[i] = new LstPTaPlanTarifarioOutDTO();
					  listaPlanesEval[i].setCodigoPlanTarifario(plan.getCodPlanTarif());
					  listaPlanesEval[i].setDescripcionPlanTarifario(plan.getDesPlanTarif());
					  listaPlanesEval[i].setCanLineas(new Long(plan.getCanLineas()));
					  i++;
					}// fin for
					
					if (tipoListaPlan.equals("rango")){
						//Agrega una fila para seleccionar
						 listaPlanesEval[i] = new LstPTaPlanTarifarioOutDTO();
						 listaPlanesEval[i].setCodigoPlanTarifario("0");
						 listaPlanesEval[i].setDescripcionPlanTarifario("Seleccione...");
						 listaPlanesEval[i].setCanLineas(new Long(0));
					}
					//Setea el arreglo flitrado
					dataPlanesEval.setallLstPTaPlanTarifarioOutDTO(listaPlanesEval);
					session.setAttribute("dataPlanesEval", dataPlanesEval);
				}
				else{
					String msgErr = "Debe realizar una evaluación de riesgo para el cliente con id "+numIdentCliOrigen+" considerando a los "+cantAbonados+" abonados"; 
					dataPlanesEval.setMsgError(msgErr);
					dataPlanesEval.setCodError(new Long(999));
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

	
	
	public LstPTaPlanTarifarioListOutDTO obtenerPlanesEvalSesion (){
	    // Obtiene planes  de evaluacion de riesgo en sesion
		HttpSession session = WebContextFactory.get().getSession();
		LstPTaPlanTarifarioListOutDTO dataPlanesEval = (LstPTaPlanTarifarioListOutDTO) session.getAttribute("dataPlanesEval"); 
		return dataPlanesEval;
		
	}
}
