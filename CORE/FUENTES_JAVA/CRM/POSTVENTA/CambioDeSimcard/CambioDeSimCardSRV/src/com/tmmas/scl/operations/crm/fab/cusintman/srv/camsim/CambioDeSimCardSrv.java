/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 01/06/2007	     	Elizabeth Vera        				Versi�n Inicial
 */
package com.tmmas.scl.operations.crm.fab.cusintman.srv.camsim;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.ProductDomain.bo.DatosGeneralesBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.SeriesBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.ServiciosSuplementariosBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.SiniestroBOFactory;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.DatosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.DatosGeneralesBOIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SeriesBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SeriesBOIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.ServiciosSuplementariosBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.ServiciosSuplementariosBOIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SiniestroBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SiniestroBOIT;
import com.tmmas.scl.framework.ProductDomain.dto.ArticuloInDTO;
import com.tmmas.scl.framework.ProductDomain.dto.BodegaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CategoriaTributariaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaCamSerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CausaSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.CuotaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.DatosCentralDTO;
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SerieDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SiniestrosDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SolicitudAvisoDeSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TecnologiaDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoDeContratoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSiniestroDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoSuspencionDTO;
import com.tmmas.scl.framework.ProductDomain.dto.TipoTerminalDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsoArticuloDTO;
import com.tmmas.scl.framework.ProductDomain.dto.UsosVentaDTO;
import com.tmmas.scl.framework.ProductDomain.exception.ProductException;
import com.tmmas.scl.framework.aplicationDomain.bo.UsuarioSistemaBOFactory;
import com.tmmas.scl.framework.aplicationDomain.bo.interfeces.UsuarioSistemaBOFactoryIT;
import com.tmmas.scl.framework.aplicationDomain.bo.interfeces.UsuarioSistemaBOIT;
import com.tmmas.scl.framework.aplicationDomain.dto.MensajeRetornoDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.OperadoraLocalDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.SesionDTO;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;
import com.tmmas.scl.framework.customerDomain.bo.AbonadoBOFactory;
import com.tmmas.scl.framework.customerDomain.bo.ClienteBOFactory;
import com.tmmas.scl.framework.customerDomain.bo.VendedorBOFactory;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.AbonadoIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.ClienteIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.VendedorBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.VendedorBOIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.customerDomain.dto.VendedorDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.businessObject.bo.PlanTarifarioBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.SimcardBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SimcardBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SimcardBOIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SimcardDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.camsim.helper.Global;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.camsim.interfaces.CambioDeSimCardSrvIF;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;

public class CambioDeSimCardSrv implements CambioDeSimCardSrvIF {

	private final Logger logger = Logger.getLogger(CambioDeSimCardSrv.class);
	
	private Global global = Global.getInstance();	
	private AbonadoBOFactoryIT factoryBO11 = new AbonadoBOFactory();
	private AbonadoIT abonadoBO = factoryBO11.getBusinessObject1();	
	
	
//	 ---------------------------------------------------------------------------
	
	private ClienteBOFactoryIT factoryBO13 = new ClienteBOFactory();
	private ClienteIT clienteBO = factoryBO13.getBusinessObject1();
	private DatosGeneralesBOFactoryIT factoryBO14 = new DatosGeneralesBOFactory();
	private UsuarioSistemaBOFactoryIT factoryBO2 = new UsuarioSistemaBOFactory();
	private SeriesBOFactoryIT factoryBO3 = new SeriesBOFactory();	
	private SiniestroBOFactoryIT factoryBO5 = new SiniestroBOFactory();	
	private ServiciosSuplementariosBOFactoryIT factoryBO6 = new ServiciosSuplementariosBOFactory();
	private DatosGeneralesBOIT datosGeneralesBO = factoryBO14.getBusinessObject1();
	private UsuarioSistemaBOIT usuarioSistemaBO = factoryBO2.getBusinessObject1();
	private SeriesBOIT seriesBO = factoryBO3.getBusinessObject1();
	private SiniestroBOIT siniestroBO = factoryBO5.getBusinessObject1();
	private ServiciosSuplementariosBOIT serviciosSuplmentariosBO = factoryBO6.getBusinessObject1();
	private VendedorBOFactoryIT factoryBO1 = new VendedorBOFactory();
	private VendedorBOIT vendedorBO = factoryBO1.getBusinessObject1();
	private SimcardBOFactoryIT simcardFactory=new SimcardBOFactory();
	private SimcardBOIT simcardBO=simcardFactory.getBusinessObject1();
	private PlanTarifarioBOFactoryIT planFactory= new PlanTarifarioBOFactory();
	private PlanTarifarioIT planTarifarioBO=planFactory.getBusinessObject1();
	
//	 --------------------------------------------------------------------------------
	
