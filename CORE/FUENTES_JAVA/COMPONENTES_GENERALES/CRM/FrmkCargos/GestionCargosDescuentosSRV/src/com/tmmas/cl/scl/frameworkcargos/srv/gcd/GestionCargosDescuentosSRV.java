package com.tmmas.cl.scl.frameworkcargos.srv.gcd;


import java.sql.Date;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.ArrayUtl;
import com.tmmas.cl.scl.frameworkcargos.base.ReglaListaPrecio;
import com.tmmas.cl.scl.frameworkcargos.exception.FrameworkCargosException;
import com.tmmas.cl.scl.frameworkcargos.motorv1.ProcesadorCargos;
import com.tmmas.cl.scl.frameworkcargos.srv.gcd.helper.Global;
import com.tmmas.cl.scl.frameworkcargos.srv.gcd.interfaces.GestionCargosDescuentosSrvIF;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasAbonadoCeroDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasBajaOptaPrepagoIndemnizacionDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasBajaOptaPrepagoSinPenalizacionDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasDiferenciaGarantiaDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasHabilitacionDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasSSAdelantadoDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasSegmentacionDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasServicioOcacionalPVDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasServicioSuplementarioDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasSimcardDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasSimcardRestitucionDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasTerminalDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.dto.ParametrosReglasTerminalRestitucionDTO;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasAbonadoCero;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasBajaOptaPrepagoIndemnizacion;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasBajaOptaPrepagoSinPenalizacion;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasDiferenciaGarantia;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasEquipoCargador;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasHabilitacion;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasPenalizacion;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasSSAdelantado;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasSegmentacion;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasServiciosOcasionalesPV;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasServiciosSuplementariosPV;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasSimcard;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasSimcardRestitucion;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasTerminalPV;
import com.tmmas.cl.scl.frameworkcargossrv.service.implementacion.ReglasTerminalRestitucionPV;
import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.CargoFacturadoBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.OrdenServicioBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.VendedorBOFactory;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.CargoFacturadoBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.CargoFacturadoIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.OrdenServicioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.VendedorBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.VendedorIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoOcasionalListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargoRecurrenteListDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.CargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ImpuestosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioEquipoNuevoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioTerminalDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.CargoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.ParametrosGeneralesBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.PlanTarifarioBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.SCLPlanDescuentoBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.SegmentacionBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.TerminalBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SCLPlanDescuentoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SCLPlanDescuentoIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SegmentacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SegmentacionBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GedCodigosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.GedCodigosListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParamCargosAbonadoCeroDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroFacturacionDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ParamBajaIndemnizacionQTDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PresupuestoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RespuestaSolicitudDTO;
//
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingPriceException;


public class GestionCargosDescuentosSRV implements GestionCargosDescuentosSrvIF{
	
	private final Logger logger = Logger.getLogger(GestionCargosDescuentosSRV.class);
	private Global global = Global.getInstance();
	
	private PlanTarifarioBOFactoryIT factoryBO1 = new PlanTarifarioBOFactory();
	private PlanTarifarioIT planTarifarioBO = factoryBO1.getBusinessObject1();
	
	private AbonadoBOFactoryIT factoryBO2 = new AbonadoBOFactory();
	private AbonadoIT abonadoBO = factoryBO2.getBusinessObject1();
	
	private ParametrosGeneralesBOFactoryIT factoryBO3 = new ParametrosGeneralesBOFactory();
	private ParametrosGeneralesIT parametrosGeneralesBO = factoryBO3.getBusinessObject1();
	
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
	
	private TerminalBOFactoryIT terminalFactory=new TerminalBOFactory();
	private TerminalBOIT terminalBO=terminalFactory.getBusinessObject1();
	
	private RegistroFacturacionBOFactoryIT regFactFactory=new RegistroFacturacionBOFactory();
	private RegistroFacturacionIT registroFacturacionBO=regFactFactory.getBusinessObject1();
	
	private VendedorBOFactoryIT vendFactory =new VendedorBOFactory();
	private VendedorIT vendedorBO=vendFactory.getBusinessObject1();
	
