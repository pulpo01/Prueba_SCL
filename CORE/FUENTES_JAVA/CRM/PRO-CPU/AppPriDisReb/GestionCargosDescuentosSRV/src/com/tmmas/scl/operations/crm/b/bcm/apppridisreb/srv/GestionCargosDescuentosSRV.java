package com.tmmas.scl.operations.crm.b.bcm.apppridisreb.srv;


import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.CargoImpuestoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.CobroAdelantadoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ProrrateoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.CargoFacturadoBOFactory;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.interfaces.CargoFacturadoBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerBillABE.businessObject.bo.interfaces.CargoFacturadoIT;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoOcasionalListDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.CargoRecurrenteListDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.OrdenServicioBOFactory;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.SegmentacionBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.SegmentacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.SegmentacionBOIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.PlanTarifarioBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.PlanTarifarioIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.CargoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.SCLPlanDescuentoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.interfaces.CargoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.interfaces.CargoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.interfaces.SCLPlanDescuentoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.interfaces.SCLPlanDescuentoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RegistroSolicitudListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.RespuestaSolicitudDTO;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.common.exception.AppPriDisRebException;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.srv.helper.Global;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.srv.interfaces.GestionCargosDescuentosSrvIF;

public class GestionCargosDescuentosSRV implements GestionCargosDescuentosSrvIF{
	
	private final Logger logger = Logger.getLogger(GestionCargosDescuentosSRV.class);
	private Global global = Global.getInstance();
	
	private PlanTarifarioBOFactoryIT factoryBO1 = new PlanTarifarioBOFactory();
	private PlanTarifarioIT planTarifarioBO = factoryBO1.getBusinessObject1();
	
	private AbonadoBOFactoryIT factoryBO2 = new AbonadoBOFactory();
	private AbonadoIT abonadoBO = factoryBO2.getBusinessObject1();
	
	/*private ParametrosGeneralesBOFactoryIT factoryBO3 = new ParametrosGeneralesBOFactory();
	private ParametrosGeneralesIT parametrosGeneralesBO = factoryBO3.getBusinessObject1();*/
	
	private OrdenServicioBOFactoryIT factoryBO4 = new OrdenServicioBOFactory();
	private OrdenServicioIT ordenServicioBO = factoryBO4.getBusinessObject1();
	
	private SCLPlanDescuentoBOFactoryIT factoryBO5 = new SCLPlanDescuentoBOFactory();
	private SCLPlanDescuentoIT planDescuentoBO = factoryBO5.getBusinessObject1();
	
	private CargoBOFactoryIT factoryBO6 = new CargoBOFactory();	
	private CargoIT cargoBO = factoryBO6.getBusinessObject1();
	
	private CargoFacturadoBOFactoryIT factoryBO7 = new CargoFacturadoBOFactory();	
	private CargoFacturadoIT cargoFacturadoBO = factoryBO7.getBusinessObject1();
	
	private ClienteBOFactoryIT clienteFactory =new ClienteBOFactory();
	private ClienteIT clienteBO =clienteFactory.getBusinessObject1();
	
	private SegmentacionBOFactoryIT segmFactory =new SegmentacionBOFactory();
	private SegmentacionBOIT segmentacionBO =segmFactory.getBusinessObject1();
	
	
	
	
	/**
	 * Metodo que activa los cargos ocasionales
	 * @param cargosOc: Lista de cargos ocasionales a activar
	 * @return
	 * @throws AppPriDisRebException 
	 */
	public RetornoDTO informarCargosOcasionales(CargoOcasionalListDTO cargosOc) throws AppPriDisRebException
	{
		RetornoDTO retorno=new RetornoDTO();
		try
		{
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
	
			logger.debug("Inicio:informarCargosOcasionales()");
			retorno = cargoFacturadoBO.informar(cargosOc);
			logger.debug("Fin:informarCargosOcasionales()");
		}
		catch (GeneralException e) 
		{
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}				
		return retorno;
	}
	
	/**
	 * Metodo que activa los cargos recurrentes
	 * @param cargosOc: Lista de cargos ocasionales a activar
	 * @return
	 * @throws AppPriDisRebException 
	 */
	public RetornoDTO informarCargosRecurrentes(CargoRecurrenteListDTO cargosReq) throws AppPriDisRebException
	{
		RetornoDTO retorno=new RetornoDTO();
		try
		{
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
	
			logger.debug("Inicio:informarCargosOcasionales()");
			retorno = cargoFacturadoBO.informar(cargosReq);
			
			//cargosReq
			
			
			logger.debug("Fin:informarCargosOcasionales()");
		}
		catch (GeneralException e) 
		{
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}				
		return retorno;
	}
	
