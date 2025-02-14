/**
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 01/06/2007	     	Elizabeth Vera        				Versión Inicial
 */
package com.tmmas.scl.operations.crm.fab.cusintman.srv.camser;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.cl.scl.socketps.common.dto.SaldoDTO;
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
import com.tmmas.scl.framework.ProductDomain.dto.MesesProrrogasDTO;
import com.tmmas.scl.framework.ProductDomain.dto.ModalidadPagoDTO;
import com.tmmas.scl.framework.ProductDomain.dto.RestriccionesDTO;
import com.tmmas.scl.framework.ProductDomain.dto.SSuplementarioDTO;
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
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosVerificaPlanComercialDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.dto.UsuarioAbonadoDTO;
import com.tmmas.scl.framework.customerDomain.dto.VendedorDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.businessObject.bo.PlanTarifarioBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.SimcardBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.TerminalBOFactory;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SimcardBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SimcardBOIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOIT;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCambioSerieDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.SimcardDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.TerminalDTO;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.camser.helper.Global;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.camser.interfaces.CambioDeSerieSrvIF;
import com.tmmas.scl.operations.crm.fab.customerinterfacemanagement.common.exception.CusIntManException;

public class CambioDeSerieSrv implements CambioDeSerieSrvIF {

	private final Logger logger = Logger.getLogger(CambioDeSerieSrv.class);
	
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
	private TerminalBOFactoryIT terminalFactory=new TerminalBOFactory();
	private TerminalBOIT terminalBO =terminalFactory.getBusinessObject1();
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
				
	public SerieDTO reservaSimcard(String accionProceso, SerieDTO serie,
			UsuarioSistemaDTO usuarioSistema, UsuarioAbonadoDTO usuarioAbonado,
			String parametros, CausaCamSerieDTO causa,
			TipoTerminalDTO terminal, ModalidadPagoDTO modalidadPago,String tipoAccion 
			,String prmInterno)
			throws ProductException, CustomerException {

		SerieDTO infoSerie = null;

		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);
			RetornoDTO retValue=null;

			String strMensaje = "";;
			long strCodigo= 0;

			logger.debug("reservaSimcard():start");

			logger.debug("Origen Serie:" + prmInterno); 

			// inicio RRG 93022 COL 06-06-2009
			logger.debug("Serie numSerie:" + serie.getNum_serie()); 
			logger.debug("Serie numSerie String" + serie.getNum_serie().toString()); 
			logger.debug("Serie numSerie largo" + serie.getNum_serie().toString().length()); 

			if (serie.getNum_serie().toString().length() > 15 && prmInterno.trim().equalsIgnoreCase("E") )
			{
				logger.debug("Se pasa a Interno ya que es la simcard");
				prmInterno = "I"; 
				logger.debug("Origen Serie Simcard:" + prmInterno); 
			}
			// fin RRG 93022 COL 06-06-2009


