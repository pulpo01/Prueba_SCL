package com.tmmas.scl.operations.crm.f.oh.isscusord.cmd;


import java.io.File;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.rmi.RemoteException;
import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.ejb.CreateException;

import net.sf.dozer.util.mapping.DozerBeanMapper;
import net.sf.dozer.util.mapping.MapperIF;

import org.apache.log4j.Logger;
import org.jdom.Document;
import org.jdom.Element;
import org.jdom.JDOMException;
import org.jdom.input.SAXBuilder;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.exception.ServiceLocatorException;
import com.tmmas.cl.framework.processmgr.AsyncProcessParameterObject;
import com.tmmas.cl.framework.processmgr.AsyncProcessResponseObject;
import com.tmmas.cl.framework.util.Formatting;
import com.tmmas.cl.framework.util.ServiceLocator;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacade;
import com.tmmas.cl.scl.frameworkcargos.bean.ejb.session.FrmkCargosFacadeHome;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.AbonadoSecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DetEstadoProcesoOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.EstadoProcesoOOSSDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.FiltroAbonadosDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntegraProdCPUDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntegraProdCPUListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CabeceraArchivoDTO;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;
import com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.cmd.orc.OrdenServicioAsincronoCmdORC;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.OSAbonadoDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.OrdenServicioBaseDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.ParamRegistroOrdenServicioDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.dataTransferObject.RegistroPlanDTO;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;
import com.tmmas.scl.operations.crm.f.sel.negsal.dataTransferObject.CambioPlanAdicionalDTO;
import com.tmmas.scl.operations.crm.f.sel.negsal.exception.NegSalException;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacade;
import com.tmmas.scl.operations.crm.fab.cim.mancon.bean.ejb.session.ManConFacadeHome;
import com.tmmas.scl.operations.crm.fab.cim.mancon.common.exception.ManConException;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.common.exception.ManProOffInvException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacade;
import com.tmmas.scl.operations.crm.o.csr.supordhan.bean.ejb.session.SupOrdHanFacadeHome;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;
import com.tmmas.scl.operations.crm.osr.mancusinv.common.exception.ManCusInvException;




public class CambioPlanUnificadoOSAsinORC extends OrdenServicioAsincronoCmdORC {


	private static final long serialVersionUID = 1L;
	private long numeroProceso;
	private long numOrdenServicio;
		
	transient static Logger cat = Logger.getLogger(CambioPlanUnificadoOSAsinORC.class);
	transient private AsyncProcessParameterObject parametros = null;
	Map datosExtra = new HashMap();
	IntegraProdCPUDTO [] integracionProdCPU = new IntegraProdCPUDTO[0];


	public CambioPlanUnificadoOSAsinORC() {
		// TODO Auto-generated constructor stub
	}

	public CambioPlanUnificadoOSAsinORC(AsyncProcessParameterObject value) {
		super(value);
		// TODO Auto-generated constructor stub
	}