	public GestionCargosDescuentosSRV (){
		String log = global.getValor("service.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);
	}
	
	
	/**
	 * Metodo que activa los cargos ocasionales
	 * @param cargosOc: Lista de cargos ocasionales a activar
	 * @return
	 * @throws FrmkCargosExceptionException 
	 */
	public RetornoDTO informarCargosOcasionales(CargoOcasionalListDTO cargosOc) throws FrmkCargosException
	{
		RetornoDTO retorno=new RetornoDTO();
		try
		{
			
	
			logger.debug("Inicio:informarCargosOcasionales()");
			retorno = cargoFacturadoBO.informar(cargosOc);
			logger.debug("Fin:informarCargosOcasionales()");
		}
		catch (GeneralException e) 
		{
			logger.debug("GeneralException[", e);
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}				
		return retorno;
	}
	
	/**
	 * Metodo que activa los cargos recurrentes
	 * @param cargosOc: Lista de cargos ocasionales a activar
	 * @return
	 * @throws FrmkCargosExceptionException 
	 */
	public RetornoDTO informarCargosRecurrentes(CargoRecurrenteListDTO cargosReq) throws FrmkCargosException
	{
		RetornoDTO retorno=new RetornoDTO();
		try
		{
			
	
			logger.debug("Inicio:informarCargosOcasionales()");
			retorno = cargoFacturadoBO.informar(cargosReq);
			logger.debug("Fin:informarCargosOcasionales()");
		}
		catch (GeneralException e) 
		{
			logger.debug("GeneralException[", e);
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}				
		return retorno;
	}
	
	/**
	 * Obtiene un listado de abonados asociados al cliente.
	 * @param entrada
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public AbonadoListDTO getListaAbonadosCliente(ClienteDTO cliente) throws FrmkCargosException{
		AbonadoListDTO resultado = null;
		try{
			
	
			logger.debug("Inicio:getListaAbonadosVenta()");
			resultado = abonadoBO.obtenerListaAbonados(cliente);
			logger.debug("Fin:getListaAbonadosVenta()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}				
		
		return resultado;
	}//fin getListaAbonadosCliente
	
	/**
	 * Obtengo los cargos asociados a un abonado
	 * @param parametros
	 * @return
	 * @throws FrmkCargosExceptionException
	 */
	public ObtencionCargosDTO obtenerCargos(ParametrosObtencionCargosDTO parametros)throws FrmkCargosException{
		
		
		//String log = global.getValor("service.log");
		//PropertyConfigurator.configure(log);

		logger.debug("--------FrmkCargosEJBEAR.ear CREADO 02/11/2009 15:33 : PV--------");
		logger.debug("Tipo Pantalla              ["+parametros.getTipoPantalla()+"]");                  
		logger.debug("Cod Modalidad de Venta     ["+parametros.getCodigoModalidadVenta()+"]");      
		logger.debug("Abonados cantidad          ["+parametros.getAbonados()+"]");              
		logger.debug("Codigo Cliente Origen      ["+parametros.getCodigoClienteOrigen()+"]");          
		logger.debug("Codigo Cliente Destino     ["+parametros.getCodigoClienteDestino()+"]");         
		logger.debug("Codigo PlanTarifario Origen["+parametros.getCodigoPlanTarifOrigen()+"]");    
		logger.debug("Codigo PlanTarifario Destin["+parametros.getCodigoPlanTarifDestino()+"]");   
		logger.debug("Tipo Segmentacion Origen   ["+parametros.getTipoSegOrigen()+"]");       
		logger.debug("Tipo Segmentacion Origen   ["+parametros.getTipoSegDestino()+"]");       
		logger.debug("Codigo Causa Cambio de Plan["+parametros.getCodCausaCambioPlan()+"]");    
		logger.debug("Codigo Actuacion           ["+parametros.getCodActabo()+"]");               
		logger.debug("Codigo Tecnologia          ["+parametros.getCodigoTecnologia()+"]");              
		logger.debug("Codigo Penalizacion        ["+parametros.getCodPenalizacion()+"]");            
		logger.debug("Indicador Comodato         ["+parametros.getIndComodato()+"]");             
		logger.debug("Codigo Categoria           ["+parametros.getCodCategoria()+"]");               
		logger.debug("Tipo Contrato              ["+parametros.getTipoContrato()+"]");                  
		logger.debug("Indicador Causa            ["+parametros.getIndCausa()+"]");                
		logger.debug("Estado Devoluci de Cargador["+parametros.getEstdDevlCargador()+"]");  
		logger.debug("Fecha Vigencia             ["+parametros.getFechaVigenciaAbonadoCero()+"]");                
        logger.debug("Número de OOSS de Renova   ["+ parametros.getNumOsRenova()+"]"); // p-mix-09003; OCB

		ObtencionCargosDTO resultado = new ObtencionCargosDTO();
		
		

		
		
		//TODO: Se recepciona el cliente y los abonados asociados a ese cliente, de los cuales se obtienen los cargos desde la capa superior
		//--AbonadoDTO[] listaAbonados = (new AbonadoListDTO()).getAbonados();//abonadoBO.obtenerListaAbonados(cliente).getAbonados();
		ProcesadorCargos procesadorCargos = new ProcesadorCargos();
		try{
			
			// INI P-MIX-09003 OCB;
			// Aqui debemos invocar package que evalua si la OOSS versus el numero de Renovación esta afecto o no a cargos
			if (parametros.getNumOsRenova()!=null){
				ParametrosObtencionCargosDTO ind_cobro = new ParametrosObtencionCargosDTO();
				ind_cobro=abonadoBO.verificaRenovacion(parametros);
				if ("0".equals(""+ind_cobro.getIndComodato()))
				{
					
					CargosDTO[] cargos = procesadorCargos.obtenerCargos();
					resultado.setCargos(cargos);
					logger.debug("Fin:no trae cargos por renovacion()");
				    return resultado;
				}
			
			}
			// FIN P-MIX-09003 OCB;
			

			ClienteDTO clienteOrigen =new ClienteDTO();
			clienteOrigen.setCodCliente(Long.parseLong(parametros.getCodigoClienteOrigen()));
			clienteOrigen=clienteBO.obtenerDatosCliente(clienteOrigen);
			ClienteDTO clienteDestino = new ClienteDTO();
			String nomOrdenServ=parametros.getOrdenServicio();
			nomOrdenServ=nomOrdenServ==null?"":nomOrdenServ.trim();
			
			boolean isAplicaAbonadoCero=false;
			if (parametros.getOrdenServicio()!=null){
				if (false) {//parametros.getOrdenServicio().equals("40008"))  sin cargos X abonado0 191009 pv 
					clienteDestino.setCodCliente(Long.parseLong(parametros.getCodigoClienteDestino()));
					clienteDestino = clienteBO.obtenerDatosCliente(clienteDestino);
					//(+)EV, 28/07/08
					//isAplicaAbonadoCero=clienteDestino.getCodTipoPlanTarif().equals(global.getValor("tipo.plan.tarifario.empresa"))?true:false;
					boolean esEmpresa = clienteDestino.getCodTipoPlanTarif().equals(global.getValor("tipo.plan.tarifario.empresa"))?true:false;
					ParamCargosAbonadoCeroDTO param = new ParamCargosAbonadoCeroDTO();
					param.setCodCliente(clienteDestino.getCodCliente());
					if (esEmpresa)	isAplicaAbonadoCero = cargoBO.getValidacionAbonadoCero(param).isResultado();
					//(-)
				}
			}
			logger.debug("isAplicaAbonadoCero["+isAplicaAbonadoCero+"]");
			AbonadoDTO abonadoDTO= new AbonadoDTO();
			logger.debug("Inicio recorre lista de abonados...");
			for(int i=0;i<parametros.getAbonados().length;i++){
				String numAbonado=parametros.getAbonados()[i];
				
				logger.debug("ABONADO: " + numAbonado);
				
				abonadoDTO.setNumAbonado(Long.parseLong(numAbonado));
				//abonadoDTO.setCodCliente(Long.parseLong(parametros.getCodigoClienteOrigen()));
				
				abonadoDTO=	"0".equalsIgnoreCase(numAbonado)?abonadoDTO:abonadoBO.obtenerDatosAbonado(abonadoDTO);
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
				if (tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.servicios.ocasionales"))){
					ReglasServiciosOcasionalesPV reglasServiciosOcasionales=new ReglasServiciosOcasionalesPV(getParametrosReglaServiciosOcasionales(parametros,abonadoDTO)); 
					arregloReglas.add(reglasServiciosOcasionales);
				}
				else if (!tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.reglas.simcard"))&&!tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.reglas.servicios.suplementarios"))
						&&!tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.reglas.terminal"))) {
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
					long numCliAnt = abonadoDTO.getCodCliente();
					abonadoDTO.setCodCliente(Long.parseLong(parametros.getCodigoClienteDestino()));
					ReglasAbonadoCero reglasAbonadoCero =new ReglasAbonadoCero(getParametrosReglaAbonadoCero(parametros,abonadoDTO));
					arregloReglas.add(reglasAbonadoCero);
					abonadoDTO.setCodCliente(numCliAnt);
				}
				
				//TODO : Cargos Cambio Simcard
				
				if (tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.reglas.simcard"))){
					ReglasSimcard reglasSimcard=new ReglasSimcard(getParametrosReglasSimcard(parametros,abonadoDTO));
					arregloReglas.add(reglasSimcard);
				}
				
				if (tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.reglas.servicios.suplementarios"))){
					
					String[] arrayCodServ=recuperaCodigoServSuplementario(parametros.getCodigoServicio());
					boolean aplicaRegla=arrayCodServ!=null&&arrayCodServ.length>0?true:false;
					if (aplicaRegla){
						for (int k=0;k<arrayCodServ.length;k++){
							parametros.setCodServSS(arrayCodServ[k]);
							ReglasServiciosSuplementariosPV reglasSimcard=new ReglasServiciosSuplementariosPV(getParametrosReglasServiciosSuplentarios(parametros,abonadoDTO));
							arregloReglas.add(reglasSimcard);
						}
					}
					String codCausaCamPlan=parametros.getCodCausaCambioPlan();
					if (codCausaCamPlan!=null){
						ReglasSSAdelantado reglasSSAdelantado=new ReglasSSAdelantado(getParametrosReglaSSAdelantado(parametros,abonadoDTO));  /* ocb adelantado */	
						 arregloReglas.add(reglasSSAdelantado);	 /* ocb adelantado */
					}
				}
				
				if (tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.reglas.terminal"))){
				//-- CARGOS TERMINAL
					//------------------
				   ReglasTerminalPV reglaTerminal = new ReglasTerminalPV(getParametrosReglaTerminal(parametros,abonadoDTO));
				   arregloReglas.add(reglaTerminal);
				}
				
				if (tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.reglas.habilitacion"))){
					ReglasHabilitacion reglasHabilitacion=new ReglasHabilitacion(getParametrosReglaHabilitacion(parametros,abonadoDTO)); 
					arregloReglas.add(reglasHabilitacion);
				}
				
				if (tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.reglas.terminal.restitucion"))){
					ReglasTerminalRestitucionPV reglasTerminalRestitucionPV=new ReglasTerminalRestitucionPV(getParametrosReglaTerminalRestitucion(parametros,abonadoDTO)); 
					arregloReglas.add(reglasTerminalRestitucionPV);
				}
				
				logger.debug("TIPO_PANTALLA: " + tipoPantalla);
				logger.debug("TIPO_PANTALLA_PROPERTIES: " + global.getValor("codigo.tipo.pantalla.reglas.simcard.restitucion"));
				
				if (tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.reglas.simcard.restitucion"))){

					logger.debug("CARGOS DE SIMCARD PARA RESTITUCION");
					
					ReglasSimcardRestitucion reglasSimcardRestitucion=new ReglasSimcardRestitucion(getParametrosReglasSimcardRestitucion(parametros,abonadoDTO)); 
					arregloReglas.add(reglasSimcardRestitucion);
				}
				
				//Se crea nueva pantalla pero se reutiliza ReglasEquipoCargador
				if (tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.reglas.estado.devolucion"))){

					logger.debug("CARGOS DE ESTADO DEVOLUCION DE EQUIPO");
					
					ReglasEquipoCargador reglasEquipoCargador=new ReglasEquipoCargador(getParametrosReglaEquipoCargador(parametros,abonadoDTO));
					arregloReglas.add(reglasEquipoCargador);
				}
				
				if (tipoPantalla.equals(global.getValor("codigo.tipo.pantalla.reglas.dif.garantia"))){

					logger.debug("CARGOS POR DIFERENCIA DE GARANTIA");
					
					ReglasDiferenciaGarantia reglasDifGarantia=new ReglasDiferenciaGarantia(getParametrosReglaDifGarantia(parametros,abonadoDTO));
					arregloReglas.add(reglasDifGarantia);
				}
				
				ReglaListaPrecio[] coleccionReglas =(ReglaListaPrecio[])ArrayUtl.copiaArregloTipoEspecifico(arregloReglas.toArray(),ReglaListaPrecio.class);
				
				procesadorCargos.calcularCargos(coleccionReglas);
			}
			CargosDTO[] cargos = procesadorCargos.obtenerCargos();
			
			resultado.setCargos(cargos);
			logger.debug("Fin:obtenerCargos()");
		}catch(GeneralException e){
			throw new FrmkCargosException("",e, e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		}
		logger.debug("fin obtenerCargos FrmkCargosEJBEAR.ear --------");
		return resultado;
		
		//----------------------
		
		
	}//fin obtenerCargos
	
	
	/**
	 * obtiene los parametros para buscar los precios y descuento por concepto de garantia
	 * @param parametros
	 * @param abonadoDTO
	 * @return
	 */
	private ParametrosReglasDiferenciaGarantiaDTO getParametrosReglaDifGarantia(ParametrosObtencionCargosDTO parametros, AbonadoDTO abonadoDTO) {

		ParametrosReglasDiferenciaGarantiaDTO result = new ParametrosReglasDiferenciaGarantiaDTO();
			result.setValorDiferencia(parametros.getValorDiferencia());
		return result;
	}


