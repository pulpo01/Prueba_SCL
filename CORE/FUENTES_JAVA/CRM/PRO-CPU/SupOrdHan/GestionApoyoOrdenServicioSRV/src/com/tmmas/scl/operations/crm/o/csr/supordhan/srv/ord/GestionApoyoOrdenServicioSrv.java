package com.tmmas.scl.operations.crm.o.csr.supordhan.srv.ord;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.CuentaBOFactory;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.CuentaBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerABE.businessObject.bo.interfaces.CuentaIT;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.CargoClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.LimiteLineasDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.LineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.MorosidadClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.ObtencionLineasClienteDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.UsuarioDTO;
import com.tmmas.scl.framework.customerDomain.customerBillABE.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.OrdenServicioBOFactory;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.PrestacionBOFactory;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.PrestacionBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.businessObject.bo.interfaces.PrestacionIT;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.AbonadoSecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CITIPORSERVDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CantSecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.CausaCambioPlanListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ContratoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ConvertActAboDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DescuentoVendedorDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.DireccionOficinaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.IngresoVentaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ModalidadPagoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OficinaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OperadoraLocalDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PenalizacionDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.PrestacionListDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RangoAntiguedadDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.ServCuentaSegDTO;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.ProductoContratadoBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.RegistroFacturacionBOFactory;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.ProductoContratadoIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productABE.businessObject.bo.interfaces.RegistroFacturacionIT;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ArchivoFacturaDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.CausaBajaListDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.GaAbocelDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ObtencionSecuenciasDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.VendedorDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.ParametrosGenerales;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.PlanTarifario;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.PlanTarifarioBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.SCLPlanBasicoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.PlanTarifarioIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.SCLPlanBasicoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.businessObject.bo.interfaces.SCLPlanBasicoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.LimiteConsumoAbonadoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanCicloDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ServicioDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.CargoBOFactory;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.interfaces.CargoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.businessObject.bo.interfaces.CargoIT;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.BolsaDinamicaDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.productOfferingPriceABE.dataTransferObject.ParamCargosAbonadoCeroDTO;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.EspecificacionProductoBOFactory;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.businessObject.bo.interfaces.EspecificacionProductoIT;
import com.tmmas.scl.framework.productDomain.productSpecificationABE.dataTransferObject.CartaGeneralDTO;
import com.tmmas.scl.operations.crm.o.csr.supordhan.common.exception.SupOrdHanException;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.ord.helper.Global;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.ord.interfaces.GestionApoyoOrdenServicioSrvIF;

public class GestionApoyoOrdenServicioSrv implements GestionApoyoOrdenServicioSrvIF {
	
	private final Logger logger = Logger.getLogger(GestionApoyoOrdenServicioSrv.class);
	
	private SCLPlanBasicoBOFactoryIT factoryBO1 = new SCLPlanBasicoBOFactory();
	private ClienteBOFactoryIT factoryBO2 = new ClienteBOFactory();
	private ProductoContratadoBOFactoryIT factoryBO3 = new ProductoContratadoBOFactory();
	private AbonadoBOFactoryIT factoryBO4 = new AbonadoBOFactory();
	private OrdenServicioBOFactoryIT factoryBO5 = new OrdenServicioBOFactory();
	private EspecificacionProductoBOFactory factoryBO6 = new EspecificacionProductoBOFactory();
	private RegistroFacturacionBOFactoryIT factoryBO7 = new RegistroFacturacionBOFactory();
	private CargoBOFactoryIT factoryBO8 = new CargoBOFactory();
	private CuentaBOFactoryIT factoryB09 = new CuentaBOFactory();
	private PrestacionBOFactoryIT factoryB10 = new PrestacionBOFactory();
	private PlanTarifarioBOFactoryIT factoryB11 =  new PlanTarifarioBOFactory();
	