	/**
	 * Obtiene un listado de abonados asociados al cliente.
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public AbonadoListDTO getListaAbonadosCliente(ClienteDTO cliente) throws AppPriDisRebException{
		AbonadoListDTO resultado = null;
		try{
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
	
			logger.debug("Inicio:getListaAbonadosVenta()");
			resultado = abonadoBO.obtenerListaAbonados(cliente);
			logger.debug("Fin:getListaAbonadosVenta()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}				
		
		return resultado;
	}//fin getListaAbonadosCliente
	
	/**
	 * Obtengo los cargos asociados a un abonado
	 * @param parametros
	 * @return
	 * @throws AppPriDisRebException
	 */
	/*public ObtencionCargosDTO obtenerCargos(ParametrosObtencionCargosDTO parametros)throws AppPriDisRebException{
		
		logger.debug("inicio:obtenerCargos()");
		String log = global.getValor("service.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);
				
		ObtencionCargosDTO resultado = new ObtencionCargosDTO();
		
		
		//TODO: Se recepciona el cliente y los abonados asociados a ese cliente, de los cuales se obtienen los cargos desde la capa superior
		//--AbonadoDTO[] listaAbonados = (new AbonadoListDTO()).getAbonados();//abonadoBO.obtenerListaAbonados(cliente).getAbonados();
		ProcesadorCargos procesadorCargos = new ProcesadorCargos();
		try{
			ClienteDTO clienteOrigen =new ClienteDTO();
			clienteOrigen.setCodCliente(Long.parseLong(parametros.getCodigoClienteOrigen()));
			clienteOrigen=clienteBO.obtenerDatosCliente(clienteOrigen);
			String nomOrdenServ=parametros.getOrdenServicio();
			nomOrdenServ=nomOrdenServ==null?"":nomOrdenServ.trim();
			
			boolean ordServicio=nomOrdenServ.equals("40006")||nomOrdenServ.equals("40007")
					||nomOrdenServ.equals("40008")?true:false;
			boolean isAplicaAbonadoCero=clienteOrigen.getCodTipoPlanTarif().equals(global.getValor("tipo.plan.tarifario.empresa"))
					&&ordServicio?true:false;
			
			
			AbonadoDTO abonadoDTO= new AbonadoDTO();
			logger.debug("Inicio recorre lista de abonados...");
			for(int i=0;i<parametros.getAbonados().length;i++){
				String numAbonado=parametros.getAbonados()[i];
				abonadoDTO.setNumAbonado(Long.parseLong(numAbonado));
				//abonadoDTO.setCodCliente(Long.parseLong(parametros.getCodigoClienteOrigen()));
				//abonadoDTO=	abonadoBO.obtenerDatosAbonado(abonadoDTO);
				ParamBajaIndemnizacionQTDTO inValue =new ParamBajaIndemnizacionQTDTO(); 
				inValue.setCod_Producto(Long.parseLong(global.getValor("codigo.producto")));
				inValue.setNum_Abonado(Long.parseLong(numAbonado));
				ParamBajaIndemnizacionQTDTO[] paramBJ= cargoBO.getParametrosbajaIndemnizacion(inValue);
				boolean bnumBoolean=paramBJ==null||paramBJ.length<1?false:true;
				
				String numMeses=bnumBoolean?String.valueOf(paramBJ[0].getNum_Meses()):null;
				numMeses=numMeses==null?"0":numMeses;
				parametros.setNumeroMesesContrato(Integer.parseInt(numMeses));
				ArrayList arregloReglas = new ArrayList();
				String tipoPantalla=parametros.getTipoPantalla();
				tipoPantalla=tipoPantalla==null?"":tipoPantalla.trim();
				
				// Se Procede a llamar  a los cargos y se activan los precios determinados
				 
				
				//TODO: CARGOS SERVICIOS OCASIONALES 
				if(tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.servicios.ocasionales"))){
					ReglasServiciosOcasionalesPV reglasServiciosOcasionales=new ReglasServiciosOcasionalesPV(getParametrosReglaServiciosOcasionales(parametros,abonadoDTO)); 
					arregloReglas.add(reglasServiciosOcasionales);
				}
				else {
					//TODO :Cargos por segmentacion
					GedCodigosDTO gedCodigosDTO=new GedCodigosDTO();
					gedCodigosDTO.setCod_modulo(global.getValor("codigo.modulo.GA"));
					gedCodigosDTO.setNom_columna(global.getValor("nombre.columna.cargo.segmentacion"));
					gedCodigosDTO.setNom_tabla(global.getValor("nombre.tabla.cargo.segmentacion"));
					GedCodigosListDTO tipoCargoListDTO =segmentacionBO.obtenerListaGedCodigos(gedCodigosDTO);  
					
					for (int k=0;k<tipoCargoListDTO.getGedCodigosDTO().length;k++){
						parametros.setGedCodigoTipoCargoSegm(tipoCargoListDTO.getGedCodigosDTO()[k].getCod_valor()); //1,2,3,4 
						parametros.setGedCodigoDescTipoCargSeg(tipoCargoListDTO.getGedCodigosDTO()[k].getDes_valor());//
						
						ReglasSegmentacion reglasSegmentacion=new ReglasSegmentacion(getParametrosReglaSegmentacion(parametros,abonadoDTO)); 
						arregloReglas.add(reglasSegmentacion);	
					}
				}
					
				//TODO: CARGOS BAJA OPTA PREPAGO SIN PENALIZACION "A"
				if(tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.servicios.sinpenalizacion"))){
					ReglasBajaOptaPrepagoSinPenalizacion reglasBajaOptaPrepagoSinPenaliza=new ReglasBajaOptaPrepagoSinPenalizacion(getParametrosReglaBajaOptaPrepagoSinPenalizacion(parametros,abonadoDTO)); 
					arregloReglas.add(reglasBajaOptaPrepagoSinPenaliza);
				}
				
				//TODO: CARGOS BAJA OPTA PREPAGO BAJA ABONADO "B"
				if (tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.servicios.baja.abonado"))){
					ReglasPenalizacion reglasPenalizacion =new ReglasPenalizacion(getParametrosReglaPenalizacion(parametros,abonadoDTO)); 
					arregloReglas.add(reglasPenalizacion);
					ReglasEquipoCargador reglasEquipoCargador=new ReglasEquipoCargador(getParametrosReglaEquipoCargador(parametros,abonadoDTO));
					arregloReglas.add(reglasEquipoCargador);
				}
				
				//TODO: CARGOS BAJA OPTA PREPAGO BAJA INDEMNIZACION "B" CAMBIAR A "C" EN EL DOCUMENTO
				if (tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.serivicios.baja.indemnizacion"))){
					ReglasBajaOptaPrepagoIndemnizacion reglasBajaOptaPrepagoIndeminzacion =new ReglasBajaOptaPrepagoIndemnizacion(getParametrosReglaBajaOptaPrepagoIndemnizacion(parametros,abonadoDTO));
					arregloReglas.add(reglasBajaOptaPrepagoIndeminzacion);
				}
				
				//TODO:Cargos Abonado Cero
				if (isAplicaAbonadoCero){
					ReglasAbonadoCero reglasAbonadoCero =new ReglasAbonadoCero(getParametrosReglaAbonadoCero(parametros,abonadoDTO));
					arregloReglas.add(reglasAbonadoCero);
				}
				
				ReglaListaPrecio[] coleccionReglas =(ReglaListaPrecio[])ArrayUtl.copiaArregloTipoEspecifico(arregloReglas.toArray(),ReglaListaPrecio.class);
				procesadorCargos.calcularCargos(coleccionReglas);
			}
			CargosDTO[] cargos = procesadorCargos.obtenerCargos();
			resultado.setCargos(cargos);
			logger.debug("Fin:obtenerCargos()");
		}catch(GeneralException e){
			throw new AppPriDisRebException(e);
			
		}
		
		return resultado;
		
		//----------------------
	}*///fin obtenerCargos
	
	
	