			if (accionProceso.equals("bloquear")) {
				String codigoPrograma = global.getValor("codigoPrograma");
				String versionPrograma = global.getValor("versionPrograma");
				Long versionProgramaLong = new Long(versionPrograma);

				// Tomo el valor del properties y ejecuto las restricciones
				RestriccionesDTO restriccion = new RestriccionesDTO();

				//restriccion.setCod_actuacion(global.getValor("ACT_SIMCARD")); INC-149992
				restriccion.setCod_actuacion(global.getValor("ACT_CAMBIOSERIE"));//INC-149992

				restriccion.setCod_modulo(global.getValor("MODULO"));
				restriccion.setCod_producto(1);
				restriccion.setCod_evento("CLICKSIM");
				restriccion.setParam_entrada(parametros);

				// 1- Ejecuto las restricciones
				MensajeRetornoDTO mensaje = ejecutaRestrccion(restriccion);

				// Verificamos que se hayan cumplido todas las restricciones
				if ((mensaje.getMensaje() != null)
						&& (!(mensaje.getMensaje().toUpperCase().equals("OK"))))
					throw new CustomerException(mensaje.getMensaje());

				// 2 - Obtengo la info del numero de serie

				if (prmInterno.trim().equalsIgnoreCase("I")) { // RRG 70904 29-01-2009 COL 
						infoSerie = seriesBO.recInfoSerie(serie);
				} else {
						infoSerie = new SerieDTO(); // RRG 70904 29-01-2009 COL
				}

				

				// 3 - Valido si la bodega es valida para este numero de serie
				SesionDTO sesion = new SesionDTO();
				sesion.setCod_programa(codigoPrograma);
				sesion.setCodCliente(usuarioAbonado.getCod_cliente());
				sesion.setNum_version(versionProgramaLong.longValue());
				sesion.setUsuario(usuarioSistema);
				sesion.setNumAbonado(usuarioAbonado.getNum_abonado());
				sesion.setCodOrdenServicio(Long.parseLong(global.getValor("codigo.orden.servicio.cambioserie")));

				UsoArticuloDTO usoArticulos = new UsoArticuloDTO();
				usoArticulos.setCod_uso(serie.getCod_uso());

				seriesBO.validaBodegaSerie(usoArticulos, terminal,
						usuarioAbonado, sesion, serie);

				// 4 - Valido si el vendedor tiene acceso a la bodega de la
				// serie
				VendedorDTO vendedor = new VendedorDTO();
				vendedor.setCod_vendedor(usuarioSistema.getCod_vendedor());

				if (prmInterno.trim().equalsIgnoreCase("I")){ // RRG 70904 29-01-2009 COL 

						BodegaDTO bodega = new BodegaDTO();
						Long codBodega = new Long(infoSerie.getCod_bodega());
						bodega.setCod_bodega(codBodega.toString());
						
						vendedorBO.validaVendedorbodega(vendedor, sesion, bodega);
						
						
							// 5 - Valida que la serie este relacionada a un plan comercial
						//if (!tipoAccion.equals(global.getValor("parametro.equipo"))){
							//datosGeneralesBO.verificaPlancomercial(sesion, causa, modalidadPago, usoArticulos, terminal, serie);
						
						
						ParametrosVerificaPlanComercialDTO param=new ParametrosVerificaPlanComercialDTO();
						param.setNumAbonado(usuarioAbonado.getNum_abonado());
						param.setNomUsuario(usuarioSistema.getNom_usuario());
						param.setCodPrograma(codigoPrograma);
						param.setNumVersion(versionPrograma);
						param.setCodCausaServicio(causa.getCod_caucaser());
						param.setCodModVenta(modalidadPago.getCod_modventa());
						param.setCodUso(String.valueOf(serie.getCod_uso()));
						param.setTipTerminal(terminal.getTip_terminal());
						param.setNumSerie(serie.getNum_serie());
						param.setCodTipContrato(usuarioAbonado.getCodTipContrato());
						param.setCodTecnologia(usuarioAbonado.getCod_tecnologia());
						
						//INICIO CSR-11002 PAH
						//Se agrega el cambio de uso de la serie para 
						//poder entregar cualquiera sin importar su uso
						datosGeneralesBO.cambioUsoSeries(param);
						//FIN CSR-11002 PAH
						
						retValue=datosGeneralesBO.verificaPlanComercialTerminal(param);

						if (!retValue.isResultado()){
							throw new CustomerException("Error al aplicar validacion Comercial en el bloqueo del Equipo");
						}
				} // RRG 70904 29-01-2009 COL

				// 6- Ejecuto el bloqueo de la serie 
				/**
				 * @author rlozano
				 * @description Tanto la simcard como el termial usan el mismo método
				 */
				
				
				prmInterno = prmInterno.trim(); //INC-70904; AVC
					
				// if (prmInterno.compareTo("I") != 0) { // RRG 24-09-2008 COL  si la serie es externa no ejecuta metodo
				if (prmInterno.trim().equalsIgnoreCase("I")){
					retValue = seriesBO.reservaSimcard(serie);
					String numMovimientoBloqDesb = retValue.getDescripcion();
					numMovimientoBloqDesb = (numMovimientoBloqDesb == null || numMovimientoBloqDesb.equals("")) ? "0" : numMovimientoBloqDesb;

					MensajeRetornoDTO mensajeRetornoDTO = new MensajeRetornoDTO();
					mensajeRetornoDTO.setNumMovimientoBloqDesb(Long.parseLong(numMovimientoBloqDesb));
					infoSerie.setMensajeRetorno(mensajeRetornoDTO);
				}
 
				if (prmInterno.trim().equalsIgnoreCase("E")){   // RRG 70904 24-09-2008 COL  si la serie es externa solo la valida

					retValue = seriesBO.validaSerieExterna(serie);

					String numMovimientoBloqDesb = retValue.getDescripcion();
					numMovimientoBloqDesb = (numMovimientoBloqDesb == null || numMovimientoBloqDesb.equals("")) ? "0" : numMovimientoBloqDesb;
					logger.debug("numMovimientoBloqDesb:" + numMovimientoBloqDesb); // RRG 70904 02-02-2009 COL

					MensajeRetornoDTO mensajeRetornoDTO = new MensajeRetornoDTO();

					// retValue = RetornoDTO 
					// infoSerie = serieDTO

					//strMensaje = retValue.getDescripcion() + "";
					//strCodigo= retValue.getCodigo();

					logger.debug("retValue.getCodigo():"+retValue.getCodigo()); // RRG 70904 02-02-2009 COL
					logger.debug("retValue.getDescripcion():"+retValue.getCodigo()); // RRG 70904 02-02-2009 COL

					mensajeRetornoDTO.setMensaje(retValue.getDescripcion()); // RRG 70904 02-02-2009 COL
					mensajeRetornoDTO.setNumMovimientoBloqDesb(0); // RRG 70904 02-02-2009 COL
					mensajeRetornoDTO.setCodigo(Long.parseLong(retValue.getCodigo()) ); // RRG 70904 02-02-2009 COL

					infoSerie.setMensajeRetorno(mensajeRetornoDTO);

				}


				
				// infoSerie.getMensajeRetorno().setNumMovimientoBloqDesb(seriesBO.reservaSimcard(serie).getDesc());

				// ------------------------------------------------------------------------
			} // if bloquear
			else {
				// 1- Ejecuto el desbloqueo de la serie
				/***
				 * @author rlozano
				 * @description Simcard y terminal usan el mismo metodo
				 */
				
				
				
				retValue = seriesBO.desReservaSimcard(serie);
				infoSerie = new SerieDTO();
				String numMovimientoBloqDesb = retValue.getDescripcion();
				numMovimientoBloqDesb = (numMovimientoBloqDesb == null || numMovimientoBloqDesb.equals("")) ? "0" : numMovimientoBloqDesb;
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
			throw new CustomerException(e.getMessage(), e.getCause(), e
					.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (CustomerException e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("CustomerException[" + loge + "]");
			throw new CustomerException(e.getMessage(), e.getCause(), e
					.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		} catch (Exception e) {
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("Exception[" + loge + "]");
			throw new CustomerException(e.getMessage(), e.getCause());
		}

	} // reservaSimcard
	
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
	
	public SSuplementarioDTO[] obtenerServiciosDisplonibles(UsuarioAbonadoDTO usuarioAbonado, SesionDTO sesion) throws ProductException{

		SSuplementarioDTO[] respuesta = null;
		
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerServiciosDisplonibles():start");
				respuesta = serviciosSuplmentariosBO.obtenerServiciosDisplonibles(usuarioAbonado, sesion);
			logger.debug("obtenerServiciosDisplonibles():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return respuesta;
		
	}  // obtenerServiciosDisplonibles

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

//	public String registraCambioDeSerie(ParametrosCambioSerieDTO parametros) throws ProductException { // RRG 23-09-2008 COL 70904
	public String registraCambioDeSerie(ParametrosCambioSerieDTO parametros,SaldoDTO saldo) throws ProductException {
		
		String respuesta;
		
		try {
			
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("recInfoSerie():start");
				respuesta =seriesBO.registraCambioDeSerie(parametros, saldo);
//				respuesta =seriesBO.registraCambioDeSerie(parametros); // RRG 23-09-2008 COL 70904
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
		
	}  // registraCambioDeSerie

// --------------------------------------------------------------------------------	

	public ArticuloDTO[] obtenerListaArticulos (ArticuloDTO articuloDTO) throws ProductException{
		
		ArticuloDTO[] retValue = null;
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerListaArticulos():start");
			retValue = datosGeneralesBO.obtenerListaArticulos(articuloDTO);
			logger.debug("obtenerListaArticulos():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		
		return retValue;		
		
	}	// obtenerTipoTerminal
	
//	 --------------------------------------------------------------------------------	
	public TerminalDTO obtenerTerminal (TerminalDTO terminalDTO) throws ProductException{
			
			try {
				String log = global.getValor("service.log");
				log = System.getProperty("user.dir") + log;
				PropertyConfigurator.configure(log);		
				
				logger.debug("obtenerTerminal():start");
				terminalDTO = terminalBO.getTerminal(terminalDTO);
				logger.debug("obtenerTerminal():end");
				
			} catch (GeneralException e) {
				logger.debug("GeneralException[", e);
				throw new ProductException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
			}
			catch (Exception e) {
				logger.debug("Exception[", e);
				throw new ProductException(e);
			}
			
			return terminalDTO;		
			
		}	// obtenerTipoTerminal
	
//	 --------------------------------------------------------------------------------
	public RetornoDTO verificaConcFactGarantia(ParametroDTO parametrosDTO )throws GeneralException{
		RetornoDTO retValue=null;
		try{
			retValue=datosGeneralesBO.verificaConcFactGarantia(parametrosDTO);
		}catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
		
	}
	
	public RetornoDTO validaSeleccionCausa(ParametrosCambioSerieDTO parametrosCambioSerieDTO)throws GeneralException{
		RetornoDTO retValue=null;
		try{
			retValue=datosGeneralesBO.validaSeleccionCausa(parametrosCambioSerieDTO);
		}catch(GeneralException e){
			logger.debug("GeneralException[", e);
			throw(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new GeneralException(e);
		}
		return retValue;
	}
//	 --------------------------------------------------------------------------------	
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
			
		}	// obtenerTipoTerminal

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
	
	public UsuarioAbonadoDTO getPlanTarifarioDefault(UsuarioAbonadoDTO usuarioAbonadoDTO)throws GeneralException{
		try {
			String log = global.getValor("service.log");
			log = System.getProperty("user.dir") + log;
			PropertyConfigurator.configure(log);		
			
			logger.debug("obtenerSimcard():start");
			usuarioAbonadoDTO = abonadoBO.getPlanTarifarioDefault(usuarioAbonadoDTO);
			logger.debug("obtenerSimcard():end");
			
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new CustomerException(e.getMessage(), e.getCause(), e.getCodigo(), e.getCodigoEvento(), e.getDescripcionEvento());
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerException(e);
		}
		
		return usuarioAbonadoDTO;
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
	
	//INICIO 177697 PAH
	public SerieDTO[] obtieneSeriesSinUso(SerieDTO entrada) throws GeneralException{
		logger.debug("Inicio:obtieneSeriesSinUso()");
		SerieDTO[] resultado = seriesBO.obtieneSeriesSinUso(entrada);
		logger.debug("Fin:obtieneSeriesSinUso()");
		return resultado;	
	}
	//FIN 177697 PAH
	
	public ArticuloInDTO[] obtieneArticulos(ArticuloInDTO entrada) throws GeneralException{
		logger.debug("Inicio:obtieneArticulos()");
		ArticuloInDTO[] resultado = seriesBO.obtieneArticulos(entrada);
		logger.debug("Fin:obtieneArticulos()");
		return resultado;	
	}
	
	 public RetornoDTO validaSerieExternaEquipo (SerieDTO serie) throws GeneralException {
			RetornoDTO retValue=null;
			logger.debug("validaSerieExternaEquipo():start");
			retValue=seriesBO.validaSerieExternaEquipo(serie);
			logger.debug("validaSerieExternaEquipo():end");
			return retValue;
		}

	public RetornoDTO validaSerieExterna(SerieDTO serie) throws GeneralException  {
		RetornoDTO retValue=null;
		logger.debug("validaSerieExterna():start");
		retValue=seriesBO.validaSerieExterna(serie);
		logger.debug("validaSerieExterna():end");
		return retValue;
	}
	
	public String consultarSeguroAbonado(Long numAbonado) throws GeneralException  {
		String retValue="";
		logger.debug("consultarSeguroAbonado():start");
		retValue=datosGeneralesBO.consultarSeguroAbonado(numAbonado);
		logger.debug("consultarSeguroAbonado():end");
		return retValue;
	}
	
}