	public VendedorDTO obtenerEstadoVendedor(VendedorDTO vendedor) throws CustomerException {
		VendedorDTO respuesta = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerEstadoVendedor():start");
				respuesta = vendedorBO.obtenerEstadoVendedor(vendedor);
			logger.debug("obtenerEstadoVendedor():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CustomerException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}
		return respuesta;
		
	}	// obtenerEstadoVendedor
	
// --------------------------------------------------------------------------------

	public void bloquearVendedor(VendedorDTO vendedor) throws CustomerException {
	
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("bloquearVendedor():start");
				vendedorBO.bloquearVendedor(vendedor);
			logger.debug("bloquearVendedor():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CustomerException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}
		
	}	// bloquearVendedor
	
// --------------------------------------------------------------------------------

	public void desbloquearVendedor(VendedorDTO vendedor) throws CustomerException {
	
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("desbloquearVendedor():start");
				vendedorBO.desbloquearVendedor(vendedor);
			logger.debug("desbloquearVendedor():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CustomerException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}
		
	}	// desbloquearVendedor
	
// --------------------------------------------------------------------------------
	
	public BodegaDTO[] obtenerBodegas(SesionDTO sesion) throws ProductException {
		BodegaDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerBodegas():start");
				respuesta = datosGeneralesBO.obtenerBodegas(sesion);
			logger.debug("obtenerBodegas():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;
		
	}	// obtenerBodegas
	
// --------------------------------------------------------------------------------
	
	public CausaCamSerieDTO[] obtenerCausaCambioSerie () throws ProductException	{
		
		CausaCamSerieDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerCausaCambioSerie():start");
				respuesta = datosGeneralesBO.obtenerCausaCambioSerie();
			logger.debug("obtenerCausaCambioSerie():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;		

	} 	// obtenerCausaCambioSerie
	
//	 --------------------------------------------------------------------------------
	
	
	public TipoDeContratoDTO[] obtenerTiposDeContrato(SesionDTO sessionDTO) throws ProductException	{
		TipoDeContratoDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerTiposDeContrato():start");
				respuesta = datosGeneralesBO.obtenerTiposDeContrato(sessionDTO);
			logger.debug("obtenerTiposDeContrato():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;		
		
	}	// obtenerTiposDeContrato

//	 --------------------------------------------------------------------------------
	
	public TecnologiaDTO[] obtenerTecnologia () throws ProductException {
		TecnologiaDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerTecnologia():start");
				respuesta = datosGeneralesBO.obtenerTecnologia();
			logger.debug("obtenerTecnologia():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;		
		
	}	// obtenerTecnologia
	
//	 --------------------------------------------------------------------------------
	
	public MesesProrrogasDTO[] obtenerMesesProrroga () throws ProductException {	
	
		MesesProrrogasDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerMesesProrroga():start");
				respuesta = datosGeneralesBO.obtenerMesesProrroga();
			logger.debug("obtenerMesesProrroga():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;		
		
	}	// obtenerTecnologia
	
//	 --------------------------------------------------------------------------------
	
	public ModalidadPagoDTO[] obtenerModalidadPago (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException{
		
		ModalidadPagoDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerModalidadPago():start");
				respuesta = datosGeneralesBO.obtenerModalidadPago(Sesion, CausaCamSerie);
			logger.debug("obtenerModalidadPago():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;		
		
	}	// obtenerModalidadPago
	
//	 --------------------------------------------------------------------------------	
	
	public ModalidadPagoDTO[] obtenerModalidadPagoSimcard (SesionDTO Sesion, CausaCamSerieDTO CausaCamSerie) throws ProductException{
		
		ModalidadPagoDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerModalidadPagoSimcard():start");
				respuesta = datosGeneralesBO.obtenerModalidadPagoSimcard(Sesion, CausaCamSerie);
			logger.debug("obtenerModalidadPagoSimcard():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;		
		
	}	// obtenerModalidadPagoSimcard
	
//	 --------------------------------------------------------------------------------	

	public TipoTerminalDTO[] obtenerTipoTerminal (TecnologiaDTO tecnologia) throws ProductException{
		
		TipoTerminalDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerTipoTerminal():start");
				respuesta = datosGeneralesBO.obtenerTipoterminal(tecnologia);
			logger.debug("obtenerTipoTerminal():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;		
		
	}	// obtenerTipoTerminal
	
//	 --------------------------------------------------------------------------------	
	
	public CuotaDTO[] obtenerCuotas (SesionDTO sesion, ModalidadPagoDTO modalidadPago) throws ProductException{
		
		CuotaDTO[] respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerCuotas():start");
				respuesta = datosGeneralesBO.obtenerCuotas(sesion, modalidadPago);
			logger.debug("obtenerCuotas():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;		
		
	}	// obtenerTipoTerminal
	
//	 --------------------------------------------------------------------------------	

	public CategoriaTributariaDTO[] obtenerCatTributaria (SesionDTO sesion) throws ProductException{
		CategoriaTributariaDTO[] respuesta = null;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerCatTributaria():start");
				respuesta = datosGeneralesBO.obtenerCatTributaria(sesion);
			logger.debug("obtenerCatTributaria():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

		return respuesta;		
		
	}	// obtenerTipoTerminal
	
//	 --------------------------------------------------------------------------------	

	public UsosVentaDTO[] obtenerUsosVenta () throws ProductException
	{
		UsosVentaDTO[] respuesta = null;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerUsosVenta():start");
				respuesta = datosGeneralesBO.obtenerUsosVenta();
			logger.debug("obtenerUsosVenta():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

		return respuesta;		
		
	}	// obtenerTipoTerminal
	
//	 --------------------------------------------------------------------------------	

	public CentralDTO[] obtenerCentralTecnologiaHlr (SerieDTO serie, TecnologiaDTO tecnologia) throws ProductException {
		CentralDTO[] respuesta = null;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerCentralTecnologiaHlr():start");
				respuesta = datosGeneralesBO.obtenerCentralTecnologiaHlr(serie, tecnologia);
			logger.debug("obtenerCentralTecnologiaHlr():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}

		return respuesta;		
		
	}	// obtenerCentralTecnologiaHlr
	
//	 --------------------------------------------------------------------------------	

	public void validaCausaCamSerie (SesionDTO sesion, CausaCamSerieDTO causaCamSerie) throws ProductException{
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("validaCausaCamSerie():start");
				datosGeneralesBO.validaCausaCamSerie(sesion, causaCamSerie);
			logger.debug("validaCausaCamSerie():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
	}	// validaCausaCamSerie
	
//	 --------------------------------------------------------------------------------	
		
	public MensajeRetornoDTO ejecutaRestrccion(RestriccionesDTO restricciones) throws ProductException {

		MensajeRetornoDTO respuesta = null;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("ejecutaRestrccion():start");
				respuesta = datosGeneralesBO.ejecutaRestrccion(restricciones);
			logger.debug("ejecutaRestrccion():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;		
	
	}	// ejecutaRestrccion
	
//	 --------------------------------------------------------------------------------	
		
	public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO usuarioSistema) throws AplicationException {

		UsuarioSistemaDTO respuesta = null;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("ejecutaRestrccion():start");
				respuesta = usuarioSistemaBO.obtenerInformacionUsuario(usuarioSistema);
			logger.debug("ejecutaRestrccion():end");
			
		} catch (AplicationException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AplicationException(e);
		}
		
		return respuesta;		
	
	}	// obtenerInformacionUsuario
	
//	 --------------------------------------------------------------------------------	
				
	public SerieDTO reservaSimcard (String accionProceso,
								SerieDTO serie, 
								UsuarioSistemaDTO usuarioSistema, 
								UsuarioAbonadoDTO usuarioAbonado, 
								String parametros,
								CausaCamSerieDTO causa,
								TipoTerminalDTO terminal,
								ModalidadPagoDTO modalidadPago) throws ProductException,CustomerException {
		
		SerieDTO infoSerie=null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("reservaSimcard():start");
			
			if (accionProceso.equals("bloquear"))	{
				String codigoPrograma = global.getValor("codigoPrograma");
			    String versionPrograma = global.getValor("versionPrograma");
			    Long versionProgramaLong = new Long (versionPrograma);
	
			    // Tomo el valor del properties y ejecuto las restricciones
			    RestriccionesDTO restriccion = new RestriccionesDTO();	                                                                                                                                                                                                                                                                                                                
			    restriccion.setCod_actuacion(global.getValor("ACT_SIMCARD"));
			    restriccion.setCod_modulo(global.getValor("MODULO"));
			    restriccion.setCod_producto(1);
			    restriccion.setCod_evento("CLICKSIM");	
			    restriccion.setParam_entrada(parametros);
	
			    // 1- Ejecuto las restricciones
			    MensajeRetornoDTO mensaje = ejecutaRestrccion(restriccion);
			    
			    // Verificamos que se hayan cumplido todas las restricciones 
			    if 	((mensaje.getMensaje() !=  null) && (!(mensaje.getMensaje().toUpperCase().equals("OK"))))
			    	throw new CustomerException(mensaje.getMensaje());
			    	
			    // 2 - Obtengo la info del numero de serie
		    	infoSerie = seriesBO.recInfoSerie(serie);
    
		    	// 3 - Valido si la bodega es valida para este numero de serie
		    	SesionDTO sesion = new SesionDTO();
		    	sesion.setCod_programa(codigoPrograma);
		    	sesion.setCodCliente(usuarioAbonado.getCod_cliente());
		    	sesion.setNum_version(versionProgramaLong.longValue());
		    	sesion.setUsuario(usuarioSistema);
		    	sesion.setNumAbonado(usuarioAbonado.getNum_abonado());
				
		    	UsoArticuloDTO usoArticulos = new UsoArticuloDTO();
		    	usoArticulos.setCod_uso(serie.getCod_uso());
		    	
		    	seriesBO.validaBodegaSerie(usoArticulos, terminal, usuarioAbonado, sesion, serie);
		    	
		    	// 4 - Valido si el vendedor tiene acceso a la bodega de la serie 
		    	VendedorDTO vendedor = new VendedorDTO();
		    	vendedor.setCod_vendedor(usuarioSistema.getCod_vendedor());
		    	
		    	BodegaDTO bodega = new BodegaDTO();
		    	Long codBodega = new Long(infoSerie.getCod_bodega());
		    	bodega.setCod_bodega(codBodega.toString());
		    	
		    	vendedorBO.validaVendedorbodega(vendedor, sesion, bodega);
		    	
		    	// 5 - Valida que la serie este relacionada a un plan comercial
		    	datosGeneralesBO.verificaPlancomercial(sesion, causa, modalidadPago, usoArticulos, terminal, serie);
		    	 
		    	// 6- Ejecuto el bloqueo de la serie
		    	
		    	logger.debug("seriesBO.reservaSimcard(serie) antes");
		    	RetornoDTO retValue= seriesBO.reservaSimcard(serie);//new RetornoDTO();new RetornoDTO();
		    	//retValue.setDescripcion("La reserva de Simcard no se realizar� por pruebas 050809 GtSv");
		    	logger.debug("seriesBO.reservaSimcard(serie) despues");
		    	String numMovimientoBloqDesb=retValue.getDescripcion();
		    	numMovimientoBloqDesb=(numMovimientoBloqDesb==null||numMovimientoBloqDesb.equals(""))?"0":numMovimientoBloqDesb;
		    	MensajeRetornoDTO mensajeRetornoDTO = new MensajeRetornoDTO();
		    	mensajeRetornoDTO.setNumMovimientoBloqDesb(Long.parseLong(numMovimientoBloqDesb));
		    	infoSerie.setMensajeRetorno(mensajeRetornoDTO);
		    	//infoSerie.getMensajeRetorno().setNumMovimientoBloqDesb(seriesBO.reservaSimcard(serie).getDesc());
			    
		    	// ------------------------------------------------------------------------
			} // if bloquear
			else	{
		    	// 1- Ejecuto el desbloqueo de la serie
				RetornoDTO retValue=     seriesBO.desReservaSimcard(serie);
				infoSerie=new SerieDTO();
				String numMovimientoBloqDesb=retValue.getDescripcion();
		    	numMovimientoBloqDesb=(numMovimientoBloqDesb==null||numMovimientoBloqDesb.equals(""))?"0":numMovimientoBloqDesb;
		    	MensajeRetornoDTO mensajeRetornoDTO = new MensajeRetornoDTO();
		    	mensajeRetornoDTO.setNumMovimientoBloqDesb(Long.parseLong(numMovimientoBloqDesb));
		    	infoSerie.setMensajeRetorno(mensajeRetornoDTO);
			}
				
			logger.debug("reservaSimcard():end");
			
			// retorno la info de la serie
			
			return infoSerie;
			
		} catch (ProductException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("ProductException[" + loge + "]");
			throw new CustomerException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (CustomerException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerException[" + loge + "]");
			throw new CustomerException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("Exception[" + loge + "]");
			throw new CustomerException(e.getMessage(), e.getCause());
		}
		
	}	// reservaSimcard
	
//	 --------------------------------------------------------------------------------
	
	public CausaSiniestroDTO[] obtenerCausasSiniestro(UsuarioAbonadoDTO usuarioAbonado, String actAbo) throws ProductException {
		
		CausaSiniestroDTO[] respuesta ;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerCausasSiniestro():start");
			respuesta = siniestroBO.obtenerCausasSiniestro(usuarioAbonado, actAbo);
			logger.debug("obtenerCausasSiniestro():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}	// obtenerCausasSiniestro
	
//	 --------------------------------------------------------------------------------	
	
	public TipoSiniestroDTO[] obtenerTiposDeSiniestros(UsuarioAbonadoDTO usuarioAbonado) throws ProductException {
		
		TipoSiniestroDTO[] respuesta;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerTiposDeSiniestros():start");
			respuesta = siniestroBO.obtenerTiposDeSiniestros(usuarioAbonado);
			logger.debug("obtenerTiposDeSiniestros():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}	// obtenerTiposDeSiniestros
	
//	 --------------------------------------------------------------------------------	
	
	public TipoSuspencionDTO[] obtenerTiposDeSuspencion() throws ProductException {

		TipoSuspencionDTO[] respuesta ;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerTiposDeSuspencion():start");
			respuesta = siniestroBO.obtenerTiposDeSuspencion();
			logger.debug("obtenerTiposDeSuspencion():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}	// obtenerTiposDeSuspencion
	
//	 --------------------------------------------------------------------------------		
	
	public SolicitudAvisoDeSiniestroDTO grabaAvisoDeSiniestro (UsuarioAbonadoDTO usuarioAbonado, TipoSiniestroDTO tipoSiniestro, TipoSuspencionDTO tipoSuspencion, CausaSiniestroDTO causaSiniestro, UsuarioSistemaDTO usuarioSistema, String actabo, String num_os, String comentario) throws ProductException {

		SolicitudAvisoDeSiniestroDTO respuesta ;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("grabaAvisoDeSiniestro():start");
			respuesta = siniestroBO.grabaAvisoDeSiniestro(usuarioAbonado, tipoSiniestro, tipoSuspencion, causaSiniestro, usuarioSistema, actabo, num_os, comentario);
			logger.debug("grabaAvisoDeSiniestro():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}	// grabaAvisoDeSiniestro
	
//	 --------------------------------------------------------------------------------			

	public void registraCambioSimcard(UsuarioAbonadoDTO usuarioAbonado, SerieDTO serie, UsoArticuloDTO usoArticulo, CuotaDTO cuota, SesionDTO sesion, ModalidadPagoDTO modalidadPago, BodegaDTO bodega, String actabo, String codModulo, CausaCamSerieDTO causaCamSerie) throws ProductException{

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("registraCambioSimcard():start");
			seriesBO.registraCambioSimcard(usuarioAbonado, serie, usoArticulo, cuota, sesion, modalidadPago, bodega, actabo, codModulo, causaCamSerie);
			logger.debug("registraCambioSimcard():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
	}	// registraCambioSimcard
	
//	 --------------------------------------------------------------------------------		
	
	public SerieDTO recInfoSerie (SerieDTO serie) throws ProductException {
		
		SerieDTO respuesta = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("recInfoSerie():start");
				respuesta = seriesBO.recInfoSerie(serie);
			logger.debug("recInfoSerie():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}  // recInfoSerie

// --------------------------------------------------------------------------------	
	
	public SiniestrosDTO[] recDatosSiniestroAboando (UsuarioAbonadoDTO usuarioAbonado) throws ProductException {
		SiniestrosDTO[] respuesta ;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("recDatosSiniestroAboando():start");
				respuesta = siniestroBO.recDatosSiniestroAboando(usuarioAbonado);
			logger.debug("recDatosSiniestroAboando():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}  // recDatosSiniestroAboando

// --------------------------------------------------------------------------------	

	public void anulaSinistroAbonado(SiniestrosDTO Siniestros, UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws ProductException {

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("anulaSinistroAbonado():start");
			siniestroBO.anulaSinistroAbonado(Siniestros, usuarioAbonado, sesion);
			logger.debug("anulaSinistroAbonado():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
	}	// anulaSinistroAbonado
	
//	 --------------------------------------------------------------------------------
	
	public ClienteDTO obtenerDatosCliente(ClienteDTO cliente) throws CusIntManException {
		ClienteDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosCliente():start");
			respuesta = clienteBO.obtenerDatosCliente(cliente);
			logger.debug("obtenerDatosCliente():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return respuesta;
	}
	
	public AbonadoDTO obtenerDatosAbonado(AbonadoDTO abonado)
	throws CusIntManException {
		AbonadoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosAbonado():start");
			respuesta = abonadoBO.obtenerDatosAbonado(abonado);
			logger.debug("obtenerDatosAbonado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return respuesta;		
	}

// ---------------------------------------------------------------------------
	
	public UsuarioAbonadoDTO obtenerDatosUsuarioAbonado(UsuarioAbonadoDTO UsuarioAbonado)
	throws CusIntManException {
		UsuarioAbonadoDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerDatosUsuarioAbonado():start");
			respuesta = abonadoBO.obtenerDatosUsuarioCelular(UsuarioAbonado);
			logger.debug("obtenerDatosUsuarioAbonado():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CusIntManException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CusIntManException(e);
		}
		return respuesta;		
	
	}  // obtenerDatosUsuarioAbonado

//	 ---------------------------------------------------------------------------

	public SimcardDTO obtenerSimcard (SimcardDTO simcardDTO) throws ProductException{
			
			try {
				String log = global.getValor("service.log");
				log = System.getProperty("user.dir") + log;
				PropertyConfigurator.configure(log);		
				
				logger.debug("obtenerSimcard():start");
				simcardDTO = simcardBO.getSimcard(simcardDTO);
				logger.debug("obtenerSimcard():end");
				
			} catch (GeneralException e) {
				logger.debug("GeneralException[", e);
				throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			}
			catch (Exception e) {
				logger.debug("Exception[", e);
				throw new ProductException(e);
			}
			
			return simcardDTO;		
			
		}	
	
	public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO planTarifarioDTO) throws GeneralException {
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerSimcard():start");
			planTarifarioDTO = planTarifarioBO.getCategoriaPlanTarifario(planTarifarioDTO);
			logger.debug("obtenerSimcard():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return planTarifarioDTO;	
	}

	public OperadoraLocalDTO obtenerOperadoraLocal() throws GeneralException {
		OperadoraLocalDTO respuesta = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerOperadoraLocal():start");
			respuesta = datosGeneralesBO.obtenerOperadoraLocal();
			logger.debug("obtenerOperadoraLocal():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return respuesta;		
	}
	
	public BodegaDTO[] obtieneBodega(BodegaDTO entrada) throws GeneralException {
		logger.debug("Inicio:obtieneBodega()");
		BodegaDTO[] resultado = seriesBO.obtieneBodega(entrada);
		logger.debug("Fin:obtieneBodega()");
		return resultado;		
	}
	
	public SerieDTO[] obtieneSerie(SerieDTO entrada) throws GeneralException {
		logger.debug("Inicio:obtieneSerie()");
		SerieDTO[] resultado = seriesBO.obtieneSerie(entrada);
		logger.debug("Fin:obtieneSerie()");
		return resultado;	
	}
	
	public SerieDTO[] obtieneSeries(SerieDTO entrada) throws GeneralException{
		logger.debug("Inicio:obtieneSeries()");
		SerieDTO[] resultado = seriesBO.obtieneSeries(entrada);
		logger.debug("Fin:obtieneSeries()");
		return resultado;	
	}
	
	public ArticuloInDTO[] obtieneArticulos(ArticuloInDTO entrada) throws GeneralException{
		logger.debug("Inicio:obtieneArticulos()");
		ArticuloInDTO[] resultado = seriesBO.obtieneArticulos(entrada);
		logger.debug("Fin:obtieneArticulos()");
		return resultado;	
	}
	
	 public RetornoDTO validaSerieExterna (SerieDTO serie) throws GeneralException {
			RetornoDTO retValue=null;
			logger.debug("validaSerieExterna():start");
			retValue=seriesBO.validaSerieExterna(serie);
			logger.debug("validaSerieExterna():end");
			return retValue;
		}

	public DatosCentralDTO obtenerDatosCentral(int codCentral)throws ProductException {
		DatosCentralDTO retValue=null;
		logger.debug("obtenerDatosCentral():start");
		retValue=datosGeneralesBO.obtenerDatosCentral(codCentral);
		logger.debug("obtenerDatosCentral():end");
		return retValue;
	}

}