	/**
	 * Registra una solicitud de aprobación de descuento en SCL
	 * @param parametros
	 * @return
	 * @throws ProyectoException
	 * @throws FrameworkCargosException
	 */
	public RespuestaSolicitudDTO solicitarAprobacionDescuento(RegistroSolicitudListDTO registro)throws FrmkCargosException{
		RespuestaSolicitudDTO respuesta = new RespuestaSolicitudDTO();
		long lNumeroAutorizacion;
		long lNumAbonado = 0;
		
		try {
				
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
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}
		return respuesta;	
	}
	
	public RegistroSolicitudDTO consultarEstadoSolicitud(RegistroSolicitudDTO registro) throws FrmkCargosException{
		RegistroSolicitudDTO respuesta = null;
		
		try {
			
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
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}
		return respuesta;			
	}
	
	public RetornoDTO eliminarSolicitud(RegistroSolicitudDTO registro) throws FrmkCargosException{
		RetornoDTO respuesta = null;
		try {
			
			logger.debug("eliminarSolicitud():start");
			respuesta = planDescuentoBO.eliminarSolicitudDescuento(registro);
			logger.debug("eliminarSolicitud():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}
		return respuesta;		
	}
	
	
	
	public ImpuestosDTO obtenerImpuestos(ImpuestosDTO impuestos) throws FrmkCargosException{
		ImpuestosDTO respuesta = null;
		try {
			
			logger.debug("obtenerImpuestos():start");
			respuesta = cargoBO.obtenerImpuestos(impuestos);
			logger.debug("obtenerImpuestos():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}
		return respuesta;		
	}

	public RetornoDTO aceptarPresupuesto(PresupuestoDTO presup) throws FrmkCargosException{
		RetornoDTO respuesta = null;
		try {
			
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
			Date fecha = new Date(System.currentTimeMillis());	
			Calendar cal = new GregorianCalendar(); 
		    cal.setTimeInMillis(fecha.getTime()); 
		    cal.add(Calendar.DATE, numDias); 
		    Date fechaVencimiento = new Date(cal.getTimeInMillis());
		    
			presup.setFechaVcto(fechaVencimiento);
			respuesta = cargoBO.aceptarPresupuesto(presup);
			logger.debug("aceptarPresupuesto():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}
		return respuesta;		
		
	}

	public RetornoDTO finalizarCargosFacturados(ProductoContratadoListDTO listaProductos) throws FrmkCargosException 
	{
		RetornoDTO resultado = null;
		try{
			
			logger.debug("Inicio:finalizarCargosFacturados()");
			resultado = cargoFacturadoBO.eliminar(listaProductos);
			logger.debug("Fin:finalizarCargosFacturados()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}			
		return resultado;
	}

	public RetornoDTO descontratarCargosRecurrentes(ProductoContratadoListDTO listaProductos) throws FrmkCargosException {
		RetornoDTO resultado = null;
		try{
			
	
			logger.debug("Inicio:descontratarCargosRecurrentes()");
			resultado = cargoFacturadoBO.desactivar(listaProductos);
			logger.debug("Fin:descontratarCargosRecurrentes()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}			
		return resultado;
	}

	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de los Servicios de Segmentacion
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaSegmentacion
	 * @throws FrmkCargosException
	 */
	private ParametrosReglasServicioOcacionalPVDTO getParametrosReglaServiciosOcasionales(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado)throws FrmkCargosException{
		
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
	}//fin getParametrosReglaServicioSegmentacion
	
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos para la habilitacion
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return ParametrosReglasHabilitacionDTO
	 * @throws FrmkCargosException
	 */
	private ParametrosReglasHabilitacionDTO getParametrosReglaHabilitacion(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado)throws FrmkCargosException{
		
		ParametrosReglasHabilitacionDTO paramRegHabilitacionDTO =new ParametrosReglasHabilitacionDTO();
		
		try{
			
			logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaHabilitacion:");
			
			paramRegHabilitacionDTO.setIndComodato(parametros.getIndComodato());
			paramRegHabilitacionDTO.setCodigoProducto(global.getValor("codigo.producto"));
			paramRegHabilitacionDTO.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
			paramRegHabilitacionDTO.setTipoStock(parametros.getTipoStock());
			paramRegHabilitacionDTO.setCodArticulo(parametros.getCodArticulo());
			paramRegHabilitacionDTO.setCodUso(parametros.getCodUso());
			paramRegHabilitacionDTO.setNumeroMeses(parametros.getNumeroMesesContrato());
			paramRegHabilitacionDTO.setCodPlanTarifDestino(parametros.getCodigoPlanTarifDestino());
			paramRegHabilitacionDTO.setCodAntiguedad(global.getValor("codigo.antiguedad"));
			
			paramRegHabilitacionDTO.setCodigoPlanTarifario(abonado.getCodPlanTarif());
			
			//########### datos para descuentos #####################
			
			ParametrosDescuentoDTO parametrosDescuentoDTO=new ParametrosDescuentoDTO();
			parametrosDescuentoDTO.setIndicadorCiclo(global.getValor("indicador.ciclo"));
			parametrosDescuentoDTO.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
			
			
			
			ParametrosGeneralesDTO parametrosDTO =new ParametrosGeneralesDTO();
			parametrosDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosDTO.setNombreparametro(global.getValor("parametro.preciolista"));
			
			parametrosDTO=parametrosGeneralesBO.getParametroGeneral(parametrosDTO);
			
			//obtener parametro de concepto descuento
			parametrosDTO.setNombreparametro(global.getValor("parametro.clasedescuento"));
			parametrosDTO=parametrosGeneralesBO.getParametroGeneral(parametrosDTO);
			parametrosDescuentoDTO.setClaseDescuento(parametrosDTO.getValorparametro());
			parametros.setIndicadorTipoVenta(0);
			paramRegHabilitacionDTO.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
			/***
			 * @author rlozano
			 * @descripcion Para el cambio de simcard el tipo de venta es interno es decir indice de venta externa =0
			 */
			/*if (parametros.getIndicadorTipoVenta()==Integer.parseInt(global.getValor("indicador.venta.distribuidor"))) 
				parametrosDescuentoDTO.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
			else*/
			//parametrosDescuentoDTO.setIndiceVentaExterna(global.getValor("indice.venta.interna"));
			//parametrosDescuentoDTO.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
			
			VendedorDTO vendedorDTO = new VendedorDTO();
			vendedorDTO.setCodigoVendedor(parametros.getCodigoVendedor());
			vendedorDTO = vendedorBO.verificaVendedorEsExterno(vendedorDTO);
			
			if (!vendedorDTO.isVendedorInterno()) {
				//venta externa
				parametrosDescuentoDTO.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
			}else{
				//venta intera
				parametrosDescuentoDTO.setIndiceVentaExterna(global.getValor("indice.venta.interna"));
			}
			
			parametrosDescuentoDTO.setCodigoVendedor(String.valueOf(parametros.getCodigoVendedor()));
			parametrosDescuentoDTO.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));		
			parametrosDescuentoDTO.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
			parametrosDescuentoDTO.setCodigoContratoNuevo(parametros.getTipoContrato());
			//parametrosDescuentoDTO.setCodigoCausaDescuento(parametros.getCodigoCausalDescuento());
			parametrosDescuentoDTO.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
			parametrosDescuentoDTO.setTipoPlanTarifario(abonado.getCodTipPlan());
			parametrosDescuentoDTO.setCodigoTipoPlanTarifario(abonado.getCodTipoPlanTarif());
			parametrosDescuentoDTO.setCodigoCliente(paramRegHabilitacionDTO.getCodigoCliente());
			parametrosDescuentoDTO.setIndicadorCiclo(global.getValor("indicador.ciclo"));
			parametrosDescuentoDTO.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
			parametrosDescuentoDTO.setCodigoOperacion(global.getValor("codigo.operacion.cambiosimcard"));
			
			parametrosDescuentoDTO.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
			
			parametrosDescuentoDTO.setEquipoEstado(global.getValor("equipo.estado"));
			parametrosDescuentoDTO.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
			
			paramRegHabilitacionDTO.setParametrosDescuento(parametrosDescuentoDTO);
			
		} 
		catch(Exception e){
			e.printStackTrace();
		}
			return paramRegHabilitacionDTO;
	}//fin getParametrosReglaServicioSegmentacion
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de los Servicios Ocacionales
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaSegmentacion
	 * @throws FrmkCargosException
	 */
	private ParametrosReglasSegmentacionDTO getParametrosReglaSegmentacion(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws FrmkCargosException{
		
		ParametrosReglasSegmentacionDTO paramRegSegmentacionDTO =new ParametrosReglasSegmentacionDTO();
		try{
			logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSegmentacion:");
			
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
			throw new FrmkCargosException(e);
		}
			return paramRegSegmentacionDTO;
	}
			
			
	/* ocb adelantado */				
			
	/**
	 * Obtiene parametros necesarios para buscar los precios cobros adelantados
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return ParametrosReglasSSAdelantadoDTO
	 * @throws FrmkCargosException
	 */
	private ParametrosReglasSSAdelantadoDTO getParametrosReglaSSAdelantado(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws FrmkCargosException{
		
		ParametrosReglasSSAdelantadoDTO paramRegSSAdelantadoDTO =new ParametrosReglasSSAdelantadoDTO();
		
		try{
			logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSSAdelantado:");
			
			//TODO: Se cargan datos de consulta sobre el Plan Tarifario Origen y Destino
			
			
			paramRegSSAdelantadoDTO.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
			String codPlanTarifOrig=parametros.getCodigoPlanTarifOrigen();
			codPlanTarifOrig=codPlanTarifOrig==null?"":codPlanTarifOrig;
			paramRegSSAdelantadoDTO.setCodigoPlanTarifOrigen(codPlanTarifOrig);
			logger.debug("Clase:::"+getClass().getName()+"::getParametrosReglaSSAdelantado:1");
			paramRegSSAdelantadoDTO.setCodigoProducto(global.getValor("codigo.producto"));
			paramRegSSAdelantadoDTO.setCodigoTecnologia(parametros.getCodigoTecnologia());
			paramRegSSAdelantadoDTO.setCodigoModulo(global.getValor("codigo.modulo.YX"));
			String codCausCamPlan=parametros.getCodCausaCambioPlan();
			codCausCamPlan=codCausCamPlan==null?"":codCausCamPlan;
			paramRegSSAdelantadoDTO.setCodCausaCambioPlan(codCausCamPlan);
			String codClieOrig=parametros.getCodigoClienteOrigen();
			codClieOrig=codClieOrig==null||codClieOrig.trim().equals("")?"0":codClieOrig;
			paramRegSSAdelantadoDTO.setCodigoCliente(codClieOrig);
			paramRegSSAdelantadoDTO.setCodOS(parametros.getOrdenServicio());
			paramRegSSAdelantadoDTO.setTipoPantalla(parametros.getTipoPantalla());
			paramRegSSAdelantadoDTO.setCodCausaCambioPlan(parametros.getCodCausaCambioPlan());
			RegistroFacturacionDTO registroFact= new RegistroFacturacionDTO();
			registroFact.setCodigoSecuencia(global.getValor("secuencia.pv.seq.numos"));
			registroFact = registroFacturacionBO.getSecuenciaProcesoFacturacion(registroFact);
			paramRegSSAdelantadoDTO.setNumProceso(String.valueOf(registroFact.getNumeroProcesoFacturacion()));
			paramRegSSAdelantadoDTO.setCodPlanServ(parametros.getCodPlanServ());
		
		} 
		catch(Exception e){
			throw new FrmkCargosException(e);
		}
			return paramRegSSAdelantadoDTO;	
			
		/* ocb adelantado */	
			
			
			
			
	}//fin getParametrosReglaServicioOcacional
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de Baja Opta Prepago
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaBajaOptaPrepago
	 * @throws FrmkCargosException
	 */
	private ParametrosReglasBajaOptaPrepagoSinPenalizacionDTO getParametrosReglaBajaOptaPrepagoSinPenalizacion(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws FrmkCargosException{
		
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
			throw new FrmkCargosException(e);
		}
			return paramRegBajaOptaPrepagoSinPenalizacionDTO;
	}
	
		
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de Baja Opta Prepago
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaBajaOptaPrepago
	 * @throws FrmkCargosException
	 */
	private ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO getParametrosReglaPenalizacion(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws FrmkCargosException{
		
		ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO paramRegBajaOptaPrepagoBajaAbonadoDTO =new ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO();
		try{
			
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_Penaliza(parametros.getCodPenalizacion());
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_Producto(Long.parseLong(global.getValor("codigo.producto")));
			paramRegBajaOptaPrepagoBajaAbonadoDTO.setCod_Modulo(global.getValor("codigo.modulo.GA"));
		} 
		catch(Exception e){
			throw new FrmkCargosException(e);
		}
			return paramRegBajaOptaPrepagoBajaAbonadoDTO;
	}
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de Baja Opta Prepago
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaBajaOptaPrepago
	 * @throws FrmkCargosException
	 */
	private ParametrosReglasBajaOptaPrepagoBajaAbonadoDTO getParametrosReglaEquipoCargador(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws FrmkCargosException{
		
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
			throw new FrmkCargosException(e);
		}
			return paramRegBajaOptaPrepagoBajaAbonadoDTO;
	}
	
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de Baja Opta Prepago
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaBajaOptaPrepago
	 * @throws FrmkCargosException
	 */
	private ParametrosReglasBajaOptaPrepagoIndemnizacionDTO getParametrosReglaBajaOptaPrepagoIndemnizacion(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws FrmkCargosException{
		
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
			throw new FrmkCargosException(e);
		}
			return paramRegBajaOptaPrepagoIndemnizacionDTO;
	}
	

	
	public RetornoDTO consultarEstadoFacturado(long numProceso) throws FrmkCargosException{
		RetornoDTO resultado = null;
		try{
			
			logger.debug("Inicio:consultarEstadoFacturado()");
			resultado = cargoBO.consultarEstadoFacturado(numProceso);
			logger.debug("Fin:consultarEstadoFacturado()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}			
		return resultado;
	}
	
	public PresupuestoDTO obtenerDetallePresupuesto(PresupuestoDTO presup) throws FrmkCargosException{
		PresupuestoDTO resultado = null;
		try{
			
	
			logger.debug("Inicio:obtenerDetallePresupuesto()");
			resultado = cargoBO.obtenerDetallePresupuesto(presup);
			logger.debug("Fin:obtenerDetallePresupuesto()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}			
		return resultado;
	}
	
	public DescuentoDTO obtenerCodConceptoDescuento(DatosGeneralesDTO sec) throws FrmkCargosException{
		DescuentoDTO resultado = null;
		try{
			
	
			logger.debug("Inicio:obtenerCodConceptoDescuento()");
			resultado = cargoBO.obtenerCodConceptoDescuento(sec);
			logger.debug("Fin:obtenerCodConceptoDescuento()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}			
		return resultado;		
	}
	
	public RetornoDTO eliminaCodConceptoDescuento(long numTransaccion) throws FrmkCargosException{
		RetornoDTO resultado = null;
		try{
			
			logger.debug("Inicio:eliminaCodConceptoDescuento()");
			resultado = cargoBO.eliminaCodConceptoDescuento(numTransaccion);
			logger.debug("Fin:eliminaCodConceptoDescuento()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}			
		return resultado;			
		
	}
	
	public RetornoDTO insertarConceptoDescuento(DescuentoDTO desc) throws FrmkCargosException{
		RetornoDTO resultado = null;
		try{
			
			logger.debug("Inicio:insertarConceptoDescuento()");
			resultado = cargoBO.insertarConceptoDescuento(desc);
			logger.debug("Fin:insertarConceptoDescuento()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}			
		return resultado;			
		
	}
	
	public RetornoDTO eliminarPresupuesto(RegistroFacturacionDTO registro) throws FrmkCargosException{
		RetornoDTO resultado = null;
		try{
			
	
			logger.debug("Inicio:eliminarPresupuesto()");
			resultado = cargoBO.eliminarPresupuesto(registro);
			logger.debug("Fin:eliminarPresupuesto()");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new FrmkCargosException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}			
		return resultado;			
		
	}

	/**
	 * Obtiene parametros necesarios para buscar los cargos de SimCard
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametrosReglasSimcardDTO
	 * @throws FrmkCargosException
	 */
	private ParametrosReglasSimcardDTO getParametrosReglasSimcard(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado)throws FrmkCargosException{
		
		ParametrosReglasSimcardDTO parametrosCargoSimcardDTO =new ParametrosReglasSimcardDTO();
		try{
			parametrosCargoSimcardDTO.setCodigoArticulo(parametros.getCodArticulo());
			parametrosCargoSimcardDTO.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
			//parametrosCargoSimcardDTO.setTipoStock(parametros.getTipoStock());
			parametrosCargoSimcardDTO.setTipoStock("2");
			parametrosCargoSimcardDTO.setCodigoUso(parametros.getCodUso());
			//parametrosCargoSimcardDTO.setEstado(parametros.getEstadoSimcard());
			parametrosCargoSimcardDTO.setEstado("1");
			parametrosCargoSimcardDTO.setCodigoCategoria(parametros.getCodCategoria());
			//parametrosCargoSimcardDTO.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
			//parametrosCargoSimcardDTO.setTipoContrato(parametros.getTipoContrato());
			parametrosCargoSimcardDTO.setCodigoPlanTarifario(abonado.getCodPlanTarif());
			//parametrosCargoSimcardDTO.setCodigoCliente(parametros.getCodigoClienteOrigen());

			/**
			 * @author ggaletti
			 * @description se recupera parametro de precios lista
			 * @param  ObtieneGedParametros("PRECIO_LISTA_EQUIPO", "GA", 1)
			 */
			
			
			//parametrosCargoSimcardDTO.setCodigoPlanTarifario(abonado.getCodPlanTarif());
			parametrosCargoSimcardDTO.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
			parametrosCargoSimcardDTO.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
			parametrosCargoSimcardDTO.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
						
			ParametrosGeneralesDTO parametrosDTO =new ParametrosGeneralesDTO();
			parametrosDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosDTO.setNombreparametro(global.getValor("parametro.preciolista"));
			
			parametrosDTO=parametrosGeneralesBO.getParametroGeneral(parametrosDTO);
			parametrosCargoSimcardDTO.setIndicadorPrecioLista(parametrosDTO.getValorparametro());
			parametrosCargoSimcardDTO.setCodigoPlanTarifario(abonado.getCodPlanTarif());
			//parametrosCargoSimcardDTO.setIndiceRecambioNoLista(global.getValor("indice.recambio.nolista"));
			ParametrosDescuentoDTO parametrosDescuentoDTO=new ParametrosDescuentoDTO();
			//parametrosDescuentoDTO.setClaseDescuentoArticulo(global.getValor("parametro.clasedescuento.articulo"));
			if (parametros.getNumOsRenova()!=null && !parametros.getNumOsRenova().equals("")) {
				parametrosDescuentoDTO.setParamRenova("1");
				parametrosCargoSimcardDTO.setParamRenova("1");
			} else {
				parametrosDescuentoDTO.setParamRenova("0");
				parametrosCargoSimcardDTO.setParamRenova("0");
			}
			//obtener parametro de concepto descuento
			parametrosDTO.setNombreparametro(global.getValor("parametro.clasedescuento"));
			parametrosDTO=parametrosGeneralesBO.getParametroGeneral(parametrosDTO);
			parametrosDescuentoDTO.setClaseDescuento(parametrosDTO.getValorparametro());
			
			parametrosCargoSimcardDTO.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
			
			parametrosCargoSimcardDTO.setIndiceRecambioPrecioLista(global.getValor("indice.recambio.preciolista"));
			parametrosCargoSimcardDTO.setIndiceRecambioNoLista(global.getValor("indice.recambio.nolista"));
			parametrosCargoSimcardDTO.setCodigoCategoria(parametros.getCodCategoria());
			parametros.setIndicadorTipoVenta(0);
			parametrosDescuentoDTO.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
			parametrosCargoSimcardDTO.setNumSerie(parametros.getNumSerieSimcard());
			/***
			 * @author rlozano
			 * @descripcion Para el cambio de simcard el tipo de venta es interno es decir indice de venta externa =0
			 */
			/*if (parametros.getIndicadorTipoVenta()==Integer.parseInt(global.getValor("indicador.venta.distribuidor"))) 
				parametrosDescuentoDTO.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
			else*/
				parametrosDescuentoDTO.setIndiceVentaExterna(global.getValor("indice.venta.interna"));
			parametrosDescuentoDTO.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));		
			parametrosDescuentoDTO.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
			parametrosDescuentoDTO.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
			parametrosDescuentoDTO.setCodigoContratoNuevo(parametros.getTipoContrato());
			//parametrosDescuentoDTO.setCodigoCausaDescuento(parametros.getCodigoCausalDescuento());
			parametrosDescuentoDTO.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
			parametrosDescuentoDTO.setTipoPlanTarifario(abonado.getCodTipPlan());
			parametrosDescuentoDTO.setCodigoTipoPlanTarifario(abonado.getCodTipoPlanTarif());
			parametrosDescuentoDTO.setCodigoCliente(parametrosCargoSimcardDTO.getCodigoCliente());
			parametrosDescuentoDTO.setIndicadorCiclo(global.getValor("indicador.ciclo"));
			parametrosDescuentoDTO.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
			parametrosDescuentoDTO.setCodigoOperacion(global.getValor("codigo.operacion.cambiosimcard"));
			
			parametrosDescuentoDTO.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
			
			parametrosDescuentoDTO.setEquipoEstado(global.getValor("equipo.estado"));
			parametrosDescuentoDTO.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
			//En este caso corresponde a la causa de cambio de simcard
			parametrosDescuentoDTO.setCodigoCausaVenta(parametros.getCodCausaCambioPlan());
			
			parametrosCargoSimcardDTO.setParametrosDescuento(parametrosDescuentoDTO);
			
		} 
		catch(Exception e){
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}
			return parametrosCargoSimcardDTO;
	}//fin getParametrosReglaServicioSegmentacion
	
	/**
	 * Obtiene parametros necesarios para buscar los cargos de SimCard
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametrosReglasSimcardDTO
	 * @throws FrmkCargosException
	 */
	private ParametrosReglasSimcardRestitucionDTO getParametrosReglasSimcardRestitucion(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado)throws FrmkCargosException{
		
		ParametrosReglasSimcardRestitucionDTO parametrosCargoSimcardDTO =new ParametrosReglasSimcardRestitucionDTO();
		try{
			parametrosCargoSimcardDTO.setCodigoArticulo(parametros.getCodArticulo());
			parametrosCargoSimcardDTO.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
			//parametrosCargoSimcardDTO.setTipoStock(parametros.getTipoStock());
			parametrosCargoSimcardDTO.setTipoStock("2");
			parametrosCargoSimcardDTO.setCodigoUso(parametros.getCodUso());
			//parametrosCargoSimcardDTO.setEstado(parametros.getEstadoSimcard());
			parametrosCargoSimcardDTO.setEstado("1");
			parametrosCargoSimcardDTO.setCodigoCategoria(parametros.getCodCategoria());
			//parametrosCargoSimcardDTO.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
			//parametrosCargoSimcardDTO.setTipoContrato(parametros.getTipoContrato());
			parametrosCargoSimcardDTO.setCodigoPlanTarifario(abonado.getCodPlanTarif());
			//parametrosCargoSimcardDTO.setCodigoCliente(parametros.getCodigoClienteOrigen());

			/**
			 * @author ggaletti
			 * @description se recupera parametro de precios lista
			 * @param  ObtieneGedParametros("PRECIO_LISTA_EQUIPO", "GA", 1)
			 */
			
			
			//parametrosCargoSimcardDTO.setCodigoPlanTarifario(abonado.getCodPlanTarif());
			parametrosCargoSimcardDTO.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
			parametrosCargoSimcardDTO.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
			parametrosCargoSimcardDTO.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
						
			ParametrosGeneralesDTO parametrosDTO =new ParametrosGeneralesDTO();
			parametrosDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosDTO.setNombreparametro(global.getValor("parametro.preciolista"));
			
			parametrosDTO=parametrosGeneralesBO.getParametroGeneral(parametrosDTO);
			parametrosCargoSimcardDTO.setIndicadorPrecioLista(parametrosDTO.getValorparametro());
			parametrosCargoSimcardDTO.setCodigoPlanTarifario(abonado.getCodPlanTarif());
			//parametrosCargoSimcardDTO.setIndiceRecambioNoLista(global.getValor("indice.recambio.nolista"));
			ParametrosDescuentoDTO parametrosDescuentoDTO=new ParametrosDescuentoDTO();
			//parametrosDescuentoDTO.setClaseDescuentoArticulo(global.getValor("parametro.clasedescuento.articulo"));
			if (parametros.getNumOsRenova()!=null && !parametros.getNumOsRenova().equals("")) {
				parametrosDescuentoDTO.setParamRenova("1");
				parametrosCargoSimcardDTO.setParamRenova("1");
			} else {
				parametrosDescuentoDTO.setParamRenova("0");
				parametrosCargoSimcardDTO.setParamRenova("0");
			}
			//obtener parametro de concepto descuento
			parametrosDTO.setNombreparametro(global.getValor("parametro.clasedescuento"));
			parametrosDTO=parametrosGeneralesBO.getParametroGeneral(parametrosDTO);
			parametrosDescuentoDTO.setClaseDescuento(parametrosDTO.getValorparametro());
			
			parametrosCargoSimcardDTO.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
			
			parametrosCargoSimcardDTO.setIndiceRecambioPrecioLista(global.getValor("indice.recambio.preciolista"));
			parametrosCargoSimcardDTO.setIndiceRecambioNoLista(global.getValor("indice.recambio.nolista"));
			parametrosCargoSimcardDTO.setCodigoCategoria(parametros.getCodCategoria());
			parametros.setIndicadorTipoVenta(0);
			parametrosDescuentoDTO.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
			parametrosCargoSimcardDTO.setNumSerie(parametros.getNumSerieSimcard());
			/***
			 * @author rlozano
			 * @descripcion Para el cambio de simcard el tipo de venta es interno es decir indice de venta externa =0
			 */
			/*if (parametros.getIndicadorTipoVenta()==Integer.parseInt(global.getValor("indicador.venta.distribuidor"))) 
				parametrosDescuentoDTO.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
			else*/
				parametrosDescuentoDTO.setIndiceVentaExterna(global.getValor("indice.venta.interna"));
			parametrosDescuentoDTO.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));		
			parametrosDescuentoDTO.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
			parametrosDescuentoDTO.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
			parametrosDescuentoDTO.setCodigoContratoNuevo(parametros.getTipoContrato());
			//parametrosDescuentoDTO.setCodigoCausaDescuento(parametros.getCodigoCausalDescuento());
			parametrosDescuentoDTO.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
			parametrosDescuentoDTO.setTipoPlanTarifario(abonado.getCodTipPlan());
			parametrosDescuentoDTO.setCodigoTipoPlanTarifario(abonado.getCodTipoPlanTarif());
			parametrosDescuentoDTO.setCodigoCliente(parametrosCargoSimcardDTO.getCodigoCliente());
			parametrosDescuentoDTO.setIndicadorCiclo(global.getValor("indicador.ciclo"));
			parametrosDescuentoDTO.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
			parametrosDescuentoDTO.setCodigoOperacion(global.getValor("codigo.operacion.cambiosimcard"));
			
			parametrosDescuentoDTO.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
			
			parametrosDescuentoDTO.setEquipoEstado(global.getValor("equipo.estado"));
			parametrosDescuentoDTO.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
			//En este caso corresponde a la causa de cambio de simcard
			parametrosDescuentoDTO.setCodigoCausaVenta(parametros.getCodCausaCambioPlan());
			
			parametrosCargoSimcardDTO.setParametrosDescuento(parametrosDescuentoDTO);
			
		} 
		catch(Exception e){
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}
			return parametrosCargoSimcardDTO;
	}
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos de Abonado Cero
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaBajaOptaPrepago
	 * @throws AppPriDisRebException
	 */
	private ParametrosReglasAbonadoCeroDTO getParametrosReglaAbonadoCero(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws FrmkCargosException{
		
		ParametrosReglasAbonadoCeroDTO parametrosReglasAbonadoCeroDTO =new ParametrosReglasAbonadoCeroDTO();
		try{
			parametrosReglasAbonadoCeroDTO.setCodigoModulo(global.getValor("codigo.modulo.GE"));
			parametrosReglasAbonadoCeroDTO.setNombreTabla(global.getValor("nombre.tabla.fa_conceptos"));
			parametrosReglasAbonadoCeroDTO.setNombreColumna(global.getValor("nombre.columna.cod_concepto"));
			parametrosReglasAbonadoCeroDTO.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
			parametrosReglasAbonadoCeroDTO.setFechaVigenciaAbonadoCero(parametros.getFechaVigenciaAbonadoCero());
			parametrosReglasAbonadoCeroDTO.setCodigoProducto(Long.parseLong(global.getValor("codigo.producto")));
		} 
		catch(Exception e){
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}
			return parametrosReglasAbonadoCeroDTO;
	}
	
	/**
	 * Obtiene parametros necesarios para buscar los cargos de SimCard
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametrosReglasSimcardDTO
	 * @throws FrmkCargosException
	 */
	private ParametrosReglasServicioSuplementarioDTO getParametrosReglasServiciosSuplentarios(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado)throws FrmkCargosException{
		
		ParametrosReglasServicioSuplementarioDTO parametrosReglasServicioSuplementarioDTO =new ParametrosReglasServicioSuplementarioDTO();
		try{
			
			
			parametrosReglasServicioSuplementarioDTO.setCodigoProducto(global.getValor("codigo.producto"));
			parametrosReglasServicioSuplementarioDTO.setCodigoServicio(parametros.getCodServSS());
			parametrosReglasServicioSuplementarioDTO.setCodigoPlanServicio(abonado.getCodPlanServ());
			parametrosReglasServicioSuplementarioDTO.setCodigoActuacion(parametros.getCodActabo());
			parametrosReglasServicioSuplementarioDTO.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
			parametrosReglasServicioSuplementarioDTO.setCodigoPlanTarifario(abonado.getCodPlanTarif());
			
			
			ParametrosDescuentoDTO parametrosDescuentoDTO=new ParametrosDescuentoDTO();
			parametrosDescuentoDTO.setIndicadorCiclo(global.getValor("indicador.ciclo"));
			parametrosDescuentoDTO.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
			
			
			
			ParametrosGeneralesDTO parametrosDTO =new ParametrosGeneralesDTO();
			parametrosDTO.setCodigomodulo(global.getValor("codigo.modulo.GA"));
			parametrosDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosDTO.setNombreparametro(global.getValor("parametro.preciolista"));
			
			parametrosDTO=parametrosGeneralesBO.getParametroGeneral(parametrosDTO);
			
			//obtener parametro de concepto descuento
			parametrosDTO.setNombreparametro(global.getValor("parametro.clasedescuento"));
			parametrosDTO=parametrosGeneralesBO.getParametroGeneral(parametrosDTO);
			parametrosDescuentoDTO.setClaseDescuento(parametrosDTO.getValorparametro());
			parametros.setIndicadorTipoVenta(0);
			parametrosReglasServicioSuplementarioDTO.setNumAbonado(String.valueOf(abonado.getNumAbonado()));
			/***
			 * @author rlozano
			 * @descripcion Para el cambio de simcard el tipo de venta es interno es decir indice de venta externa =0
			 */
			/*if (parametros.getIndicadorTipoVenta()==Integer.parseInt(global.getValor("indicador.venta.distribuidor"))) 
				parametrosDescuentoDTO.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
			else*/
				parametrosDescuentoDTO.setIndiceVentaExterna(global.getValor("indice.venta.interna"));
			parametrosDescuentoDTO.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));		
			parametrosDescuentoDTO.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
			parametrosDescuentoDTO.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
			parametrosDescuentoDTO.setCodigoContratoNuevo(parametros.getTipoContrato());
			//parametrosDescuentoDTO.setCodigoCausaDescuento(parametros.getCodigoCausalDescuento());
			parametrosDescuentoDTO.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
			parametrosDescuentoDTO.setTipoPlanTarifario(abonado.getCodTipPlan());
			parametrosDescuentoDTO.setCodigoTipoPlanTarifario(abonado.getCodTipoPlanTarif());
			parametrosDescuentoDTO.setCodigoCliente(parametrosReglasServicioSuplementarioDTO.getCodigoCliente());
			parametrosDescuentoDTO.setIndicadorCiclo(global.getValor("indicador.ciclo"));
			parametrosDescuentoDTO.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
			parametrosDescuentoDTO.setCodigoOperacion(global.getValor("codigo.operacion.cambiosimcard"));
			
			parametrosDescuentoDTO.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
			
			parametrosDescuentoDTO.setEquipoEstado(global.getValor("equipo.estado"));
			parametrosDescuentoDTO.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
			
			
			
			
			
			parametrosReglasServicioSuplementarioDTO.setParametrosDescuento(parametrosDescuentoDTO);
			
		} 
		catch(Exception e){
			logger.debug("Exception[", e);
			throw new FrmkCargosException(e);
		}
			return parametrosReglasServicioSuplementarioDTO;
	}//fin getParametrosReglaServicioSegmentacion
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos
	 * de la regla Terminal
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaTerminal
	 * @throws CustomerDomainException,ProductDomainException
	 */
	private ParametrosReglasTerminalDTO getParametrosReglaTerminal(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws FrmkCargosException{
		
		
		//Obtiene datos del plan tarifario
		ParametrosReglasTerminalDTO parametroReglaTerminal = new ParametrosReglasTerminalDTO();
	try{	
		String usoLinea = null;
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		//Obtiene datos del plan tarifario
		planTarifario.setCodigoTecnologia(abonado.getCodTecnologia());
		planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
		if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.postpago"))){
			usoLinea =  global.getValor("codigo.uso.postpago");
		}else if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.hibrido"))){
			usoLinea =  global.getValor("codigo.uso.hibrido");
		}
		else if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.prepago"))){
			usoLinea =  global.getValor("codigo.uso.prepago");
		}
		
		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral = new ParametrosGeneralesDTO();
		TerminalDTO terminal = new TerminalDTO();
		
		
        //-- OBTIENE PARAMETRO : PRECIO LISTA
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.preciolista"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		String sPrecioLista = parametrosGral.getValorparametro();
		
		//-- BUSCAR DATOS DEL TERMINAL
		/**
		 * @author rlozano
		 * @description se comenta. PostVenta(PV), necesita el terminal q aun no ha sido asignado al 
		 * 				abonado por lo tanto se setea como un parametro del dto obtencion de cargos.
		 *@comments terminal.setNumeroSerie(abonado.getNumSerieTerminal());
		 */
		// 
		terminal.setNumeroSerie(parametros.getNumImei());
		terminal = terminalBO.getTerminal(terminal);
		parametroReglaTerminal.setNumAbonado(String.valueOf(abonado.getNumAbonado())); 
		parametroReglaTerminal.setCodigoArticulo(terminal.getCodigoArticulo());
		parametroReglaTerminal.setTipoStock(terminal.getTipoStock());
		parametroReglaTerminal.setCodigoUso(usoLinea);
		parametroReglaTerminal.setEstado(global.getValor("estado.articulo"));
		parametroReglaTerminal.setCodigoCategoria(terminal.getCodigoCategoria());
		parametroReglaTerminal.setIndicadorValorar(terminal.getIndicadorValorar());
		parametroReglaTerminal.setIndicadorPrecioLista(sPrecioLista);
		parametroReglaTerminal.setIndiceRecambioPrecioLista(global.getValor("indice.recambio.preciolista"));
		parametroReglaTerminal.setIndiceRecambioNoLista(global.getValor("indice.recambio.nolista"));
		parametroReglaTerminal.setCodigoCategoria(global.getValor("codigo.categoria"));
		parametroReglaTerminal.setIndicadorProcEquipo(terminal.getIndProcEq());
		parametroReglaTerminal.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		parametroReglaTerminal.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
		//parametroReglaTerminal.setNumeroSerie(abonado.getNumSerieTerminal());
		parametroReglaTerminal.setNumeroSerie(terminal.getNumeroSerie());
		parametroReglaTerminal.setNumeroImei(terminal.getNumeroSerie());
		parametroReglaTerminal.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
		parametroReglaTerminal.setTipoContrato(parametros.getTipoContrato());
		
		parametroReglaTerminal.setNumeroCelular(String.valueOf(abonado.getNumCelular()));
		parametroReglaTerminal.setNumeroContrato(abonado.getNumContrato());
		parametroReglaTerminal.setCodigoTecnologia(parametros.getCodigoTecnologia());
		
		/*-- Inicio Parametros Descuentos --*/
		ParametrosDescuentoDTO parametrosDescuentoTerminal = new ParametrosDescuentoDTO();
		parametrosDescuentoTerminal.setNumeroMesesContrato(parametros.getNumeroMesesContrato());
		parametrosDescuentoTerminal.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
		
		if (parametros.getIndicadorTipoVenta()==Integer.parseInt(global.getValor("indicador.venta.distribuidor"))) 
			parametrosDescuentoTerminal.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
		else
			parametrosDescuentoTerminal.setIndiceVentaExterna(global.getValor("indice.venta.interna"));
		parametrosDescuentoTerminal.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));
		
		parametrosDescuentoTerminal.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
		parametrosDescuentoTerminal.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametrosDescuentoTerminal.setCodigoContratoNuevo(String.valueOf(abonado.getNumContrato()));
		parametrosDescuentoTerminal.setCodigoCausaDescuento(parametros.getCodigoCausalDescuento());
		parametrosDescuentoTerminal.setCodigoModalidadVenta(String.valueOf(abonado.getCodModVenta()));
		parametrosDescuentoTerminal.setCodigoArticulo(terminal.getCodigoArticulo());
		
		parametrosDescuentoTerminal.setTipoPlanTarifario(planTarifario.getCodigoTipoPlan());
		
		
		
		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.facturacion.codabonocel"));
		parametrosGral = parametrosGeneralesBO.getParametroFacturacion(parametrosGral);
		parametrosDescuentoTerminal.setCodAbonocel(parametrosGral.getValorparametro());
		
		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.clasedescuento"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		parametrosDescuentoTerminal.setClaseDescuento(parametrosGral.getValorparametro());
		
		
		PlanTarifarioDTO planTarifario2 = new PlanTarifarioDTO();
		planTarifario2.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario2 = planTarifarioBO.getCategoriaPlanTarifario(planTarifario2);
		parametrosDescuentoTerminal.setCodigoCategoria(planTarifario2.getCodigoCategoria());
		
		parametrosDescuentoTerminal.setCodigoCausaVenta(parametros.getCodCausaCambioPlan());
		parametrosDescuentoTerminal.setIndicadorCiclo(global.getValor("indicador.ciclo"));
		parametrosDescuentoTerminal.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
		parametrosDescuentoTerminal.setCodigoOperacion(global.getValor("codigo.operacion.cambio.serie"));
		parametrosDescuentoTerminal.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
		parametrosDescuentoTerminal.setEquipoEstado(global.getValor("equipo.estado"));
		parametrosDescuentoTerminal.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
		parametroReglaTerminal.setParametrosDescuento(parametrosDescuentoTerminal);
		parametroReglaTerminal.setParamRenova(parametros.getNumOsRenova());
		if (parametros.getNumOsRenova()!=null && !parametros.getNumOsRenova().equals("")) {
			parametroReglaTerminal.setParamRenova("1");
		} else {
			parametroReglaTerminal.setParamRenova("0");
		}		
	}catch(GeneralException e){
		throw new FrmkCargosException(e);
	}
	
		
		
		return parametroReglaTerminal;
	}//fin getParametrosReglaTerminal
	
	
	/**
	 * Obtiene parametros necesarios para buscar los precios y descuentos
	 * de la regla Terminal
	 * @param ParametrosObtencionCargosDTO parametros, AbonadoDTO abonado
	 * @return parametroReglaTerminal
	 * @throws CustomerDomainException,ProductDomainException
	 */
	private ParametrosReglasTerminalRestitucionDTO getParametrosReglaTerminalRestitucion(ParametrosObtencionCargosDTO parametros,AbonadoDTO abonado) 
	throws FrmkCargosException{
		
		
		//Obtiene datos del plan tarifario
		ParametrosReglasTerminalRestitucionDTO parametroReglaTerminal = new ParametrosReglasTerminalRestitucionDTO();
	try{	
		String usoLinea = null;
		PlanTarifarioDTO planTarifario = new PlanTarifarioDTO();
		planTarifario.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		//Obtiene datos del plan tarifario
		planTarifario.setCodigoTecnologia(abonado.getCodTecnologia());
		planTarifario.setCodigoProducto(global.getValor("codigo.producto"));
		planTarifario = planTarifarioBO.getPlanTarifario(planTarifario);
		if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.postpago"))){
			usoLinea =  global.getValor("codigo.uso.postpago");
		}else if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.hibrido"))){
			usoLinea =  global.getValor("codigo.uso.hibrido");
		}
		else if (planTarifario.getCodigoTipoPlan().equals(global.getValor("tipo.plan.prepago"))){
			usoLinea =  global.getValor("codigo.uso.prepago");
		}
		
		ParametrosGeneralesDTO parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral = new ParametrosGeneralesDTO();
		TerminalDTO terminal = new TerminalDTO();
		
		
        //-- OBTIENE PARAMETRO : PRECIO LISTA
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.preciolista"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		String sPrecioLista = parametrosGral.getValorparametro();
		
//		-- OBTIENE PARAMETRO : INDICADOR APLICA SEGURO
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.aplicasegrest"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		String sAplicaSegRest = parametrosGral.getValorparametro();
		
		//-- BUSCAR DATOS DEL TERMINAL
		/**
		 * @author rlozano
		 * @description se comenta. PostVenta(PV), necesita el terminal q aun no ha sido asignado al 
		 * 				abonado por lo tanto se setea como un parametro del dto obtencion de cargos.
		 *@comments terminal.setNumeroSerie(abonado.getNumSerieTerminal());
		 */
		// 
		terminal.setNumeroSerie(parametros.getNumImei());
		terminal = terminalBO.getTerminal(terminal);
		parametroReglaTerminal.setNumAbonado(String.valueOf(abonado.getNumAbonado())); 
		parametroReglaTerminal.setCodigoArticulo(terminal.getCodigoArticulo());
		parametroReglaTerminal.setTipoStock(terminal.getTipoStock());
		parametroReglaTerminal.setCodigoUso(usoLinea);
		parametroReglaTerminal.setEstado(global.getValor("estado.articulo"));
		parametroReglaTerminal.setCodigoCategoria(terminal.getCodigoCategoria());
		parametroReglaTerminal.setIndicadorValorar(terminal.getIndicadorValorar());
		parametroReglaTerminal.setIndicadorRecambio("0"); //se setea en cero ya que será invocado por restitucion y en el visual siempre manda TRUE
		parametroReglaTerminal.setIndicadorPrecioLista(sPrecioLista);
		parametroReglaTerminal.setIndicadorPrecioDeducible(sAplicaSegRest);
		parametroReglaTerminal.setIndiceRecambioPrecioLista(global.getValor("indice.recambio.preciolista"));
		parametroReglaTerminal.setIndiceRecambioNoLista(global.getValor("indice.recambio.nolista"));
		parametroReglaTerminal.setCodigoCategoria(global.getValor("codigo.categoria"));
		parametroReglaTerminal.setIndicadorProcEquipo(terminal.getIndProcEq());
		parametroReglaTerminal.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		parametroReglaTerminal.setCodigoCliente(String.valueOf(abonado.getCodCliente()));
		//parametroReglaTerminal.setNumeroSerie(abonado.getNumSerieTerminal());
		parametroReglaTerminal.setNumeroSerie(terminal.getNumeroSerie());
		parametroReglaTerminal.setNumeroImei(terminal.getNumeroSerie());
		parametroReglaTerminal.setCodigoModalidadVenta(parametros.getCodigoModalidadVenta());
		parametroReglaTerminal.setTipoContrato(parametros.getTipoContrato());
		
		parametroReglaTerminal.setNumeroCelular(String.valueOf(abonado.getNumCelular()));
		parametroReglaTerminal.setNumeroContrato(abonado.getNumContrato());
		parametroReglaTerminal.setCodigoTecnologia(parametros.getCodigoTecnologia());
		parametroReglaTerminal.setNumMesesProrroga(String.valueOf(parametros.getNumeroMesesProrroga()));
		parametroReglaTerminal.setPromoCelular(String.valueOf(parametros.getPromoCelular()));
		parametroReglaTerminal.setNombre(parametros.getNombreUsuario());
		
		//parametroReglaTerminal.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
		parametroReglaTerminal.setCodigoAntiguedad("0");
		
		/*-- Inicio Parametros Descuentos --*/
		ParametrosDescuentoDTO parametrosDescuentoTerminal = new ParametrosDescuentoDTO();
		parametrosDescuentoTerminal.setNumeroMesesContrato(parametros.getNumeroMesesContrato());
		parametrosDescuentoTerminal.setNumeroMesesNuevo(String.valueOf(parametros.getNumeroMesesContrato()));
		
		if (parametros.getIndicadorTipoVenta()==Integer.parseInt(global.getValor("indicador.venta.distribuidor"))) 
			parametrosDescuentoTerminal.setIndiceVentaExterna(global.getValor("indice.venta.externa"));
		else
			parametrosDescuentoTerminal.setIndiceVentaExterna(global.getValor("indice.venta.interna"));
		parametrosDescuentoTerminal.setTipoConceptoDescuento(global.getValor("tipo.concepto.descuento"));
		
		parametrosDescuentoTerminal.setCodigoVendedor(String.valueOf(abonado.getCodVendedor()));
		parametrosDescuentoTerminal.setTipoContrato(String.valueOf(abonado.getCodTipContrato()));
		parametrosDescuentoTerminal.setCodigoContratoNuevo(String.valueOf(abonado.getNumContrato()));
		parametrosDescuentoTerminal.setCodigoCausaDescuento(parametros.getCodigoCausalDescuento());
		parametrosDescuentoTerminal.setCodigoModalidadVenta(String.valueOf(abonado.getCodModVenta()));
		parametrosDescuentoTerminal.setCodigoArticulo(terminal.getCodigoArticulo());
		
		parametrosDescuentoTerminal.setTipoPlanTarifario(planTarifario.getCodigoTipoPlan());
		
		
		
		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setNombreparametro(global.getValor("parametro.facturacion.codabonocel"));
		parametrosGral = parametrosGeneralesBO.getParametroFacturacion(parametrosGral);
		parametrosDescuentoTerminal.setCodAbonocel(parametrosGral.getValorparametro());
		
		parametrosGral = new ParametrosGeneralesDTO();
		parametrosGral.setCodigoproducto(global.getValor("codigo.producto"));
		parametrosGral.setCodigomodulo(global.getValor("codigo.modulo.GA"));
		parametrosGral.setNombreparametro(global.getValor("parametro.clasedescuento"));
		parametrosGral = parametrosGeneralesBO.getParametroGeneral(parametrosGral);
		parametrosDescuentoTerminal.setClaseDescuento(parametrosGral.getValorparametro());
		
		
		PlanTarifarioDTO planTarifario2 = new PlanTarifarioDTO();
		planTarifario2.setCodigoPlanTarifario(abonado.getCodPlanTarif());
		planTarifario2 = planTarifarioBO.getCategoriaPlanTarifario(planTarifario2);
		parametrosDescuentoTerminal.setCodigoCategoria(planTarifario2.getCodigoCategoria());
		
		parametrosDescuentoTerminal.setCodigoCausaVenta(parametros.getCodCausaCambioPlan());
		parametrosDescuentoTerminal.setIndicadorCiclo(global.getValor("indicador.ciclo"));
		parametrosDescuentoTerminal.setNumeroMesesFact(Integer.parseInt(global.getValor("numero.meses.faturable")));
		parametrosDescuentoTerminal.setCodigoOperacion(global.getValor("codigo.operacion.cambio.serie"));
		parametrosDescuentoTerminal.setCodigoAntiguedad(global.getValor("codigo.antiguedad"));
		parametrosDescuentoTerminal.setEquipoEstado(global.getValor("equipo.estado"));
		parametrosDescuentoTerminal.setClaseDescuentoArticulo(global.getValor("clase.descuento.articulo"));
		parametroReglaTerminal.setParametrosDescuento(parametrosDescuentoTerminal);
		parametroReglaTerminal.setParamRenova(parametros.getNumOsRenova());
		if (parametros.getNumOsRenova()!=null && !parametros.getNumOsRenova().equals("")) {
			parametroReglaTerminal.setParamRenova("1");
		} else {
			parametroReglaTerminal.setParamRenova("0");
		}		
	}catch(GeneralException e){
		throw new FrmkCargosException(e);
	}
	
		
		
		return parametroReglaTerminal;
	}//fin getParametrosReglaTerminal
	
	protected String [] recuperaCodigoServSuplementario (String codServicio){
		List listCodServ=new ArrayList();
		int cont=0;
		String codServ="";
		for (int k=0;k<codServicio.length();k++){
			char c =codServicio.charAt(k);
			
			if ("|".equals(String.valueOf(c))){
				cont++;
			}
			else{
				codServ=codServ+String.valueOf(c);
			}
			if (cont>1){
				listCodServ.add(codServ);
				codServ="";
				cont=1;
			}
		}
		String[] retValue=(String[])ArrayUtl.copiaArregloTipoEspecifico(listCodServ.toArray(),String.class);
		
		return retValue;
	}
	
	public PrecioTerminalDTO getRecPrecioEquipoActual(TerminalDTO terminalDTO)throws GeneralException{
		logger.debug("getRecPrecioEquipoActual: start");
		PrecioTerminalDTO  precioTerminalDTO=null;
		try{
			logger.debug("numero Serie::"+terminalDTO.getNumeroSerie());
			logger.debug("invocando DAO");
			precioTerminalDTO=cargoBO.getRecPrecioEquipoActual(terminalDTO);
			
		}
		catch(ProductOfferingPriceException e){
			//throw new GeneralException(e);
			throw new GeneralException(e.getMessage(),e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		}
		logger.debug("getRecPrecioEquipoActual: end");
		return precioTerminalDTO;
	}
	
	/**
	 * CSR11003
	 * permite obtener el precio para el equipo nuevo, será invocado desde la OOSS restitucion equipo
	 */
	public PrecioTerminalDTO getRecPrecioEquipoNuevo(PrecioEquipoNuevoDTO precioEquipoNuevoDTO)throws GeneralException{
		
		logger.debug("getRecPrecioEquipoNuevo: start");
		PrecioTerminalDTO  precioTerminalDTO=null;
		try{
			
			logger.debug("invocando DAO");
			precioTerminalDTO=cargoBO.getRecPrecioEquipoNuevo(precioEquipoNuevoDTO);
			
		}
		catch(ProductOfferingPriceException e){
			//throw new GeneralException(e);
			throw new GeneralException(e.getMessage(),e.getCodigo(),e.getCodigoEvento(),e.getDescripcionEvento());
		}
		
		logger.debug("getRecPrecioEquipoNuevo: end");
		return precioTerminalDTO;
	}
}
	