	/**
	 * Registra una solicitud de aprobación de descuento en SCL
	 * @param parametros
	 * @return
	 * @throws ProyectoException
	 * @throws FrameworkCargosException
	 */
	public RespuestaSolicitudDTO solicitarAprobacionDescuento(RegistroSolicitudListDTO registro)throws AppPriDisRebException{
		RespuestaSolicitudDTO respuesta = new RespuestaSolicitudDTO();
		long lNumeroAutorizacion;
		long lNumAbonado = 0;
		
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("solicitarAprobacionDescuento():start");
			
			String sEstadoSolicitud = global.getValor("estado.solicitud.pendiente");
			String sCodigoMonedaSolicitud  = global.getValor("codigo.moneda.solicitud");
			String sCodigoOrigen = global.getValor("codigo.origen");
			String sNomSecuencia = global.getValor("secuencia.solicitud.autorizacion");
			int indModif = Integer.parseInt(global.getValor("indicador.modificacion.descuento"));
			
			SecuenciaDTO secuencia = new SecuenciaDTO();
			secuencia.setNomSecuencia(sNomSecuencia);
			secuencia = ordenServicioBO.obtenerSecuencia(secuencia);
			lNumeroAutorizacion = secuencia.getNumSecuencia();

			RegistroSolicitudDTO[] solicitudes = registro.getSolicitudes();
			for (int i=0; i<solicitudes.length;i++){
				solicitudes[i].setLinAutoriza(i+1);
				solicitudes[i].setCodigoEstado(sEstadoSolicitud);
				solicitudes[i].setNumeroAutorizacion(lNumeroAutorizacion);
				solicitudes[i].setCodigoMoneda(sCodigoMonedaSolicitud);
				solicitudes[i].setNumeroAbonado(lNumAbonado);
				solicitudes[i].setIndicadorModificacion(indModif);
				solicitudes[i].setCodigoOrigen(sCodigoOrigen);
				planDescuentoBO.crearSolicitud(solicitudes[i]);
			}
			respuesta.setNumeroAutorizacion(lNumeroAutorizacion);
			respuesta.setCodigoEstado(sEstadoSolicitud);
			
			logger.debug("solicitarAprobacionDescuento():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}
		return respuesta;	
	}
	
	public RegistroSolicitudDTO consultarEstadoSolicitud(RegistroSolicitudDTO registro) throws AppPriDisRebException{
		RegistroSolicitudDTO respuesta = null;
		
	try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
			logger.debug("consultarEstadoSolicitud():start");
			String estadoPendiente = global.getValor("estado.solicitud.pendiente");
			String estadoAutorizada = global.getValor("estado.solicitud.autorizada");
			String estadoCancelada = global.getValor("estado.solicitud.cancelada");
			String glosaPendiente = global.getValor("desc.estado.solicitud.PD");
			String glosaAutorizada = global.getValor("desc.estado.solicitud.AU");
			String glosaCancelada = global.getValor("desc.estado.solicitud.CA");
			String glosaEstado = " ";
			
			respuesta = planDescuentoBO.consultarEstadoSolicitud(registro);
			if (registro.getCodigoEstado().equalsIgnoreCase(estadoPendiente))
				glosaEstado = glosaPendiente;
			else if (registro.getCodigoEstado().equalsIgnoreCase(estadoAutorizada))
				glosaEstado = glosaAutorizada;
			else if (registro.getCodigoEstado().equalsIgnoreCase(estadoCancelada))
				glosaEstado = glosaCancelada;
			
			respuesta.setDescripcionEstado(glosaEstado);
			
			logger.debug("consultarEstadoSolicitud():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}
		return respuesta;			
	}
	
	public RetornoDTO eliminarSolicitud(RegistroSolicitudDTO registro) throws AppPriDisRebException{
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("eliminarSolicitud():start");
			respuesta = planDescuentoBO.eliminarSolicitudDescuento(registro);
			logger.debug("eliminarSolicitud():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}
		return respuesta;		
	}
	
	
	
	public ImpuestosDTO obtenerImpuestos(ImpuestosDTO impuestos) throws AppPriDisRebException{
		ImpuestosDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerImpuestos():start");
			respuesta = cargoBO.obtenerImpuestos(impuestos);
			logger.debug("obtenerImpuestos():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}
		return respuesta;		
	}

	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws AppPriDisRebException{
		RetornoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
			logger.debug("aceptarPresupuesto():start");
			String moduloGA =  global.getValor("codigo.modulo.GA");
			String codProducto = global.getValor("codigo.producto");
			String paramDiasVctoFact = global.getValor("parametro.dias.vcto.fact");
			
			ParametroDTO parametro = new ParametroDTO();
			parametro.setCodModulo(moduloGA);
			parametro.setCodProducto(Integer.parseInt(codProducto));
			parametro.setNomParametro(paramDiasVctoFact);
			parametro = ordenServicioBO.obtenerParametroGeneral(parametro);
			int numDias = Integer.parseInt(parametro.getValor());
			
			//calcula fecha de vencimiento
			Date fecha = new Date();	
			Calendar cal = new GregorianCalendar(); 
		    cal.setTimeInMillis(fecha.getTime()); 
		    cal.add(Calendar.DATE, numDias); 
		    Date fechaVencimiento = new Date(cal.getTimeInMillis());
		    
			presup.setFechaVcto(fechaVencimiento);
			respuesta = cargoBO.aceptarPresupuesto(presup);
			logger.debug("aceptarPresupuesto():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}
		return respuesta;		
		
	}

	public RetornoDTO finalizarCargosFacturados(ProductoContratadoListDTO listaProductos) throws AppPriDisRebException 
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
	
			logger.debug("Inicio:finalizarCargosFacturados()");
			resultado = cargoFacturadoBO.eliminar(listaProductos);
			logger.debug("Fin:finalizarCargosFacturados()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}			
		return resultado;
	}

	public RetornoDTO eliminarCargosFacturados(ProductoContratadoListDTO listaProductos) throws AppPriDisRebException 
	{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
	
			logger.debug("Inicio:eliminarCargosFacturados()");
			resultado = cargoFacturadoBO.eliminarCargosFacturados(listaProductos);
			logger.debug("Fin:eliminarCargosFacturados()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}			
		return resultado;
	}
	
	public RetornoDTO descontratarCargosRecurrentes(ProductoContratadoListDTO listaProductos) throws AppPriDisRebException {
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
	
			logger.debug("Inicio:descontratarCargosRecurrentes()");
			resultado = cargoFacturadoBO.desactivar(listaProductos);
			logger.debug("Fin:descontratarCargosRecurrentes()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}			
		return resultado;
	}

	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de los Servicios de Segmentacion
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaSegmentacion
	 * @throws AppPriDisRebException
	 */
	/*private ParametrosReglasServicioOcacionalPVDTO getParametrosReglaServiciosOcasionales(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado)throws AppPriDisRebException{
		
		ParametrosReglasServicioOcacionalPVDTO paramRegServOcasionalDTO =new ParametrosReglasServicioOcacionalPVDTO();
		try{
			//TODO: Se cargan datos de consulta sobre el Plan Tarifario Origen y Destino
			logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaServiciosOcasionales:");
			//
			String tipoPantalalPrevio=parametros.getTipoPantallaPrevio();
			tipoPantalalPrevio=tipoPantalalPrevio==null?"":tipoPantalalPrevio.trim(); 
			paramRegServOcasionalDTO.setAplicaConcepto(tipoPantalalPrevio.equals(global.getValor("codigo.tipo.pantalla.servicios.baja.abonado"))?false:true);
			paramRegServOcasionalDTO.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
			paramRegServOcasionalDTO.setCodPlanServicio(parametros.getCodPlanServ());
			paramRegServOcasionalDTO.setCodProducto(global.getValor("codigo.producto"));
			paramRegServOcasionalDTO.setCodModulo(global.getValor("codigo.modulo.GA"));
			paramRegServOcasionalDTO.setCodTipoServicio(global.getValor("codigo.tipo.servicio"));
			paramRegServOcasionalDTO.setCodPlanTarifOrigen(parametros.getCodigoPlanTarifOrigen());
			paramRegServOcasionalDTO.setCodPlanTarifDestino(parametros.getCodigoPlanTarifDestino());
			//TODO : realizar validacion para determinar la procedencia del cambio del Plan Tarifario;
			
			
			PlanTarifarioDTO planEntradaOrigen = new PlanTarifarioDTO();
			String codPlantarifarioOrigen=parametros.getCodigoPlanTarifOrigen();
			codPlantarifarioOrigen=codPlantarifarioOrigen==null?"":codPlantarifarioOrigen.trim();
			planEntradaOrigen.setCodigoPlanTarifario(parametros.getCodigoPlanTarifOrigen());
			planEntradaOrigen.setCodigoProducto(global.getValor("codigo.producto"));
			planEntradaOrigen.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
			planEntradaOrigen=planTarifarioBO.getPlanTarifario(planEntradaOrigen);
			String tipoPlanTarifOrigen=planEntradaOrigen.getCodigoTipoPlan();
			tipoPlanTarifOrigen=tipoPlanTarifOrigen==null?"":tipoPlanTarifOrigen;
			PlanTarifarioDTO planEntradaDestino = new PlanTarifarioDTO();
			String planTarifDestino= parametros.getCodigoPlanTarifDestino();
			boolean isplanTarifDesNull=planTarifDestino==null||planTarifDestino.trim().equals("")?true:false;
			planTarifDestino=planTarifDestino==null?codPlantarifarioOrigen:planTarifDestino;
			String tipoPlanTarifDestino=null;
			if (!isplanTarifDesNull){		
				planEntradaDestino.setCodigoPlanTarifario(parametros.getCodigoPlanTarifDestino());
				planEntradaDestino.setCodigoProducto(global.getValor("codigo.producto"));
				planEntradaDestino.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
				planEntradaDestino=planTarifarioBO.getPlanTarifario(planEntradaDestino);
				
				tipoPlanTarifDestino=tipoPlanTarifDestino==null?"":tipoPlanTarifDestino;
			}else{
				planEntradaDestino=planEntradaOrigen;
				
			}
			tipoPlanTarifDestino=planEntradaDestino.getCodigoTipoPlan();
			
			if (tipoPlanTarifOrigen.equals(tipoPlanTarifDestino)){
				if (tipoPlanTarifOrigen.equals(global.getValor("parametros.entrada.prepago"))){
					paramRegServOcasionalDTO.setPrepagoPrepago(true);
					
				}
				else if (tipoPlanTarifOrigen.equals(global.getValor("parametros.entrada.hibrido"))){
					paramRegServOcasionalDTO.setHibridoHibrido(true);
					paramRegServOcasionalDTO.setPrepagoHibrido(global.getValor("parametros.nombre.conc_prepago.hibrido"));
				}
				
			}
			else{
				if (tipoPlanTarifOrigen.equals(global.getValor("parametros.entrada.prepago"))){
					if (tipoPlanTarifOrigen.equals(global.getValor("parametros.entrada.hibrido"))){
						paramRegServOcasionalDTO.setPrepagoHibrido(global.getValor("parametros.nombre.conc_prepago.hibrido"));
					}
				}
			}
			
			String tipoTecno=planEntradaOrigen.getCodigoTecnologia();
			tipoTecno=tipoTecno==null?global.getValor("codigo.tecnologia.GSM"):tipoTecno;
			paramRegServOcasionalDTO.setCodigoTecnologia(tipoTecno);
			
			//Codigo de actuacion;
			String codActuacion = parametros.getCodActabo();
			codActuacion=codActuacion==null?"":codActuacion;
			paramRegServOcasionalDTO.setCodActuacion(codActuacion);
			paramRegServOcasionalDTO.setPrepagoPrepago(global.getValor("parametros.nombre.conc.prepago"));
			paramRegServOcasionalDTO.setPrepagoHibrido(global.getValor("parametros.nombre.conc_prepago.hibrido"));
			
		} 
		catch(Exception e){
			e.printStackTrace();
		}
			return paramRegServOcasionalDTO;
	}*///fin getParametrosReglaServicioSegmentacion
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de los Servicios Ocacionales
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaSegmentacion
	 * @throws AppPriDisRebException
	 */
	/*private ParametrosReglasSegmentacionDTO getParametrosReglaSegmentacion(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws AppPriDisRebException{
		
		logger.debug("getParametrosReglaSegmentacion():start");
		
		ParametrosReglasSegmentacionDTO paramRegSegmentacionDTO =new ParametrosReglasSegmentacionDTO();
		try{
			
			//TODO: Se cargan datos de consulta sobre el Plan Tarifario Origen y Destino
			
			paramRegSegmentacionDTO.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
			paramRegSegmentacionDTO.setTipoSegOrigen(parametros.getTipoSegOrigen());
			paramRegSegmentacionDTO.setTipoSegDestino(parametros.getTipoSegDestino());

			String codPlanTarifOrig=parametros.getCodigoPlanTarifOrigen();
			codPlanTarifOrig=codPlanTarifOrig==null?"":codPlanTarifOrig;
			paramRegSegmentacionDTO.setCodigoPlanTarifOrigen(codPlanTarifOrig);
			
			String codPlantarifDes=parametros.getCodigoPlanTarifDestino();
			codPlantarifDes=codPlantarifDes==null?codPlanTarifOrig:codPlantarifDes;
			
			logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSegmentacion:1");
			
			paramRegSegmentacionDTO.setCodigoPlanTarifDestino(codPlantarifDes);
			
			logger.debug("paramRegSegmentacionDTO.getTipoSegOrigen():"+paramRegSegmentacionDTO.getTipoSegOrigen());
			logger.debug("paramRegSegmentacionDTO.getTipoSegDestino():"+paramRegSegmentacionDTO.getTipoSegDestino());
			logger.debug("paramRegSegmentacionDTO.getCodigoPlanTarifOrigen():"+paramRegSegmentacionDTO.getCodigoPlanTarifOrigen());
			logger.debug("paramRegSegmentacionDTO.getCodigoPlanTarifDestino():"+paramRegSegmentacionDTO.getCodigoPlanTarifDestino());
				
			paramRegSegmentacionDTO.setCodigoProducto(global.getValor("codigo.producto"));
			//paramRegSegmentacionDTO.setCodigoTecnologia(global.getValor("codigo.tecnologia.GSM"));
			paramRegSegmentacionDTO.setCodigoTecnologia(parametros.getCodigoTecnologia());
			paramRegSegmentacionDTO.setCodigoModulo(global.getValor("codigo.modulo.GA"));
			paramRegSegmentacionDTO.setNombreParametro1(global.getValor("parametro.min.optaramistar"));
			paramRegSegmentacionDTO.setNombreParametro2(global.getValor("parametro.cod.optaamistar"));
			logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSegmentacion:2");
			String codCausCamPlan=parametros.getCodCausaCambioPlan();
			codCausCamPlan=codCausCamPlan==null?"":codCausCamPlan;
			paramRegSegmentacionDTO.setCodCausaCambioPlan(codCausCamPlan);
			
			
			//paramRegSegmentacionDTO.setFechaAceptacionVenta(new java.sql.Date(abonado.getFec_AcepVenta().getTime()));
			//nombres acorde  al valor de lo q representan (cambiar)
			paramRegSegmentacionDTO.setTipoCargo1(global.getValor("parametro.tipo.cargo.uno"));
			paramRegSegmentacionDTO.setTipoCargo4(global.getValor("parametro.tipo.cargo.cuatro"));
			
			logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSegmentacion:3");
			String codClieOrig=parametros.getCodigoClienteOrigen();
			codClieOrig=codClieOrig==null||codClieOrig.trim().equals("")?"0":codClieOrig;
			paramRegSegmentacionDTO.setCodClienteOrig(Long.parseLong(codClieOrig));
			
			String codClieDes=parametros.getCodigoClienteDestino();
			codClieDes=codClieDes==null||codClieDes.trim().equals("")?"0":codClieDes;
			paramRegSegmentacionDTO.setCodClienteDes(Long.parseLong(codClieDes));
			
			logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSegmentacion:3.1");
			
			paramRegSegmentacionDTO.setNombreClaseDescuento(global.getValor("parametro.clase.descuento"));
			
			paramRegSegmentacionDTO.setGedCodigoTipoCargoSegm(parametros.getGedCodigoTipoCargoSegm());
			
			
			//paramDesc.setCodigoVendedor(codigoVendedor);
			
			//TODO :  Parametros de Entrada WEB
			boolean desto =parametros.getParametrosDescuentoDTO()==null?false:true;
			 if (desto){
				 ParametrosDescuentoDTO paramDesc=new ParametrosDescuentoDTO();
				
				 String codOperacion=parametros.getParametrosDescuentoDTO().getCodigoOperacion()==null?"":parametros.getParametrosDescuentoDTO().getCodigoOperacion();
				codOperacion=codOperacion==null?"":codOperacion;
				paramDesc.setCodigoOperacion(codOperacion);//CE VE P
				
				logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSegmentacion:3.2");
				
				String codTipContrato=parametros.getParametrosDescuentoDTO().getTipoContrato();
				codTipContrato=codTipContrato==null?"0":codTipContrato;
				paramDesc.setTipoContrato(codTipContrato); //73, 82, 84
				
				
				
				String codAntg=parametros.getParametrosDescuentoDTO().getCodigoAntiguedad()==null?"":parametros.getParametrosDescuentoDTO().getCodigoAntiguedad();
				paramDesc.setCodigoAntiguedad(codAntg); //01 02 03 04
				
				logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSegmentacion:4");
				
				String eqEstado=parametros.getParametrosDescuentoDTO().getEquipoEstado()==null?" ":parametros.getParametrosDescuentoDTO().getEquipoEstado();
				eqEstado=eqEstado==null?"":eqEstado;
				paramDesc.setEquipoEstado(eqEstado);//B Codigo estado devolución
				
				String MesesNuev=parametros.getParametrosDescuentoDTO().getNumeroMesesNuevo()==null?"":parametros.getParametrosDescuentoDTO().getNumeroMesesNuevo();
				MesesNuev=MesesNuev==null?"0":MesesNuev;
				paramDesc.setNumeroMesesNuevo(MesesNuev);//0 6 12 18 24
				
				String codArt=parametros.getParametrosDescuentoDTO().getCodigoArticulo()==null?"":parametros.getParametrosDescuentoDTO().getCodigoArticulo();
				codArt=codArt==null?"0":codArt;
				paramDesc.setCodigoArticulo(codArt);//1549
				logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSegmentacion:5");
				String indCiclo=parametros.getParametrosDescuentoDTO().getIndicadorCiclo()==null?"":parametros.getParametrosDescuentoDTO().getIndicadorCiclo();
				indCiclo=indCiclo==null?"0":indCiclo;
				paramDesc.setIndicadorCiclo(indCiclo);//0
				
				paramDesc.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
				String codVendedor=parametros.getParametrosDescuentoDTO().getCodigoVendedor()==null?"":parametros.getParametrosDescuentoDTO().getCodigoVendedor();
				codVendedor=codVendedor==null?"0":codVendedor;
				paramDesc.setCodigoVendedor(codVendedor);//1000
				
				String MesesContrat=String.valueOf(parametros.getParametrosDescuentoDTO().getNumeroMesesContrato())==null?"":String.valueOf(parametros.getParametrosDescuentoDTO().getNumeroMesesContrato());
				MesesContrat=MesesContrat==null?"0":MesesContrat;
				paramDesc.setNumeroMesesContrato(Integer.parseInt(MesesContrat));//0 6 12 18 24
				
				String codCategoria=parametros.getParametrosDescuentoDTO().getCodigoCategoria();
				codCategoria=codCategoria==null?"":codCategoria;
				paramDesc.setCodigoCategoria(codCategoria);
				
				logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSegmentacion:6");
				
				String modVenta=parametros.getCodigoModalidadVenta()==null?"":parametros.getCodigoModalidadVenta();
				modVenta=modVenta==null?"0":modVenta;
				paramDesc.setCodigoModalidadVenta(modVenta); //1
				
				String codContratNuev=parametros.getParametrosDescuentoDTO().getCodigoContratoNuevo();
				 codContratNuev= codContratNuev==null?"": codContratNuev;
				 paramDesc.setCodigoContratoNuevo(codContratNuev);
				 
				 String codCauVenta=parametros.getParametrosDescuentoDTO().getCodigoCausaVenta();
				 codCauVenta=codCauVenta==null||codCauVenta.trim().equals("")?" ":codCauVenta;
				 paramDesc.setCodigoCausaVenta(codCauVenta);
				 
				paramRegSegmentacionDTO.setParametrosDescuento(paramDesc);
				
				
				
			}
		} 
		catch(Exception e){
			throw new AppPriDisRebException(e);
		}
		logger.debug("getParametrosReglaSegmentacion():end");
			return paramRegSegmentacionDTO;
	}*///fin getParametrosReglaServicioOcacional
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de Baja Opta Prepago
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaBajaOptaPrepago
	 * @throws AppPriDisRebException
	 */
	/*private ParametrosReglasBajaOptaPrepagoSinPenalizacionDTO getParametrosReglaBajaOptaPrepagoSinPenalizacion(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws AppPriDisRebException{
		
		ParametrosReglasBajaOptaPrepagoSinPenalizacionDTO paramRegBajaOptaPrepagoSinPenalizacionDTO =new ParametrosReglasBajaOptaPrepagoSinPenalizacionDTO();
		try{
			//TODO: Se cargan datos de consulta sobre el Plan Tarifario Origen y Destino
			paramRegBajaOptaPrepagoSinPenalizacionDTO.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
			paramRegBajaOptaPrepagoSinPenalizacionDTO.setCod_Producto(Long.parseLong(global.getValor("codigo.producto")));
			paramRegBajaOptaPrepagoSinPenalizacionDTO.setCod_Categoria("");
			paramRegBajaOptaPrepagoSinPenalizacionDTO.setCod_TipContrato("");
			paramRegBajaOptaPrepagoSinPenalizacionDTO.setNum_Meses("");
			paramRegBajaOptaPrepagoSinPenalizacionDTO.setCod_Antiguedad(global.getValor("codigo.antiguedad"));
			paramRegBajaOptaPrepagoSinPenalizacionDTO.setCod_Operacion("");
			paramRegBajaOptaPrepagoSinPenalizacionDTO.setInd_Causa("");
			paramRegBajaOptaPrepagoSinPenalizacionDTO.setCod_Causa("");
			paramRegBajaOptaPrepagoSinPenalizacionDTO.setCod_ModPago("");
			paramRegBajaOptaPrepagoSinPenalizacionDTO.setCod_EstadDevolucion("");
			
			ParametrosDescuentoDTO paramDesc=new ParametrosDescuentoDTO(); 
			
			paramRegBajaOptaPrepagoSinPenalizacionDTO.setParametrosDescuento(paramDesc);
			
		} 
		catch(Exception e){
			throw new AppPriDisRebException(e);
		}
			return paramRegBajaOptaPrepagoSinPenalizacionDTO;
	}*/
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de Baja Opta Prepago
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaBajaOptaPrepago
	 * @throws AppPriDisRebException
	 */
	/*private ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO getParametrosReglaBajaOptaPrepagoBajaAbonado(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws AppPriDisRebException{
		
		ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO paramRegBajaOptaPrepagoBajaAbonadoDTO =new ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO();
		try{
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_Producto(Long.parseLong(global.getValor("codigo.producto")));
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_TipServ(global.getValor("codigo.tipo.servicio"));
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_Modulo(global.getValor("codigo.modulo.GA"));
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_Actabo(parametros.getCodActabo());
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_PlanServ(parametros.getCodPlanServ());
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_Penaliza(parametros.getCodPenalizacion());
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setInd_Comodato(String.valueOf(parametros.getIndComodato()));
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setEquipCargador(parametros.getEstdDevlCargador());
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_EstadoDev(parametros.getParametrosDescuentoDTO().getEquipoEstado());
			parametros.getParametrosDescuentoDTO().setTipoContrato(parametros.getParametrosDescuentoDTO().getTipoContrato());
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setParametrosDescuento(parametros.getParametrosDescuentoDTO());
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setInd_Causa(parametros.getIndCausa());
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_Causa(parametros.getCodCausaCambioPlan());
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCodPlanComercial(parametros.getCodPlanComercial());
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCodCargoBasico(parametros.getCodCargoBasico());
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_ModVenta(parametros.getCodigoModalidadVenta());
			
			
		} 
		catch(Exception e){
			throw new AppPriDisRebException(e);
		}
			return paramRegBajaOptaPrepagoBajaAbonadoDTO;
	}*/
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de Baja Opta Prepago
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaBajaOptaPrepago
	 * @throws AppPriDisRebException
	 */
	/*private ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO getParametrosReglaPenalizacion(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws AppPriDisRebException{
		
		ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO paramRegBajaOptaPrepagoBajaAbonadoDTO =new ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO();
		try{
			
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_Penaliza(parametros.getCodPenalizacion());
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_Producto(Long.parseLong(global.getValor("codigo.producto")));
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_Modulo(global.getValor("codigo.modulo.GA"));
		} 
		catch(Exception e){
			throw new AppPriDisRebException(e);
		}
			return paramRegBajaOptaPrepagoBajaAbonadoDTO;
	}*/
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de Baja Opta Prepago
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaBajaOptaPrepago
	 * @throws AppPriDisRebException
	 */
	/*private ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO getParametrosReglaEquipoCargador(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws AppPriDisRebException{
		
		ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO paramRegBajaOptaPrepagoBajaAbonadoDTO =new ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO();
		try{
			
			
			boolean desto =parametros.getParametrosDescuentoDTO()==null?false:true;
			 if (desto){
				 ParametrosDescuentoDTO paramDesc=new ParametrosDescuentoDTO();
				
				 String codOperacion=parametros.getParametrosDescuentoDTO().getCodigoOperacion()==null?"":parametros.getParametrosDescuentoDTO().getCodigoOperacion();
				codOperacion=codOperacion==null?"":codOperacion;
				paramDesc.setCodigoOperacion(codOperacion);//CE VE P
				
				logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSegmentacion:3.2");
				
				String codTipContrato=parametros.getParametrosDescuentoDTO().getTipoContrato();
				codTipContrato=codTipContrato==null?"0":codTipContrato;
				paramDesc.setTipoContrato(codTipContrato); //73, 82, 84
				
				
				
				String codAntg=parametros.getParametrosDescuentoDTO().getCodigoAntiguedad()==null?"":parametros.getParametrosDescuentoDTO().getCodigoAntiguedad();
				paramDesc.setCodigoAntiguedad(codAntg); //01 02 03 04
				
				logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSegmentacion:4");
				
				String eqEstado=parametros.getParametrosDescuentoDTO().getEquipoEstado()==null?" ":parametros.getParametrosDescuentoDTO().getEquipoEstado();
				eqEstado=eqEstado==null?"":eqEstado;
				paramDesc.setEquipoEstado(eqEstado);//B Codigo estado devolución
				
				String MesesNuev=parametros.getParametrosDescuentoDTO().getNumeroMesesNuevo()==null?"":parametros.getParametrosDescuentoDTO().getNumeroMesesNuevo();
				MesesNuev=MesesNuev==null?"0":MesesNuev;
				paramDesc.setNumeroMesesNuevo(MesesNuev);//0 6 12 18 24
				
				String codArt=parametros.getParametrosDescuentoDTO().getCodigoArticulo()==null?"":parametros.getParametrosDescuentoDTO().getCodigoArticulo();
				codArt=codArt==null?"0":codArt;
				paramDesc.setCodigoArticulo(codArt);//1549
				logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSegmentacion:5");
				String indCiclo=parametros.getParametrosDescuentoDTO().getIndicadorCiclo()==null?"":parametros.getParametrosDescuentoDTO().getIndicadorCiclo();
				indCiclo=indCiclo==null?"0":indCiclo;
				paramDesc.setIndicadorCiclo(indCiclo);//0
				
				paramDesc.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
				String codVendedor=parametros.getParametrosDescuentoDTO().getCodigoVendedor()==null?"":parametros.getParametrosDescuentoDTO().getCodigoVendedor();
				codVendedor=codVendedor==null?"0":codVendedor;
				paramDesc.setCodigoVendedor(codVendedor);//1000
				
				String MesesContrat=String.valueOf(parametros.getParametrosDescuentoDTO().getNumeroMesesContrato())==null?"":String.valueOf(parametros.getParametrosDescuentoDTO().getNumeroMesesContrato());
				MesesContrat=MesesContrat==null?"0":MesesContrat;
				paramDesc.setNumeroMesesContrato(Integer.parseInt(MesesContrat));//0 6 12 18 24
				
				String codCategoria=parametros.getParametrosDescuentoDTO().getCodigoCategoria();
				codCategoria=codCategoria==null?"":codCategoria;
				paramDesc.setCodigoCategoria(codCategoria);
				
				logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSegmentacion:6");
				
				String modVenta=parametros.getCodigoModalidadVenta()==null?"":parametros.getCodigoModalidadVenta();
				modVenta=modVenta==null?"0":modVenta;
				paramDesc.setCodigoModalidadVenta(modVenta); //1
				
				String codContratNuev=parametros.getParametrosDescuentoDTO().getCodigoContratoNuevo();
				 codContratNuev= codContratNuev==null?"": codContratNuev;
				 paramDesc.setCodigoContratoNuevo(codContratNuev);
				 
				 String codCauVenta=parametros.getParametrosDescuentoDTO().getCodigoCausaVenta();
				 codCauVenta=codCauVenta==null||codCauVenta.trim().equals("")?" ":codCauVenta;
				 paramDesc.setCodigoCausaVenta(codCauVenta);
				 
				 paramRegBajaOptaPrepagoBajaAbonadoDTO.setParametrosDescuento(paramDesc);
				
				
				
			}
			
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
			//paramRegBajaOptaPrepagoBajaAbonadoDTO.setInd_Comodato(String.valueOf(parametros.getIndComodato()));
			String indComodato=String.valueOf(parametros.getIndComodato());
	        indComodato=indComodato==null?"":indComodato.trim();
	        paramRegBajaOptaPrepagoBajaAbonadoDTO.setIndComodato(indComodato.equals(global.getValor("parametro.comodato"))?true:false);
			//paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_EstadoDev(parametros.getParametrosDescuentoDTO().getEquipoEstado());
	        paramRegBajaOptaPrepagoBajaAbonadoDTO.setCodEstDev_D(paramRegBajaOptaPrepagoBajaAbonadoDTO.getParametrosDescuento().getEquipoEstado().equals(global.getValor("codigo.devolucion.equipo.D"))?true:false);
	        paramRegBajaOptaPrepagoBajaAbonadoDTO.setEquipCargador_N(parametros.getEstdDevlCargador().equals(global.getValor("codigo.equipo.cargador.N"))?true:false);
	        
			
	        paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_Producto(Long.parseLong(global.getValor("codigo.producto")));
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_Modulo(global.getValor("codigo.modulo.GA"));
			
			
			
			
			
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_Penaliza(parametros.getCodPenalizacion());
		} 
		catch(Exception e){
			throw new AppPriDisRebException(e);
		}
			return paramRegBajaOptaPrepagoBajaAbonadoDTO;
	}*/
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de Baja Opta Prepago
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaBajaOptaPrepago
	 * @throws AppPriDisRebException
	 */
	/*private ParametrosReglasBajaOptaPrepagoIndemnizacionDTO getParametrosReglaBajaOptaPrepagoIndemnizacion(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws AppPriDisRebException{
		
		ParametrosReglasBajaOptaPrepagoIndemnizacionDTO paramRegBajaOptaPrepagoIndemnizacionDTO =new ParametrosReglasBajaOptaPrepagoIndemnizacionDTO();
		try{
			paramRegBajaOptaPrepagoIndemnizacionDTO.setNum_Abonado(abonado.getNumAbonado());
			paramRegBajaOptaPrepagoIndemnizacionDTO.setCod_Producto(Long.parseLong(global.getValor("codigo.producto")));
			paramRegBajaOptaPrepagoIndemnizacionDTO.setCod_Actabo(parametros.getCodActabo());
			paramRegBajaOptaPrepagoIndemnizacionDTO.setCod_TipServ(parametros.getCodiTipServicio());
			ParametroDTO parametroDTO=new ParametroDTO();
			parametroDTO.setNomParametro(global.getValor("parametro.codigo.concepto.indemnizacion"));
			paramRegBajaOptaPrepagoIndemnizacionDTO.setCod_Servicio(global.getValor("codigo.tipo.servicio"));//Parametro de Entrada properties
			paramRegBajaOptaPrepagoIndemnizacionDTO.setMeses_Contrato(String.valueOf(parametros.getNumeroMesesContrato()));
			paramRegBajaOptaPrepagoIndemnizacionDTO.setNum_meses(String.valueOf(parametros.getNumeroMesesContrato()));
			//paramRegBajaOptaPrepagoIndemnizacionDTO.setCod_TipServ(global.getValor("codigo.tipo.servicio"));
			paramRegBajaOptaPrepagoIndemnizacionDTO.setCod_Modulo(global.getValor("codigo.modulo.GA"));
			paramRegBajaOptaPrepagoIndemnizacionDTO.setInd_Comodato(String.valueOf(parametros.getIndComodato()));
			//paramRegBajaOptaPrepagoIndemnizacionDTO.setEquipCargador(parametros.getEstdDevlCargador());
			paramRegBajaOptaPrepagoIndemnizacionDTO.setEquipoEstado(parametros.getParametrosDescuentoDTO().getEquipoEstado());
			
			ParametrosDescuentoDTO paramDesc=new ParametrosDescuentoDTO(); 
			paramRegBajaOptaPrepagoIndemnizacionDTO.setParametrosDescuento(paramDesc);
			
		} 
		catch(Exception e){
			throw new AppPriDisRebException(e);
		}
			return paramRegBajaOptaPrepagoIndemnizacionDTO;
	}*/
	

	
	public RetornoDTO consultarEstadoFacturado(long numProceso) throws AppPriDisRebException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
	
			logger.debug("Inicio:consultarEstadoFacturado()");
			resultado = cargoBO.consultarEstadoFacturado(numProceso);
			logger.debug("Fin:consultarEstadoFacturado()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}			
		return resultado;
	}
	
	public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws AppPriDisRebException{
		PresupuestoDTO resultado = null;
		try{
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
	
			logger.debug("Inicio:obtenerDetallePresupuesto()");
			resultado = cargoBO.obtenerDetallePresupuesto(presup);
			logger.debug("Fin:obtenerDetallePresupuesto()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}			
		return resultado;
	}
	
	public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO sec) throws AppPriDisRebException{
		DescuentoDTO resultado = null;
		try{
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
	
			logger.debug("Inicio:obtenerCodConceptoDescuento()");
			resultado = cargoBO.obtenerCodConceptoDescuento(sec);
			logger.debug("Fin:obtenerCodConceptoDescuento()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}			
		return resultado;		
	}
	
	public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws AppPriDisRebException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
	
			logger.debug("Inicio:eliminaCodConceptoDescuento()");
			resultado = cargoBO.eliminaCodConceptoDescuento(numTransaccion);
			logger.debug("Fin:eliminaCodConceptoDescuento()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}			
		return resultado;			
		
	}
	
	public RetornoDTO insertarConceptoDescuento(DescuentoDTO desc) throws AppPriDisRebException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
	
			logger.debug("Inicio:insertarConceptoDescuento()");
			resultado = cargoBO.insertarConceptoDescuento(desc);
			logger.debug("Fin:insertarConceptoDescuento()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}			
		return resultado;			
		
	}
	
	public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro) throws AppPriDisRebException{
		RetornoDTO resultado = null;
		try{
			String log = global.getValor("service.log");
			log = global.getPathInstancia() + log;
			PropertyConfigurator.configure(log);
	
			logger.debug("Inicio:eliminarPresupuesto()");
			resultado = cargoBO.eliminarPresupuesto(registro);
			logger.debug("Fin:eliminarPresupuesto()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new AppPriDisRebException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}			
		return resultado;			
		
	}
	
	
	public ProrrateoDTO getCargoRecurrenteProrrateo(CargoRecurrenteDTO cargoRecurrenteDTO)throws GeneralException{
		ProrrateoDTO prorrateoDTO = new ProrrateoDTO();
		try 
		{
			logger.debug("getCargoRecurrenteProrrateado():start");
			
			prorrateoDTO.setNumAbonado(Long.parseLong(cargoRecurrenteDTO.getNumAbonadoPago()));
			prorrateoDTO.setCodCargo(Long.parseLong(cargoRecurrenteDTO.getCodCargoContratado()));
			prorrateoDTO = cargoFacturadoBO.getCargoRecurrenteProrrateo(cargoRecurrenteDTO);
			logger.debug("getCargoRecurrenteProrrateado():end");
		}
		catch (GeneralException e) 
		{
			logger.debug("CustomerBillException[", e);
			throw e;
		}
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
		return prorrateoDTO;	
	}
	
	public CargoImpuestoDTO getImpuestoImporte(CargoImpuestoDTO cargoImpuestoDTO)throws GeneralException{
		try 
		{
			logger.debug("getCargoImpuesto():start");
			cargoImpuestoDTO = cargoFacturadoBO.getImpuestoImporte(cargoImpuestoDTO);
			logger.debug("getCargoImpuesto():end");
		}
		catch (GeneralException e) 
		{
			logger.debug("CustomerBillException[", e);
			throw e;
		}
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}		
		return cargoImpuestoDTO;
		
	}
	public RetornoDTO insertaCobroAdelantado(CargoRecurrenteDTO cargoRecurrenteDTO)	throws GeneralException{
		RetornoDTO retValue= new RetornoDTO();
		try 
		{
			logger.debug("insertaCobroAdelantado():start");
			retValue = cargoFacturadoBO.insertaCobroAdelantado(cargoRecurrenteDTO);
			logger.debug("insertaCobroAdelantado():end");
		}
		catch (GeneralException e) 
		{
			logger.debug("CustomerBillException[", e);
			throw e;
		}
		catch (Exception e) 
		{
			logger.debug("Exception[", e);
			throw new AppPriDisRebException(e);
		}		
		return retValue;	
		
	}
	
	
	
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de Abonado Cero
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaBajaOptaPrepago
	 * @throws AppPriDisRebException
	 */
/*	private ParametrosReglasAbonadoCeroDTO getParametrosReglaAbonadoCero(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws AppPriDisRebException{
		
		ParametrosReglasAbonadoCeroDTO parametrosReglasAbonadoCeroDTO =new ParametrosReglasAbonadoCeroDTO();
		try{
			parametrosReglasAbonadoCeroDTO.setCodigoModulo(global.getValor("codigo.modulo.GE"));
			parametrosReglasAbonadoCeroDTO.setNombreTabla(global.getValor("nombre.tabla.fa_conceptos"));
			parametrosReglasAbonadoCeroDTO.setNombreColumna(global.getValor("nombre.columna.cod_concepto"));
			parametrosReglasAbonadoCeroDTO.setCodigoCliente(String.valueOf(parametros.getCodigoClienteOrigen()));
			parametrosReglasAbonadoCeroDTO.setFechaVigenciaAbonadoCero(parametros.getFechaVigenciaAbonadoCero());
			parametrosReglasAbonadoCeroDTO.setCodigoProducto(Long.parseLong(global.getValor("codigo.producto")));
		} 
		catch(Exception e){
			throw new AppPriDisRebException(e);
		}
			return parametrosReglasAbonadoCeroDTO;
	}*/
}
	