	private SCLPlanBasicoIT planBO = factoryBO1.getBusinessObject1();
	private ClienteIT clienteBO = factoryBO2.getBusinessObject1();
	private ProductoContratadoIT productoBO = factoryBO3.getBusinessObject1();
	private AbonadoIT abonadoBO = factoryBO4.getBusinessObject1();
	private OrdenServicioIT ordenServicioBO = factoryBO5.getBusinessObject1();
	private EspecificacionProductoIT espProductoBO = factoryBO6.getBusinessObject();
	private RegistroFacturacionIT facturacionBO = factoryBO7.getBusinessObject1(); 
	private CargoIT cargoBO = factoryBO8.getBusinessObject1();
	private CuentaIT cuentaBO = factoryB09.getBusinessObject1();
	private PrestacionIT prestacionBO = factoryB10.getBusinessObject1();  		
	private PlanTarifarioIT planTarifarioBO = factoryB11.getBusinessObject1();  	
	
	private Global global = Global.getInstance();
	
	
	public GestionApoyoOrdenServicioSrv(){
		String log = global.getValor("service.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);
	}
	
	public CartaGeneralDTO obtenerTextoCarta(CartaGeneralDTO cartaGeneral) throws SupOrdHanException{
		CartaGeneralDTO retorno = null;
				
		logger.debug("obtenerTextoCarta():start");
		try {
			retorno = espProductoBO.obtenerTextoCarta(cartaGeneral);
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		logger.debug("obtenerTextoCarta():end");
		return retorno;
	}
	
	public RetornoDTO anularCargoBolsaDinamica(BolsaDinamicaDTO bolsa) throws SupOrdHanException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("anularCargoBolsaDinamica():start");
			respuesta = planBO.anularCargoBolsaDinamica(bolsa);
			logger.debug("anularCargoBolsaDinamica():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;		
	}
	
	public CargoClienteDTO obtenerCargoBasicoActual(CargoClienteDTO cliente) throws SupOrdHanException{
		CargoClienteDTO cargo = null;
		try {
			logger.debug("obtenerCargoBasicoActual():start");
			cargo = clienteBO.obtenerCargoBasicoActual(cliente);
			logger.debug("obtenerCargoBasicoActual():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return cargo;			
	}
	
	public RetornoDTO validarTipoPlanCliente(ClienteDTO cliente) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try {
			logger.debug("validarTipoPlanCliente():start");
			retorno = clienteBO.validarTipoPlanCliente(cliente);
			logger.debug("validarTipoPlanCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	public AbonadoDTO obtenerDatosCambPlanServ(AbonadoDTO abonado) throws SupOrdHanException{
		AbonadoDTO retorno = null;
		try {
			logger.debug("obtenerDatosCambPlanServ():start");
			retorno = productoBO.obtenerDatosCambPlanServ(abonado);
			logger.debug("obtenerDatosCambPlanServ():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;				
	}
	
	public RetornoDTO actualizarAboCtaSeg(GaAbocelDTO abonado) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try {
			logger.debug("actualizarAboCtaSeg():start");
			retorno = abonadoBO.actualizarAboCtaSeg(abonado);
			logger.debug("actualizarAboCtaSeg():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;	
	}
	
	public RetornoDTO migrarAbonado(GaAbocelDTO abonado) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try {
			logger.debug("migrarAbonado():start");
			retorno = abonadoBO.migrarAbonado(abonado);
			logger.debug("migrarAbonado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;	
		
	}
	
	public GaAbocelDTO obtenerFecCumPlan(GaAbocelDTO abonado) throws SupOrdHanException{
		GaAbocelDTO retorno = null;
		try {
			logger.debug("obtenerFecCumPlan():start");
			retorno = abonadoBO.obtenerFecCumPlan(abonado);
			logger.debug("obtenerFecCumPlan():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;	
		
	}
	
	public ConvertActAboDTO obtenerConverActAbo(ConvertActAboDTO param) throws SupOrdHanException{
		ConvertActAboDTO retorno = null;
		try {
			logger.debug("obtenerConverActAbo():start");
			retorno = ordenServicioBO.obtenerConverActAbo(param);
			logger.debug("obtenerConverActAbo():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	public RetornoDTO validarServiciosDuplicados(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try {
			logger.debug("validarServiciosDuplicados():start");
			retorno = ordenServicioBO.validarServiciosDuplicados(abonado);
			logger.debug("validarServiciosDuplicados():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
		
	}
	
	public RetornoDTO bajaSSPrepago(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try {
			logger.debug("bajaSSPrepago():start");
			retorno = ordenServicioBO.bajaSSPrepago(abonado);
			logger.debug("bajaSSPrepago():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	public RetornoDTO bajaRegTarif(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try {
			logger.debug("bajaRegTarif():start");
			retorno = ordenServicioBO.bajaRegTarif(abonado);
			logger.debug("bajaRegTarif():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
		
	}
	
	public ServicioDTO obtenerGrupoNivelContratado(AbonadoDTO abonado) throws SupOrdHanException{
		ServicioDTO retorno = null;
		try {
			logger.debug("obtenerGrupoNivelContratado():start");
			retorno = ordenServicioBO.obtenerGrupoNivelContratado(abonado);
			logger.debug("obtenerGrupoNivelContratado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	public CausaBajaListDTO obtenerCausaBaja() throws SupOrdHanException{
		CausaBajaListDTO retorno = null;
		try {
			logger.debug("obtenerCausaBaja():start");
			retorno = productoBO.obtenerCausaBaja();
			logger.debug("obtenerCausaBaja():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	public PlanCicloDTO obtenerCicloFreedom(PlanCicloDTO plan) throws SupOrdHanException{
		PlanCicloDTO retorno = null;
		try {
			logger.debug("obtenerCicloFreedom():start");
			retorno = planBO.obtenerCicloFreedom(plan);
			logger.debug("obtenerCicloFreedom():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	public RetornoDTO insertarTransacabo(SecuenciaDTO secuencia) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try {
			logger.debug("insertarTransacabo():start");
			retorno = ordenServicioBO.insertarTransacabo(secuencia);
			logger.debug("insertarTransacabo():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}	
	
	public PlanTarifarioDTO obtenerCategPlan(PlanTarifarioDTO plan) throws SupOrdHanException{
		PlanTarifarioDTO retorno = null;
		try {
			logger.debug("obtenerCategPlan():start");
			retorno = planBO.obtenerCategPlan(plan);
			logger.debug("obtenerCategPlan():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;				
	}
	
	public ClienteDTO obtenerPlanComercial(ClienteDTO cliente) throws SupOrdHanException{
		ClienteDTO retorno = null;
		try {
			logger.debug("obtenerPlanComercial():start");
			retorno = planBO.obtenerPlanComercial(cliente);
			logger.debug("obtenerPlanComercial():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	public ClienteDTO obtenerValorCalculado(ClienteDTO cliente) throws SupOrdHanException{
		ClienteDTO retorno = null;
		try {
			logger.debug("obtenerValorCalculado():start");
			retorno = clienteBO.obtenerValorCalculado(cliente);
			logger.debug("obtenerValorCalculado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
			
	public UsuarioDTO obtenerVendedor(UsuarioDTO usuario) throws SupOrdHanException{
		UsuarioDTO retorno = null;
		try {
			logger.debug("obtenerVendedor():start");
			retorno = ordenServicioBO.obtenerVendedor(usuario);
			logger.debug("obtenerVendedor():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;				
	}
	
	public ArchivoFacturaDTO obtenerRutaFactura(ArchivoFacturaDTO factura) throws SupOrdHanException{
		ArchivoFacturaDTO retorno = null;
		try {
			logger.debug("obtenerRutaFactura():start");
			retorno = facturacionBO.obtenerRutaFactura(factura);
			logger.debug("obtenerRutaFactura():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	public DescuentoVendedorDTO obtenerDescuentoVendedor(DescuentoVendedorDTO vendedor) throws SupOrdHanException{
		DescuentoVendedorDTO retorno = null;
		try {
			logger.debug("obtenerDescuentoVendedor():start");
			retorno = ordenServicioBO.obtenerDescuentoVendedor(vendedor);
			logger.debug("obtenerDescuentoVendedor():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	public PenalizacionDTO obtenerPenalizacion(PenalizacionDTO param) throws SupOrdHanException{
		PenalizacionDTO retorno = null;
		try {
			logger.debug("obtenerPenalizacion():start");
			retorno = ordenServicioBO.obtenerPenalizacion(param);
			logger.debug("obtenerPenalizacion():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	public RangoAntiguedadDTO obtenerRangoAntiguedad(RangoAntiguedadDTO param) throws SupOrdHanException{
		RangoAntiguedadDTO retorno = null;
		try {
			logger.debug("obtenerRangoAntiguedad():start");
			retorno = ordenServicioBO.obtenerRangoAntiguedad(param);
			logger.debug("obtenerRangoAntiguedad():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	
	public DireccionOficinaDTO obtenerDireccionOficina(String codOficina) throws SupOrdHanException{
		DireccionOficinaDTO retorno = null;
		try {
			logger.debug("obtenerDireccionOficina():start");
			retorno = ordenServicioBO.obtenerDireccionOficina(codOficina);
			logger.debug("obtenerDireccionOficina():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	public Integer obtenerVendedorRaiz(Integer codVendedor) throws SupOrdHanException{
		Integer retorno = null;
		try {
			logger.debug("obtenerVendedorRaiz():start");
			retorno = ordenServicioBO.obtenerVendedorRaiz(codVendedor);
			logger.debug("obtenerVendedorRaiz():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;				
	}
	
	public String obtenerOperadora(Long codCliente) throws SupOrdHanException{
		String retorno = null;
		try {
			logger.debug("obtenerOperadora():start");
			retorno = ordenServicioBO.obtenerOperadora(codCliente);
			logger.debug("obtenerOperadora():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;				
	}
	
	public ServCuentaSegDTO tratarServCtaSeg(ServCuentaSegDTO param) throws SupOrdHanException{
		ServCuentaSegDTO retorno = null;
		try {
			logger.debug("tratarServCtaSeg():start");
			retorno = ordenServicioBO.tratarServCtaSeg(param);
			logger.debug("tratarServCtaSeg():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	public RetornoDTO registrarMovControlada(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("registrarMovControlada():start");
			respuesta = ordenServicioBO.registrarMovControlada(abonado);
			logger.debug("registrarMovControlada():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;		
	}
	
	public ContratoDTO obtenerTipoContrato(ContratoDTO contrato) throws SupOrdHanException{
		ContratoDTO respuesta = null;
		try {
			logger.debug("obtenerTipoContrato():start");
			respuesta = ordenServicioBO.obtenerTipoContrato(contrato);
			logger.debug("obtenerTipoContrato():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;		
	}
	
	public ModalidadPagoDTO obtenerModalidadPago(ModalidadPagoDTO modalidad) throws SupOrdHanException{
		ModalidadPagoDTO respuesta = null;
		try {
			logger.debug("obtenerModalidadPago():start");
			respuesta = ordenServicioBO.obtenerModalidadPago(modalidad);
			logger.debug("obtenerModalidadPago():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;	
	}
	
	public VendedorDTO obtenerVendedor(VendedorDTO vendedor) throws SupOrdHanException{
		VendedorDTO respuesta = null;
		try {
			logger.debug("obtenerVendedor():start");
			respuesta = ordenServicioBO.obtenerVendedor(vendedor);
			logger.debug("obtenerVendedor():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;			
	}
	
	public LineasClienteDTO obtenerCantidadLineasCliente(LineasClienteDTO cliente) throws SupOrdHanException{
		LineasClienteDTO respuesta = null;
		try {
			logger.debug("obtenerCantidadLineasCliente():start");
			respuesta = clienteBO.obtenerCantidadLineasCliente(cliente);
			logger.debug("obtenerCantidadLineasCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;		
	}
	
	public MorosidadClienteDTO obtenerMorosidadCliente(MorosidadClienteDTO cliente) throws SupOrdHanException{
		MorosidadClienteDTO respuesta = null;
		try {
			logger.debug("obtenerMorosidadCliente():start");
			respuesta = clienteBO.obtenerMorosidadCliente(cliente);
			logger.debug("obtenerMorosidadCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;			
	}
	
	public AbonadoDTO obtenerCodigoModalidad(AbonadoDTO abonado) throws SupOrdHanException{
		AbonadoDTO respuesta = null;
		try {
			logger.debug("obtenerMorosidadCliente():start");
			respuesta = cargoBO.obtenerCodigoModalidad(abonado);
			logger.debug("obtenerMorosidadCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;			
	}
	
	public LimiteLineasDTO obtenerLimiteLineas(ObtencionLineasClienteDTO lineas) throws SupOrdHanException{
		LimiteLineasDTO respuesta = null;
		try {
			logger.debug("obtenerLimiteLineas():start");
			respuesta = clienteBO.obtenerLimiteLineas(lineas);
			logger.debug("obtenerLimiteLineas():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;			
	}

	public RetornoDTO validarSituaCliEmp(ClienteDTO cliente) throws SupOrdHanException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("validarSituaCliEmp():start");
			respuesta = clienteBO.validarSituaCliEmp(cliente);
			logger.debug("validarSituaCliEmp():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;	
	}
	
	public RetornoDTO validarClienteNPW(ClienteDTO cliente) throws SupOrdHanException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("validarClienteNPW():start");
			respuesta = clienteBO.validarClienteNPW(cliente);
			logger.debug("validarClienteNPW():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;	
	}
	
	public PlanTarifarioDTO obtenerPlanTarifario(PlanTarifarioDTO plan) throws SupOrdHanException{
		try {
			logger.debug("obtenerPlanTarifario():start");
			plan = planBO.obtenerPlanTarifario(plan);
			logger.debug("obtenerPlanTarifario():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return plan;
	}
	
	public RetornoDTO validarOriDesUso(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("validarOriDesUso():start");
			respuesta = abonadoBO.validarOriDesUso(abonado);
			logger.debug("validarOriDesUso():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;		
	}

	public RetornoDTO insertarContratoCuenta(GaAbocelDTO contratoCuenta) throws SupOrdHanException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("insertarContratoCuenta():start");
			respuesta = cuentaBO.insertarContratoCuenta(contratoCuenta);
			logger.debug("insertarContratoCuenta():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;		
	}	

	public RetornoDTO validaListaNegra(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("validaListaNegra():start");
			respuesta = abonadoBO.validaListaNegra(abonado);
			logger.debug("validaListaNegra():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;		
	}	


	public RetornoDTO insertarGaVenta (IngresoVentaDTO venta ) throws SupOrdHanException{
		RetornoDTO respuesta = null;
		try {
			logger.debug("insertarGaVenta():start");
			respuesta = ordenServicioBO.insertarGaVenta(venta);
			logger.debug("insertarGaVenta():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return respuesta;		
	}
	
	public RetornoDTO validarSolicitudesBaja(AbonadoDTO abonado) throws SupOrdHanException{
		RetornoDTO retorno = null;
		try {
			logger.debug("validarSolicitudesBaja():start");
			retorno = abonadoBO.validarSolicitudesBaja(abonado);
			logger.debug("validarSolicitudesBaja():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}

	public RetornoDTO validarReversa(OrdenServicioDTO ordenServicioDto) throws SupOrdHanException {
		RetornoDTO retorno = null;
		try {
			logger.debug("validarReversa():start");
			retorno = ordenServicioBO.validarReversa(ordenServicioDto);
			logger.debug("validarSolicitudesBaja():end");
		} catch (GeneralException e) {
			logger.debug("validarReversa[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	public RetornoDTO validarNumPer(AbonadoDTO abonado) throws SupOrdHanException {
		RetornoDTO retorno = null;
		try {
			logger.debug("validarNumPer():start");
			retorno = abonadoBO.validarNumPer(abonado);
			logger.debug("validarNumPer():end");
		} catch (GeneralException e) {
			logger.debug("validarNumPer[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	
	public RetornoDTO actualizarUsoIntarcel(AbonadoDTO abonado) throws SupOrdHanException {
		RetornoDTO retorno = null;
		try {
			logger.debug("actualizarUsoIntarcel():start");
			retorno = ordenServicioBO.actualizarUsoIntarcel(abonado);
			logger.debug("actualizarUsoIntarcel():end");
		} catch (GeneralException e) {
			logger.debug("actualizarUsoIntarcel[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	public int validarCarta(OrdenServicioDTO ordenServicio) throws SupOrdHanException {
		int canReg = 0;
		try {
			logger.debug("validarCarta():start");
			canReg = ordenServicioBO.validarCarta(ordenServicio);
			logger.debug("validarCarta():end");
		} catch (GeneralException e) {
			logger.debug("validarCarta[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return canReg;		
	}
	
	public SecuenciaDTO[] obtenerNumeroDeSecuencias(CantSecuenciaDTO param) throws SupOrdHanException {
		SecuenciaDTO[] secuencias = null;
		try {
			logger.debug("obtenerNumeroDeSecuencias():start");
			secuencias = ordenServicioBO.obtenerNumeroDeSecuencias(param);
			logger.debug("obtenerNumeroDeSecuencias():end");
		} catch (GeneralException e) {
			logger.debug("validarCarta[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return secuencias;		
	}
	
	public  OficinaDTO obtenerDatosOficina(OficinaDTO param) throws SupOrdHanException {
		OficinaDTO retorno = null;
		try {
			logger.debug("obtenerDatosOficina():start");
			retorno = ordenServicioBO.obtenerDatosOficina(param);
			logger.debug("obtenerDatosOficina():end");
		} catch (GeneralException e) {
			logger.debug("validarCarta[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	
	public AbonadoSecuenciaDTO[] obtenerSecuenciasAbonados(ObtencionSecuenciasDTO param) throws SupOrdHanException{
		AbonadoSecuenciaDTO[] retorno = null;
		try {
			logger.debug("obtenerSecuenciasAbonados():start");
			retorno = ordenServicioBO.obtenerSecuenciasAbonados(param);
			logger.debug("obtenerSecuenciasAbonados():end");
		} catch (GeneralException e) {
			logger.debug("validarCarta[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;				
	}
	
	//INI COL INC_72181 AVC 13-12-08
	public RetornoDTO getValidacionAbonadoCero(ParamCargosAbonadoCeroDTO param)throws SupOrdHanException{
		RetornoDTO retorno = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);	
			logger.debug("getValidacionAbonadoCero():start");
			retorno = cargoBO.getValidacionAbonadoCero(param);
			logger.debug("getValidacionAbonadoCero():end");
		} catch (GeneralException e) {
			logger.debug("getValidacionAbonadoCero[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}
	//FIN COL INC_72181 AVC 13-12-08	
	
	public  CITIPORSERVDTO obtenerTiporserv(CITIPORSERVDTO param) throws SupOrdHanException {
		CITIPORSERVDTO retorno = null;
		try {
			logger.debug("obtenerTiporserv():start");
			retorno = ordenServicioBO.obtenerTiporserv(param);
			logger.debug("obtenerTiporserv():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;		
	}	

	public PrestacionListDTO obtenerPrestaciones() throws SupOrdHanException{
		PrestacionListDTO retorno = null;
		try {
			logger.debug("obtenerPrestaciones():start");
			retorno = prestacionBO.obtenerPrestaciones();
			logger.debug("obtenerPrestaciones():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	public CausaCambioPlanListDTO obtenerCausasCambioPlan() throws SupOrdHanException{
		CausaCambioPlanListDTO retorno = null;
		try {
			logger.debug("obtenerCausasCambioPlan():start");
			retorno = prestacionBO.obtenerCausasCambioPlan();
			logger.debug("obtenerCausasCambioPlan():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	public OperadoraLocalDTO obtenerOperadoraLocal() throws SupOrdHanException{
		OperadoraLocalDTO retorno = null;
		try {
			logger.debug("obtenerOperadoraLocal():start");
			retorno = prestacionBO.obtenerOperadoraLocal();
			logger.debug("obtenerOperadoraLocal():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
	public PlanTarifarioDTO[] obtenerLimitesPlan(PlanTarifarioDTO planTarifario)	throws SupOrdHanException{
		
		PlanTarifarioDTO[] resultado = null;
		try {
			logger.debug("Inicio:obtenerLimitesPlan()");
			ParametrosGenerales parametrosGeneralesBO = new ParametrosGenerales();
			PlanTarifarioDTO planTarifarioDTO = new PlanTarifarioDTO();
			planTarifarioDTO.setCodigoPlanTarifario(planTarifario.getCodigoPlanTarifario());
			planTarifarioDTO.setCodCliente(planTarifario.getCodCliente());
			// Obtiene primer formato para consultar los limites de consumo
			// asociados al cliente
			ParametrosGeneralesDTO parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GE"));
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.formato.sel2"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			planTarifarioDTO.setFormatoFecha1(parametrosGeneralesDTO.getValorparametro());
			// Obtiene segundo formato para consultar los limites de consumo
			// asociados al cliente
			parametrosGeneralesDTO = new ParametrosGeneralesDTO();
			parametrosGeneralesDTO.setCodigomodulo(global.getValor("codigo.modulo.GE"));
			parametrosGeneralesDTO.setCodigoproducto(global.getValor("codigo.producto"));
			parametrosGeneralesDTO.setNombreparametro(global.getValor("parametro.formato.sel7"));
			parametrosGeneralesDTO = parametrosGeneralesBO.getParametroGeneral(parametrosGeneralesDTO);
			planTarifarioDTO.setFormatoFecha2(parametrosGeneralesDTO.getValorparametro());

			PlanTarifario planTarifarioBO = new PlanTarifario();
			resultado = planTarifarioBO.getListLimiteConsumo(planTarifarioDTO);
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		logger.debug("Fin:obtenerLimitesPlan()");
		return resultado;
	}// fin getListLimiteConsumo
	
	public RetornoDTO actualizaLimiteConsumoPlan(PlanTarifarioDTO planTarifario)	throws SupOrdHanException{
		RetornoDTO retorno =  new RetornoDTO();
		PlanTarifario planTarifarioBO = new PlanTarifario();
		logger.debug("Ini:actualizaLimiteConsumoPlan()");		
		try{
			retorno = planTarifarioBO.actualizaLimiteConsumoPlan(planTarifario);
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		logger.debug("Fin:actualizaLimiteConsumoPlan()");
		
		
		return retorno;
	}
	
	public RetornoDTO actualizarLimiteConsumoFinal(LimiteConsumoAbonadoDTO entrada)	throws SupOrdHanException{
		RetornoDTO retorno =  new RetornoDTO();
		PlanTarifario planTarifarioBO = new PlanTarifario();
		logger.debug("Ini:actualizarLimiteConsumoFinal()");		
		try{
			retorno = planTarifarioBO.actualizarLimiteConsumoFinal(entrada);
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		logger.debug("Fin:actualizarLimiteConsumoFinal()");
		
		
		return retorno;
	}
	
	public PlanTarifarioDTO obtenerDatosPlanTarifario(String codPlanTarif) throws SupOrdHanException{
		PlanTarifarioDTO retorno = null;
		try {
			logger.debug("obtenerDatosPlanTarifario():start");
			retorno = planTarifarioBO.obtenerDatosPlanTarifario(codPlanTarif);
			logger.debug("obtenerDatosPlanTarifario():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new SupOrdHanException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new SupOrdHanException(e);
		}
		return retorno;			
	}
	
}