	public void ejecutarOrdenServicio(OrdenServicioBaseDTO object)	throws IssCusOrdException{
		cat.debug("ejecutarOrdenServicio():start");
		Global global = Global.getInstance();
		try{
			ParamRegistroOrdenServicioDTO objeto;
			if(object!=null){
				objeto = (ParamRegistroOrdenServicioDTO) object;
			}else{
				throw new IssCusOrdException("El objeto que se encoló es nulo"); 
			}
			registroOrden(objeto);
			
			String rollback = global.getValor("data.rollback");
			cat.debug("rollback = "+rollback);
			if (rollback.trim().equalsIgnoreCase("TRUE")) {
				cat.debug("Se procede a ejecutar rollback");
				setRollBackManual(true);
			}
			
		}catch(IssCusOrdException e){
			
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("notificarError():inicio");
			notificarError(e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			cat.debug("notificarError():fin");
			cat.debug("Exception[" + loge + "]");
			throw e;
		}
						
		cat.debug("ejecutarOrdenServicio():end");	
	}

	/**
	 * Se encarga de parsear el XML de configuración de combinatorias de cambio de plan unificado e invocar los métodos de obtención dinámica de fachadas, creación dinámica de DTOs e Invocación dínamica de métodos.
	 * 
	 * @param registro Objeto que ha sido encolado, el cual contiene todos los datos necesarios para crear los DTOs que utilizan los métodos que se ejecutarán para esta OOSS
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 * @throws ClassNotFoundException
	 * @throws JDOMException
	 * @throws IOException
	 * @throws SecurityException
	 * @throws IllegalArgumentException
	 * @throws InvocationTargetException
	 * @throws NoSuchFieldException
	 * @throws NoSuchMethodException
	 * @throws NegSalException 
	 * @throws ManProOffInvException 
	 * @throws ManCusInvException 
	 * @throws ManConException 
	 * @throws SupOrdHanException 
	 * @throws ProyectoException
	 */
	public void registroOrden(ParamRegistroOrdenServicioDTO objeto) throws IssCusOrdException {
		
		cat.debug("CambioPlanUnificadoOSAsinORC 201009 pv");
		cat.debug("registroOrden():start");
		try{
			RegistroPlanDTO registro = objeto.getRegistroPlan();
			
			EstadoProcesoOOSSDTO estadoProcesoOOSS = objeto.getEstadoProcesoOOSS();
			this.numeroProceso = estadoProcesoOOSS.getNumProceso();
			Global global = Global.getInstance();
			SAXBuilder builder = new SAXBuilder();
			Document doc = null;
			doc = builder.build(new File(global.getPathInstancia()+global.getValor("OOSSConf.definition")));

			String combinatoriaRecibida = registro.getParamRegistroPlan().getCombinatoria()+registro.getParamRegistroPlan().getTipOOSS();
			cat.debug(" NOMBRE COMBINATORIA RECIBIDA: "+ combinatoriaRecibida);


			//Verifica que una combinatoria es masiva
			cat.debug("verificarCombinatoriaMasiva:antes");
			boolean masiva = verificarCombinatoriaMasiva(combinatoriaRecibida);
			cat.debug("verificarCombinatoriaMasiva:despues");
			
			List arregloMetodos = doc.getRootElement().getChild(registro.getParamRegistroPlan().getCombinatoria()+registro.getParamRegistroPlan().getTipOOSS()).getChildren();
			AbonadoDTO [] arregloAbonados = null;
			
			
			if (!registro.getParamRegistroPlan().getTipOOSS().equals("40007")){//si no es empresa se trabaja con todos los abonados
				
				if(registro.getParamRegistroPlan().getAbonadosSel()!=null){  
					arregloAbonados = registro.getParamRegistroPlan().getAbonadosSel();
				}	
				else{
					if(registro.getParamRegistroPlan().getNumAbonados()!=null){
						try {
							arregloAbonados = obtenerAbonados(registro.getParamRegistroPlan().getNumAbonados());
						} catch (ManConException e) {
							String loge = StackTraceUtl.getStackTrace(e);
							cat.debug("ManConException[" + loge + "]");
							throw new IssCusOrdException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
						}
					}
				}
			
			
				//Si la cantidad de aboandos seleccionados es nula, solo se iterará una vez
				//Sino Si la combinatoria recibida es masiva se itera una vez por aboando seleccionado
				//Sino se itera solamente una vez
				int numIteraciones = 0;
				//int numAbonados = registro.getParamRegistroPlan().getNumAbonados()==null?1:masiva?registro.getParamRegistroPlan().getNumAbonados().length:1;
				int numAbonados = (arregloAbonados ==null)?1:masiva?arregloAbonados.length:1;
				int indiceAbonados = 0;
				
				OSAbonadoDTO[] osAbonados =  new OSAbonadoDTO[numAbonados]; //arreglo donde se asocia un numero de orden de servicio a un abonado
				cat.debug("numAbonados="+numAbonados);
				
				
				//(+) EV 27/09/08 -- ind # 71096
				if (   combinatoriaRecibida.equals("POSPAGOPOSPAGO40008")
					|| combinatoriaRecibida.equals("HIBRIDOHIBRIDO40008")
					|| combinatoriaRecibida.equals("POSPAGOHIBRIDO40008")
					|| combinatoriaRecibida.equals("HIBRIDOPOSPAGO40008")){
					//se debe validar si la modificacion a la ga_modabocel viene por cliente o
					//por abonado, si viene por abonado el metodo debe quedar iterativo
					
					if (registro.getParamRegistroPlan().getSujeto().equals("A")){
						for (int i = 0; i<arregloMetodos.size();i++){
							Element metodo = (Element)arregloMetodos.get(i);
				
							if ( metodo.getAttributeValue("nombre").equals("registraNivelOoss")){
								metodo.getChild("Iterativo").setText("S");
							}
							
						}//fin for metodos
					}
				}
				//(-)
				
				//ejecucion de metodos iterativos
				for(int nAbonados = 0; nAbonados<numAbonados;nAbonados++){
					OSAbonadoDTO osAbonado = new OSAbonadoDTO();
					
					if(arregloAbonados!=null&&arregloAbonados.length>0){
						
						// Obtencion del numero contrato
						SecuenciaDTO secuenciaNumOs = new SecuenciaDTO(); 
						secuenciaNumOs.setNomSecuencia(global.getValor("secuencia.contrato"));
						secuenciaNumOs = getSupOrdHanFacade().obtenerSecuencia(secuenciaNumOs);
						long numOs = secuenciaNumOs.getNumSecuencia();
		                String numeroContrato = Formatting.number(numOs,global.getValor("formato.numero.contrato"));
		                Calendar hoy = Calendar.getInstance();
		                String anio = Formatting.dateTime(hoy,"yy");                   
		                numeroContrato = global.getValor("prefijo.numero.contrato") + "-" + numeroContrato + "-" + anio +  "-" +  global.getValor("sufijo.numero.contrato");
		                cat.debug("numeroContrato="+numeroContrato);
						arregloAbonados[nAbonados].setNumContrato(numeroContrato);
						// Obtencion del anexo
						String numAnexo = numeroContrato.substring(0,(numeroContrato.length()-String.valueOf(1).length()));
						numAnexo=numAnexo+String.valueOf(nAbonados+1);
						cat.debug("numAnexo="+numAnexo);
						arregloAbonados[nAbonados].setNumAnexo(numAnexo);
			
						registro.setAbonado(arregloAbonados[nAbonados]);
						osAbonado.setAbonado(registro.getAbonado()); //guarda datos de abonado
						osAbonado.setNumOOSS(registro.getAbonado().getNumeroOS());
					}
					
					this.numOrdenServicio = osAbonado.getAbonado().getNumeroOS();
						
					//For que recorre los métodos declarados en el XML para la combinatoria recibida
					for (int i = 0; i<arregloMetodos.size();i++){
						//Metodo que se encuentra en el indice i para la combinatoria recibida
						Element metodo = (Element)arregloMetodos.get(i);
		
						String flgIterativo = "S"; //indica si el metodo se debe incluir en la iteracion o se ejecuta una sola vez
						if (metodo.getChild("Iterativo")!= null) flgIterativo = metodo.getChild("Iterativo").getText();
		
						if ( flgIterativo.equals("S") ){
							cat.debug("Método que se ejecutará : "+ metodo.getAttributeValue("nombre"));
							
							//(-)evera 20 de julio
							if( metodo.getAttributeValue("nombre").equalsIgnoreCase("anulaOossPendPlan") ){ 
									//estos metodos se ejecutan solo una vez al principio
									if (indiceAbonados==0){
										Object retorno = utilizaMetodo(metodo,registro, objeto); 
										cat.debug("Tipo de retorno del método ejecutado :"+ retorno.getClass().getName());
									}
							}
							else{
								//Si el método que se debe ejecutar es el registroCambPlanServ y el getCodPlanServ del abonado != de nulo y el codPlanServNuevo != codPlanServ del abonado 
								//O si el método que se debe ejecutar != registroCambPlanServ también se ejecuta .
								boolean condPlanServNoNull =
								(
									metodo.getAttributeValue("nombre").equalsIgnoreCase("registroCambPlanServ")
											&&
									(//(planServ!=planServNuevo) || (planServ==planServNuevo && combinatoria=prepagoprepago40006) 
											registro.getAbonado().getCodPlanServ()!=null 
												&& 
											( (!registro.getAbonado().getCodPlanServ().equalsIgnoreCase(registro.getParamRegistroPlan().getCodPlanServNuevo()))
												 ||
											  (registro.getAbonado().getCodPlanServ().equalsIgnoreCase(registro.getParamRegistroPlan().getCodPlanServNuevo())
													  && combinatoriaRecibida.equals("PREPAGOPREPAGO40006")
											   )
											)
									)
								);
								
								boolean condPosHib =
								(
									metodo.getAttributeValue("nombre").equalsIgnoreCase("actualizarLimiteConsumo")
												&&
									(//para el caso de poshib y hibpos 40006 solo se debe ejecutar si el holding es distinto de 99
										( !combinatoriaRecibida.equals("POSPAGOHIBRIDO40006")&& !combinatoriaRecibida.equals("HIBRIDOPOSPAGO40006") 
											||
										( 
											combinatoriaRecibida.equals("POSPAGOHIBRIDO40006") || combinatoriaRecibida.equals("HIBRIDOPOSPAGO40006"))
													&&
											!registro.getParamRegistroPlan().getCodHolding().equals("99") 
										)
									)
								);
									
								
								boolean condTodosMetodos = 
								(
										!metodo.getAttributeValue("nombre").equalsIgnoreCase("registroCambPlanServ")
											&&
										!metodo.getAttributeValue("nombre").equalsIgnoreCase("actualizarLimiteConsumo")
								);
									
								if( condTodosMetodos || condPlanServNoNull ||condPosHib ){
									//Aqui se ejecuta el metodo declarado en el xml
									//	metodo   :Elemento que contiene informacion del metodo como nombre, atributos, tipos de datos, etc.
									//	registro :RegistroPlanDTO, contiene información que viene desde las paginas
									//	objeto   :ParamRegistroOrdenServicioDTO, contiene información que viene desde las paginas
									//	retorno  :DTO retornado por el metodo despues de su ejecución
									Object retorno = utilizaMetodo(metodo,registro, objeto); 
									cat.debug("Tipo de retorno del método ejecutado :"+ retorno.getClass().getName());
									if (retorno instanceof SecuenciaDTO){//las secuencias se dejan disponibles para ser usadas por otros metodos
										String nombreSecuencia = ((SecuenciaDTO)retorno).getNomSecuencia();
										Long valorSecuencia = new Long(((SecuenciaDTO)retorno).getNumSecuencia());
										datosExtra.put(nombreSecuencia, valorSecuencia);
										cat.debug("Guarda Secuencia :" + datosExtra.get(nombreSecuencia));
										
										/*if (nombreSecuencia.equals("CI_SEQ_NUMOS")){ //asocia numero de orden de servicio al abonado
											osAbonado.setNumOOSS(valorSecuencia.longValue());
										}*/
									}//fin if (retorno instanceof SecuenciaDTO)
									
								}//fin if((metodo.getAttributeValue("nombre")...
							}//(-)
						}//fin if (flgIterativo.equals("S"))
						
						
					}//fin for metodos
					
					//----------------------NOTIFICAR CABECERA Y DETALLE PARA METODOS EJECUTADOS POR ABONADO------------------------------------------------------------------------------
					EstadoProcesoOOSSDTO estPro = new EstadoProcesoOOSSDTO();
					estPro.setEstado("PROCESADO");
					estPro.setFechaActualizacion(new Date());
					estPro.setNumProceso(estadoProcesoOOSS.getNumProceso());
					DetEstadoProcesoOSSDTO[] detalles = new DetEstadoProcesoOSSDTO[1];
					DetEstadoProcesoOSSDTO detalle = new DetEstadoProcesoOSSDTO();
					detalle.setEstado("PROCESADO");
					detalle.setFecEstado(new Date());
					detalle.setNumProceso(estadoProcesoOOSS.getNumProceso());
					detalle.setNumOOSS(osAbonado.getAbonado().getNumeroOS());
					cat.debug("estPro.getEstado()[" + estPro.getEstado() + "]");
					cat.debug("estPro.getFechaActualizacion()[" + estPro.getFechaActualizacion() + "]");
					cat.debug("estPro.getNumProceso()[" + estPro.getNumProceso() + "]");
					cat.debug("detalle.getEstado()[" + detalle.getEstado() + "]");
					cat.debug("detalle.getFecEstado()[" + detalle.getFecEstado() + "]");
					cat.debug("detalle.getNumProceso()[" + detalle.getNumProceso() + "]");
					cat.debug("detalle.getNumOOSS()[" + detalle.getNumOOSS() + "]");
					detalles[0] = detalle;
					estPro.setDetEstadoProcesoOSSDTO(detalles);
					cat.debug("notificar():inicio");
					notificar(estPro);
					cat.debug("notificar():fin");
					
					//-----------------------------------------FIN---------------------------------------------------------------------------------
					
					osAbonados[nAbonados] = osAbonado;
					cat.debug("numAbonado="+osAbonado.getAbonado().getNumAbonado());
					cat.debug("numOS="+osAbonado.getNumOOSS());
					numIteraciones++;
					indiceAbonados++;
				}// fin for abonados
		
				registro.setOsAbonados(osAbonados);//guarda informacion de abonados y numeros de ooss
				objeto.setRegistroPlan(registro);
				
				//Ejecucion de metodos no iterativos
				for (int i = 0; i<arregloMetodos.size();i++){
					Element metodo = (Element)arregloMetodos.get(i);
		
					String flgIterativo = "S";
					if (metodo.getChild("Iterativo")!= null) flgIterativo =metodo.getChild("Iterativo").getText();
					
					if (flgIterativo.equals("N")){
							cat.debug("Método no iterativo que se ejecutará : "+ metodo.getAttributeValue("nombre"));
							Object retorno = utilizaMetodo(metodo,registro, objeto); 
							cat.debug("Tipo de retorno del método ejecutado :"+ retorno.getClass().getName());
							if (retorno instanceof SecuenciaDTO){
								String nombreSecuencia = ((SecuenciaDTO)retorno).getNomSecuencia();
								Long valorSecuencia = new Long(((SecuenciaDTO)retorno).getNumSecuencia());
								datosExtra.put(nombreSecuencia, valorSecuencia);
								cat.debug("Guarda Secuencia :" + datosExtra.get(nombreSecuencia));
							}//fin if (retorno instanceof SecuenciaDTO)
					}//fin if ((flgIterativo.equals("N"))
					
				}//fin for metodos
				//fin ejecucion de metodos no iterativos
							
				
				if(integracionProdCPU!=null&&integracionProdCPU.length!=0){
					CambioPlanAdicionalDTO[] cambPlan = new CambioPlanAdicionalDTO[integracionProdCPU.length];
					for(int i = 0; i<integracionProdCPU.length;i++){
						cambPlan[i] = new CambioPlanAdicionalDTO();
						cambPlan[i].setClienteOrigen(String.valueOf(integracionProdCPU[i].getClienteOrigen()));
						cambPlan[i].setAbonadoOrigen(String.valueOf(integracionProdCPU[i].getAbonadoOrigen()));
						cambPlan[i].setPlanTarifOrigen(integracionProdCPU[i].getPlanTarifOrigen());
						cambPlan[i].setClienteDestino(String.valueOf(integracionProdCPU[i].getClienteDestino()));
						cambPlan[i].setAbonadoDestino(String.valueOf(integracionProdCPU[i].getAbonadoDestino()));
						cambPlan[i].setPlanTarifDestino(integracionProdCPU[i].getPlanTarifDestino());
						cambPlan[i].setFechaActivacionPlanes(String.valueOf(integracionProdCPU[i].getFechaActivacionPlanes()));
						cambPlan[i].setFechaDesactivacionPlanes(String.valueOf(integracionProdCPU[i].getFechaDesactivacionPlanes()));
						cambPlan[i].setNumMovCentral(String.valueOf(integracionProdCPU[i].getNumMovCentral()));
						cambPlan[i].setOrigenProceso(integracionProdCPU[i].getOrigenProceso());
						cambPlan[i].setNumProceso(String.valueOf(integracionProdCPU[i].getNumProceso()));	
						
					}
					/**
					 * @author rlozano
					 * @date 12-01-2009
					 * @description se comenta llamada a la fachada de ProductoEJBEAR Servicio de Integracion con Producto
					 */
					//integrarProductoConCPU(cambPlan);
				}
				
			}//fin if (!registro.getParamRegistroPlan().getTipOOSS().equals("40007"))
			else{ //es empresa - NO SE USA PARA GUATEMALA-SALVADOR
				Map abonadosEmpresaMap = new HashMap();
				
				//deja numero abonado-orden de servicio de una lista HashMap
				if(registro.getParamRegistroPlan().getAbonadosEmpresa()!=null){  
					AbonadoSecuenciaDTO[] abonadosEmpresa = registro.getParamRegistroPlan().getAbonadosEmpresa();
					cat.debug("total abonados="+abonadosEmpresa.length);
					for(int i=0; i<abonadosEmpresa.length; i++){
						abonadosEmpresaMap.put(String.valueOf(abonadosEmpresa[i].getNumAbonado()), String.valueOf(abonadosEmpresa[i].getNumOOSS()));
					}
					
				};
				
				//obtiene abonados por bloque
				long codCliente = registro.getCliente().getCodCliente();
				cat.debug("codCliente="+codCliente);
				int indiceAbonados = 0;
				int numBloque = 1;
				int numMaxFilas = Integer.parseInt(global.getValor("numero.abonados.bloque"));
				FiltroAbonadosDTO filtro =  new FiltroAbonadosDTO();
				filtro.setCodCliente(codCliente);
				filtro.setNumBloque(numBloque);
				filtro.setMaxFilas(numMaxFilas);
				boolean existeData = true;
				cat.debug("numero.abonados.bloque="+numMaxFilas);
				while (existeData ){

					cat.debug("NumBloque="+filtro.getNumBloque());
					//obtiene bloque de abonados
					AbonadoListDTO  listaAbonados = getManConFacade().obtieneBloqueAbonados(filtro);
					arregloAbonados = listaAbonados.getAbonados();
					filtro.setNumBloque(listaAbonados.getNumBloque());//siguiente bloque
					
					if (arregloAbonados.length == 0){
						existeData = false;
						break;
					}
					
					int numIteraciones = 0;
					int numAbonados = arregloAbonados.length;
					OSAbonadoDTO[] osAbonados =  new OSAbonadoDTO[numAbonados]; //arreglo donde se asocia un numero de orden de servicio a un abonado
					cat.debug("numAbonados="+numAbonados);
					
					//ejecucion de metodos iterativos
					for(int nAbonados = 0; nAbonados<numAbonados;nAbonados++){
						OSAbonadoDTO osAbonado = new OSAbonadoDTO();
						
						// Obtencion del numero contrato
						SecuenciaDTO secuenciaNumContrato = new SecuenciaDTO(); 
						secuenciaNumContrato.setNomSecuencia(global.getValor("secuencia.contrato"));
						secuenciaNumContrato = getSupOrdHanFacade().obtenerSecuencia(secuenciaNumContrato);
						long numContrato = secuenciaNumContrato.getNumSecuencia();
						
			            String numeroContrato = Formatting.number(numContrato,global.getValor("formato.numero.contrato"));
			            Calendar hoy = Calendar.getInstance();
			            String anio = Formatting.dateTime(hoy,"yy");                   
			            numeroContrato = global.getValor("prefijo.numero.contrato") + "-" + numeroContrato + "-" + anio +  "-" +  global.getValor("sufijo.numero.contrato");
			            cat.debug("numeroContrato="+numeroContrato);
						arregloAbonados[nAbonados].setNumContrato(numeroContrato);
						
						// Obtencion del anexo
						String numAnexo = numeroContrato.substring(0,(numeroContrato.length()-String.valueOf(1).length()));
						numAnexo=numAnexo+String.valueOf(nAbonados+1);
						cat.debug("numAnexo="+numAnexo);
						arregloAbonados[nAbonados].setNumAnexo(numAnexo);
						
						// Guarda numero de orden de servicio que viene de la sesion
						long numOS =  Long.parseLong(abonadosEmpresaMap.get(String.valueOf(arregloAbonados[nAbonados].getNumAbonado())).toString());
						arregloAbonados[nAbonados].setNumeroOS(numOS);
						
						registro.setAbonado(arregloAbonados[nAbonados]);
						osAbonado.setAbonado(registro.getAbonado()); //guarda datos de abonado
						osAbonado.setNumOOSS(numOS);
						
						this.numOrdenServicio = osAbonado.getAbonado().getNumeroOS();
						
						//For que recorre los métodos declarados en el XML para la combinatoria recibida
						for (int i = 0; i<arregloMetodos.size();i++){
							//Metodo que se encuentra en el indice i para la combinatoria recibida
							Element metodo = (Element)arregloMetodos.get(i);
			
							String flgIterativo = "S"; //indica si el metodo se debe incluir en la iteracion o se ejecuta una sola vez
							if (metodo.getChild("Iterativo")!= null) flgIterativo = metodo.getChild("Iterativo").getText();
												
							if ( flgIterativo.equals("S") ){
								
								cat.debug("Método que se ejecutará : "+ metodo.getAttributeValue("nombre"));

								if( metodo.getAttributeValue("nombre").equalsIgnoreCase("registroCambPlanComer")
									|| metodo.getAttributeValue("nombre").equalsIgnoreCase("actualizarLimiteConsumo")
									|| metodo.getAttributeValue("nombre").equalsIgnoreCase("anulaOossPendPlan")
									|| metodo.getAttributeValue("nombre").equalsIgnoreCase("insertarFrecuentesProgramados")	){ 
									//estos metodos se ejecutan solo una vez al principio
									if (indiceAbonados==0){
										Object retorno = utilizaMetodo(metodo,registro, objeto); 
										cat.debug("Tipo de retorno del método ejecutado :"+ retorno.getClass().getName());
									}
								}
								else{		
									//Si el método que se debe ejecutar es el registroCambPlanServ y el getCodPlanServ del abonado != de nulo y el codPlanServNuevo != codPlanServ del abonado 
									//O si el método que se debe ejecutar != registroCambPlanServ también se ejecuta .
									if((metodo.getAttributeValue("nombre").equalsIgnoreCase("registroCambPlanServ")&&(registro.getAbonado().getCodPlanServ()!=null&&!registro.getAbonado().getCodPlanServ().equalsIgnoreCase(registro.getParamRegistroPlan().getCodPlanServNuevo())))||(!metodo.getAttributeValue("nombre").equalsIgnoreCase("registroCambPlanServ"))){
										//Aqui se ejecuta el metodo declarado en el xml
										//	metodo   :Elemento que contiene informacion del metodo como nombre, atributos, tipos de datos, etc.
										//	registro :RegistroPlanDTO, contiene información que viene desde las paginas
										//	objeto   :ParamRegistroOrdenServicioDTO, contiene información que viene desde las paginas
										//	retorno  :DTO retornado por el metodo despues de su ejecución
										Object retorno = utilizaMetodo(metodo,registro, objeto); 
										cat.debug("Tipo de retorno del método ejecutado :"+ retorno.getClass().getName());
										if (retorno instanceof SecuenciaDTO){//las secuencias se dejan disponibles para ser usadas por otros metodos
											String nombreSecuencia = ((SecuenciaDTO)retorno).getNomSecuencia();
											Long valorSecuencia = new Long(((SecuenciaDTO)retorno).getNumSecuencia());
											datosExtra.put(nombreSecuencia, valorSecuencia);
											cat.debug("Guarda Secuencia :" + datosExtra.get(nombreSecuencia));
										}//fin if (retorno instanceof SecuenciaDTO)
									}//fin if((metodo.getAttributeValue("nombre")...
								}
							}//fin if (flgIterativo.equals("S"))
							
						}//fin for metodos
						
						//-------------------------------NOTIFICAR CABECERA Y DETALLE-------------------------------------------------------------
						EstadoProcesoOOSSDTO estPro = new EstadoProcesoOOSSDTO();
						estPro.setEstado("PROCESADO");
						estPro.setFechaActualizacion(new Date());
						estPro.setNumProceso(estadoProcesoOOSS.getNumProceso());
						DetEstadoProcesoOSSDTO[] detalles = new DetEstadoProcesoOSSDTO[1];
						DetEstadoProcesoOSSDTO detalle = new DetEstadoProcesoOSSDTO();
						detalle.setEstado("PROCESADO");
						detalle.setFecEstado(new Date());
						detalle.setNumProceso(estadoProcesoOOSS.getNumProceso());
						detalle.setNumOOSS(osAbonado.getAbonado().getNumeroOS());
						cat.debug("estPro.getEstado()[" + estPro.getEstado() + "]");
						cat.debug("estPro.getFechaActualizacion()[" + estPro.getFechaActualizacion() + "]");
						cat.debug("estPro.getNumProceso()[" + estPro.getNumProceso() + "]");
						cat.debug("detalle.getEstado()[" + detalle.getEstado() + "]");
						cat.debug("detalle.getFecEstado()[" + detalle.getFecEstado() + "]");
						cat.debug("detalle.getNumProceso()[" + detalle.getNumProceso() + "]");
						cat.debug("detalle.getNumOOSS()[" + detalle.getNumOOSS() + "]");
						detalles[0] = detalle;
						estPro.setDetEstadoProcesoOSSDTO(detalles);
						cat.debug("notificar():inicio");
						notificar(estPro);
						cat.debug("notificar():fin");
						//------------------------------FIN----------------------------------------------------------------------------------------
										
						osAbonados[nAbonados] = osAbonado;
						cat.debug("numAbonado="+osAbonado.getAbonado().getNumAbonado());
						cat.debug("numOS="+osAbonado.getNumOOSS());
						numIteraciones++;
						indiceAbonados++;
					}// fin for abonados
			
					registro.setOsAbonados(osAbonados);//guarda informacion de abonados y numeros de ooss
					objeto.setRegistroPlan(registro);
					
					//Ejecucion de metodos no iterativos
					for (int i = 0; i<arregloMetodos.size();i++){
						Element metodo = (Element)arregloMetodos.get(i);
			
						String flgIterativo = "S";
						if (metodo.getChild("Iterativo")!= null) flgIterativo =metodo.getChild("Iterativo").getText();
											
						if (flgIterativo.equals("N")){
								cat.debug("Método no iterativo que se ejecutará : "+ metodo.getAttributeValue("nombre"));
								Object retorno = utilizaMetodo(metodo,registro, objeto); 
								cat.debug("Tipo de retorno del método ejecutado :"+ retorno.getClass().getName());
								if (retorno instanceof SecuenciaDTO){
									String nombreSecuencia = ((SecuenciaDTO)retorno).getNomSecuencia();
									Long valorSecuencia = new Long(((SecuenciaDTO)retorno).getNumSecuencia());
									datosExtra.put(nombreSecuencia, valorSecuencia);
									cat.debug("Guarda Secuencia :" + datosExtra.get(nombreSecuencia));
								}//fin if (retorno instanceof SecuenciaDTO)
						}//fin if ((flgIterativo.equals("N"))
						
					}//fin for metodos
					//fin ejecucion de metodos no iterativos
					
				}//fin if (numBloque > 0)
					
			}//fin es empresa
			
			
			
			
			String comb = registro.getParamRegistroPlan().getCombinatoria()+registro.getParamRegistroPlan().getTipOOSS();
			boolean posPos7 = false;
			boolean posPos6 = false;
			boolean posPre8 = false;
			boolean hibpre8 = false;
			boolean prepre6 = false;
			boolean poshib6 = false;
			boolean hibpos6 = false;
			boolean hibhib6 = false;
			
			posPos7 = "POSPAGOPOSPAGO40007".equalsIgnoreCase(comb);
			posPos6 = "POSPAGOPOSPAGO40006".equalsIgnoreCase(comb);
			posPre8 = "POSPAGOPREPAGO40008".equalsIgnoreCase(comb);
			hibpre8 = "HIBRIDOPREPAGO40008".equalsIgnoreCase(comb);
			prepre6 = "PREPAGOPREPAGO40006".equalsIgnoreCase(comb);
			poshib6 = "POSPAGOHIBRIDO40006".equalsIgnoreCase(comb);
			hibpos6 = "HIBRIDOPOSPAGO40006".equalsIgnoreCase(comb);
			hibhib6 = "HIBRIDOHIBRIDO40006".equalsIgnoreCase(comb);
			
			//Si corresponde a una de las combinatorias de arriba no se debe ejecutar el 
			//método parametrosRegistrarCargos
			boolean ejecutarRegistroCargos = true;
			if(posPos7||posPos6||posPre8||hibpre8||prepre6||poshib6||hibpos6||hibhib6){
				ejecutarRegistroCargos = false;
			}
			if (objeto.getRegistroCargos()== null || objeto.getRegistroCargos().getOcacionales()==null){
				ejecutarRegistroCargos = false;
			}
			
			
			
			cat.debug("ejecutarRegistroCargos="+ejecutarRegistroCargos);
			
			// Obtener desde secuencias almacenadas el numero de abonado destino
			Long numAbonadoDest = null;
			Iterator it= datosExtra.entrySet().iterator();
			while (it.hasNext()){
				Map.Entry e = (Map.Entry)it.next();
				cat.debug("SECUENCIAS ALMACENADAS :"+ e.getKey()+ "  "+e.getValue());
				if(e.getKey().equals("GA_SEQ_NUMABO")){
					numAbonadoDest = (Long)e.getValue();
				}
			}
			
			if  (ejecutarRegistroCargos){
				
				if (combinatoriaRecibida.equals("PREPAGOPOSPAGO40006") || combinatoriaRecibida.equalsIgnoreCase("PREPAGOHIBRIDO40006")){
					// asignar ABONADO DESTINO a objeto de cargos
					cat.debug("numAbonadoDest :"+numAbonadoDest);
					objeto.getRegistroCargos().getOcacionales().setNumAbonado(String.valueOf(numAbonadoDest));
					for(int i=0;i<objeto.getRegistroCargos().getOcacionales().getCargos().length;i++){
						// setear el numero abonado destino en el objeto de tipo AtributosCargoDTO (dentro del arreglo Cargos[])
						objeto.getRegistroCargos().getOcacionales().getCargos()[i].getAtributo().setNumAbonado(String.valueOf(numAbonadoDest));
						// setear el numero abonado destino en el objeto de tipo AtributosMigracionDTO (dentro del arreglo Cargos[])
						objeto.getRegistroCargos().getOcacionales().getCargos()[i].getPrecio().getDatosAnexos().setNumAbonado(String.valueOf(numAbonadoDest));
					}
				}
				
				
				
				//RegCargosDTO retValConst=new RegCargosDTO();
				com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO retValConst = new com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegCargosDTO();
				com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO retValConstFrmk = new com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO();
				com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO obtCargos= new com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ObtencionCargosDTO();
				com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO obtCargosFrmk = new com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO(); 
				obtCargos = objeto.getRegistroCargos().getOcacionales();
				MapperIF mapper = new DozerBeanMapper();
				mapper.map(obtCargos, obtCargosFrmk);
				
				cat.debug("construirRegistroCargos():inicio");
				//retValConst=this.getManCusBilFacade().construirRegistroCargos(objeto.getRegistroCargos().getOcacionales());
				cat.debug("::::::::::PARAMETROS ENTRADA CONSTRUIR CARGOS::::::::");
				cat.debug(":::::::::::::::::::::::::::::::::::::::::::::::::::::");
				cat.debug("ObtencionCargosDTO");
				cat.debug("monto               :"+obtCargosFrmk.getMonto());
				cat.debug("tipo                :"+obtCargosFrmk.getTipo());
				cat.debug("codigoConcepto      :"+obtCargosFrmk.getCodigoConcepto());
				cat.debug("DescripcionConcepto :"+obtCargosFrmk.getDescripcionConcepto());
				cat.debug("MinDescuento        :"+obtCargosFrmk.getMinDescuento());
				cat.debug("MaxDescuento        :"+obtCargosFrmk.getMaxDescuento());
				cat.debug("TipoAplicacion      :"+obtCargosFrmk.getTipoAplicacion());
				cat.debug("NumAbonado          :"+obtCargosFrmk.getNumAbonado());
				cat.debug("Aprobacion          :"+obtCargosFrmk.isAprobacion());
				cat.debug("----------------------------------------------------------");
				cat.debug("CargosDTO");
				if (obtCargosFrmk.getCargos()!= null) {
					for(int i=0; i<obtCargosFrmk.getCargos().length;i++){
						cat.debug("IdProducto             :"+obtCargosFrmk.getCargos()[i].getIdProducto());
						cat.debug("Cantidad               :"+obtCargosFrmk.getCargos()[i].getCantidad());
						
						cat.debug("--------------------------------------------------------------------------");
						cat.debug("AtributosCargoDTO");
						cat.debug("getAtributo().getCuotas()            :"+obtCargosFrmk.getCargos()[i].getAtributo().getCuotas());
						cat.debug("getAtributo().getFechaAplicacion()   :"+obtCargosFrmk.getCargos()[i].getAtributo().getFechaAplicacion());
						cat.debug("getAtributo().getTipoProducto()      :"+obtCargosFrmk.getCargos()[i].getAtributo().getTipoProducto());
						cat.debug("getAtributo().getClaseProducto()     :"+obtCargosFrmk.getCargos()[i].getAtributo().getClaseProducto());
						cat.debug("getAtributo().getCicloFacturacion()  :"+obtCargosFrmk.getCargos()[i].getAtributo().getCicloFacturacion());
						cat.debug("getAtributo().getCodigoArticuloServicio() :"+obtCargosFrmk.getCargos()[i].getAtributo().getCodigoArticuloServicio());
						cat.debug("getAtributo().getNumAbonado()             :"+obtCargosFrmk.getCargos()[i].getAtributo().getNumAbonado());
						cat.debug("getAtributo().isRecurrente()              :"+obtCargosFrmk.getCargos()[i].getAtributo().isRecurrente());
						cat.debug("getAtributo().isObligatorio()             :"+obtCargosFrmk.getCargos()[i].getAtributo().isObligatorio());
						cat.debug("getAtributo().isCiclo()                   :"+obtCargosFrmk.getCargos()[i].getAtributo().isCiclo());
						
						cat.debug("--------------------------------------------------------------------------");
						cat.debug("PrecioDTO");
						cat.debug("getPrecio().getMonto()               :"+obtCargosFrmk.getCargos()[i].getPrecio().getMonto());
						cat.debug("getPrecio().getCodigoConcepto()      :"+obtCargosFrmk.getCargos()[i].getPrecio().getCodigoConcepto());
						cat.debug("getPrecio().getDescripcionConcepto() :"+obtCargosFrmk.getCargos()[i].getPrecio().getDescripcionConcepto());
						cat.debug("getPrecio().getFechaAplicacion()     :"+obtCargosFrmk.getCargos()[i].getPrecio().getFechaAplicacion());
						cat.debug("getPrecio().getValorMaximo()         :"+obtCargosFrmk.getCargos()[i].getPrecio().getValorMaximo());
						cat.debug("getPrecio().getValorMinimo()         :"+obtCargosFrmk.getCargos()[i].getPrecio().getValorMinimo());
						cat.debug("getPrecio().getIndicadorAutMan()     :"+obtCargosFrmk.getCargos()[i].getPrecio().getIndicadorAutMan());
						
						cat.debug("--------------------------------------------------------------------------");
						cat.debug("AtributosMigracionDTO");
						cat.debug("getPrecio().getDatosAnexos().getInd_paquete() :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getInd_paquete());
						cat.debug("getPrecio().getDatosAnexos().getInd_cuota()   :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getInd_cuota());
						cat.debug("getPrecio().getDatosAnexos().getInd_equipo()  :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getInd_equipo());
						cat.debug("getPrecio().getDatosAnexos().getCod_tecnologia() :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getCod_tecnologia());
						cat.debug("getPrecio().getDatosAnexos().getCodTipPlantarifOrig() :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getCodTipPlantarifOrig());
						cat.debug("getPrecio().getDatosAnexos().getCodTipPlantarifDes()  :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getCodTipPlantarifDes());
						cat.debug("getPrecio().getDatosAnexos().getNumAbonado()          :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getNumAbonado());
						cat.debug("getPrecio().getDatosAnexos().getNumeroCelular()       :"+obtCargosFrmk.getCargos()[i].getPrecio().getDatosAnexos().getNumeroCelular());
						
						cat.debug("--------------------------------------------------------------------------");
						cat.debug("MonedaDTO");
						cat.debug("getPrecio().getUnidad().getCodigo()      :"+obtCargosFrmk.getCargos()[i].getPrecio().getUnidad().getCodigo());
						cat.debug("getPrecio().getUnidad().getDescripcion() :"+obtCargosFrmk.getCargos()[i].getPrecio().getUnidad().getDescripcion());
						if (obtCargosFrmk.getCargos()[i].getDescuento()!=null){
							for(int j=0; j<obtCargosFrmk.getCargos()[i].getDescuento().length;j++){
								cat.debug("=============================================================================");
								cat.debug("DescuentoDTO");
								cat.debug("Monto       :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getMonto());
								cat.debug("Tipo        :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getTipo());
								cat.debug("CodigoConceptoCargo :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getCodigoConceptoCargo());
								cat.debug("CodigoConcepto      :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getCodigoConcepto());
								cat.debug("DescripcionConcepto :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getDescripcionConcepto());
								cat.debug("MinDescuento        : :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getMinDescuento());
								cat.debug("MaxDescuento        :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getMaxDescuento());
								cat.debug("TipoAplicacion      :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getTipoAplicacion());
								cat.debug("MontoCalculado      :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getMontoCalculado());
								cat.debug("CodigoMoneda        :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getCodigoMoneda());
								cat.debug("NumTransaccion      :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].getNumTransaccion());
								cat.debug("isAprobacion()      :"+obtCargosFrmk.getCargos()[i].getDescuento()[j].isAprobacion());
							}
							
						} // del if (descuentos)
					
				} //del for de imprimir
					
				}  // del if (cargos)

				retValConstFrmk = this.getFrmkCargosFacade().construirRegistroCargos(obtCargosFrmk);
				MapperIF mapper2 = new DozerBeanMapper();
				mapper2.map(retValConstFrmk, retValConst);
				cat.debug("construirRegistroCargos():fin");
				CabeceraArchivoDTO objetoSesion=new CabeceraArchivoDTO();
				
				objetoSesion.setPlanComercialCliente(String.valueOf(objeto.getRegistroPlan().getCliente().getCodPlanCom()));
				objetoSesion.setCodigoCliente(String.valueOf(objeto.getRegistroPlan().getCliente().getCodCliente()));
				objetoSesion.setFacturaCiclo(true);
				objetoSesion.setNumeroVenta(0);
				objetoSesion.setNumeroTransaccionVenta(0);
				objetoSesion.setCodigoDocumento(objeto.getRegistroPlan().getParamRegistroPlan().getCodTipoDocumento());
				objetoSesion.setCodModalidadVenta(objeto.getRegistroPlan().getParamRegistroPlan().getModPago());
							
				//TODO : Obtener vendedor
				UsuarioDTO usuario = new UsuarioDTO();
		        usuario.setNombre(registro.getParamRegistroPlan().getNomUsuaOra());
		        usuario = getSupOrdHanFacade().obtenerVendedor(usuario);
				objetoSesion.setCodigoVendedor(String.valueOf(usuario.getCodigo()));
				objetoSesion.setNombreUsuario(usuario.getNombre());
				
				retValConst.setObjetoSesion(objetoSesion);
				com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO retValConstFrmk2 = new com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO(); 
				MapperIF mapper3 = new DozerBeanMapper();
				mapper3.map(retValConst, retValConstFrmk2);
				com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO resultadoFrmk = new com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO();
				cat.debug("parametrosRegistrarCargos():inicio");
				//ResultadoRegCargosDTO resultado = this.getManCusBilFacade().parametrosRegistrarCargos(retValConst);
				
				// para las combinatorias señaladas (reordenamiento), asignar el numero de cliente destino
				if (combinatoriaRecibida.equalsIgnoreCase("POSPAGOPOSPAGO40008") || combinatoriaRecibida.equalsIgnoreCase("POSPAGOHIBRIDO40008") || 
					combinatoriaRecibida.equalsIgnoreCase("HIBRIDOPOSPAGO40008") || combinatoriaRecibida.equalsIgnoreCase("HIBRIDOHIBRIDO40008") ||
					combinatoriaRecibida.equalsIgnoreCase("PREPAGOPOSPAGO40006") || combinatoriaRecibida.equalsIgnoreCase("PREPAGOHIBRIDO40006")){
					long codClienteDestino = objeto.getRegistroPlan().getParamRegistroPlan().getCodClienteDestino();
					retValConstFrmk2.getObjetoSesion().setCodigoCliente(String.valueOf(codClienteDestino));
				}
				
				
				//comentado por EV 03/05/2010, este codigo no es valido para guatemala, salvador
				/*
				ClienteDTO cliDest = new ClienteDTO();
				cliDest.setCodCliente(Long.parseLong(retValConstFrmk2.getObjetoSesion().getCodigoCliente()));
				cat.debug("clienteDest[" + cliDest.getCodCliente() + "]");
				cat.debug("obtenerDatosCliente():inicio");
				cliDest = getManConFacade().obtenerDatosCliente(cliDest);
				cat.debug("obtenerDatosCliente():fin");
				cat.debug("CodTipoPlanTarif[" + cliDest.getCodTipoPlanTarif() + "]");
				cat.debug("TipOOSS()[" + objeto.getRegistroPlan().getParamRegistroPlan().getTipOOSS() + "]");
			
				if (cliDest.getCodTipoPlanTarif()!= null && objeto.getRegistroPlan().getParamRegistroPlan().getTipOOSS()!=null){
					if((cliDest.getCodTipoPlanTarif().equals("E") && objeto.getRegistroPlan().getParamRegistroPlan().getTipOOSS().equals("40008"))){
						for(int i=0; i<retValConstFrmk2.getCargos().length;i++){
							retValConstFrmk2.getCargos()[i].setNumAbonado("0");
						}
					}
				}*/
				
				
				
				
				//-------------inicio log------------------------
				cat.debug("PARAMETROS ENTRADA A REGISTRAR CARGOS");
				cat.debug(":::::::::::::::::::::::::::::::::::::");
				
				cat.debug("RegCargosDTO");
				cat.debug("---------------------------------------------------------------------------------");
				cat.debug("PuntoDesctoInferior   :"+retValConstFrmk2.getPuntoDesctoInferior());
				cat.debug("PuntoDesctoSuperior   :"+retValConstFrmk2.getPuntoDesctoSuperior());
				cat.debug("PorcentajeDesctoInferior :"+retValConstFrmk2.getPorcentajeDesctoInferior());
				cat.debug("PorcentajeDesctoSuperior :"+retValConstFrmk2.getPorcentajeDesctoSuperior());
				cat.debug("AplicaDescuentoVendedor  :"+retValConstFrmk2.isAplicaDescuentoVendedor());
				cat.debug("AplicaTipoCargo          :"+retValConstFrmk2.isAplicaTipoCargo());
				
				cat.debug("---------------------------------------------------------------------------------");
				cat.debug("CabeceraArchivoDTO");
				cat.debug("getObjetoSesion().getCodigoOperadora()        :"+retValConstFrmk2.getObjetoSesion().getCodigoOperadora());
				cat.debug("getObjetoSesion().getCodigoVendedorRaiz()     :"+retValConstFrmk2.getObjetoSesion().getCodigoVendedorRaiz());
				cat.debug("getObjetoSesion().getCodigoVenDealer()        :"+retValConstFrmk2.getObjetoSesion().getCodigoVenDealer());
				cat.debug("getObjetoSesion().getIndicadorTipoVenta()     :"+retValConstFrmk2.getObjetoSesion().getIndicadorTipoVenta());
				cat.debug("getObjetoSesion().getCodigoCliente()          :"+retValConstFrmk2.getObjetoSesion().getCodigoCliente());
				cat.debug("getObjetoSesion().getCodigoTipoIdentificacion()  :"+retValConstFrmk2.getObjetoSesion().getCodigoTipoIdentificacion());
				cat.debug("getObjetoSesion().getNumeroIdentificacion()      :"+retValConstFrmk2.getObjetoSesion().getNumeroIdentificacion());
				cat.debug("getObjetoSesion().getNombreCliente()             :"+retValConstFrmk2.getObjetoSesion().getNombreCliente());
				cat.debug("getObjetoSesion().getCodigoCuentaCliente()       :"+retValConstFrmk2.getObjetoSesion().getCodigoCuentaCliente());
				cat.debug("getObjetoSesion().getCodigoSubCuentaCliente()    :"+retValConstFrmk2.getObjetoSesion().getCodigoSubCuentaCliente());
				cat.debug("getObjetoSesion().getNombreApellido1Cliente()    :"+retValConstFrmk2.getObjetoSesion().getNombreApellido1Cliente());
				cat.debug("getObjetoSesion().getNombreApellido2Cliente()    :"+retValConstFrmk2.getObjetoSesion().getNombreApellido2Cliente());
				cat.debug("getObjetoSesion().getIndicadorEstadoCivilCliente() :"+retValConstFrmk2.getObjetoSesion().getIndicadorEstadoCivilCliente());
				cat.debug("getObjetoSesion().getIndicadorSexoCliente()        :"+retValConstFrmk2.getObjetoSesion().getIndicadorSexoCliente());
				cat.debug("getObjetoSesion().getCodigoActividadCliente()      :"+retValConstFrmk2.getObjetoSesion().getCodigoActividadCliente());
				cat.debug("getObjetoSesion().getTipoCliente()                 :"+retValConstFrmk2.getObjetoSesion().getTipoCliente());
				cat.debug("getObjetoSesion().getCodigoCeldaCliente()          :"+retValConstFrmk2.getObjetoSesion().getCodigoCeldaCliente());
				cat.debug("getObjetoSesion().getCodigoCalidadCliente()        :"+retValConstFrmk2.getObjetoSesion().getCodigoCalidadCliente());
				cat.debug("getObjetoSesion().getIndicativoFacturableCliente() :"+retValConstFrmk2.getObjetoSesion().getIndicativoFacturableCliente());
				cat.debug("getObjetoSesion().getCodigoCicloCliente()          :"+retValConstFrmk2.getObjetoSesion().getCodigoCicloCliente());
				cat.debug("getObjetoSesion().getCodigoEmpresa()               :"+retValConstFrmk2.getObjetoSesion().getCodigoEmpresa());
				cat.debug("getObjetoSesion().getCodigoDealer()                :"+retValConstFrmk2.getObjetoSesion().getCodigoDealer());
				cat.debug("getObjetoSesion().getCodigoVendedor()              :"+retValConstFrmk2.getObjetoSesion().getCodigoVendedor());
				cat.debug("getObjetoSesion().getOficinaVendedor()             :"+retValConstFrmk2.getObjetoSesion().getOficinaVendedor());
				cat.debug("getObjetoSesion().getIdentificadorEmpresa()        :"+retValConstFrmk2.getObjetoSesion().getIdentificadorEmpresa());
				cat.debug("getObjetoSesion().getNombreUsuario()               :"+retValConstFrmk2.getObjetoSesion().getNombreUsuario());
				cat.debug("getObjetoSesion().getNombreArchivo()               :"+retValConstFrmk2.getObjetoSesion().getNombreArchivo());
				cat.debug("getObjetoSesion().getNumeroSeries()                :"+retValConstFrmk2.getObjetoSesion().getNumeroSeries());
				cat.debug("getObjetoSesion().getParametroCalCliente()         :"+retValConstFrmk2.getObjetoSesion().getParametroCalCliente());
				cat.debug("getObjetoSesion().getParametroCodigoAbc()          :"+retValConstFrmk2.getObjetoSesion().getParametroCodigoAbc());
				cat.debug("getObjetoSesion().getParametroCodigo123()          :"+retValConstFrmk2.getObjetoSesion().getParametroCodigo123());
				cat.debug("getObjetoSesion().getParametroCodigoEstadoCobros() :"+retValConstFrmk2.getObjetoSesion().getParametroCodigoEstadoCobros());
				cat.debug("getObjetoSesion().getParametroCodigoSimcardGSM()   :"+retValConstFrmk2.getObjetoSesion().getParametroCodigoSimcardGSM());
				cat.debug("getObjetoSesion().getParametroCodigoTerminalGSM()  :"+retValConstFrmk2.getObjetoSesion().getParametroCodigoTerminalGSM());
				cat.debug("getObjetoSesion().getPlanComercialCliente()        :"+retValConstFrmk2.getObjetoSesion().getPlanComercialCliente());
				cat.debug("getObjetoSesion().getTipoPlanPostpago()            :"+retValConstFrmk2.getObjetoSesion().getTipoPlanPostpago());
				cat.debug("getObjetoSesion().getTipoPlanHibrido()             :"+retValConstFrmk2.getObjetoSesion().getTipoPlanHibrido());
				cat.debug("getObjetoSesion().getCodigoDocumento()             :"+retValConstFrmk2.getObjetoSesion().getCodigoDocumento());
				cat.debug("getObjetoSesion().getCategoriaTributaria()         :"+retValConstFrmk2.getObjetoSesion().getCategoriaTributaria());
				cat.debug("getObjetoSesion().getTipoFoliacion()               :"+retValConstFrmk2.getObjetoSesion().getTipoFoliacion());
				cat.debug("getObjetoSesion().getTotalImpuestoVenta()          :"+retValConstFrmk2.getObjetoSesion().getTotalImpuestoVenta());
				cat.debug("getObjetoSesion().getTotalCargosVenta()            :"+retValConstFrmk2.getObjetoSesion().getTotalCargosVenta());
				cat.debug("getObjetoSesion().getTotalDescuentosVenta()        :"+retValConstFrmk2.getObjetoSesion().getTotalDescuentosVenta());
				cat.debug("getObjetoSesion().isFacturaCiclo()                 :"+retValConstFrmk2.getObjetoSesion().isFacturaCiclo());
				cat.debug("getObjetoSesion().getCodigoFormaPago()             :"+retValConstFrmk2.getObjetoSesion().getCodigoFormaPago());
				cat.debug("getObjetoSesion().getNumeroProcesoFacturacion()    :"+retValConstFrmk2.getObjetoSesion().getNumeroProcesoFacturacion());
				cat.debug("getObjetoSesion().isPrebillingOK()                 :"+retValConstFrmk2.getObjetoSesion().isPrebillingOK());
				cat.debug("getObjetoSesion().getNumeroVenta()                 :"+retValConstFrmk2.getObjetoSesion().getNumeroVenta());
				cat.debug("getObjetoSesion().getNumeroTransaccionVenta()      :"+retValConstFrmk2.getObjetoSesion().getNumeroTransaccionVenta());
				cat.debug("getObjetoSesion().getMontoGarantia()               :"+retValConstFrmk2.getObjetoSesion().getMontoGarantia());
				cat.debug("getObjetoSesion().getTipoVentaOficinaTerreno()     :"+retValConstFrmk2.getObjetoSesion().getTipoVentaOficinaTerreno());
				cat.debug("getObjetoSesion().getTotalPresupuestoVenta()       :"+retValConstFrmk2.getObjetoSesion().getTotalPresupuestoVenta());
				cat.debug("getObjetoSesion().getDecimalesFormulario()         :"+retValConstFrmk2.getObjetoSesion().getDecimalesFormulario());
				cat.debug("getObjetoSesion().getDecimalesBD()                 :"+retValConstFrmk2.getObjetoSesion().getDecimalesBD());
				cat.debug("getObjetoSesion().getDecimalesPorcentajeDescuento() :"+retValConstFrmk2.getObjetoSesion().getDecimalesPorcentajeDescuento());
				cat.debug("getObjetoSesion().getTipoPlanTarifario()            :"+retValConstFrmk2.getObjetoSesion().getTipoPlanTarifario());
				cat.debug("getObjetoSesion().getCodModalidadVenta()            :"+retValConstFrmk2.getObjetoSesion().getCodModalidadVenta());
				cat.debug("---------------------------------------------------------------------------------");
				if (retValConstFrmk2.getCargos()!=null) {
					for(int i=0; i<retValConstFrmk2.getCargos().length;i++){
						cat.debug("CargoFrameworkCargosDTO[" + i + "]");
						cat.debug("-----------------------------------------------------");
						cat.debug("getTipoProducto()     :"+retValConstFrmk2.getCargos()[i].getTipoProducto());
						cat.debug("getIdProducto()       :"+retValConstFrmk2.getCargos()[i].getIdProducto());
						cat.debug("getCantidad()         :"+retValConstFrmk2.getCargos()[i].getCantidad());
						cat.debug("getCodigoDescuento()  :"+retValConstFrmk2.getCargos()[i].getCodigoDescuento());
						cat.debug("getDescripcionDescuento() :"+retValConstFrmk2.getCargos()[i].getDescripcionDescuento());
						cat.debug("getTipoDescuento()        :"+retValConstFrmk2.getCargos()[i].getTipoDescuento());
						cat.debug("getMontoDescuento()       :"+retValConstFrmk2.getCargos()[i].getMontoDescuento());
						cat.debug("getDescuentoManual()      :"+retValConstFrmk2.getCargos()[i].getDescuentoManual());
						cat.debug("getTipoDescuentoManual()  :"+retValConstFrmk2.getCargos()[i].getTipoDescuentoManual());
						cat.debug("getMontoDescuentoManual() :"+retValConstFrmk2.getCargos()[i].getMontoDescuentoManual());
						cat.debug("getCodigoConceptoPrecio() :"+retValConstFrmk2.getCargos()[i].getCodigoConceptoPrecio());
						cat.debug("getDescripcionConceptoPrecio() :"+retValConstFrmk2.getCargos()[i].getDescripcionConceptoPrecio());
						cat.debug("getClase()                     :"+retValConstFrmk2.getCargos()[i].getClase());
						cat.debug("getCodigoMoneda()              :"+retValConstFrmk2.getCargos()[i].getCodigoMoneda());
						cat.debug("getMontoConceptoPrecio()       :"+retValConstFrmk2.getCargos()[i].getMontoConceptoPrecio());
						cat.debug("getMontoConceptoTotal()        :"+retValConstFrmk2.getCargos()[i].getMontoConceptoTotal());
						cat.debug("getSaldoUnitario()             :"+retValConstFrmk2.getCargos()[i].getSaldoUnitario());
						cat.debug("getSaldoTotal()                :"+retValConstFrmk2.getCargos()[i].getSaldoTotal());
						cat.debug("getDescripcionMoneda()         :"+retValConstFrmk2.getCargos()[i].getDescripcionMoneda());
						cat.debug("getInd_paquete()               :"+retValConstFrmk2.getCargos()[i].getInd_paquete());
						cat.debug("getInd_cuota()                 :"+retValConstFrmk2.getCargos()[i].getInd_cuota());
						cat.debug("getInd_equipo()                :"+retValConstFrmk2.getCargos()[i].getInd_equipo());
						cat.debug("getCod_tecnologia()            :"+retValConstFrmk2.getCargos()[i].getCod_tecnologia());
						cat.debug("getCodigoArticuloServicio()    :"+retValConstFrmk2.getCargos()[i].getCodigoArticuloServicio());
						cat.debug("getTipoCargo()                 :"+retValConstFrmk2.getCargos()[i].getTipoCargo());
						cat.debug("getNumAbonado()                :"+retValConstFrmk2.getCargos()[i].getNumAbonado());
						cat.debug("getDescCPUCargo()              :"+retValConstFrmk2.getCargos()[i].getDescCPUCargo());
					}
					
				}
				
				
				//--------------------------------fin log -------------------------------------------------------
											
				resultadoFrmk = this.getFrmkCargosFacade().parametrosRegistrarCargos(retValConstFrmk2);
				cat.debug("parametrosRegistrarCargos():fin");

			}
			
			
		}catch(Exception e){
			/*090709 pv */
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("Exception CambioPlanUnificadoOSAsinORC [" + loge + "]");
			/*090709 pv */
			if (e.getCause() != null && e.getCause() instanceof GeneralException ) {
				GeneralException ex = (GeneralException)e.getCause();
				throw new IssCusOrdException(ex.getCodigo(), ex.getCodigoEvento(), ex.getDescripcionEvento());
			}
			else {
				if(e instanceof GeneralException){
					
					throw new IssCusOrdException(e);
				}else if (e instanceof RemoteException){
					
					throw new IssCusOrdException(e);
				}else if(e instanceof Exception){
					IssCusOrdException ex = new IssCusOrdException();
					ex.setCodigo("-1");
					ex.setCodigoEvento(0);
					ex.setDescripcionEvento("Ocurrio un error general en el proceso");
					throw new IssCusOrdException(ex.getCodigo(), ex.getCodigoEvento(), ex.getDescripcionEvento());
				}
				
			}
		}
			
		cat.debug("registroOrden():end");

	}

	/**
	 * Verifica si la combinatoria dada es masiva o no
	 * @param combinatoriaRecibida
	 * @return
	 */
	private boolean verificarCombinatoriaMasiva(String combinatoriaRecibida) {
		cat.debug("verificarCombinatoriaMasiva():start");
		Global global = Global.getInstance();
		
		// Estas combinatorias pueden ser masivas
		// verifica si la combinatoria actual cae dentro de alguna combinatoria
		// masiva

		String POSPOSPUN = global.getValor("POSPOSPUN");
		cat.debug("POSPOSPUN[" + POSPOSPUN + "]");

		String POSPREPUN = global.getValor("POSPREPUN");
		cat.debug("POSPREPUN[" + POSPREPUN + "]");

		String HIBPREPUN = global.getValor("HIBPREPUN");
		cat.debug("HIBPREPUN[" + HIBPREPUN + "]");
		
		String prepre40006 = global.getValor("prepre40006");
		cat.debug("prepre40006[" + prepre40006 + "]");	
		
		String prepos40006 = global.getValor("prepos40006");
		cat.debug("prepos40006[" + prepos40006 + "]");
		
		String prehib40006 = global.getValor("prehib40006");
		cat.debug("prehib40006[" + prehib40006 + "]");
		
		String hibhib40006 = global.getValor("hibhib40006");
		cat.debug("hibhib40006[" + hibhib40006 + "]");		
		
		String hibpos40006 = global.getValor("hibpos40006");
		cat.debug("hibpos40006[" + hibpos40006 + "]");		
		
		String hibpre40006 = global.getValor("hibpre40006");
		cat.debug("hibpre40006[" + hibpre40006 + "]");	
		
		String pospos40006 = global.getValor("pospos40006");
		cat.debug("pospos40006[" + pospos40006 + "]");	
		
		String poshib40006 = global.getValor("poshib40006");
		cat.debug("poshib40006[" + poshib40006 + "]");	
		
		String pospre40006 = global.getValor("pospre40006");
		cat.debug("pospre40006[" + pospre40006 + "]");		
		
		String pospos40007 = global.getValor("pospos40007");
		cat.debug("pospos40007[" + pospos40007 + "]");

		String pospre40008 = global.getValor("pospre40008");
		cat.debug("pospre40008[" + pospre40008 + "]");
		
		String hibpre40008 = global.getValor("hibpre40008");
		cat.debug("hibpre40008[" + hibpre40008 + "]");
		
		String pospos40008 = global.getValor("pospos40008");
		cat.debug("pospos40008[" + pospos40008 + "]");
		
		String hibhib40008 = global.getValor("hibhib40008");
		cat.debug("hibhib40008[" + hibhib40008 + "]");

		String hibpos40008 = global.getValor("hibpos40008");
		cat.debug("hibpos40008[" + hibpos40008 + "]");
		
		String poshib40008 = global.getValor("poshib40008");
		cat.debug("poshib40008[" + poshib40008 + "]");
		
		// Bandera que indica si la combinatoria recibida en una de
		// las combinatorias que pueden ser masivas
		boolean masiva = false;

		// Averigua si una de las combinatorias es masiva
		if (POSPOSPUN.equalsIgnoreCase(combinatoriaRecibida)
				|| POSPREPUN.equalsIgnoreCase(combinatoriaRecibida)
				|| HIBPREPUN.equalsIgnoreCase(combinatoriaRecibida)
				|| prepre40006.equalsIgnoreCase(combinatoriaRecibida)
				|| prepos40006.equalsIgnoreCase(combinatoriaRecibida)
				|| prehib40006.equalsIgnoreCase(combinatoriaRecibida)
				|| hibhib40006.equalsIgnoreCase(combinatoriaRecibida)
				|| hibpos40006.equalsIgnoreCase(combinatoriaRecibida)
				|| hibpre40006.equalsIgnoreCase(combinatoriaRecibida)
				|| pospos40006.equalsIgnoreCase(combinatoriaRecibida)
				|| poshib40006.equalsIgnoreCase(combinatoriaRecibida)
				|| pospre40006.equalsIgnoreCase(combinatoriaRecibida)
				|| pospos40007.equalsIgnoreCase(combinatoriaRecibida)
				|| pospre40008.equalsIgnoreCase(combinatoriaRecibida)
				|| hibpre40008.equalsIgnoreCase(combinatoriaRecibida)
				|| pospos40008.equalsIgnoreCase(combinatoriaRecibida)
				|| hibhib40008.equalsIgnoreCase(combinatoriaRecibida)
				|| hibpos40008.equalsIgnoreCase(combinatoriaRecibida)
				|| poshib40008.equalsIgnoreCase(combinatoriaRecibida)
				) 
		{

			cat.debug("Combinatoria Masiva");
			masiva = true;
		}
		
		cat.debug(" masiva[" + masiva + "]");
		cat.debug("verificarCombinatoriaMasiva():start");
		return masiva;
	}


	/**
	 * Ejecuta el método descrito en el objeto "metodo".
	 * 
	 * @param metodo Element que contiene toda la información referente al método que se quiere ejecutar.
	 * @param registro Objeto que ha sido encolado, el cual contiene todos los datos necesarios para crear el DTO que utiliza el método que se invocará.
	 * @return Object que retorna el método que fué invocado(Se debe hacer Cast al tipo que retorna originalmente el método para ver su resultado).
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 * @throws ClassNotFoundException
	 * @throws SecurityException
	 * @throws IllegalArgumentException
	 * @throws InvocationTargetException
	 * @throws NoSuchFieldException
	 * @throws NoSuchMethodException
	 * @throws RemoteException 
	 * @throws SupOrdHanException 
	 * @throws ProyectoException
	 */
	private Object utilizaMetodo(Element metodo, RegistroPlanDTO registro, ParamRegistroOrdenServicioDTO objetoCompleto) throws InstantiationException, IllegalAccessException, ClassNotFoundException, SecurityException, IllegalArgumentException, InvocationTargetException, NoSuchFieldException, NoSuchMethodException, IssCusOrdException, SupOrdHanException, RemoteException{	
		cat.debug("utilizaMetodo():start");
		//Arreglo de tipos de datos que recibe el método que se invocará
		Class tiposEntrada[]=null;
		//Arreglo de parametros que recibe el método que se invocará
		Object arrayObject[]=null;

		if (metodo.getChild("DTOEntrada")!= null){
			if(metodo.getChildText("DTOEntrada").equalsIgnoreCase("com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntegraProdCPUDTO")){
				arrayObject= new Object[2];
				tiposEntrada= new Class[2];
				arrayObject[0]= Class.forName(metodo.getChild("DTOEntrada").getText()).newInstance();
				arrayObject[0] = llenarParametros(arrayObject[0],metodo, registro, objetoCompleto);
			}else{
				arrayObject= new Object[1];
				tiposEntrada= new Class[1];
				arrayObject[0]= Class.forName(metodo.getChild("DTOEntrada").getText()).newInstance();
				arrayObject[0] = llenarParametros (arrayObject[0],metodo, registro, objetoCompleto);
				tiposEntrada[0] = arrayObject[0].getClass();
			}

		}
		Object retornod = null;
		if(metodo.getChildText("DTOEntrada").equalsIgnoreCase("com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.IntegraProdCPUDTO")){
			integracionProdCPU = (IntegraProdCPUDTO[])getSupOrdHanFacade().creaEstructuraProdCPU((IntegraProdCPUDTO)arrayObject[0], integracionProdCPU);
			retornod = integracionProdCPU;
		}else{
			Object fachada = obtenerFacade(metodo);
			cat.debug(fachada.getClass().getName());
			retornod = (fachada.getClass()).getMethod(metodo.getAttributeValue("nombre"), tiposEntrada).invoke(fachada, arrayObject);
			//Si es registroReordenamientoAbonados entonces debe rescatar los datos retornados
			//ya que estos son requeridos para la integración CPU-Producto
			if(metodo.getAttributeValue("nombre").equals("registroReordenamientoAbonados")){
				IntegraProdCPUListDTO listaProd= retornod!=null?(IntegraProdCPUListDTO)retornod:null;
				integracionProdCPU = listaProd.getLista();
			}
		}

		if((Element)metodo.getChild("Almacenar")!=null){
			cat.debug("-Almacenar-");
			for(int i = 0; i<metodo.getChild("Almacenar").getChildren().size();i++){
				String origen =((Element)metodo.getChild("Almacenar").getChildren().get(i)).getChildText("Origen");
				String destino = ((Element)metodo.getChild("Almacenar").getChildren().get(i)).getChildText("Destino");
				cat.debug("-origen="+origen);
				cat.debug("-destino="+destino);

				String secuencia = ((Element)metodo.getChild("Almacenar").getChildren().get(i)).getChildText("Secuencia");
				if(secuencia!=null){
					cat.debug("-secuencia="+secuencia);
					String nombreSecuencia = ((Element)metodo.getChild("Almacenar").getChildren().get(i)).getChildText("Secuencia");
					String valorSecuencia = String.valueOf(datosExtra.get(nombreSecuencia));
					cat.debug("valorSecuencia ="+valorSecuencia);
					origen = String.valueOf(valorSecuencia);
					
					datosExtra.put(destino, origen);
					
				}else{
					guardarDatosExtra(retornod,origen,destino);
				}
			}
		}

		cat.debug("utilizaMetodo():end");
		return retornod;

	}

	private void guardarDatosExtra(Object objeto, String origen, String destino) throws IllegalArgumentException, SecurityException, IllegalAccessException, InvocationTargetException, NoSuchMethodException{
		cat.debug("guardarDatosExtra="+objeto.getClass().getMethod(origen, null).invoke(objeto, null));
		datosExtra.put(destino, objeto.getClass().getMethod(origen, null).invoke(objeto, null));
	}


	/**
	 * Obtiene una instancia de la fachada descrita en el objeto "metodo" que tiene como entrada.
	 * 
	 * @param metodo Element que contiene toda la información referente al método que se quiere ejecutar (EJ: Parametros de entrada, salida, ubicación de la fachada, etc )
	 * @return Instancia de la fachada que contiene el método que se ejecutará.
	 * @throws ProyectoException
	 * @throws ClassNotFoundException
	 */
	private Object obtenerFacade(Element metodo) throws IssCusOrdException, ClassNotFoundException{
		cat.debug("obtenerFacade():start");
		Global global = Global.getInstance();
		String initialContextFactory = global.getValor(metodo.getChild("ContextFactory").getText());
		String jndi = global.getValor(metodo.getChild("JNDI").getText());
		String url = global.getValor(metodo.getChild("URL").getText());
		String securityPrincipal = global.getValor(metodo.getChild("SecurityPrincipal").getText());
		String securityCredentials = global.getValor(metodo.getChild("SecurityCredentials").getText());
		cat.debug(initialContextFactory);
		cat.debug(jndi);
		cat.debug(url);
		cat.debug(securityPrincipal);
		cat.debug(securityCredentials);
		Object facadeHome;
		try {
			facadeHome = ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,
					jndi, securityPrincipal, securityCredentials, Class.forName(metodo.getChild("FacadeHome").getText()));
			cat.debug("Recuperada la interfaz home de " +jndi);
		} catch (ServiceLocatorException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}
		Object facade = null;
		try {
			facade = facadeHome.getClass().getMethod("create", null).invoke(facadeHome,null);
		} catch (Exception e) {
			if (e instanceof CreateException){
				String loge = StackTraceUtl.getStackTrace(e);
				cat.debug("CreateException[" + loge + "]");
				throw new IssCusOrdException(e);
			}
			if (e instanceof RemoteException){
				String loge = StackTraceUtl.getStackTrace(e);
				cat.debug("RemoteException[" + loge + "]");
				throw new IssCusOrdException(e);
			}
			if (e instanceof Exception){
				String loge = StackTraceUtl.getStackTrace(e);
				cat.debug("Exception[" + loge + "]");
				throw new IssCusOrdException(e);
			}
		}
		cat.debug("obtenerFacade():end");
		return facade;
	}

	/**
	 * Se encarga de llenar el objeto DTO que se utilizará para invocar un método determinado 
	 * 
	 * @param objeto Es la instancia del objeto DTO al que se le setean los parametros.
	 * @param metodo Contiene todoa la información referente al método que se quiere utilizar (EJ: Tipo de parametro entrada, salida, y con qué parametros se debe llenar el DTO que utiliza). 
	 * @param registro Objeto que fué encolado y contiene los datos necesarios para llenar el DTO de entrada al método que se quiere utilizar.
	 * @return La instancia del objeto DTO con sus parametros necesarios llenos.
	 * @throws SecurityException
	 * @throws ClassNotFoundException
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 * @throws NoSuchFieldException
	 * @throws InstantiationException
	 * @throws NoSuchMethodException
	 */
	private Object llenarParametros(Object objeto, Element metodo, RegistroPlanDTO registro, ParamRegistroOrdenServicioDTO objetoCompelto) throws SecurityException, ClassNotFoundException, IllegalArgumentException, IllegalAccessException, InvocationTargetException, NoSuchFieldException, InstantiationException, NoSuchMethodException{
		String desde;
		String hasta;
		String objetoOrigen;
		Object paramEntrada[] = new Object[1];
		int cantidadParametros = metodo.getChild("Parametros").getChildren().size();
		Method metodos[] = objeto.getClass().getMethods();
		
		for(int i = 0 ; i<cantidadParametros;i++){
			if(((Element)metodo.getChild("Parametros").getChildren().get(i)).getChild("Secuencia")!=null){
				seteaParametrosEnDuro(objeto,metodos,(Element)metodo.getChild("Parametros").getChildren().get(i));
			}else if(((Element)metodo.getChild("Parametros").getChildren().get(i)).getChild("Fijo")!=null){
				cat.debug("Seteo Parametros fijos");
				seteaParametrosEnDuro(objeto,metodos,(Element)metodo.getChild("Parametros").getChildren().get(i));
				cat.debug("------------------------------------------------------------");
			}else if(((Element)metodo.getChild("Parametros").getChildren().get(i)).getChild("Guardado")!=null){
				cat.debug("Seteo parametros que ya fueron guardados en un MAP");
				seteaParametrosDesdeMAP(objeto, ((Element)metodo.getChild("Parametros").getChildren().get(i)).getChildText("Guardado"),((Element)metodo.getChild("Parametros").getChildren().get(i)).getChildText("Destino"), ((Element)metodo.getChild("Parametros").getChildren().get(i)).getChildText("Tipo"),metodos);
				cat.debug("------------------------------------------------------------");
			}else if(((Element)metodo.getChild("Parametros").getChildren().get(i)).getChildText("Objeto")!=null&&((Element)metodo.getChild("Parametros").getChildren().get(i)).getChildText("Objeto").equalsIgnoreCase("ParametrosGenerales")&&((Element)metodo.getChild("Parametros").getChildren().get(i)).getChildren().size()==1){
				objeto = registro;
			}else if(((Element)metodo.getChild("Parametros").getChildren().get(i)).getChildText("Objeto")!=null&&((Element)metodo.getChild("Parametros").getChildren().get(i)).getChildText("Objeto").equalsIgnoreCase("Session")&&((Element)metodo.getChild("Parametros").getChildren().get(i)).getChildren().size()==1){
				objeto = objetoCompelto;
			}else{
				objetoOrigen =((Element)metodo.getChild("Parametros").getChildren().get(i)).getChildText("Objeto");
				desde =((Element)metodo.getChild("Parametros").getChildren().get(i)).getChildText("Origen");
				hasta = ((Element)metodo.getChild("Parametros").getChildren().get(i)).getChildText("Destino");
	
				cat.debug("metodo.getName() desde ["+desde+"]");
				cat.debug("metodo.getName() hasta ["+hasta+"]");
				cat.debug("objeto.getClass()      ["+objeto.getClass()+"]");
				for (int x = 0; x<metodos.length;x++){
					if (metodos[x].getName().equalsIgnoreCase(hasta)){
						Object paso;
						paso = registro.getClass().getMethod("get"+objetoOrigen, null).invoke(registro, null);
						paso = paso.getClass().getMethod(desde,null).invoke(paso,null);
						if (paso!= null && paso.toString().trim().equalsIgnoreCase("null"))	paso = null;
						paramEntrada[0] = paso;
						cat.debug("Ejecutando " + metodos[x].getName() + " Valor ="+paso);
						metodos[x].invoke(objeto, paramEntrada);
					}
				}
				cat.debug("------------------------------------------------------------");
			}
		}
		return objeto;
	}

	private void seteaParametrosDesdeMAP(Object objeto, String origen, String destino, String tipo, Method[]metodos) throws IllegalArgumentException, IllegalAccessException, InvocationTargetException{
		cat.debug("seteaParametrosDesdeMAP, origen, destino="+origen+","+destino);
		Object paramEntrada[] = new Object[1];
		for (int x = 0; x<metodos.length;x++){
			if (metodos[x].getName().equalsIgnoreCase(destino)){
				
				paramEntrada = seteaParametros(tipo, String.valueOf(datosExtra.get(origen)));
				metodos[x].invoke(objeto, paramEntrada);
			}
		}
	}

	private Object[] seteaParametros(String tipo, String valorASetear){
		Object paramEntrada[] = new Object[1];
		if ((valorASetear==null) || (valorASetear.trim().equalsIgnoreCase("null"))){//(+)evera 22 nov 07
			cat.debug("seteaParametros valorASetear Es NULL");
			paramEntrada[0] = null;
		}
		else
		{ 
			cat.debug("valorASetear["+valorASetear+"]");
			if(tipo.equalsIgnoreCase("int")){
				Integer valor;
				valor = new Integer(String.valueOf(valorASetear));
				paramEntrada[0] = valor;
				cat.debug("paramEntrada[0] int       ["+paramEntrada[0]+"]");
			}else if(tipo.equalsIgnoreCase("String")){
				String valor;
				valor = new String(String.valueOf(valorASetear));
				paramEntrada[0] = valor;
				cat.debug("paramEntrada[0] String    ["+paramEntrada[0]+"]");
			}else if(tipo.equalsIgnoreCase("long")){
				Long valor; 
				valor = Long.valueOf(String.valueOf(valorASetear));
				paramEntrada[0] = valor;
				cat.debug("paramEntrada[0] long      ["+paramEntrada[0]+"]");
			}else if(tipo.equalsIgnoreCase("Timestamp")){
				Timestamp valor; 
				valor = Timestamp.valueOf(String.valueOf(valorASetear));
				paramEntrada[0] = valor;
				cat.debug("paramEntrada[0] Timestamp ["+paramEntrada[0]+"]");
			}else if(tipo.equalsIgnoreCase("float")){
				Float valor; 
				valor = Float.valueOf(String.valueOf(valorASetear));
				paramEntrada[0] = valor;
				cat.debug("paramEntrada[0] float     ["+paramEntrada[0]+"]");
			}
		
		}//fin if ((valorASetear!=null)
		return paramEntrada;
	}

	/**
	 * Lee desde el XML
	 * 
	 * @param objeto Instancia del objeto al que se le setean los parámetros.
	 * @param metodos[] Metodos del DTO al que se le setean los parámetros
	 * @param parametro Element que contiene el valor fijo que se encuentra en el XML y los nombres de los getter y setter a utilizar. 
	 * @return Instancia del objeto de entrada al que se le setean los parámetros, ahora con el parámetro fijo o sequiencia ya seteado. 
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 * @throws InvocationTargetException
	 */
	private Object seteaParametrosEnDuro(Object objeto, Method metodos[],Element parametro) throws IllegalArgumentException, IllegalAccessException, InvocationTargetException{
		Object paramEntrada[] = new Object[1];
		String hasta = parametro.getChildText("Destino");
		for (int x = 0; x<metodos.length;x++){
			if (metodos[x].getName().equalsIgnoreCase(hasta)){
				cat.debug("metodos["+x+"].getName()["+metodos[x].getName()+"]<===>hasta["+hasta+"]");
				if (parametro.getChild("Secuencia")!=null){
					cat.debug("parametro.getChild(Secuencia)");
					cat.debug("parametro.getChildText(Secuencia)["+parametro.getChildText("Secuencia")+"]");
					if (datosExtra.containsKey(parametro.getChildText("Secuencia"))){
						Long e = ((Long)datosExtra.get(parametro.getChildText("Secuencia")));
						paramEntrada[0] = e;
					}else{
						cat.debug("NO contiene Secuencia");
						cat.debug("DEBE ARROJAR EXCEPTION por que la sequencia buscada no se ha seteado aún (MALA CONFIGURACION EN EL XML"); 
					}
				}else{
					paramEntrada = seteaParametros(parametro.getChildText("Fijo"), parametro.getChildText("Valor"));
				}
				cat.debug("metodos["+x+"].getName()["+metodos[x].getName()+"]");
				cat.debug("objeto.getClass()       ["+objeto.getClass()+"]");
				metodos[x].invoke(objeto, paramEntrada);
			}
		}
		return objeto;

	}
		

	private SupOrdHanFacade getSupOrdHanFacade() throws IssCusOrdException {
		Global global = Global.getInstance();

		cat.debug("getSupOrdHanFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		SupOrdHanFacadeHome supOrdHanFacadeHome = null;
		String jndi = global.getValor("jndi.SupOrdHanFacade");
		cat.debug("Buscando servicio[" + jndi + "]");

		String url = global.getValor("url.SupOrdHanProvider");
		cat.debug("Url provider[" + url + "]");

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");

		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");

		try {
			supOrdHanFacadeHome = (SupOrdHanFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,
					jndi, securityPrincipal, securityCredentials, SupOrdHanFacadeHome.class);
		} catch (ServiceLocatorException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}

		cat.debug("Recuperada interfaz home de Issue Customer Order Facade...");
		SupOrdHanFacade supOrdHanFacade = null;
		try {
			supOrdHanFacade = supOrdHanFacadeHome.create();
		} catch (CreateException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");

			throw new IssCusOrdException(e);
		} catch (RemoteException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}

		cat.debug("getIssCusOrdFacade():end");
		return supOrdHanFacade;
	}





	public void onInit() throws GeneralException {
		cat.debug("onInit():start");
		setRollBackManual(false);
		// Recupero el parametro
		parametros = getArguments();
		ParamRegistroOrdenServicioDTO paramOServicio; 
		paramOServicio = (ParamRegistroOrdenServicioDTO)parametros.getArgumentsData();
		cat.debug("onInit():end");
	}

	public AsyncProcessResponseObject start() throws GeneralException {
		return super.start();
	}
	
	
	public EstadoProcesoOOSSDTO notificar(EstadoProcesoOOSSDTO estadoProcesoOOSS) throws CloCusOrdException, RemoteException, IssCusOrdException, GeneralException {
		return super.notificar(estadoProcesoOOSS);
	}
	
	
	



	private ManConFacade getManConFacade() throws IssCusOrdException, ManConException 
	{
		Global global = Global.getInstance();		
		cat.debug("getManConFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		ManConFacadeHome manConFacadeHome = null;

		String jndi = global.getValor("jndi.ManConFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.ManConProvider");
		cat.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			manConFacadeHome = (ManConFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, ManConFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new ManConException(e);
		}		
		cat.debug("Recuperada interfaz home de ManConFacade...");
		ManConFacade manConFacade = null;

		try 
		{
			manConFacade = manConFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("getManConFacade():end");
		return manConFacade;
	}
		
/*	
	private CusRelManWSFacade getCusRelManWSFacade() throws IssCusOrdException 
	{
		Global global = Global.getInstance();		
		cat.debug("getCusRelManWSFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		CusRelManWSFacadeHome cusRelManWSFacadeHome = null;

		String jndi = global.getValor("jndi.CusRelManWSFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.CusRelManWSProvider");
		cat.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			cusRelManWSFacadeHome = (CusRelManWSFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, CusRelManWSFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("Recuperada interfaz home de cusRelManWSFacade...");
		CusRelManWSFacade cusRelManWSFacade = null;

		try 
		{
			cusRelManWSFacade = cusRelManWSFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" +  loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("cusRelManWSFacade():end");
		return cusRelManWSFacade;
	}*/

	/**
	 * @author rlozano
	 * @date 12-01-2009
	 * @description se comenta llamada a la fachada de ProductoEJBEAR Servicio de Integracion con Producto
	 */
	
	/*
	private EtiquetadoFacade getEtiquetadoFacade() throws IssCusOrdException 
	{
		Global global = Global.getInstance();		
		cat.debug("getEtiquetadoFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		EtiquetadoFacadeHome etiquetadoFacadeHome = null;

		String jndi = global.getValor("jndi.EtiquetadoFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.EtiquetadoProvider");
		cat.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			etiquetadoFacadeHome = (EtiquetadoFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, EtiquetadoFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("Recuperada interfaz home de EtiquetadoFacade...");
		EtiquetadoFacade etiquetadoFacade = null;

		try 
		{
			etiquetadoFacade = etiquetadoFacadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("getEtiquetadoFacade():end");
		return etiquetadoFacade;
	}
	*/
	private FrmkCargosFacade getFrmkCargosFacade() throws IssCusOrdException, FrmkCargosException 
	{
		Global global = Global.getInstance();		
		cat.debug("getFrmkCargosFacade():start");
		String initialContextFactory = global.getValor("initial.context.factory");
		cat.debug("Initial context factory[" + initialContextFactory + "]");

		FrmkCargosFacadeHome facadeHome = null;

		String jndi = global.getValor("jndi.FrmkCargosFacade");
		cat.debug("Buscando servicio[" + jndi + "]");		
		String url = global.getValor("url.FrmkCargosProvider");
		cat.debug("Url provider[" + url + "]");		

		String securityPrincipal = global.getValor("security.principal");
		cat.debug("Security principal[" + securityPrincipal + "]");		
		String securityCredentials = global.getValor("security.credentials");
		cat.debug("Security credentials[" + securityCredentials + "]");		
		try 
		{
			facadeHome = (FrmkCargosFacadeHome) ServiceLocator.getInstance().getRemoteHome(initialContextFactory, url,jndi, securityPrincipal, securityCredentials, FrmkCargosFacadeHome.class);
		} 
		catch (ServiceLocatorException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("ServiceLocatorException[" + loge + "]");
			throw new FrmkCargosException(e);
		}		
		cat.debug("Recuperada interfaz home de FrmkCargosFacade...");
		FrmkCargosFacade frmkCargosFacade = null;

		try 
		{
			frmkCargosFacade = facadeHome.create();
		}
		catch (CreateException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("CreateException[" + loge + "]");		
			throw new IssCusOrdException(e);
		}
		catch (RemoteException e) 
		{
			String loge = StackTraceUtl.getStackTrace(e);
			cat.debug("RemoteException[" + loge + "]");
			throw new IssCusOrdException(e);
		}		
		cat.debug("getFrmkCargosFacade():end");
		return frmkCargosFacade;
	}
	
	
	/**
	 * @author rlozano
	 * @date 12-01-2009
	 * @description se comenta llamada a la fachada de ProductoEJBEAR Servicio de Integracion con Producto
	 */
	
/*
	private void integrarProductoConCPU(CambioPlanAdicionalDTO[] cambioPlanAdicionalArr) throws SupOrdHanException, RemoteException, IssCusOrdException, ManConException, ManCusInvException, ManProOffInvException, NegSalException, PlanTarifCmdException{
		boolean aplicaProducto = false;
		ParametroDTO param = new ParametroDTO();
		param.setCodModulo("GA");
		param.setCodProducto(1);
		param.setNomParametro("APLICA_PL_ADICIONAL");
		param = getSupOrdHanFacade().obtenerParametroGeneral(param);
		
		
		if(param!=null&&param.getValor()!=null&&param.getValor().equals("TRUE")){
			aplicaProducto = true;
		}else{
			aplicaProducto = false;
		}
		
		//para probar
		//aplicaProducto = true;
		cat.debug("aplicaProducto="+aplicaProducto);
		if(aplicaProducto){
			int totalAbonados = integracionProdCPU.length;
			cat.debug("totalAbonados="+totalAbonados);
			int totalBloquesAbonado = 2000;
			int totalBloquesProducto = 2000;
			float resto = totalAbonados%totalBloquesAbonado;
			int numeroBloques = totalAbonados/totalBloquesAbonado;
			if (resto>0) numeroBloques++;
			
			//obtiene datos generales
			long codClienteOrigen = integracionProdCPU[0].getClienteOrigen();
			long codClienteDestino = integracionProdCPU[0].getClienteDestino();
			String codPlanTarifDestino = integracionProdCPU[0].getPlanTarifDestino();
			Timestamp fecT =integracionProdCPU[0].getFechaActivacionPlanes();
			Date fechaActual = new Date(integracionProdCPU[0].getFechaActivacionPlanes().getTime());
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String fechaActualStr = sdf.format(fechaActual);
			cat.debug("fechaActualStr="+fechaActualStr);
			BloqueCambioPlanAdicionalDTO bloque = new BloqueCambioPlanAdicionalDTO();
			
			//Para cada bloque
			for (int i=0; i<numeroBloques; i++){
				
				bloque.setFechaInicioStr(fechaActualStr);
				bloque.setTotalBloquesAbonado(totalBloquesAbonado);
				bloque.setTotalBloquesProducto(totalBloquesProducto);
				bloque.setMaximoBloqueAbonados(numeroBloques);
				bloque.setMaximoBloqueProductos(numeroBloques);
				bloque.setClienteOrigen(String.valueOf(codClienteOrigen));
				bloque.setClienteDestino(String.valueOf(codClienteDestino));
				bloque.setPlanTarifarioDestino(codPlanTarifDestino);
				bloque.setEjecutarCola(false);

				//generar una lista para un bloque de abonados
				int indiceAbonadosAProcesarIni = i*totalBloquesAbonado;
				int indiceAbonadosAProcesarFin = (i + 1)*totalBloquesAbonado;
				
				if (indiceAbonadosAProcesarFin > totalAbonados) indiceAbonadosAProcesarFin = totalAbonados;
				
				int totalAbonadosLista = indiceAbonadosAProcesarFin - indiceAbonadosAProcesarIni;
				AbonadoPlanAdicionalDTO[] listaAbonados = new AbonadoPlanAdicionalDTO[totalAbonadosLista];
				int indiceLista = 0;
				
				for(int j=indiceAbonadosAProcesarIni; j<indiceAbonadosAProcesarFin; j++){
					AbonadoPlanAdicionalDTO abonado = new AbonadoPlanAdicionalDTO();
					abonado.setIdProceso(bloque.getIdProceso());
					abonado.setNumAbonado(String.valueOf(integracionProdCPU[j].getAbonadoOrigen()));
					abonado.setIdBloqueAbonado(i + 1);
					abonado.setPlanTarifarioOrigen(integracionProdCPU[j].getPlanTarifOrigen());
					abonado.setNumProceso(String.valueOf(integracionProdCPU[j].getNumProceso()));
					abonado.setOrigenProceso(integracionProdCPU[j].getOrigenProceso());
					abonado.setNumMovimientoCentral(String.valueOf(integracionProdCPU[j].getNumMovCentral()));
					abonado.setFechaActivacionStr(fechaActualStr);
					Date fechaDesactivacion = new Date(integracionProdCPU[0].getFechaActivacionPlanes().getTime());
					String fechaDesactivacionStr = sdf.format(fechaDesactivacion);
					abonado.setFechaDesactivacionStr(fechaDesactivacionStr);
					listaAbonados[indiceLista] = abonado;
					indiceLista++;
				}
				bloque.setListaAbonados(listaAbonados);
				bloque = getEtiquetadoFacade().etiquetarProductos(bloque);
			}
			
		}
	}
	
	*/
	
	private AbonadoDTO [] obtenerAbonados(String [] numAbonados) throws RemoteException, IssCusOrdException, ManConException{
		AbonadoDTO []abonados = new AbonadoDTO[numAbonados.length];
		ManConFacade manConFacade = getManConFacade();
		for(int i = 0; i<abonados.length;i++){
			abonados[i] = new AbonadoDTO();
			abonados[i].setNumAbonado(Long.valueOf(numAbonados[i]).longValue());
			abonados[i] = manConFacade.obtenerDatosAbonado(abonados[i]);
		}
		return abonados;
	}
	
	private void notificarError(String codError, long numEvento, String desError) throws IssCusOrdException{
		cat.debug("notificarError:inicio");
		EstadoProcesoOOSSDTO estadoProc = new EstadoProcesoOOSSDTO();
		estadoProc.setEstado("ERROR");
		estadoProc.setFechaActualizacion(new Date());
		estadoProc.setNumProceso(this.numeroProceso);
		DetEstadoProcesoOSSDTO[] detalles = new DetEstadoProcesoOSSDTO[1];
		DetEstadoProcesoOSSDTO detalle = new DetEstadoProcesoOSSDTO();
		detalle.setEstado("ERROR");
		detalle.setFecEstado(new Date());
		detalle.setNumProceso(this.numeroProceso);
		detalle.setNumOOSS(this.numOrdenServicio);
		if(codError!=null)
			detalle.setCodError(Long.parseLong(codError));
		detalle.setNumEvento(numEvento);
		detalle.setDesError(desError);
		cat.debug("estadoProc.getEstado()[" + estadoProc.getEstado() + "]");
		cat.debug("estadoProc.getFechaActualizacion()[" + estadoProc.getFechaActualizacion() + "]");
		cat.debug("estadoProc.getNumProceso()[" + estadoProc.getNumProceso() + "]");
		cat.debug("detalle.getEstado()[" + detalle.getEstado() + "]");
		cat.debug("detalle.getFecEstado()[" + detalle.getFecEstado() + "]");
		cat.debug("detalle.getNumProceso()[" + detalle.getNumProceso() + "]");
		cat.debug("detalle.getNumOOSS()[" + detalle.getNumOOSS() + "]");
		if(codError!=null)
			cat.debug("detalle.getCodError()[" + detalle.getCodError() + "]");
		cat.debug("detalle.getNumEvento()[" + detalle.getNumEvento() + "]");
		if(desError!=null)
			cat.debug("detalle.getDesError()[" + detalle.getDesError() + "]");
		
		detalles[0] = detalle;
		estadoProc.setDetEstadoProcesoOSSDTO(detalles);
		try{
			cat.debug("notificar():inicio");
			notificar(estadoProc);
			cat.debug("notificar():fin");
		
		}catch(Exception e){
			throw new IssCusOrdException(e);
		}
			
		cat.debug("notificarError:fin");
		
	}
	
	
	
}
